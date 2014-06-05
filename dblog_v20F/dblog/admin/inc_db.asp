<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0

	Dim Conn, StrConn

	Set Conn = Server.CreateObject("ADODB.Connection")
	Conn.Open "Provider = Microsoft.Jet.OLEDB.4.0; Data Source = "& Server.MapPath(Path_DirScrittura & Nome_DataBase) &";"
%>