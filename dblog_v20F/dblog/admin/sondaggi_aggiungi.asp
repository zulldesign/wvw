<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include file="inc_header.asp"-->

<%
	Dim SQLAggiungi, RSAggiungi, FDomanda, FRisposta1, FRisposta2, FRisposta3, FRisposta4, FRisposta5, FRisposta6, FRisposta7, FRisposta8, FRisposta9, FRisposta10, Errore
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
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <a href="sondaggi_elenco.asp"><%=Testo_Sezione_Sondaggio%></a> : <%=Testo_Modulo_PulsanteAggiungi%></b>
									</p>
<%
	If Session("BLOGAdmin") = True Then
%>
									<p align="justify">
										<%=Testo_Sondaggi_IntroduzioneAggiungi%>
									</p>
<%
		If Request.QueryString("a") = "aggiungi" Then
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
				SQLAggiungi = " INSERT INTO [Sondaggio] ([Domanda], [Risposta1], [Risposta2], [Risposta3], [Risposta4], [Risposta5], [Risposta6], [Risposta7], [Risposta8], [Risposta9], [Risposta10]) VALUES ('"& FDomanda &"', '"& FRisposta1 &"', '"& FRisposta2 &"', '"& FRisposta3 &"', '"& FRisposta4 &"', '"& FRisposta5 &"', '"& FRisposta6 &"', '"& FRisposta7 &"', '"& FRisposta8 &"', '"& FRisposta9 &"', '"& FRisposta10 &"') "
				Set RSAggiungi = Server.CreateObject("ADODB.Recordset")
				RSAggiungi.Open SQLAggiungi, Conn, 1, 3
%>
									<p align="justify">
										<%=Testo_Sondaggi_AggiuntaABuonFine%>
										<br><a href="javascript:history.back(-1);"><%=Testo_Sondaggio_LinkTornaIndietro%></a> <%=Testo_SceltaOppure%> <a href="sondaggi_elenco.asp"><%=Testo_Sondaggi_LinkVaiElenco%></a>.
									</p>
<%
				Set RSAggiungi = Nothing
			Else
%>
									<p align="justify">
										<%=Testo_Sondaggi_ErroreInserimento%>
										<br><a href="javascript:history.back(-1);"><%=Testo_Sondaggio_LinkTornaIndietro%></a> <%=Testo_SceltaOppure%> <a href="sondaggi_elenco.asp"><%=Testo_Sondaggi_LinkVaiElenco%></a>.
									</p>
<%
			End If
		Else
%>
									<table border="0" width="450" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<form action="sondaggi_aggiungi.asp?a=aggiungi" method="post">
													<b><%=Testo_Modulo_CampoDomanda%> *</b> <%=Testo_Modulo_SpiegazioneCampoDomanda%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Domanda" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoRisposta%>1</b> <%=Testo_Modulo_SpiegazioneCampoRisposta%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Risposta1" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoRisposta%>2</b> <%=Testo_Modulo_SpiegazioneCampoRisposta%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Risposta2" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoRisposta%>3</b> <%=Testo_Modulo_SpiegazioneCampoRisposta%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Risposta3" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoRisposta%>4</b> <%=Testo_Modulo_SpiegazioneCampoRisposta%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Risposta4" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoRisposta%>5</b> <%=Testo_Modulo_SpiegazioneCampoRisposta%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Risposta5" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoRisposta%>6</b> <%=Testo_Modulo_SpiegazioneCampoRisposta%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Risposta6" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoRisposta%>7</b> <%=Testo_Modulo_SpiegazioneCampoRisposta%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Risposta7" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoRisposta%>8</b> <%=Testo_Modulo_SpiegazioneCampoRisposta%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Risposta8" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoRisposta%>9</b> <%=Testo_Modulo_SpiegazioneCampoRisposta%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Risposta9" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoRisposta%>10</b> <%=Testo_Modulo_SpiegazioneCampoRisposta%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Risposta10" size="50" maxlength="250">
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