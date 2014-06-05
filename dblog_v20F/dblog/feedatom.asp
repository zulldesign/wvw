<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--#include file="inc_db.asp"-->
<!--#include file="inc_funzioni.asp"-->
<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di generare il feed ATOM in un formato utilizzabile da programmi e siti esterni

	Dim SQLArticoli, RSArticoli

	Response.ContentType = "text/xml"

	Response.Charset = "windows-1252"
	Response.Write "<?xml version=""1.0"" encoding=""windows-1252""?>"
	Response.Write "<feed version=""0.3"" xmlns:wfw=""http://wellformedweb.org/CommentAPI/"" xmlns:slash=""http://purl.org/rss/1.0/modules/slash/"" xmlns:trackback=""http://madskills.com/public/xml/rss/module/trackback/"" xmlns=""http://purl.org/atom/ns#"" xml:lang=""it-it"">" & VbCrLf
	Response.Write "	<title>"& Nome_Blog &"</title>" & VbCrLf
	Response.Write "	<link rel=""alternate"" type=""text/html"" href="""& URL_Blog &""" />" & VbCrLf
	Response.Write "	<tagline type=""text/html"">"& Nome_Blog &"</tagline>" & VbCrLf
	Response.Write "	<id>"& URL_Blog &"</id>" & VbCrLf
	Response.Write "	<generator url="""& URL_Blog &"feedatom.asp"" version="""& Nome_Blog &""">"& Nome_Blog &" 2.0</generator>" & VbCrLf
	Response.Write "	<author>" & VbCrLf
	Response.Write "		<name>"& Nome_Blog &"</name>" & VbCrLf
	Response.Write "		<url>"& URL_Blog &"</url>" & VbCrLf
	Response.Write "	</author>" & VbCrLf

'Cerco tutti gli articoli e li visualizzo in formato xml
	SQLArticoli = " SELECT TOP "& Num_Max_Articoli &" Articoli.ID, Articoli.Autore, Articoli.Titolo, Articoli.Testo, Articoli.Data, Articoli.Ora, Count(Commenti.ID) AS TotaleCommenti FROM Commenti RIGHT JOIN Articoli ON Commenti.IDArticolo = Articoli.ID GROUP BY Articoli.ID, Articoli.Autore, Articoli.Titolo, Articoli.Testo, Articoli.Data, Articoli.Ora, Articoli.Bozza HAVING Articoli.Data <= '"& DataToStr(Date()) &"' AND Articoli.Bozza = False ORDER BY Articoli.Data DESC, Articoli.Ora DESC "
	Set RSArticoli = Server.CreateObject("ADODB.Recordset")
	RSArticoli.Open SQLArticoli, Conn, 1, 3

	If NOT RSArticoli.EOF Then
		RSArticoli.MoveFirst
		Response.Write "	<modified>"& Mid(RSArticoli("Data"), 1, 4) & "-" & Mid(RSArticoli("Data"), 5, 2) & "-" & Mid(RSArticoli("Data"), 7, 2) & "T" & Mid(RSArticoli("Ora"), 1, 2) & ":" & Mid(RSArticoli("Ora"), 3, 2) & ":" & Mid(RSArticoli("Ora"), 5, 2) & "+01:00</modified>" & VbCrLf
		Do While NOT RSArticoli.EOF
			If Now() > cDate(StrToData(RSArticoli("Data")) & " " & StrToOra(RSArticoli("Ora"))) Then
				Response.Write "	<entry>" & VbCrLf
				Response.Write "		<title><![CDATA["& NoHTML(DecodeEntities(RSArticoli("Titolo"))) &"]]></title>" & VbCrLf
				Response.Write "		<id>"& URL_Blog &"articolo.asp?articolo="& RSArticoli("ID") &"</id>" & VbCrLf
				Response.Write "		<created>"& Mid(RSArticoli("Data"), 1, 4) & "-" & Mid(RSArticoli("Data"), 5, 2) & "-" & Mid(RSArticoli("Data"), 7, 2) & "T" & Mid(RSArticoli("Ora"), 1, 2) & ":" & Mid(RSArticoli("Ora"), 3, 2) & ":" & Mid(RSArticoli("Ora"), 5, 2) & "+01:00</created>" & VbCrLf
				Response.Write "		<content type=""text/html"" mode=""escaped""><![CDATA["& Replace(FileToVar(Path_DirPublic & RSArticoli("Testo"), 0), Tag_Trailer, "") &"]]></content>" & VbCrLf
				Response.Write "		<link rel=""alternate"" type=""text/html"" href="""& URL_Blog &"articolo.asp?articolo="& RSArticoli("ID") &"""/>" & VbCrLf
				Response.Write "		<issued>"& Mid(RSArticoli("Data"), 1, 4) & "-" & Mid(RSArticoli("Data"), 5, 2) & "-" & Mid(RSArticoli("Data"), 7, 2) & "T" & Mid(RSArticoli("Ora"), 1, 2) & ":" & Mid(RSArticoli("Ora"), 3, 2) & ":" & Mid(RSArticoli("Ora"), 5, 2) & "+01:00</issued>" & VbCrLf
				Response.Write "		<modified>"& Mid(RSArticoli("Data"), 1, 4) & "-" & Mid(RSArticoli("Data"), 5, 2) & "-" & Mid(RSArticoli("Data"), 7, 2) & "T" & Mid(RSArticoli("Ora"), 1, 2) & ":" & Mid(RSArticoli("Ora"), 3, 2) & ":" & Mid(RSArticoli("Ora"), 5, 2) & "+01:00</modified>" & VbCrLf
				Response.Write "		<slash:comments>"& RSArticoli("TotaleCommenti") &"</slash:comments>" & VbCrLf
				Response.Write "		<wfw:comments>"& URL_Blog &"articolo.asp?articolo="& RSArticoli("ID") &"#commenti</wfw:comments>" & VbCrLf
				Response.Write "	</entry>" & VbCrLf
			End If

			RSArticoli.MoveNext
		Loop
	End If

	Response.Write "</feed>"

	set RSArticoli = Nothing

	Conn.Close
	Set Conn = Nothing
%>