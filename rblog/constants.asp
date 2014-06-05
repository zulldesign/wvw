<!--#include file="data/locales.asp" -->
<%

Function BuildDate(Temporal)
	' Response.Write("We have : " & Temporal & "<br>" & Chr(13))
	If Request.Form(Temporal & "M") <> "N/A" Then
		M = Request.Form(Temporal & "M")
		D = Request.Form(Temporal & "D")
		Y = Request.Form(Temporal & "Y")

		If M = 2 And D > 28 Then
			If Y/4 = Round(Y/4) And D > 29 Then
				D = 29
			Else
				D = 28
			End If
		End If
		If (M = 9 Or M = 4 Or M = 6 Or M = 11) And D = 31 Then
			D = 30
		End If
		' Response.Write("which is : " & CStr(M) & "/" & CStr(D) & "/" & CStr(Y) & "<br>" & Chr(13))
		BuildDate =  CStr(M) & "/" & CStr(D) & "/" & CStr(Y)
	Else
		BuildDate = "12/25/2525"
	End If
End Function

Function DateSelect(Mo,Dy,Yr,Nom,Plain)
	If IsNull(Mo) Then
		Mo = 0
	End If
	If IsNull(Dy) Then
		Dy = 0
	End If	
	If IsNull(Yr) Then
		Yr = 0
	End If
%>
<!--  <a HREF="javascript:displayHelp('<% =Plain %>')"> -->
	<tr>
	  <td class="toc" width="150" align="left" valign="top"><b><% =Plain %> :</b></td>
	  <td align="left" valign="middle">
		<SELECT NAME="<% =Nom %>M">
			<OPTION VALUE="0"<% If Mo = "0" Then %> SELECTED<% End If %>>N/A
			<OPTION VALUE="1"<% If Mo = "1" Then %> SELECTED<% End If %>>January
			<OPTION VALUE="2"<% If Mo = "2" Then %> SELECTED<% End If %>>Febuary
			<OPTION VALUE="3"<% If Mo = "3" Then %> SELECTED<% End If %>>March
			<OPTION VALUE="4"<% If Mo = "4" Then %> SELECTED<% End If %>>April
			<OPTION VALUE="5"<% If Mo = "5" Then %> SELECTED<% End If %>>May
			<OPTION VALUE="6"<% If Mo = "6" Then %> SELECTED<% End If %>>June
			<OPTION VALUE="7"<% If Mo = "7" Then %> SELECTED<% End If %>>July
			<OPTION VALUE="8"<% If Mo = "8" Then %> SELECTED<% End If %>>August
			<OPTION VALUE="9"<% If Mo = "9" Then %> SELECTED<% End If %>>September
			<OPTION VALUE="10"<% If Mo = "10" Then %> SELECTED<% End If %>>October
			<OPTION VALUE="11"<% If Mo = "11" Then %> SELECTED<% End If %>>November
			<OPTION VALUE="12"<% If Mo = "12" Then %> SELECTED<% End If %>>December
		</SELECT>
		<SELECT NAME="<% =Nom %>D">
			<OPTION VALUE="0"<% If Dy = "0" Then %> SELECTED<% End If %>>N/A
			<% For x = 1 to 31 %>
			<OPTION VALUE="<% =x %>"<% If CInt(Dy) = x Then %> SELECTED<% End If %>><% =x %>
			<% Next %>
		</SELECT>
		<SELECT NAME="<% =Nom %>Y">
			<OPTION VALUE="0"<% If Yr = "0" Then %> SELECTED<% End If %>>N/A
			<% For x = (Year(Now())-1) to (Year(Now())+2) %>
			<OPTION VALUE="<% =x %>"<% If CInt(Yr) = x Then %> SELECTED<% End If %>><% =x %>
			<% Next %>
		</SELECT>
	  </td>
	</tr>
<%
End Function

Function Cookdown(arg)
	If arg & "" = "" Then
		Cookdown = ""
	Else
		Cookdown = Server.HTMLEncode(arg)
	End If
End Function

Function StaticBuilder(Source,Destination,UserName)
	RSSData = LocalGroup & Source
	RSSHTML = LocalGroup & Destination & ".xml"

	Set ObjtConn = Server.CreateObject("ADODB.Connection")
	DataSource = DataProvider & RSSData
	ObjtConn.Open DataSource

	' The Header

	If checkValid(UserName) Then
		SQL = "SELECT * FROM Users WHERE UserName = '" & UserName & "'"
		Set RS = ObjtConn.Execute(SQL)

		If Not(RS.EOF) Then
			' That question hinges ALL of the functionality

			RSSTitle = RS("Title")
			RSSLink = RS("WebSite")
			RSSDescription = RS("Descrip")
			RSSLanguage = RS("Language")

			RS.Close

			Set FileStreamObject = Server.CreateObject("Scripting.FileSystemObject")
			Set WriteStream = FileStreamObject.CreateTextFile(RSSHTML, True, False)

			WriteStream.WriteLine("<?xml version=""1.0""?>")
			WriteStream.WriteLine("<rss version=""0.92"">")
			WriteStream.WriteLine("<channel>")
			WriteStream.WriteLine("<title>" & RSSSafe(RSSTitle) & "</title>")
   			WriteStream.WriteLine("<link>" & RSSSafe(RSSLink) & "</link>")
   			WriteStream.WriteLine("<description>" & RSSSafe(RSSDescription) & "</description>")
   			WriteStream.WriteLine("<language>" & RSSSafe(RSSLanguage) & "</language>")

			SQL = "SELECT * FROM RSS WHERE UserName = '" & UserName & "' AND DateDiff(""d"",DropOutDate,Now()) < 0 ORDER BY InputDate DESC"
			Set RS = ObjtConn.Execute(SQL)

			If Not(RS.EOF) Then
				Do While Not (RS.EOF)
					WrTitle = RS("Title")
					WrDescription = RS("Description")
					WrLink = RS("ExtLink")

					If IsNull(WrLink) Then
						WrLink = ""
					End If

					WriteStream.WriteLine("  <item>")
					WriteStream.WriteLine("  <title>" & RSSSafe(WrTitle) & "</title>")
					WriteStream.WriteLine("  <link>" & RSSSafe(WrLink) & "</link>")
					WriteStream.WriteLine("  <description>" & RSSSafe(WrDescription) & "</description>")
					WriteStream.WriteLine("</item>")

					RS.MoveNext
				Loop
			End If 
			WriteStream.WriteLine("</channel>")
			WriteStream.WriteLine("</rss>")
			WriteStream.Close
		End If
		RS.Close
		Set RS = Nothing
	End If
	ObjtConn.Close
	Set ObjtConn = Nothing
End Function

Function BuildStatement(List,Style,Destination,Source)
	Up = 0
	UpD = ""
	InA = ""
	InB = ""
	If Source = "Form" Then
		Source = "Request.Form"
	End If

	Dim Listing
	List = Replace(List,",,",",")
	List = Replace(List,"]","")
	List = Replace(List,"[","")
	Listing = split(List,",")
	For Each Item In Listing
		' Response.Write("We have : " & Item & "<br>")
		' Putin is the value
		' Item is the field name

		Putin = Chr(7)
		If InStr(Item,"Date") > 0 Then
			Putin = CheckString(BuildDate(Item))
		End If

		' we could put these all on one line, but we'll break it up
		If Putin <> Chr(7) AND (Left(Item,3) = "Est" OR Right(Item,6) = "Budget") Then
			Putin = eval(Source & "(" & chr(34) & Item & chr(34) & ")")
		End If
		If Putin <> Chr(7) AND (Left(Item,5) = "Price" OR Item = "ID") Then
			Putin = eval(Source & "(" & chr(34) & Item & chr(34) & ")")
		End If
		If Putin <> Chr(7) AND (Item = "Reference") Then
			Putin = LCase(eval(Source & "(" & chr(34) & Item & chr(34) & ")"))
		End If
		If Item = "Category" Then
			If IsNull(eval(Source & "(" & chr(34) & Item & chr(34) & ")")) OR Len(eval(Source & "(" & chr(34) & Item & chr(34) & ")")) < 2 Then
				Putin = CheckString(eval(Source & "(" & chr(34) & "NewCategory"  & chr(34) & ")")) 
				Ats = Source & "(" & chr(34) & "NewCategory"  & chr(34) & ")"
				' Response.Write(Ats & " is " & eval(Ats) & "<br>")
			Else
				Putin =CheckString(eval(Source & "(" & chr(34) & Item & chr(34) & ")"))
			End If
			' Response.Write("<i>" & Putin & "</i>")
		End If
		If Putin = Chr(7) Then		
			Ats = Source & "(" & chr(34) & Item & chr(34) & ")"
			Putin =CheckString(eval(Ats))
		End If 

		If Style = "Update" Then
			If Up = 1 Then
				UpD = UpD & ", "
			End If
			Up = 1
			UpD = UpD & "[" & Item & "] = " & Putin
		End If
		If Style = "Insert" Then
			If Up = 1 Then
				InA = InA & ", "
				InB = InB & ", "
			End If
			Up = 1

			InA = InA & "[" & Item & "]"
			InB = InB & Putin
		End If
	Next

	If Style = "Update" Then
		Incert = "UPDATE " & Destination & " SET " & UpD
		BuildStatement = Incert
	End If
	If Style = "Insert" Then
		Incert = "INSERT INTO " & Destination & " (" & InA & ") VALUES (" & InB & ")"
		BuildStatement = Incert
	End If
End Function

Function CheckString (s)
pos = InStr(s, "'")
While pos > 0
	s = Mid(s, 1, pos) & "'" & Mid(s, pos + 1)
	pos = InStr(pos + 2, s, "'")
	Wend
	If Len(s) < 1 Then
		s = " "
	End If
	If Request.Form("verbatim") <> "yes" Then
		s = Replace("" & s,vbCRLF,"<br>")
	End If
	s = Replace("" & s,"<br><br><br>","<br>")
	CheckString="'" & s & "'"
End Function

Function Cookdown(arg)
	If IsNull(arg) Or Len(arg) < 1 Then
		Cookdown = ""
	Else
		Cookdown = Server.HTMLEncode(arg)
	End If
End Function

Function RSSSafe(arg)
	If IsNull(arg) Or Len(arg) < 1 Then
		RSSSafe = ""
	Else
		RSSSafe = Server.HTMLEncode(arg)
	End If
End Function

Function checkValid(arg)
	If Len(arg) > 1 Then 
		Dim funcObjRegExp
		Set funcObjRegExp = New Regexp
		funcObjRegExp.IgnoreCase = True
		funcObjRegExp.Global = True
		funcObjRegExp.Pattern = "[a-zA-Z_\-0-9]*"
		If IsEmpty(arg) OR IsNull(arg) Then
			checkValid = FALSE
		End If
		If (funcObjRegExp.Test(arg)) Then
			checkValid = TRUE
		Else
			checkValid = FALSE
		End If
	Else
		checkValid = FALSE
	End If
End Function

Function Tidy(look)
	Set tidFSO = Server.CreateObject("Scripting.FileSystemObject")
	Set seedir = tidFSO.GetFolder(look)
	Set seefiles = seedir.Files
	
	For Each thefile in seefiles
		Daat = thefile.DateCreated
		' Response.Write("--- we see " & thefile & " it was made " & abs(DateDiff("h", Daat, Date())) & "hours ago<br>")

		If abs(DateDiff("h", Date(), Daat)) > 16 Then
			tidFSO.DeleteFile thefile
			' Response.Write("--- now it is gone<br>")
		End If 
	Next 

	Set seefiles = Nothing
	Set seedir = Nothing
	Set tidFSO = Nothing
End Function

Function UserSelect(UserArg)
	RSSData = LocalGroup & DataDir & "\rblog.mdb"

	Set ObjUConn = Server.CreateObject("ADODB.Connection")
	DataSource = DataProvider & RSSData
	ObjUConn.Open DataSource

	Set RSUsers = ObjUConn.Execute("SELECT DISTINCT(UserName),RealName FROM Users ORDER BY UserName")

	If Not(RSUsers.EOF) Then
		%>
		<SELECT NAME="UserName">
		<%
		Do While Not(RSUsers.EOF)
			UserNom = RSUsers("UserName")
			RealName = RSUsers("RealName")
			%>
			<option value="<% Response.Write(UserNom) %>"<% If UserNom & "" = UserArg & "" Then %> SELECTED<% End If %>><% Response.Write(UserNom) %> (<% =RealName %>)
			<%
			RSUsers.MoveNext
		Loop
		%>
		</SELECT>
		<%
	End If
	RSUsers.Close 
	Set RSUsers=Nothing 
	ObjUConn.Close 
	Set ObjUConn=Nothing

End Function

ManySeconds = DateDiff("s", DateSerial(2002, 9, 9), Date())

Randomize
ManySeconds = CStr(ManySeconds) & CStr(Int(Rnd * 300))
Problem = ""
%>