<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di modificare la tabella Autori, creare la tabella LinkLog, aggiungere il campo Podcast alla tabella Articoli, criptare le password e sostituire i path degli smile nei commenti e nei post per passare dalla versione 1.4 alla versione 2.0, da cancellare assolutamente dopo l'uso
%>
<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--#include file="dblog/inc_db.asp"-->
<!--#include file="dblog/inc_funzioni.asp"-->
<!--#include file="dblog/admin/inc_sha-1.asp"-->
<%
	StringaDaTrovare = "/dblog/gfx/smile_"
	StringaDaUtilizzare = Path_Skin & "smile_"

	Set FSO = CreateObject("Scripting.FileSystemObject")
	Set Cartella = FSO.GetFolder(Server.MapPath(Path_DirPublic))
	Set Documenti = Cartella.Files

	TotaleFileTXT = 0
	TotaleFileTXTModificati = 0

	For Each Documento in Documenti
		If Right(Documento.Name, 4) = ".txt" AND Len(Documento.Name) = 10 AND IsNumeric(Left(Documento.Name, 6)) Then
			TotaleFileTXT = TotaleFileTXT + 1

			Contenuto = ""
			If Documento.Size > 0 Then
				Set FileTXT = FSO.OpenTextFile(Server.MapPath(Path_DirPublic) &"/"& Documento.Name, 1)
				Contenuto = FileTXT.ReadAll
				Set FileTXT = Nothing
			End If

			If Len(Contenuto) > 0 AND InStr(Contenuto, StringaDaTrovare) Then
				Contenuto = Replace(Contenuto, StringaDaTrovare, StringaDaUtilizzare)

				Set FileTXT = FSO.OpenTextFile(Server.MapPath(Path_DirPublic) &"/"& Documento.Name, 2, True)
				FileTXT.Write Contenuto
				Set FileTXT = Nothing

				TotaleFileTXTModificati = TotaleFileTXTModificati + 1
			End If
		End If
	Next

	Set Cartella = Nothing
	Set Documenti = Nothing
	Set FSO = Nothing
%>
	<p>
		<b>Conversione dei path degli Smile nei file txt (post)</b>
	</p>
	<p>
		Totale file txt (post): <%=TotaleFileTXT%>
		<br>Totale file txt (post) modificati: <%=TotaleFileTXTModificati%>
	</p>
<%
	SQLVecchiCommenti = " SELECT ID, Testo FROM Commenti "
	Set RSVecchiCommenti = Server.CreateObject("ADODB.Recordset")
	RSVecchiCommenti.Open SQLVecchiCommenti, Conn, 1, 3

	TotaleCommenti = 0
	TotaleCommentiModificati = 0

	If NOT RSVecchiCommenti.EOF Then
		TotaleCommenti = RSVecchiCommenti.RecordCount

		Do While NOT RSVecchiCommenti.EOF
			If InStr(RSVecchiCommenti("Testo"), StringaDaTrovare) > 0 Then
				SQLNuoviCommenti = " UPDATE Commenti SET Commenti.Testo = '"& Replace(Replace(RSVecchiCommenti("Testo"), StringaDaTrovare, StringaDaUtilizzare), "'", "''") &"' WHERE Commenti.ID = "& RSVecchiCommenti("ID") &" "
				Set RSNuoviCommenti = Server.CreateObject("ADODB.Recordset")
				RSNuoviCommenti.Open SQLNuoviCommenti, Conn, 1, 3

				Set RSNuoviCommenti = Nothing
				TotaleCommentiModificati = TotaleCommentiModificati + 1
			End If
			RSVecchiCommenti.MoveNext
		Loop
	End If

	RSVecchiCommenti.Close
	Set RSVecchiCommenti = Nothing
%>
	<p>
		<b>Conversione dei path degli Smile nei commenti</b>
	</p>
	<p>
		Totale commenti: <%=TotaleCommenti%>
		<br>Totale commenti con smile, modificati: <%=TotaleCommentiModificati%>
	</p>
	<p>
		<b>Conversione delle password in SHA-1 criptate a 160 bit</b>
	</p>
<%
	SQLAlterPassword = " ALTER TABLE Autori ALTER COLUMN [Password] TEXT(40)"
	Conn.Execute SQLAlterPassword

	SQLVecchiePWD = " SELECT UserID, [Password] FROM Autori "
	Set RSVecchiePWD = Server.CreateObject("ADODB.Recordset")
	RSVecchiePWD.Open SQLVecchiePWD, Conn, 1, 3

	TotaleAutori = 0
	TotaleAutoriModificati = 0

	If NOT RSVecchiePWD.EOF Then
		TotaleAutori = RSVecchiePWD.RecordCount

		Do While NOT RSVecchiePWD.EOF
			If NOT Len(RSVecchiePWD("Password")) = 40 Then
				SQLNuovePWD = " UPDATE Autori SET [Password] = '"& getSHAPassword(RSVecchiePWD("Password")) &"' WHERE Autori.UserID = '"& ControlloSQLInjection(RSVecchiePWD("UserID")) &"' "
				Set RSNuovePWD = Server.CreateObject("ADODB.Recordset")
				RSNuovePWD.Open SQLNuovePWD, Conn, 1, 3

				Set RSNuovePWD = Nothing
				TotaleAutoriModificati = TotaleAutoriModificati + 1
			End If
			RSVecchiePWD.MoveNext
		Loop
	End If

	RSVecchiePWD.Close
	Set RSVecchiePWD = Nothing
%>
	<p>
		Totale password: <%=TotaleAutori%>
		<br>Totale password vecchie, modificate: <%=TotaleAutoriModificati%>
	</p>
<%
	SQLCreateLinkLog = " CREATE TABLE LinkLog ([ID] COUNTER PRIMARY KEY, [Autore] TEXT(50), [Introduzione] TEXT(250), [TestoLinkato] TEXT(250), [URL] MEMO, [Data] TEXT(8))"
	Conn.Execute SQLCreateLinkLog 
%>
	<p>
		Tabella LinkLog creata!
	</p>
	<p>
		<b>Inserimento del campo Podcast nella tabella Articoli</b>
	</p>
<%
	SQLAlterArticoli = " ALTER TABLE Articoli ADD [Podcast] TEXT(250)"	
	Conn.Execute SQLAlterArticoli
%>
	<p>
		Tabella Articoli modificata!
	</p>
	<p>
		<font color="red"><b>RICORDA: cancellare subito i file "da_14_a_20.asp" e "da_20rc2_a_20.asp" dalla root del sito!!</b></font>
	</p>
<%
	Conn.Close
	Set Conn = Nothing
%>
