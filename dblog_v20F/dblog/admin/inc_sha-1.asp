<%
' TITLE:
'
'	Secure Hash Algorithm, SHA-1
'
' PURPOSE:
'
'	for computing a condensed representation of a
'	message or a data file.
'
' Ported By Lewis Moten From Visual Basic Code posted
' at Planet-Source-Code by Peter Girard
'
' http://www.planetsourcecode.com/xq/ASP/txtCodeId.13565/lngWId.1/qx/vb/scripts/ShowCode.htm
'
' The function SecureHash generates a 160-bit (20-hex-digit)
' message digest for a given message (String) of any length.
' The digest is unique to the message. It is not possible to
' recover the message from the digest. The only way to find
' the source message for a digest is by the brute force
' hashing of all possible messages and comparison of their
' digests. For a complete description see FIPS Publication
' 180-1: http://www.itl.nist.gov/fipspubs/fip180-1.htm (HTML
' version) http://csrc.nist.gov/fips/fip180-1.txt (plain text
' version) I wrote this a few months ago, prior to recent PSC
' submissions describing how to use Internet Explorer's hashing
' functions (in advapi32.dll). It is present here solely for
' your edificaton and entertainment.
'
' ------------------------------------------------------------------------------
'THIS IS MY PERSONAL/OFFICIAL REQUEST FOR USE THIS LIBRARY IN DBLOG, CONFIRMED BY AUTHOR :-)
'Date: Wed, 1 Jun 2005 03:33:09 -0400
'From: lewis moten <lewismoten@gmail.com>
'To: marlenek@dblog.it
'Subject: Re: Request: your algorithm
'
'On 5/30/05, dBlog.it - Daniele <marlenek@dblog.it> wrote:
'> Hi Lewis, I find your routine SHA-1 at
'> http://www.planetsourcecode.com/vb/scripts/ShowCode.asp?txtCodeId=3D6545&=lngWId=3D4
'> and I would like to use it in the new version of dBlog CMS Open Source
'> software. In that page you wrote: "You MAY NOT redistribute this code
'> (for example to a web site) without written permission from the original
'> author. Failure to do so is a violation of copyright laws" so I'm here
'> to asking you a permission :)
'> Thank you in advance
'
'Go for it.
'
'Lewis E. Moten III
'http://lewismoten.blogspot.com
'lewismoten@gmail.com
' ------------------------------------------------------------------------------
'
' USAGE:
'
'	Dim ObjSHA1
'	Dim StrDigest
'	Set ObjSHA1 = New clsSHA1
'	StrDigest = ObjSHA1.SecureHash("Message")
'	Set ObjSHA1 = Nothing
'
' SAMPLE:
'
'	Message: "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq"
'	Returns Digest: "84983E441C3BD26EBAAE4AA1F95129E5E54670F1"
'
' ------------------------------------------------------------------------------
function getSHAPassword(strPassword)
	Dim ObjSHA1

	Set ObjSHA1 = New clsSHA1
	getSHAPassword = ObjSHA1.SecureHash(strPassword)
	Set ObjSHA1 = Nothing
end function

Class clsSHA1
' ------------------------------------------------------------------------------
	Private Function AndW(ByRef pBytWord1Ary, ByRef pBytWord2Ary)
		Dim lBytWordAry(3)
		Dim lLngIndex
		For lLngIndex = 0 To 3
			lBytWordAry(lLngIndex) = CByte(pBytWord1Ary(lLngIndex) And pBytWord2Ary(lLngIndex))
		Next
		AndW = lBytWordAry
	End Function
' ------------------------------------------------------------------------------
	Private Function OrW(ByRef pBytWord1Ary, ByRef pBytWord2Ary)
		Dim lBytWordAry(3)
		Dim lLngIndex
		For lLngIndex = 0 To 3
			lBytWordAry(lLngIndex) = CByte(pBytWord1Ary(lLngIndex) Or pBytWord2Ary(lLngIndex))
		Next
		OrW = lBytWordAry
	End Function
' ------------------------------------------------------------------------------
	Private Function XorW(ByRef pBytWord1Ary, ByRef pBytWord2Ary)
		Dim lBytWordAry(3)
		Dim lLngIndex
		For lLngIndex = 0 To 3
			lBytWordAry(lLngIndex) = CByte(pBytWord1Ary(lLngIndex) Xor pBytWord2Ary(lLngIndex))
		Next
		XorW = lBytWordAry
	End Function
' ------------------------------------------------------------------------------
	Private Function NotW(ByRef pBytWordAry)
		Dim lBytWordAry(3)
		Dim lLngIndex
		For lLngIndex = 0 To 3
			lBytWordAry(lLngIndex) = Not CByte(pBytWordAry(lLngIndex))
		Next
		NotW = lBytWordAry
	End Function
' ------------------------------------------------------------------------------
	Private Function AddW(ByRef pBytWord1Ary, ByRef pBytWord2Ary)
		Dim lLngIndex
		Dim lIntTotal
		Dim lBytWordAry(3)
		For lLngIndex = 3 To 0 Step -1
			If lLngIndex = 3 Then
				lIntTotal = CInt(pBytWord1Ary(lLngIndex)) + pBytWord2Ary(lLngIndex)
				lBytWordAry(lLngIndex) = lIntTotal Mod 256
			Else
				lIntTotal = CInt(pBytWord1Ary(lLngIndex)) + pBytWord2Ary(lLngIndex) + (lIntTotal \ 256)
				lBytWordAry(lLngIndex) = lIntTotal Mod 256
			End If
		Next
		AddW = lBytWordAry
	End Function
' ------------------------------------------------------------------------------
	Private Function CircShiftLeftW(ByRef pBytWordAry, ByRef pLngShift)
		Dim lDbl1
		Dim lDbl2
		lDbl1 = WordToDouble(pBytWordAry)
		lDbl2 = lDbl1
		lDbl1 = CDbl(lDbl1 * (2 ^ pLngShift))
		lDbl2 = CDbl(lDbl2 / (2 ^ (32 - pLngShift)))
		CircShiftLeftW = OrW(DoubleToWord(lDbl1), DoubleToWord(lDbl2))
	End Function
' ------------------------------------------------------------------------------
	Private Function WordToHex(ByRef pBytWordAry)
		Dim lLngIndex
		For lLngIndex = 0 To 3
			WordToHex = WordToHex & Right("0" & Hex(pBytWordAry(lLngIndex)), 2)
		Next
	End Function
' ------------------------------------------------------------------------------
	Private Function HexToWord(ByRef pStrHex)
		HexToWord = DoubleToWord(CDbl("&h" & pStrHex)) ' needs "#" at end for VB?
	End Function
' ------------------------------------------------------------------------------
	Private Function DoubleToWord(ByRef pDblValue)
		Dim lBytWordAry(3)
		lBytWordAry(0) = Int(DMod(pDblValue, 2 ^ 32) / (2 ^ 24))
		lBytWordAry(1) = Int(DMod(pDblValue, 2 ^ 24) / (2 ^ 16))
		lBytWordAry(2) = Int(DMod(pDblValue, 2 ^ 16) / (2 ^ 8))
		lBytWordAry(3) = Int(DMod(pDblValue, 2 ^ 8))
		DoubleToWord = lBytWordAry
	End Function
' ------------------------------------------------------------------------------
	Private Function WordToDouble(ByRef pBytWordAry)
		WordToDouble = CDbl((pBytWordAry(0) * (2 ^ 24)) + (pBytWordAry(1) * (2 ^ 16)) + (pBytWordAry(2) * (2 ^ 8)) + pBytWordAry(3))
	End Function
' ------------------------------------------------------------------------------
	Private Function DMod(ByRef pDblValue, ByRef pDblDivisor)
		Dim lDblMod
		lDblMod = CDbl(CDbl(pDblValue) - (Int(CDbl(pDblValue) / CDbl(pDblDivisor)) * CDbl(pDblDivisor)))
		If lDblMod < 0 Then
			lDblMod = CDbl(lDblMod + pDblDivisor)
		End If
		DMod = lDblMod
	End Function
' ------------------------------------------------------------------------------
	Private Function F( _
		ByRef lIntT, _
		ByRef pBytWordBAry, _
		ByRef pBytWordCAry, _
		ByRef pBytWordDAry _
		)
		If lIntT <= 19 Then
			F = OrW(AndW(pBytWordBAry, pBytWordCAry), AndW((NotW(pBytWordBAry)), pBytWordDAry))
		ElseIf lIntT <= 39 Then
			F = XorW(XorW(pBytWordBAry, pBytWordCAry), pBytWordDAry)
		ElseIf lIntT <= 59 Then
			F = OrW(OrW(AndW(pBytWordBAry, pBytWordCAry), AndW(pBytWordBAry, pBytWordDAry)), AndW(pBytWordCAry, pBytWordDAry))
		Else
			F = XorW(XorW(pBytWordBAry, pBytWordCAry), pBytWordDAry)
		End If
	End Function
' ------------------------------------------------------------------------------
	Public Function SecureHash(ByVal pStrMessage)
		Dim lLngLen
		Dim lBytLenW
		Dim lStrPadMessage
		Dim lLngNumBlocks
		Dim lVarWordWAry(79)
		Dim lLngTempWordWAry
		Dim lStrBlockText
		Dim lStrWordText
		Dim lLngBlock
		Dim lIntT
		Dim lBytTempAry
		Dim lVarWordKAry(3)
		Dim lBytWordH0Ary
		Dim lBytWordH1Ary
		Dim lBytWordH2Ary
		Dim lBytWordH3Ary
		Dim lBytWordH4Ary
		Dim lBytWordAAry
		Dim lBytWordBAry
		Dim lBytWordCAry
		Dim lBytWordDAry
		Dim lBytWordEAry
		Dim lBytWordFAry
		lLngLen = Len(pStrMessage)
		lBytLenW = DoubleToWord(CDbl(lLngLen) * 8)
		lStrPadMessage = pStrMessage & Chr(128) & String((128 - (lLngLen Mod 64) - 9) Mod 64, Chr(0)) & _
		String(4, Chr(0)) & Chr(lBytLenW(0)) & Chr(lBytLenW(1)) & Chr(lBytLenW(2)) & Chr(lBytLenW(3))
		lLngNumBlocks = Len(lStrPadMessage) / 64
		lVarWordKAry(0) = HexToWord("5A827999")
		lVarWordKAry(1) = HexToWord("6ED9EBA1")
		lVarWordKAry(2) = HexToWord("8F1BBCDC")
		lVarWordKAry(3) = HexToWord("CA62C1D6")
		lBytWordH0Ary = HexToWord("67452301")
		lBytWordH1Ary = HexToWord("EFCDAB89")
		lBytWordH2Ary = HexToWord("98BADCFE")
		lBytWordH3Ary = HexToWord("10325476")
		lBytWordH4Ary = HexToWord("C3D2E1F0")
		For lLngBlock = 0 To lLngNumBlocks - 1
			lStrBlockText = Mid(lStrPadMessage, (lLngBlock * 64) + 1, 64)
			For lIntT = 0 To 15
				lStrWordText = Mid(lStrBlockText, (lIntT * 4) + 1, 4)
				lVarWordWAry(lIntT) = Array(Asc(Mid(lStrWordText, 1, 1)), Asc(Mid(lStrWordText, 2, 1)), Asc(Mid(lStrWordText, 3, 1)), Asc(Mid(lStrWordText, 4, 1)))
			Next
			For lIntT = 16 To 79
				lVarWordWAry(lIntT) = CircShiftLeftW(XorW(XorW(XorW(lVarWordWAry(lIntT - 3), lVarWordWAry(lIntT - 8)), lVarWordWAry(lIntT - 14)), lVarWordWAry(lIntT - 16)), 1)
			Next
			lBytWordAAry = lBytWordH0Ary
			lBytWordBAry = lBytWordH1Ary
			lBytWordCAry = lBytWordH2Ary
			lBytWordDAry = lBytWordH3Ary
			lBytWordEAry = lBytWordH4Ary
			For lIntT = 0 To 79
				lBytWordFAry = F(lIntT, lBytWordBAry, _
					lBytWordCAry, lBytWordDAry)
				lBytTempAry = AddW(AddW(AddW(AddW(CircShiftLeftW(lBytWordAAry, 5), lBytWordFAry), lBytWordEAry), lVarWordWAry(lIntT)), lVarWordKAry(lIntT \ 20))
				lBytWordEAry = lBytWordDAry
				lBytWordDAry = lBytWordCAry
				lBytWordCAry = CircShiftLeftW(lBytWordBAry, 30)
				lBytWordBAry = lBytWordAAry
				lBytWordAAry = lBytTempAry
			Next
			lBytWordH0Ary = AddW(lBytWordH0Ary, lBytWordAAry)
			lBytWordH1Ary = AddW(lBytWordH1Ary, lBytWordBAry)
			lBytWordH2Ary = AddW(lBytWordH2Ary, lBytWordCAry)
			lBytWordH3Ary = AddW(lBytWordH3Ary, lBytWordDAry)
			lBytWordH4Ary = AddW(lBytWordH4Ary, lBytWordEAry)
		Next
		SecureHash = _
			WordToHex(lBytWordH0Ary) & _
			WordToHex(lBytWordH1Ary) & _
			WordToHex(lBytWordH2Ary) & _
			WordToHex(lBytWordH3Ary) & _
			WordToHex(lBytWordH4Ary)
	End Function
' ------------------------------------------------------------------------------
End Class
' ------------------------------------------------------------------------------
%>