<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include file="inc_header.asp"-->

<%
	Dim SQLFotografia, RSFotografia, SQLModifica, RSModifica, FID, FNomeFile, FSezione, FAutore, FDescrizione, FData, FOra, FLetture, FHeader, Errore, FilSezioneFotografie, SezioneFotografie, SQLSezioneFotografie, RSSezioneFotografie, SQLListBox, RSListBox

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
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <a href="fotografie_elenco.asp"><%=Testo_Sezione_Fotografie%></a> : <%=Testo_Modulo_PulsanteModifica%></b>
									</p>
									<p align="justify">
										<%=Testo_Fotografie_IntroduzioneModifica%>
									</p>
<%
	If Request.QueryString("a") = "modifica" Then
		FNomeFile = DoppioApice(Request.Form("NomeFile"))
		FSezione = DecodeEntities(SostituisciCaratteri(DoppioApice(Request.Form("Sezione")), "No"))
		If Request.Form("Autore") = "" Then
			FAutore = Session("BLOGNick")
		Else
			FAutore = DoppioApice(Request.Form("Autore"))
		End If
		FDescrizione = DoppioApice(SostituisciCaratteri(Request.Form("Descrizione"), "No"))
		FData = DoppioApice(Request.Form("Data"))
		FOra = DoppioApice(Request.Form("Ora"))
		FLetture = DoppioApice(Request.Form("Letture"))
		FHeader = Request.Form("Header")

		Errore = False
		If FNomeFile = "" Then
			Errore = True
		End If

		If FSezione = "" Then
			Errore = True
		End If

		If FDescrizione = "" Then
			Errore = True
		End If

		If FData = "" OR Len(FData) <> 8 OR IsNumeric(FData) = False OR IsDate(StrToData(FData)) = False Then
			Errore = True
		End If

		If FOra = "" OR Len(FOra) <> 6 OR IsNumeric(FOra) = False Then
			Errore = True
		End If

		If FLetture = "" OR IsNumeric(FLetture) = False Then
			Errore = True
		End If

		If Errore = False Then
			SQLModifica = " UPDATE [Fotografie] SET Fotografie.NomeFile = '"& FNomeFile &"', Fotografie.Sezione = '"& FSezione &"', Fotografie.Autore = '"& FAutore &"', Fotografie.Descrizione = '"& FDescrizione &"', Fotografie.Data = '"& FData &"', Fotografie.Ora = '"& FOra &"', Fotografie.Letture = "& FLetture &", "
			If FHeader = "si" Then
				SQLModifica = SQLModifica & "Fotografie.Header = True "
			Else
				SQLModifica = SQLModifica & "Fotografie.Header = False "
			End If
			If Session("BLOGAdmin") = True Then
				SQLModifica = SQLModifica & "WHERE Fotografie.ID = "& FID &" "
			Else
				SQLModifica = SQLModifica & "WHERE Fotografie.ID = "& FID &" AND Fotografie.Autore = '"& Session("BLOGNick") &"' "
			End If
			Set RSModifica = Server.CreateObject("ADODB.Recordset")
			RSModifica.Open SQLModifica, Conn, 1, 3

			Set RSModifica = Nothing
%>
									<p align="justify">
										<%=Testo_Fotografie_ModificaABuonFine%>
										<br><a href="javascript:history.back(-1);"><%=Testo_Fotografie_LinkTornaIndietro%></a>, <a href="fotografie_elenco.asp"><%=Testo_Fotografie_LinkVaiElenco%></a> <%=Testo_SceltaOppure%> <a href="javascript:popup('upload.asp', 400, 430, 'upload');"><%=Testo_Link_AvviaUploadFile%></a>.
									</p>
<%
		Else
%>
									<p align="justify">
										<%=Testo_Fotografie_ErroreModifica%>
										<br><a href="javascript:history.back(-1);"><%=Testo_Fotografie_LinkTornaIndietro%></a> <%=Testo_SceltaOppure%> <a href="fotografie_elenco.asp"><%=Testo_Fotografie_LinkVaiElenco%></a>.
									</p>
<%
		End If
	Else

		If Session("BLOGAdmin") = True Then
			SQLFotografia = " SELECT * FROM [Fotografie] WHERE ID = "& FID &" "
		Else
			SQLFotografia = " SELECT * FROM [Fotografie] WHERE ID = "& FID &" AND [Autore] = '"& Session("BLOGNick") &"' "
		End If
		Set RSFotografia = Server.CreateObject("ADODB.Recordset")
		RSFotografia.Open SQLFotografia, Conn, 1, 3

		If NOT RSFotografia.EOF Then
%>
									<table border="0" width="450" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<form name="FormSorgente" action="fotografie_modifica.asp?id=<%=Server.HTMLEncode(FID)%>&a=modifica" method="post">
													<b><%=Testo_Modulo_CampoNomeFileFotografia%> *</b> 
<%
			If NOT Abilita_ResizeASPNET Then
%>
													<%=Testo_Modulo_CampoNomeFileFotografiaSpiegazione%>
<%
			Else
%>
													<%=Testo_Modulo_CampoNomeFileFotografiaSpiegazioneConResizeASPNET%>
<%
			End If
%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="NomeFile" name="NomeFile" value="<%=Server.HTMLEncode(RSFotografia("NomeFile"))%>" size="50" maxlength="100"> <a href="javascript:popup('fotografie_visualizza.asp?path=<%=Path_DirPublic%><%=RSFotografia("NomeFile")%>', 570, 400, 'preview');"><%=Testo_Modulo_LinkPopupPreviewFotografia%></a> o <a href="javascript:popup('elencofile.asp', 400, 380, 'elenco');"><%=Testo_Modulo_LinkPopupCampoFileFotografia%></a>
<%
		If Session("BLOGAdmin") = True Then
			SQLListBox = " SELECT [Nick] FROM [Autori] GROUP BY Autori.Nick "
			Set RSListBox = Server.CreateObject("ADODB.Recordset")
			RSListBox.Open SQLListBox, Conn, 1, 3
%>
													<br><b><%=Testo_Modulo_CampoAutore%></b> <%=Testo_Modulo_SpiegazioneCampoAutore%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;<select id="Autore" name="Autore" size="1">
<%
			Do While NOT RSListBox.EOF
%>
														<option <%If RSFotografia("Autore") = RSListBox("Nick") Then Response.Write "selected" End If%> value="<%=Server.HTMLEncode(RSListBox("Nick"))%>"><%=RSListBox("Nick")%></option>
<%
				RSListBox.MoveNext
			Loop
			Set RSListBox = Nothing
%>
													</select>
<%
		End If
%>
													<br><b><%=Testo_Modulo_CampoSezione%> *</b> <%=Testo_Modulo_SpiegazioneCampoSezione%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="Sezione" name="Sezione" value="<%=Server.HTMLEncode(RSFotografia("Sezione"))%>" size="50" maxlength="100"> <%=Testo_SceltaOppure%> <a href="javascript:popup('sezioni_fotografie_elenco.asp', 400, 380, 'sezioni');"><%=Testo_Modulo_LinkPopupCampoSezione%></a>
													<br><b><%=Testo_Modulo_CampoDescrizione%> *</b> <%=Testo_Modulo_SpiegazioneCampoDescrizione%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="Descrizione" name="Descrizione" value="<%=Server.HTMLEncode(RSFotografia("Descrizione"))%>" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoData%></b> <%=Testo_Modulo_SpiegazioneCampoData%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="Data" name="Data" value="<%=Server.HTMLEncode(RSFotografia("Data"))%>" size="50" maxlength="8"> o <a href="javascript:popup('calendario.asp', 400, 450, 'calendario');"><%=Testo_Modulo_LinkPopupCampoData%></a>
													<br><b><%=Testo_Modulo_CampoOra%></b> <%=Testo_Modulo_SpiegazioneCampoOra%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="Ora" name="Ora" value="<%=Server.HTMLEncode(RSFotografia("Ora"))%>" size="50" maxlength="6"> o <a href="javascript:popup('orologio.asp', 400, 260, 'orologio');"><%=Testo_Modulo_LinkPopupCampoOra%></a>
													<br><b><%=Testo_Modulo_CampoLetture%></b> <%=Testo_Modulo_SpiegazioneCampoLetture%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="Letture" name="Letture" value="<%=Server.HTMLEncode(RSFotografia("Letture"))%>" size="50" maxlength="5">
													<br><b><%=Testo_Modulo_CampoHeader%></b> <%=Testo_Modulo_SpiegazioneCampoHeader%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;<%=Testo_Modulo_CampoHeaderSi%> <input type="radio" id="Header" name="Header" value="si" <%If RSFotografia("Header") Then Response.Write "checked" End If%>> <%=Testo_Modulo_CampoHeaderNo%> <input type="radio" id="Header" name="Header" value="no" <%If NOT RSFotografia("Header") Then Response.Write "checked" End If%>>
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
										<b><%=Testo_TabellaFotografie_ErroreNessunaFotografiaTrovata%></b>: <%=Testo_Errore_PassaggioParametri%>
										<br><a href="javascript:history.back(-1);"><%=Testo_Fotografie_LinkTornaIndietro%></a> <%=Testo_SceltaOppure%> <a href="fotografie_elenco.asp"><%=Testo_Fotografie_LinkVaiElenco%></a>.
									</p>
<%
		End If

		Set RSFotografia = Nothing
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