<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di ricevere i voti del sondaggio
%>
<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--#include file="inc_db.asp"-->
<!--#include file="inc_funzioni.asp"-->
<%
	Dim SQLVoto, RSVoto, FRisposta, FSondaggio

	FRisposta = DoppioApice(Request.Form("Risposta"))
	FSondaggio = DoppioApice(Request.Form("Sondaggio"))

'Se il sondaggio è abilitato eseguo il conteggio del voto ed aggiorno il database con i nuovi dati
	If Abilita_Sondaggio Then
		If FRisposta <> "" AND FSondaggio <> "" AND IsNumeric(FSondaggio) Then
			SQLVoto = " UPDATE [Sondaggio] SET "
			Select Case FRisposta
				Case "1"	SQLVoto = SQLVoto & "Sondaggio.Voti1 = Sondaggio.Voti1 + 1 "
				Case "2"	SQLVoto = SQLVoto & "Sondaggio.Voti2 = Sondaggio.Voti2 + 1 "
				Case "3"	SQLVoto = SQLVoto & "Sondaggio.Voti3 = Sondaggio.Voti3 + 1 "
				Case "4"	SQLVoto = SQLVoto & "Sondaggio.Voti4 = Sondaggio.Voti4 + 1 "
				Case "5"	SQLVoto = SQLVoto & "Sondaggio.Voti5 = Sondaggio.Voti5 + 1 "
				Case "6"	SQLVoto = SQLVoto & "Sondaggio.Voti6 = Sondaggio.Voti6 + 1 "
				Case "7"	SQLVoto = SQLVoto & "Sondaggio.Voti7 = Sondaggio.Voti7 + 1 "
				Case "8"	SQLVoto = SQLVoto & "Sondaggio.Voti8 = Sondaggio.Voti8 + 1 "
				Case "9"	SQLVoto = SQLVoto & "Sondaggio.Voti9 = Sondaggio.Voti9 + 1 "
				Case "10"	SQLVoto = SQLVoto & "Sondaggio.Voti10 = Sondaggio.Voti10 + 1 "
			End Select
			SQLVoto = SQLVoto & "WHERE Sondaggio.ID = "& cInt(FSondaggio) &" "
			Set RSVoto = Server.CreateObject("ADODB.Recordset")
			RSVoto.Open SQLVoto, Conn, 1, 3

			Set RSVoto = Nothing

			Response.Cookies("GiaVotato" & FSondaggio) = "si"
		End If
	End If

	Conn.Close
	Set Conn = Nothing

	Response.Redirect "risultati.asp"
%>