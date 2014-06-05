<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include file="inc_header.asp"-->

<%
	Dim SQLCitazioni, RSCitazioni, SQLModifica, RSModifica, FID, Fautore, FCitazione, FHeader, Errore

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
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <a href="citazioni_elenco.asp"><%=Testo_Sezione_Citazioni%></a> : <%=Testo_Modulo_PulsanteModifica%></b>
									</p>
<%
	If Session("BLOGAdmin") = True Then
%>
									<p align="justify">
										<%=Testo_Citazioni_IntroduzioneModifica%>
									</p>
<%
		If Request.QueryString("a") = "modifica" Then
			FAutore = DoppioApice(SostituisciCaratteri(Request.Form("Autore"), "No"))
			FCitazione = DoppioApice(SostituisciCaratteri(Request.Form("Citazione"), "Si"))
			FHeader = Request.Form("Header")

			Errore = False
			If FCitazione = "" Then
				Errore = True
			End If

			If Errore = False Then
				SQLModifica = " UPDATE [Citazioni] SET Citazioni.Autore = '"& FAutore &"', Citazioni.Citazione = '"& FCitazione &"', "
				If FHeader = "si" Then
					SQLModifica = SQLModifica & "Citazioni.Header = True "
				Else
					SQLModifica = SQLModifica & "Citazioni.Header = False "
				End If
				SQLModifica = SQLModifica & "WHERE Citazioni.ID = "& FID &" "
				Set RSModifica = Server.CreateObject("ADODB.Recordset")
				RSModifica.Open SQLModifica, Conn, 1, 3

				Set RSModifica = Nothing
%>
									<p align="justify">
										<%=Testo_Citazioni_ModificaABuonFine%>
										<br><a href="javascript:history.back(-1);"><%=Testo_Citazioni_LinkTornaIndietro%></a>, <a href="citazioni_elenco.asp"><%=Testo_Citazioni_LinkVaiElenco%></a> <%=Testo_SceltaOppure%> <a href="javascript:popup('upload.asp', 400, 430, 'upload');"><%=Testo_Link_AvviaUploadFile%></a>.
									</p>
<%
			Else
%>
									<p align="justify">
										<%=Testo_Citazioni_ErroreModifica%>
										<br><a href="javascript:history.back(-1);"><%=Testo_Citazioni_LinkTornaIndietro%></a> <%=Testo_SceltaOppure%> <a href="citazioni_elenco.asp"><%=Testo_Citazioni_LinkVaiElenco%></a>.
									</p>
<%
			End If
		Else

			SQLCitazioni = " SELECT * FROM [Citazioni] WHERE [ID] = "& FID &" "
			Set RSCitazioni = Server.CreateObject("ADODB.Recordset")
			RSCitazioni.Open SQLCitazioni, Conn, 1, 3

			If NOT RSCitazioni.EOF Then
%>
									<table border="0" width="450" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<form action="citazioni_modifica.asp?id=<%=Server.HTMLEncode(FID)%>&a=modifica" method="post">
													<b><%=Testo_Modulo_CampoAutore%></b> <%=Testo_Modulo_SpiegazioneCampoAutore%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="Autore" value="<%=Server.HTMLEncode(RSCitazioni("Autore"))%>" size="50" maxlength="100">
													<br><b><%=Testo_Modulo_CampoCitazione%> *</b> <%=Testo_Modulo_SpiegazioneCampoCitazione%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<textarea name="Citazione" rows="10" cols="43"><%=RSCitazioni("Citazione")%></textarea>
													<br><b><%=Testo_Modulo_CampoHeader%></b> <%=Testo_Modulo_SpiegazioneCampoHeader%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=Testo_Modulo_CampoHeaderSi%> <input type="radio" name="Header" value="si" <%If RSCitazioni("Header") Then Response.Write "checked" End If%>> <%=Testo_Modulo_CampoHeaderNo%> <input type="radio" name="Header" value="no" <%If NOT RSCitazioni("Header") Then Response.Write "checked" End If%>>
													<div align="right">
														<input type="submit" name="Modifica" value="<%=Testo_Modulo_PulsanteModifica%>">
													</div>
												</form>
											</td>
										</tr>
									</table>
									<p align="justify">
										<%=Testo_Legenda_CampiObbligatori%>
									</p>
<%
			Else
%>
									<p align="justify">
										<%=Testo_TabellaCitazioni_ErroreNessunaCitazioneTrovataPassaggioParametri%>
										<br><a href="javascript:history.back(-1);"><%=Testo_Citazioni_LinkTornaIndietro%></a> <%=Testo_SceltaOppure%> <a href="citazioni_elenco.asp"><%=Testo_Citazioni_LinkVaiElenco%></a>.
									</p>
<%
			End If

			Set RSCitazioni = Nothing
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