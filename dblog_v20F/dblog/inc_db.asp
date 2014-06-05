<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script gestisce la connessione al DataBase per il lato utente

	Dim Conn, StrConn

	Set Conn = Server.CreateObject("ADODB.Connection")
	Conn.Open "Provider = Microsoft.Jet.OLEDB.4.0; Data Source = "& Server.MapPath(Path_DirScrittura & Nome_DataBase) &";"
%>