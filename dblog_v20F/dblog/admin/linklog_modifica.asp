<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include file="inc_header.asp"-->

<%
	Dim SQLLinkLog, RSLinkLog, SQLModifica, RSModifica, FID, FIntroduzione, FTestoLinkato, FURL, FTitolo, FData, FAutore, Errore, SQLListBox, RSListBox

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
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <a href="linklog_elenco.asp"><%=Testo_Sezione_LinkLog%></a> : <%=Testo_Modulo_PulsanteModifica%></b>
									</p>
									<p align="justify">
										<%=Testo_LinkLog_IntroduzioneModifica%>
									</p>
<%
	If Request.QueryString("a") = "modifica" Then
		FIntroduzione = SostituisciCaratteri(DoppioApice(Request.Form("Introduzione")), "Si")
		FTestoLinkato = SostituisciCaratteri(DoppioApice(Request.Form("TestoLinkato")), "No")
		FURL = DoppioApice(Request.Form("URL"))
		FData = DoppioApice(Request.Form("Data"))
		If Request.Form("Autore") = "" Then
			FAutore = Session("BLOGNick")
		Else
			FAutore = DoppioApice(Request.Form("Autore"))
		End If

		Errore = False
		If FIntroduzione = "" Then
			Errore = True
		End If

		If FTestoLinkato = "" Then
			Errore = True
		End If

		If FURL = "" Then
			Errore = True
		End If

		If FData = "" OR Len(FData) <> 8 OR IsNumeric(FData) = False OR IsDate(StrToData(FData)) = False Then
			Errore = True
		End If

		If Errore = False Then
			SQLModifica = " UPDATE [LinkLog] SET LinkLog.Introduzione = '"& FIntroduzione &"', LinkLog.TestoLinkato = '"& FTestoLinkato &"', LinkLog.URL = '"& FURL &"', LinkLog.Data = '"& FData &"', LinkLog.Autore = '"& FAutore &"' WHERE LinkLog.ID = "& FID &" "
			If Session("BLOGAdmin") = False Then
				SQLModifica = SQLModifica & "AND LinkLog.Autore = '"& Session("BLOGNick") &"' "
			End If
			Set RSModifica = Server.CreateObject("ADODB.Recordset")
			RSModifica.Open SQLModifica, Conn, 1, 3

			Set RSModifica = Nothing
%>
									<p align="justify">
										<%=Testo_LinkLog_ModificaABuonFine%>
										<br><a href="javascript:history.back(-1);"><%=Testo_LinkLog_LinkTornaIndietro%></a>, <a href="linklog_elenco.asp"><%=Testo_LinkLog_LinkVaiElenco%></a>.
									</p>
<%
		Else
%>
									<p align="justify">
										<%=Testo_LinkLog_ErroreModifica%>
										<br><a href="javascript:history.back(-1);"><%=Testo_LinkLog_LinkTornaIndietro%></a> <%=Testo_SceltaOppure%> <a href="linklog_elenco.asp"><%=Testo_LinkLog_LinkVaiElenco%></a>.
									</p>
<%
		End If
	Else
	
		If Session("BLOGAdmin") = True Then
			SQLLinkLog = " SELECT * FROM [LinkLog] WHERE [ID] = "& FID &" "
		Else
			SQLLinkLog = " SELECT * FROM [LinkLog] WHERE [ID] = "& FID &" AND [Autore] = '"& Session("BLOGNick") &"' "
		End If
		
		Set RSLinkLog = Server.CreateObject("ADODB.Recordset")
		RSLinkLog.Open SQLLinkLog, Conn, 1, 3

		If NOT RSLinkLog.EOF Then
%>
									<table border="0" width="450" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<form name="FormSorgente" action="linklog_modifica.asp?id=<%=Server.HTMLEncode(FID)%>&a=modifica" method="post">
<%
		If Session("BLOGAdmin") = True Then
			SQLListBox = " SELECT [Nick] FROM [Autori] GROUP BY Autori.Nick "
			Set RSListBox = Server.CreateObject("ADODB.Recordset")
			RSListBox.Open SQLListBox, Conn, 1, 3
%>
													<b><%=Testo_Modulo_CampoAutore%></b> <%=Testo_Modulo_SpiegazioneCampoAutore%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select name="Autore" size="1">
<%
			Do While NOT RSListBox.EOF
%>
														<option <%If RSLinkLog("Autore") = RSListBox("Nick") Then Response.Write "selected" End If%> value="<%=Server.HTMLEncode(RSListBox("Nick"))%>"><%=RSListBox("Nick")%></option>
<%
				RSListBox.MoveNext
			Loop
			Set RSListBox = Nothing
%>
													</select>
<%
		End If
%>
													<br><b><%=Testo_Modulo_CampoIntroduzione%></b> <%=Testo_Modulo_SpiegazioneCampoIntroduzione%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Introduzione" value="<%=Server.HTMLEncode(RSLinkLog("Introduzione"))%>" size="50" maxlength="250">

													<br><b><%=Testo_Modulo_CampoTestoLinkato%> *</b> <%=Testo_Modulo_SpiegazioneCampoTestoLinkato%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="TestoLinkato" value="<%=Server.HTMLEncode(RSLinkLog("TestoLinkato"))%>" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoURL%> *</b> <%=Testo_Modulo_SpiegazioneCampoURL%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="URL" value="<%=Server.HTMLEncode(RSLinkLog("URL"))%>" size="50">
													<br><b><%=Testo_Modulo_CampoData%></b> <%=Testo_Modulo_SpiegazioneCampoData%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Data" value="<%=Server.HTMLEncode(RSLinkLog("Data"))%>" size="50" maxlength="8"> o <a href="javascript:popup('calendario.asp', 400, 450, 'calendario');">scegli</a>
													<br><b><%=Testo_Modulo_CampoOra%></b> <%=Testo_Modulo_SpiegazioneCampoOra%>
													<div align="right">
														<input type="submit" name="Modifica" value="<%=Testo_Modulo_PulsanteModifica%>">
													</div>
												</form>
											</td>
										</tr>
									</table>
									<p align="justify">
										<i><%=Testo_Legenda_CampiObbligatori%></i>
									</p>
<%
		Else
%>
									<p align="justify">
										<b><%=Testo_TabellaLinkLog_ErroreNessunLinkTrovato%></b>: <%=Testo_Errore_PassaggioParametri%>
										<br><a href="javascript:history.back(-1);"><%=Testo_LinkLog_LinkTornaIndietro%></a> <%=Testo_SceltaOppure%> <a href="linklog_elenco.asp"><%=Testo_LinkLog_LinkVaiElenco%></a>.
									</p>
<%
		End If

		Set RSLinkLog = Nothing
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