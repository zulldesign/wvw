<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0

	If (Session("BLOGNick") = "" OR Session("BLOGNick") = Null) AND Mid(Request.ServerVariables("SCRIPT_NAME"), InStrRev(Request.ServerVariables("SCRIPT_NAME"), "/") + 1) <> "login.asp" Then
		Response.Redirect "login.asp"
	End If
%>