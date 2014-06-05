<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--#include file="inc_db.asp"-->
<!--#include file="inc_funzioni.asp"-->
<% 
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di generare il feed RSS in un formato utilizzabile da programmi e siti esterni

	Dim SQLArticoli, RSArticoli

	Response.ContentType = "text/xml"

	Response.Charset = "windows-1252"
	Response.Write "<?xml version=""1.0"" encoding=""windows-1252""?>"
	Response.Write "<rss version=""0.91"" xmlns:dc=""http://purl.org/dc/elements/1.1/"">" & VbCrLf
	Response.Write "<channel>" & VbCrLf
	Response.Write "<title>" & Nome_Blog & "</title><link>" & URL_Blog & "</link>" & VbCrLf
	Response.Write "<description>" & Nome_Blog & "</description>"
	Response.Write "<language>it</language>" & VbCrLf

'Cerco tutti gli articoli e li visualizzo in formato xml
	SQLArticoli = " SELECT TOP "& Num_Max_Articoli &" [ID], [Autore], [Titolo], [Testo], [Data], [Ora] FROM Articoli WHERE Articoli.Data <= '"& DataToStr(Date()) &"' AND NOT Articoli.Bozza ORDER BY Articoli.Data DESC, Articoli.Ora DESC "
	Set RSArticoli = Server.CreateObject("ADODB.Recordset")
	RSArticoli.Open SQLArticoli, Conn, 1, 3

	If NOT RSArticoli.EOF Then
		Do While NOT RSArticoli.EOF

			If Now() > cDate(StrToData(RSArticoli("Data")) & " " & StrToOra(RSArticoli("Ora"))) Then
				Response.Write "<item>" & VbCrLf
				Response.Write "	<title><![CDATA["& NoHTML(DecodeEntities(RSArticoli("Titolo"))) &"]]></title>" & VbCrLf
				Response.Write "	<description><![CDATA["& Replace(FileToVar(Path_DirPublic & RSArticoli("Testo"), 0), Tag_Trailer, "") &"]]></description>" & VbCrLf
				Response.Write "	<link><![CDATA["& URL_Blog &"articolo.asp?articolo="& RSArticoli("ID") &"]]></link>" & VbCrLf
				Response.Write "	<guid isPermaLink=""true"">"& URL_Blog &"articolo.asp?articolo="& RSArticoli("ID") &"</guid>" & VbCrLf
				Response.Write "	<dc:date>"& Mid(RSArticoli("Data"), 1, 4) & "-" & Mid(RSArticoli("Data"), 5, 2) & "-" & Mid(RSArticoli("Data"), 7, 2) & "T" & Mid(RSArticoli("Ora"), 1, 2) & ":" & Mid(RSArticoli("Ora"), 3, 2) & ":" & Mid(RSArticoli("Ora"), 5, 2) & "+01:00</dc:date>" & VbCrLf
				Response.Write "	<dc:creator>" & RSArticoli("Autore") & "</dc:creator>" & VbCrLf
				Response.Write "</item>" & VbCrLf
			End If

			RSArticoli.MoveNext
		Loop
	End If

	Response.Write "	</channel>"
	Response.Write "</rss>"

	set RSArticoli = Nothing

	Conn.Close
	Set Conn = Nothing
%>