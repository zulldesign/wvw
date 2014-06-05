<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di gestire il sondaggio

	'Se il sondaggio è abilitato eseguo il codice relativo
	If Abilita_Sondaggio Then
%>
	<div class="modulo">
		<div class="modtitolo">
			<img src="<%=Path_Skin%>titolo_sondaggio.gif" alt="Titolo" />
		</div>
		<div class="modcontenuto">
<%
		Dim SQLSondaggio, RSSondaggio

		'Cerco il sondaggio attivo ovvero l''ultimo inserito
		SQLSondaggio = " SELECT TOP 1 * FROM [Sondaggio] ORDER BY Sondaggio.ID DESC "
		Set RSSondaggio = Server.CreateObject("ADODB.Recordset")
		RSSondaggio.Open SQLSondaggio, Conn, 1, 3

		'E visualizzo le domande relative (massimo 10)
		If RSSondaggio.EOF = False Then
			RSSondaggio.MoveFirst
%>
			<form action="vota.asp" method="post">
				<div><input type="hidden" name="Sondaggio" value="<%=RSSondaggio("ID")%>" /></div>
				<div><%=RSSondaggio("Domanda")%><br /><br /></div>
<%
			For Counter = 1 To 10
				If RSSondaggio("Risposta" & Counter) <> "" Then
					Dim AbilitazioneSondaggio : AbilitazioneSondaggio = ""
					If Request.Cookies("GiaVotato" & RSSondaggio("ID")) = "si" Then AbilitazioneSondaggio = "disabled=""disabled"""
%>
			<div><input type="radio" value="<%=Counter%>" name="Risposta" <%=AbilitazioneSondaggio%> />&nbsp;<%=RSSondaggio("Risposta" & Counter)%></div>
<%
					End If
			Next
%>
				<div>
					<br /><a href="risultati.asp"><%=Testo_Sondaggio_VisualizzaRisultati%></a>
<%
			If Request.Cookies("GiaVotato" & RSSondaggio("ID")) <> "si" Then
%>
 					&nbsp;<%=Testo_Sondaggio_Oppure%> <input type="image" src="<%=Path_Skin%>pulsante_vota.gif" alt="<%=ALT_Pulsante_Vota%>" name="Vota" value="<%=Testo_Sondaggio_PulsanteVota%>" />
<%
			End If
%>
				</div>
			</form>
<%
		Else
%>
			<%=Errore_Sondaggio_NonDisponibile%>
<%
		End If

	Set RSSondaggio = Nothing
%>
		</div>
	</div>
<%
	End If
%>