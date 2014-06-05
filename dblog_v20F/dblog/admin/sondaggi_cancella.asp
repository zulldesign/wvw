<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include file="inc_header.asp"-->

<%
	Dim SQLSondaggi, RSSondaggi, FID

		If Request.QueryString("id") <> "" AND Request.QueryString("id") <> "0" AND IsNumeric(Request.QueryString("id")) = True  Then
			FID = Request.QueryString("id")
		Else
			FID = 0
		End If
%>

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
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <a href="sondaggi_elenco.asp"><%=Testo_Sezione_Sondaggio%></a> : <%=Testo_Modulo_PulsanteCancella%></b>
									</p>
<%
	If Session("BLOGAdmin") = True Then
		SQLSondaggi = " DELETE * FROM [Sondaggio] WHERE [ID] = "& cInt(FID) &" "
		Set RSSondaggi = Server.CreateObject("ADODB.Recordset")
		RSSondaggi.Open SQLSondaggi, Conn, 1, 3
%>
									<p align="justify">
										<%=Testo_Sondaggi_CancellazioneABuonFine%>, <a href="<%=Request.ServerVariables("HTTP_REFERER")%>"><%=Testo_Sondaggio_LinkTornaIndietro%></a>.
									</p>
<%
	Else
%>
									<%=Testo_Errore_FunzioneRiservataAdmin%>
<%
	End If
%>
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
	Set RSSondaggi = Nothing

	Conn.Close
	Set Conn = Nothing
%>