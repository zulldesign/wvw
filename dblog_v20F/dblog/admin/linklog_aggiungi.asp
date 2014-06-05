<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include file="inc_header.asp"-->

<%
	Dim SQLLinkLog, RSLinkLog, FIntroduzione, FTestoLinkato, FURL, FTitolo, FData, FAutore, Errore
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
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <a href="linklog_elenco.asp"><%=Testo_Sezione_LinkLog%></a> : <%=Testo_Modulo_PulsanteAggiungi%></b>
									</p>
									<p align="justify">
										<%=Testo_LinkLog_IntroduzioneAggiungi%>
									</p>
<%
	If Request.QueryString("a") = "aggiungi" Then
		FIntroduzione = SostituisciCaratteri(DoppioApice(Request.Form("Introduzione")), "Si")
		FTestoLinkato = SostituisciCaratteri(DoppioApice(Request.Form("TestoLinkato")), "No")
		FURL = DoppioApice(Request.Form("URL"))
		FData = DoppioApice(Request.Form("Data"))
		FAutore = Session("BLOGNick")

		Errore = False
		If FIntroduzione = "" Then
			Errore = True
		End If

		If FTestoLinkato = "" Then
			Errore = True
		End If

		If FURL = "" OR FURL = "http://" OR Mid(FURL, 1, 7) <> "http://" Then
			Errore = True
		End If

		If FData = "" OR Len(FData) <> 8 OR IsNumeric(FData) = False OR IsDate(StrToData(FData)) = False Then
			Errore = True
		End If

		If Errore = False Then
			SQLLinkLog = " INSERT INTO [LinkLog] ([Introduzione], [TestoLinkato], [URL], [Data], [Autore]) VALUES ('"& FIntroduzione &"', '"& FTestoLinkato &"', '"& FURL &"', '"& FData &"', '"& FAutore &"') "
			Set RSLinkLog = Server.CreateObject("ADODB.Recordset")
			RSLinkLog.Open SQLLinkLog, Conn, 1, 3

			Set RSLinkLog = Nothing
%>
									<p align="justify">
										<%=Testo_LinkLog_AggiuntaABuonFine%>.
										<br><a href="javascript:history.back(-1);"><%=Testo_LinkLog_LinkTornaIndietro%></a>, <a href="linklog_elenco.asp"><%=Testo_LinkLog_LinkVaiElenco%></a>.
									</p>
<%
		Else
%>
									<p align="justify">
										<%=Testo_LinkLog_ErroreInserimento%>
										<br><a href="javascript:history.back(-1);"><%=Testo_LinkLog_LinkTornaIndietro%></a> <%=Testo_SceltaOppure%> <a href="linklog_elenco.asp"><%=Testo_LinkLog_LinkVaiElenco%></a>.
									</p>
<%
		End If
	Else
%>
									<table border="0" width="450" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<form name="FormSorgente" action="linklog_aggiungi.asp?a=aggiungi" method="post">
													<b><%=Testo_Modulo_CampoAutore%> *</b> <%=Testo_Modulo_SpiegazioneCampoAutore%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=Session("BLOGNick")%> <input type="hidden" name="Autore" value="<%=Session("BLOGNick")%>">
													<br><b><%=Testo_Modulo_CampoIntroduzione%> *</b> <%=Testo_Modulo_SpiegazioneCampoIntroduzione%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Introduzione" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoTestoLinkato%> *</b> <%=Testo_Modulo_SpiegazioneCampoTestoLinkato%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="TestoLinkato" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoURL%> *</b> <%=Testo_Modulo_SpiegazioneCampoURL%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="URL" size="50" value="http://">
													<br><b><%=Testo_Modulo_CampoData%></b> <%=Testo_Modulo_SpiegazioneCampoData%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Data" value="<%=DataToStr(Date())%>" size="50" maxlength="8"> <%=Testo_SceltaOppure%> <a href="javascript:popup('calendario.asp', 400, 450, 'calendario');"><%=Testo_Modulo_LinkPopupCampoData%></a>
													
													
													<div align="right">
														<input type="submit" name="Aggiungi" value="<%=Testo_Modulo_PulsanteAggiungi%>">
													</div>
												</form>
											</td>
										</tr>
									</table>
									<p align="justify">
										<i><%=Testo_Legenda_CampiObbligatori%></i>
									</p>
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
	Conn.Close
	Set Conn = Nothing
%>