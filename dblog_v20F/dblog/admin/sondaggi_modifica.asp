<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include file="inc_header.asp"-->

<%
	Dim SQLSondaggi, RSSondaggi, SQLModifica, RSModifica, FID, FDomanda, FRisposta1, FRisposta2, FRisposta3, FRisposta4, FRisposta5, FRisposta6, FRisposta7, FRisposta8, FRisposta9, FRisposta10, Errore

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
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <a href="sondaggi_elenco.asp"><%=Testo_Sezione_Sondaggio%></a> : <%=Testo_Modulo_PulsanteModifica%></b>
									</p>
<%
	If Session("BLOGAdmin") = True Then
%>
									<p align="justify">
										<%=Testo_Sondaggi_IntroduzioneModifica%>
									</p>
<%
		If Request.QueryString("a") = "modifica" Then
			FDomanda = DoppioApice(SostituisciCaratteri(Request.Form("Domanda"), "No"))
			FRisposta1 = DoppioApice(SostituisciCaratteri(Request.Form("Risposta1"), "No"))
			FRisposta2 = DoppioApice(SostituisciCaratteri(Request.Form("Risposta2"), "No"))
			FRisposta3 = DoppioApice(SostituisciCaratteri(Request.Form("Risposta3"), "No"))
			FRisposta4 = DoppioApice(SostituisciCaratteri(Request.Form("Risposta4"), "No"))
			FRisposta5 = DoppioApice(SostituisciCaratteri(Request.Form("Risposta5"), "No"))
			FRisposta6 = DoppioApice(SostituisciCaratteri(Request.Form("Risposta6"), "No"))
			FRisposta7 = DoppioApice(SostituisciCaratteri(Request.Form("Risposta7"), "No"))
			FRisposta8 = DoppioApice(SostituisciCaratteri(Request.Form("Risposta8"), "No"))
			FRisposta9 = DoppioApice(SostituisciCaratteri(Request.Form("Risposta9"), "No"))
			FRisposta10 = DoppioApice(SostituisciCaratteri(Request.Form("Risposta10"), "No"))

			Errore = False
			If FDomanda = "" Then
				Errore = True
			End If
			If FRisposta1 = "" AND FRisposta2 = "" AND FRisposta3 = "" AND FRisposta4 = "" AND FRisposta5 = "" AND FRisposta6 = "" AND FRisposta7 = "" AND FRisposta8 = "" AND FRisposta9 = "" AND FRisposta10 = "" Then
				Errore = True
			End If

			If Errore = False Then
				SQLModifica = " UPDATE [Sondaggio] SET Sondaggio.Domanda = '"& FDomanda &"', Sondaggio.Risposta1 = '"& FRisposta1 &"', Sondaggio.Risposta2 = '"& FRisposta2 &"', Sondaggio.Risposta3 = '"& FRisposta3 &"', Sondaggio.Risposta4 = '"& FRisposta4 &"', Sondaggio.Risposta5 = '"& FRisposta5 &"', Sondaggio.Risposta6 = '"& FRisposta6 &"', Sondaggio.Risposta7 = '"& FRisposta7 &"', Sondaggio.Risposta8 = '"& FRisposta8 &"', Sondaggio.Risposta9 = '"& FRisposta9 &"', Sondaggio.Risposta10 = '"& FRisposta10 &"' WHERE Sondaggio.ID = "& FID &" "
				Set RSModifica = Server.CreateObject("ADODB.Recordset")
				RSModifica.Open SQLModifica, Conn, 1, 3

				Set RSModifica = Nothing
%>
									<p align="justify">
										<%=Testo_Sondaggi_ModificaABuonFine%>
										<br><a href="javascript:history.back(-1);"><%=Testo_Sondaggio_LinkTornaIndietro%></a> <%=Testo_SceltaOppure%> <a href="sondaggi_elenco.asp"><%=Testo_Sondaggi_LinkVaiElenco%></a>.
									</p>
<%
			Else
%>
									<p align="justify">
										<%=Testo_Sondaggi_ErroreModifica%>
										<br><a href="javascript:history.back(-1);"><%=Testo_Sondaggio_LinkTornaIndietro%></a> <%=Testo_SceltaOppure%> <a href="sondaggi_elenco.asp"><%=Testo_Sondaggi_LinkVaiElenco%></a>.
									</p>
<%
			End If
		Else

			SQLSondaggi = " SELECT * FROM [Sondaggio] WHERE [ID] = "& FID &" "
			Set RSSondaggi = Server.CreateObject("ADODB.Recordset")
			RSSondaggi.Open SQLSondaggi, Conn, 1, 3

			If NOT RSSondaggi.EOF Then
%>
									<table border="0" width="450" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<form action="sondaggi_modifica.asp?id=<%=Server.HTMLEncode(FID)%>&a=modifica" method="post">
													<b><%=Testo_Modulo_CampoDomanda%> *</b> <%=Testo_Modulo_SpiegazioneCampoDomanda%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Domanda" value="<%=Server.HTMLEncode(RSSondaggi("Domanda"))%>" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoRisposta%>1</b> <%=Testo_Modulo_SpiegazioneCampoRisposta%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Risposta1" value="<%=Server.HTMLEncode(RSSondaggi("Risposta1"))%>" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoRisposta%>2</b> <%=Testo_Modulo_SpiegazioneCampoRisposta%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Risposta2" value="<%=Server.HTMLEncode(RSSondaggi("Risposta2"))%>" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoRisposta%>3</b> <%=Testo_Modulo_SpiegazioneCampoRisposta%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Risposta3" value="<%=Server.HTMLEncode(RSSondaggi("Risposta3"))%>" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoRisposta%>4</b> <%=Testo_Modulo_SpiegazioneCampoRisposta%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Risposta4" value="<%=Server.HTMLEncode(RSSondaggi("Risposta4"))%>" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoRisposta%>5</b> <%=Testo_Modulo_SpiegazioneCampoRisposta%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Risposta5" value="<%=Server.HTMLEncode(RSSondaggi("Risposta5"))%>" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoRisposta%>6</b> <%=Testo_Modulo_SpiegazioneCampoRisposta%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Risposta6" value="<%=Server.HTMLEncode(RSSondaggi("Risposta6"))%>" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoRisposta%>7</b> <%=Testo_Modulo_SpiegazioneCampoRisposta%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Risposta7" value="<%=Server.HTMLEncode(RSSondaggi("Risposta7"))%>" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoRisposta%>8</b> <%=Testo_Modulo_SpiegazioneCampoRisposta%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Risposta8" value="<%=Server.HTMLEncode(RSSondaggi("Risposta8"))%>" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoRisposta%>9</b> <%=Testo_Modulo_SpiegazioneCampoRisposta%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Risposta9" value="<%=Server.HTMLEncode(RSSondaggi("Risposta9"))%>" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoRisposta%>10</b> <%=Testo_Modulo_SpiegazioneCampoRisposta%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Risposta10" value="<%=Server.HTMLEncode(RSSondaggi("Risposta10"))%>" size="50" maxlength="250">
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
										<%=Testo_TabellaSondaggi_ErroreNessunSondaggioTrovatoPassaggioParametri%>
										<br><a href="javascript:history.back(-1);"><%=Testo_Sondaggio_LinkTornaIndietro%></a> <%=Testo_SceltaOppure%> <a href="sondaggi_elenco.asp"><%=Testo_Sondaggi_LinkVaiElenco%></a>.
									</p>
<%
			End If

			Set RSSondaggi = Nothing
		End If
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
	Conn.Close
	Set Conn = Nothing
%>