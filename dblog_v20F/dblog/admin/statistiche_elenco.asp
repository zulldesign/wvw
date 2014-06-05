<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include file="inc_header.asp"-->
<body bgcolor="<%=Colore_Sfondo_Pagina%>">
<table border="0" width="700" align="center" cellspacing="0" cellpadding="15" bgcolor="<%=Colore_Sfondo_Content%>">
	<tr>
		<td>
			<table border="0" width="700" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
				<tr>
					<td width="700">
						<table border="0" width="700" cellspacing="0" cellpadding="0">
							<tr>
								<td width="550" valign="top" style="PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px">
									<p align="justify">
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <%=Testo_Sezione_Statistiche%></b>
									</p>
									<p align="justify">
										<b><%=Testo_Sezione_Articoli%></b>
<%
	Dim SQLArticoli, RSArticoli, TotaleArticoli, TotaleArticoliLetture
	SQLArticoli = " SELECT COUNT(ID) AS TotaleArticoli, [Sezione], SUM(Letture) AS TotaleArticoliLetture FROM [Articoli] GROUP BY [Sezione] "
	Set RSArticoli = Server.CreateObject("ADODB.Recordset")
	RSArticoli.Open SQLArticoli, Conn, 1, 3

	TotaleArticoli = 0
	TotaleArticoliLetture = 0
	If NOT RSArticoli.EOF Then
		Do While NOT RSArticoli.EOF
%>
										<br><%=Testo_Modulo_CampoSezione%> <a href="/dblog/storico.asp?s=<%=RSArticoli("Sezione")%>"><%=RSArticoli("Sezione")%></a> (<%=Testo_Articoli_IntroduzioneTotaleArticoli%>: <%=RSArticoli("TotaleArticoli")%>, <%=Testo_Modulo_CampoLetture%>: <%=RSArticoli("TotaleArticoliLetture")%>)
<%
			TotaleArticoli = TotaleArticoli + RSArticoli("TotaleArticoli")
			TotaleArticoliLetture = TotaleArticoliLetture + RSArticoli("TotaleArticoliLetture")
			RSArticoli.MoveNext
		Loop
	End If
%>
										<br>
										<br><%=Testo_Articoli_IntroduzioneTotaleArticoli%>: <%=TotaleArticoli%>
										<br><%=Testo_Modulo_CampoLetture%>: <%=TotaleArticoliLetture%>
									</p>
									<p align="justify">
										<b><%=Testo_Sezione_Fotografie%></b>
<%
	Dim SQLFotografie, RSFotografie, TotaleFotografie, TotaleFotografieLetture

	SQLFotografie = " SELECT COUNT(ID) AS TotaleFotografie, [Sezione], SUM(Letture) AS TotaleFotografieLetture FROM [Fotografie] GROUP BY [Sezione] "
	Set RSFotografie = Server.CreateObject("ADODB.Recordset")
	RSFotografie.Open SQLFotografie, Conn, 1, 3

	TotaleFotografie = 0
	TotaleFotografieLetture = 0
	If NOT RSFotografie.EOF Then
		Do While NOT RSFotografie.EOF
%>
										<br><%=Testo_Modulo_CampoSezione%> <a href="/dblog/foto.asp?s=<%=RSFotografie("Sezione")%>"><%=RSFotografie("Sezione")%></a> (<%=Testo_Fotografie_IntroduzioneTotaleFotografie%>: <%=RSFotografie("TotaleFotografie")%>, <%=Testo_Modulo_CampoLetture%>: <%=RSFotografie("TotaleFotografieLetture")%>)
<%
			TotaleFotografie = TotaleFotografie + RSFotografie("TotaleFotografie")
			TotaleFotografieLetture = TotaleFotografieLetture + RSFotografie("TotaleFotografieLetture")
			RSFotografie.MoveNext
		Loop
	End If
%>
										<br>
										<br><%=Testo_Fotografie_IntroduzioneTotaleFotografie%>: <%=TotaleFotografie%>
										<br><%=Testo_Modulo_CampoLetture%>: <%=TotaleFotografieLetture%>
									</p>
									<p align="justify">
										<b><%=Testo_Sezione_LinkLog%></b>
<%
	Dim SQLLinkLog, RSLinkLog, TotaleLinkLog

	SQLLinkLog = " SELECT COUNT(ID) AS TotaleFotografie FROM [LinkLog] "
	Set RSLinkLog = Server.CreateObject("ADODB.Recordset")
	RSLinkLog.Open SQLLinkLog, Conn, 1, 3

	If NOT RSLinkLog.EOF Then
		TotaleLinkLog = RSLinkLog.RecordCount
	Else
		TotaleLinkLog = 0
	End If
%>
										<br><%=Testo_LinkLog_IntroduzioneTotaleLinkLog%>: <%=TotaleLinkLog%>
									</p>
									<p align="justify">
										<b><%=Testo_Sezione_Commenti%></b>
<%
	Dim SQLCommenti, RSCommenti, TotaleCommentiA, TotaleCommentiF

	SQLCommenti = " SELECT [ID], [IDArticolo], [IDFotografia] FROM [Commenti] "
	Set RSCommenti = Server.CreateObject("ADODB.Recordset")
	RSCommenti.Open SQLCommenti, Conn, 1, 3

	TotaleCommentiA = 0
	TotaleCommentiF = 0
	If NOT RSCommenti.EOF Then
		Do While NOT RSCommenti.EOF
				If RSCommenti("IDArticolo") <> 0 Then
					TotaleCommentiA = TotaleCommentiA + 1
				End If
				If RSCommenti("IDFotografia") <> 0 Then
					TotaleCommentiF = TotaleCommentiF + 1
				End If
			RSCommenti.MoveNext
		Loop
%>
										<br><a href="/dblog/storico.asp"><%=Testo_Sezione_Articoli%></a>: <%=TotaleCommentiA%>&nbsp;<%=Testo_Sezione_Commenti%> 
										<br><a href="/dblog/foto.asp"><%=Testo_Sezione_Fotografie%></a>: <%=TotaleCommentiF%>&nbsp;<%=Testo_Sezione_Commenti%>
<%
	End If
%>
										<br>
										<br><%=Testo_Commenti_TotaleCommentiRicevuti%>: <%=RSCommenti.RecordCount%>
									</p>
									<p align="justify">
										<b><%=Testo_Sezione_Sondaggio%></b>
<%
	Dim SQLSondaggi, RSSondaggi, TotaleSondaggi, TotaleVoti

	SQLSondaggi = " SELECT [ID], [Voti1], [Voti2], [Voti3], [Voti4], [Voti5], [Voti6], [Voti7], [Voti8], [Voti9], [Voti10] FROM [Sondaggio] "
	Set RSSondaggi = Server.CreateObject("ADODB.Recordset")
	RSSondaggi.Open SQLSondaggi, Conn, 1, 3

	TotaleSondaggi = RSSondaggi.RecordCount
	TotaleVoti = 0
	If NOT RSSondaggi.EOF Then
		Do While NOT RSSondaggi.EOF
			TotaleVoti = TotaleVoti + RSSondaggi("Voti1") + RSSondaggi("Voti2") + RSSondaggi("Voti3") + RSSondaggi("Voti4") + RSSondaggi("Voti5") + RSSondaggi("Voti6") + RSSondaggi("Voti7") + RSSondaggi("Voti8") + RSSondaggi("Voti9") + RSSondaggi("Voti10")
			RSSondaggi.MoveNext
		Loop
	End If
%>
										<br><%=Testo_Sondaggi_TotaleSondaggiProposti%>: <%=TotaleSondaggi%>
										<br><%=Testo_Sondaggi_TotaleVotiRicevuti%>: <%=TotaleVoti%>
									</p>
									<p align="justify">
										<b><%=Testo_Sezione_Citazioni%></b>
<%
	Dim SQLCitazioni, RSCitazioni, TotaleCitazioni

	SQLCitazioni = " SELECT COUNT(ID) AS TotaleCitazioni, [Autore] FROM [Citazioni] GROUP BY [Autore] "
	Set RSCitazioni = Server.CreateObject("ADODB.Recordset")
	RSCitazioni.Open SQLCitazioni, Conn, 1, 3

	TotaleCitazioni = 0
	If NOT RSCitazioni.EOF Then
		Do While NOT RSCitazioni.EOF
%>
										<br><%=Testo_Modulo_CampoAutore%>&nbsp;<%=RSCitazioni("Autore")%> (<%=Testo_Citazioni_TotalePerAutore%>: <%=RSCitazioni("TotaleCitazioni")%>)
<%
			TotaleCitazioni = TotaleCitazioni + RSCitazioni("TotaleCitazioni")
			RSCitazioni.MoveNext
		Loop
	End If
%>
										<br>
										<br><%=Testo_Citazioni_TotaleCitazioni%>: <%=TotaleCitazioni%>
									</p>
									<p align="justify">
										<b><%=Testo_Sezione_Autori%></b>
<%
	Dim SQLAutori, RSAutori, TotaleAutori

	SQLAutori = " SELECT Autori.Nick, COUNT(Articoli.ID) AS TotaleArticoliAutore FROM ([Autori] INNER JOIN [Articoli] ON Autori.Nick = Articoli.Autore) GROUP BY Autori.Nick "
	Set RSAutori = Server.CreateObject("ADODB.Recordset")
	RSAutori.Open SQLAutori, Conn, 1, 3

	TotaleAutori = 0
	If NOT RSAutori.EOF Then
		Do While NOT RSAutori.EOF
%>
										<br><a href="/dblog/autori.asp?chi=<%=RSAutori("Nick")%>"><%=RSAutori("Nick")%></a> (<%=Testo_Articoli_IntroduzioneTotaleArticoli%>: <%=RSAutori("TotaleArticoliAutore")%>)
<%
			RSAutori.MoveNext
		Loop
		TotaleAutori = RSAutori.RecordCount
	End If
%>										<br>
										<br><%=Testo_Autori_TotaleAutori%>: <%=TotaleAutori%>
									</p>
									<p>
										&nbsp;
									</p>
								</td>
								<td width="150" valign="top" style="PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px">
									<!--#include file="inc_destra.asp"-->
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td width="700" bgcolor="<%=Colore_Sfondo_Footer%>">
						<!--#include file="inc_footer.asp"-->
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</body>
</html>
<%
	Set RSArticoli = Nothing
	Set RSFotografie = Nothing
	Set RSLinkLog= Nothing
	Set RSCommenti = Nothing
	Set RSCitazioni = Nothing
	Set RSAutori = Nothing

	Conn.Close
	Set Conn = Nothing
%>