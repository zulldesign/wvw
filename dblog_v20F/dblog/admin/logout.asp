<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<%
	Session("BLOGNick") = ""
	Session("BLOGAdmin") = False

	Response.Redirect "login.asp"
%>