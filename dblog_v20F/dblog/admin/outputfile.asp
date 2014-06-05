<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0

	Server.ScriptTimeout = 300
%>
<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--#include virtual="/dblog/inc_funzioni.asp"-->
<!--#include file="inc_controllo.asp"-->
<%
	Class FileUploader
		Public  Files
		Private mcolFormElem
		Private Sub Class_Initialize()
			Set Files = Server.CreateObject("Scripting.Dictionary")
			Set mcolFormElem = Server.CreateObject("Scripting.Dictionary")
		End Sub
		Private Sub Class_Terminate()
			If IsObject(Files) Then
				Files.RemoveAll()
				Set Files = Nothing
			End If
			If IsObject(mcolFormElem) Then
				mcolFormElem.RemoveAll()
				Set mcolFormElem = Nothing
			End If
		End Sub
		Public Property Get Form(sIndex)
			Form = ""
			If mcolFormElem.Exists(LCase(sIndex)) Then Form = mcolFormElem.Item(LCase(sIndex))
		End Property
		Public Default Sub Upload()
			Dim biData, sInputName
			Dim nPosBegin, nPosEnd, nPos, vDataBounds, nDataBoundPos
			Dim nPosFile, nPosBound
			biData = Request.BinaryRead(Request.TotalBytes)
			nPosBegin = 1
			nPosEnd = InstrB(nPosBegin, biData, CByteString(Chr(13)))
			If (nPosEnd-nPosBegin) <= 0 Then Exit Sub
			vDataBounds = MidB(biData, nPosBegin, nPosEnd-nPosBegin)
			nDataBoundPos = InstrB(1, biData, vDataBounds)
			Do Until nDataBoundPos = InstrB(biData, vDataBounds & CByteString("--"))
				nPos = InstrB(nDataBoundPos, biData, CByteString("Content-Disposition"))
				nPos = InstrB(nPos, biData, CByteString("name="))
				nPosBegin = nPos + 6
				nPosEnd = InstrB(nPosBegin, biData, CByteString(Chr(34)))
				sInputName = CWideString(MidB(biData, nPosBegin, nPosEnd-nPosBegin))
				nPosFile = InstrB(nDataBoundPos, biData, CByteString("filename="))
				nPosBound = InstrB(nPosEnd, biData, vDataBounds)
				If nPosFile <> 0 And  nPosFile < nPosBound Then
					Dim oUploadFile, sFileName
					Set oUploadFile = New UploadedFile
					nPosBegin = nPosFile + 10
					nPosEnd =  InstrB(nPosBegin, biData, CByteString(Chr(34)))
					sFileName = CWideString(MidB(biData, nPosBegin, nPosEnd-nPosBegin))
					oUploadFile.FileName = Right(sFileName, Len(sFileName)-InStrRev(sFileName, "\"))
					nPos = InstrB(nPosEnd, biData, CByteString("Content-Type:"))
					nPosBegin = nPos + 14
					nPosEnd = InstrB(nPosBegin, biData, CByteString(Chr(13)))
					oUploadFile.ContentType = CWideString(MidB(biData, nPosBegin, nPosEnd-nPosBegin))
					nPosBegin = nPosEnd+4
					nPosEnd = InstrB(nPosBegin, biData, vDataBounds) - 2
					oUploadFile.FileData = MidB(biData, nPosBegin, nPosEnd-nPosBegin)
					If oUploadFile.FileSize > 0 Then Files.Add LCase(sInputName), oUploadFile
				Else
					nPos = InstrB(nPos, biData, CByteString(Chr(13)))
					nPosBegin = nPos + 4
					nPosEnd = InstrB(nPosBegin, biData, vDataBounds) - 2
					If Not mcolFormElem.Exists(LCase(sInputName)) Then mcolFormElem.Add LCase(sInputName), CWideString(MidB(biData, nPosBegin, nPosEnd-nPosBegin))
				End If
				nDataBoundPos = InstrB(nDataBoundPos + LenB(vDataBounds), biData, vDataBounds)
			Loop
		End Sub
		'String to byte string conversion
		Private Function CByteString(sString)
			Dim nIndex
			For nIndex = 1 to Len(sString)
			   CByteString = CByteString & ChrB(AscB(Mid(sString,nIndex,1)))
			Next
		End Function
		'Byte string to string conversion
		Private Function CWideString(bsString)
			Dim nIndex
			CWideString =""
			For nIndex = 1 to LenB(bsString)
			   CWideString = CWideString & Chr(AscB(MidB(bsString,nIndex,1))) 
			Next
		End Function
	End Class

	Class UploadedFile
		Public ContentType
		Public FileName
		Public FileData
		Public Property Get FileSize()
			FileSize = LenB(FileData)
		End Property
		Public Sub SaveToDisk(sPath)
			Dim oFS, oFile
			Dim nIndex
			If sPath = "" Or FileName = "" Then Exit Sub
			If Mid(sPath, Len(sPath)) <> "\" Then sPath = sPath & "\"
			Set oFS = Server.CreateObject("Scripting.FileSystemObject")
			If Not oFS.FolderExists(sPath) Then Exit Sub
			Set oFile = oFS.CreateTextFile(sPath & FileName, True)
			For nIndex = 1 to LenB(FileData)
			    oFile.Write Chr(AscB(MidB(FileData,nIndex,1)))
			Next
			oFile.Close
		End Sub

		Public Sub SaveToDatabase(ByRef oField)
			If LenB(FileData) = 0 Then Exit Sub
			If IsObject(oField) Then
				oField.AppendChunk FileData
			End If
		End Sub
	End Class

	' Create the FileUploader
	Dim Uploader, File, FilesName, x
	Set Uploader = New FileUploader
	' This starts the upload process
	Uploader.Upload()
	' Check if any files were uploaded
	If Uploader.Files.Count = 0 Then
		Response.Redirect "upload.asp?errore=si"
	Else
		' Loop through the uploaded files
		FilesName = "" : x = 0
		For Each File In Uploader.Files.Items
			If InStr(File.FileName, ".") > 0 Then
				If InStr(Testo_Upload_EstensioniNonAbilitate, Mid(File.FileName, InStrRev(File.FileName, "."), Len(File.FileName) - InStrRev(File.FileName, ".") + 1)) <= 0 Then
					' Save the file
					File.SaveToDisk (Server.MapPath(Path_DirPublic))
					FilesName = FilesName & ", " & File.FileName
					x = x + 1
				Else
					Response.Redirect "upload.asp?errore=si"
				End If
			End If
		Next
	End If

	If Len(FilesName) > 0 Then
		FilesName = Mid(FilesName, 3, Len(FilesName) - 2)
	End If

	Response.Redirect "upload.asp?errore=no&file=" & FilesName
%>