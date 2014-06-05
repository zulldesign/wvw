<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di visualizzare i risultati temporanei del sondaggio attuale o di quelli già conclusi
%>
<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--#include file="inc_db.asp"-->
<!--#include file="inc_funzioni.asp"-->
<!--#include file="inc_moduli.asp"-->
<%
	Sub Contenuto()
%>
	<div id="briciole">\\ <span><a href="default.asp"><%=Sezione_HomePage%></a> : <%=Sezione_Sondaggi%></span></div>
<%
		'Visualizzo il contenuto della pagina solo se il sondaggio è abilitato
		If Abilita_Sondaggio = False Then
%>
	<div class="giustificato"><%=Errore_Sondaggio_NonAbilitato%></div>
<%
		Else
			Dim SQLRisultati, RSRisultati, SQLVecchi, RSVecchi, ArraySondaggio, X, TotaleVoti
%>
	<div class="giustificato"><%=Testo_Segue_Risultati%></div>
<%
			'Cerco i risultati relativi al sondaggio richiesto
			If Request.QueryString("sondaggio") <> "" AND Request.QueryString("sondaggio") <> "0" AND IsNumeric(Request.QueryString("sondaggio")) = True Then
				SQLRisultati = " SELECT * FROM [Sondaggio] WHERE Sondaggio.ID = "& cInt(Request.QueryString("sondaggio")) &" "
			Else
				SQLRisultati = " SELECT TOP 1 * FROM [Sondaggio] ORDER BY Sondaggio.ID DESC "
			End If
			Set RSRisultati = Server.CreateObject("ADODB.Recordset")
			RSRisultati.Open SQLRisultati, Conn, 1, 3

			'Li visualizzo in una tabella
			If RSRisultati.EOF = False Then
				RSRisultati.MoveFirst
				ArraySondaggio = RSRisultati.GetRows
%>
	<div class="sondaggio">
		<div class="insondaggio">
			<strong><%=Testo_Sondaggio_Domanda%></strong>
			<br /><%=ArraySondaggio(1, 0)%>
			<br />
			<br /><strong><%=Testo_Sondaggio_Risposte%></strong>
<%
				TotaleVoti = 0
				For X = 2 To 21 Step 2
					If ArraySondaggio(X, 0) <> "" Then
%>
			<br />- <%=ArraySondaggio(X, 0)%>&nbsp;<i>(<%=ArraySondaggio(X+1, 0)%>&nbsp;<%=Testo_Sondaggio_Voti%>)</i>
<%
						TotaleVoti = TotaleVoti + ArraySondaggio(X+1, 0)
					End If
				Next
%>
			<br />
			<br /><strong><%=Testo_Sondaggio_TotaleVoti%></strong>
			<br /><%=TotaleVoti%>
			<br />
			<br /><strong><%=Testo_Sondaggio_Grafico%></strong>
			<br />
			<table>
				<tr>
<%
				'Ed anche in un semplice formato grafico
				For X = 3 To 22 Step 2
					If ArraySondaggio(X-1, 0) <> "" Then
%>
					<td>
						<img src="<%=Path_Skin%>pixel_azzurro.gif" alt="" height="<%If TotaleVoti <> 0 Then Response.Write (ArraySondaggio(X, 0) * 100 \ TotaleVoti) * 2 Else Response.Write "0" End If%>" />
					</td>
<%
					End If
				Next
%>
				</tr>
			</table>
		</div>
	</div>
	<br />
	<br />

	<div class="titolo"><%=Testo_Sondaggio_Precedenti%></div>
<%
				'Cerco eventuali altri sondaggi conclusi
				SQLVecchi = " SELECT [ID], [Domanda] FROM [Sondaggio] ORDER BY Sondaggio.ID DESC "
				Set RSVecchi = Server.CreateObject("ADODB.Recordset")
				RSVecchi.Open SQLVecchi, Conn, 1, 3

				'E nel caso li visualizzo per la consultazione
				If RSVecchi.EOF = False Then
					Do While NOT RSVecchi.EOF
%>
	<br />- <a href="risultati.asp?sondaggio=<%=RSVecchi("ID")%>"><%=RSVecchi("Domanda")%></a>
<%
						RSVecchi.MoveNext
					Loop
				End If

				Set RSVecchi = Nothing
			Else
%>
	<div class="giustificato"><%=Errore_Sondaggio_NonDisponibile%></div>
<%
			End If

			Set RSRisultati = Nothing
		End If
	End Sub

	Call GeneraPagina(Server.MapPath(Path_Template & "pagina.htm"), "", "", "")

	Conn.Close
	Set Conn = Nothing
%>