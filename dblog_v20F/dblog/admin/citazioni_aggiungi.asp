<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include file="inc_header.asp"-->

<%
	Dim SQLAggiungi, RSAggiungi, FAutore, FCitazione, FHeader, Errore
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
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <a href="citazioni_elenco.asp"><%=Testo_Sezione_Citazioni%></a> : <%=Testo_Modulo_PulsanteAggiungi%></b>
									</p>
<%
	If Session("BLOGAdmin") = True Then
%>
									<p align="justify">
										<%=Testo_Citazioni_IntroduzioneAggiungi%>
									</p>
<%
		If Request.QueryString("a") = "aggiungi" Then
			FAutore = DoppioApice(SostituisciCaratteri(Request.Form("Autore"), "No"))
			FCitazione = DoppioApice(SostituisciCaratteri(Request.Form("Citazione"), "Si"))
			FHeader = Request.Form("Header")

			Errore = False
			If FCitazione = "" Then
				Errore = True
			End If

			If Errore = False Then
				SQLAggiungi = " INSERT INTO [Citazioni] ([Autore], [Citazione], [Header]) VALUES ('"& FAutore &"', '"& FCitazione &"', "
				If FHeader = "si" Then
					SQLAggiungi = SQLAggiungi & "True)"
				Else
					SQLAggiungi = SQLAggiungi & "False)"
				End If
				Set RSAggiungi = Server.CreateObject("ADODB.Recordset")
				RSAggiungi.Open SQLAggiungi, Conn, 1, 3
%>
									<p align="justify">
										<%=Testo_Citazioni_AggiuntaABuonFine%>
										<br><a href="javascript:history.back(-1);"><%=Testo_Citazioni_LinkTornaIndietro%></a>, <a href="citazioni_elenco.asp"><%=Testo_Citazioni_LinkVaiElenco%></a> <%=Testo_SceltaOppure%> <a href="javascript:popup('upload.asp', 400, 430, 'upload');"><%=Testo_Link_AvviaUploadFile%></a>.
									</p>
<%
				Set RSAggiungi = Nothing
			Else
%>
									<p align="justify">
										<%=Testo_Citazioni_ErroreInserimento%>
										<br><a href="javascript:history.back(-1);"><%=Testo_Citazioni_LinkTornaIndietro%></a> <%=Testo_SceltaOppure%> <a href="citazioni_elenco.asp"><%=Testo_Citazioni_LinkVaiElenco%></a>.
									</p>
<%
			End If
		Else
%>
									<table border="0" width="450" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<form action="citazioni_aggiungi.asp?a=aggiungi" method="post">
													<b><%=Testo_Modulo_CampoAutore%></b> <%=Testo_Modulo_SpiegazioneCampoAutore%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Autore" size="50" maxlength="100">
													<br><b><%=Testo_Modulo_CampoCitazione%> *</b> <%=Testo_Modulo_SpiegazioneCampoCitazione%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<textarea name="Citazione" rows="10" cols="43"></textarea>
													<br><b><%=Testo_Modulo_CampoHeader%></b> <%=Testo_Modulo_SpiegazioneCampoHeader%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=Testo_Modulo_CampoHeaderSi%> <input type="radio" name="Header" value="si" checked> <%=Testo_Modulo_CampoHeaderNo%> <input type="radio" name="Header" value="no">
													<div align="right">
														<input type="submit" name="Aggiungi" value="<%=Testo_Modulo_PulsanteAggiungi%>">
													</div>
												</form>
											</td>
										</tr>
									</table>
									<p align="justify">
										<%=Testo_Legenda_CampiObbligatori%>
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