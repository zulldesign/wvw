<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include file="inc_header.asp"-->

<%
	Dim SQLArticolo, RSArticolo, SQLModifica, RSModifica, FID, FNomeFileTXT, FTesto, FSezione, FAutore, FTitolo, FPodcast, FData, FOra, FLetture, FBozza, Errore, FilSezioneArticoli, SezioneArticoli, SQLSezioneArticoli, RSSezioneArticoli, FilContenutoArticolo, ContenutoArticolo, ContenutoArticoloTemp, SQLListBox, RSListBox

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
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <a href="articoli_elenco.asp"><%=Testo_Sezione_Articoli%></a> : <%=Testo_Modulo_PulsanteModifica%></b>
									</p>
									<p align="justify">
										<%=Testo_Articoli_IntroduzioneModifica%>
									</p>
<%
	If Request.QueryString("a") = "modifica" Then
		FNomeFileTXT = DoppioApice(Request.Form("NomeFileTXT"))
		FTesto = SostituisciCaratteri(Request.Form("Testo"), "Si")
		FSezione = DecodeEntities(SostituisciCaratteri(DoppioApice(Request.Form("Sezione")), "No"))
		If Request.Form("Autore") = "" Then
			FAutore = Session("BLOGNick")
		Else
			FAutore = DoppioApice(Request.Form("Autore"))
		End If
		FTitolo = DecodeEntities(SostituisciCaratteri(DoppioApice(Request.Form("Titolo")), "No"))
		FPodcast = DoppioApice(Request.Form("NomeFile"))
		FData = DoppioApice(Request.Form("Data"))
		FOra = DoppioApice(Request.Form("Ora"))
		FLetture = DoppioApice(Request.Form("Letture"))
		FBozza = Request.Form("Bozza")

		Errore = False
		If FTesto = "" Then
			Errore = True
		End If

		If FSezione = "" Then
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
			SQLModifica = " UPDATE [Articoli] SET Articoli.Sezione = '"& FSezione &"', Articoli.Autore = '"& FAutore &"', Articoli.Titolo = '"& FTitolo &"', Articoli.Podcast = '"& FPodcast &"', Articoli.Data = '"& FData &"', Articoli.Ora = '"& FOra &"', Articoli.Letture = "& FLetture &", "
			If FBozza = "si" Then
				SQLModifica = SQLModifica & "Articoli.Bozza = True "
			Else
				SQLModifica = SQLModifica & "Articoli.Bozza = False "
			End If
			SQLModifica = SQLModifica & "WHERE Articoli.ID = "& FID &" "
			If Session("BLOGAdmin") = False Then
				SQLModifica = SQLModifica & "AND Articoli.Autore = '"& Session("BLOGNick") &"' "
			End If

			Set RSModifica = Server.CreateObject("ADODB.Recordset")
			RSModifica.Open SQLModifica, Conn, 1, 3

			Set RSModifica = Nothing

			Set FilContenutoArticolo = CreateObject("Scripting.FileSystemObject")
			Set ContenutoArticolo = FilContenutoArticolo.GetFile(Server.MapPath(Path_DirPublic & FNomeFileTXT))
			Set ContenutoArticoloTemp = ContenutoArticolo.OpenAsTextStream(2, 0)
			ContenutoArticoloTemp.Write FTesto
			ContenutoArticoloTemp.Close
			Set ContenutoArticolo = Nothing
			Set ContenutoArticoloTemp = Nothing
%>
									<p align="justify">
										<%=Testo_Articoli_ModificaABuonFine%>
										<br><a href="javascript:history.back(-1);"><%=Testo_Articoli_LinkTornaIndietro%></a>, <a href="Articoli_elenco.asp"><%=Testo_Articoli_LinkVaiElenco%></a> <%=Testo_SceltaOppure%> <a href="javascript:popup('upload.asp', 400, 430, 'upload');"><%=Testo_Link_AvviaUploadFile%></a>.
									</p>
									<p>
										Ping <a href="http://pingomatic.com/ping/?title=<%=Nome_Blog%>&blogurl=<%=URL_Blog%>&chk_weblogscom=on&chk_technorati=on&chk_feedster=on" target="_blank">Weblogs.com/Technorati/Feedster</a> via <a href="http://pingomatic.com/" target="_blank">Ping-o-matic</a>.
									</p>
<%
		Else
%>
									<p align="justify">
										<%=Testo_Articoli_ErroreModifica%>
										<br><a href="javascript:history.back(-1);"><%=Testo_Articoli_LinkTornaIndietro%></a> <%=Testo_SceltaOppure%> <a href="articoli_elenco.asp"><%=Testo_Articoli_LinkVaiElenco%></a>.
									</p>
<%
		End If
	Else

		If Session("BLOGAdmin") = True Then
			SQLArticolo = " SELECT * FROM [Articoli] WHERE [ID] = "& FID &" "
		Else
			SQLArticolo = " SELECT * FROM [Articoli] WHERE [ID] = "& FID &" AND [Autore] = '"& Session("BLOGNick") &"' "
		End If
		Set RSArticolo = Server.CreateObject("ADODB.Recordset")
		RSArticolo.Open SQLArticolo, Conn, 1, 3

		If NOT RSArticolo.EOF Then
%>
									<table border="0" width="450" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<form name="FormSorgente" action="Articoli_modifica.asp?id=<%=Server.HTMLEncode(FID)%>&a=modifica" method="post">
													<input type="hidden" id="NomeFileTXT" name="NomeFileTXT" value="<%=RSArticolo("Testo")%>">
													<b><%=Testo_Modulo_CampoSezione%> *</b> <%=Testo_Modulo_SpiegazioneCampoSezione%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="Sezione" name="Sezione" value="<%=Server.HTMLEncode(RSArticolo("Sezione"))%>" size="50" maxlength="100"> o <a href="javascript:popup('sezioni_articoli_elenco.asp', 400, 380, 'sezioni');">scegli</a>
<%
		If Session("BLOGAdmin") = True Then
			SQLListBox = " SELECT [Nick] FROM [Autori] GROUP BY Autori.Nick "
			Set RSListBox = Server.CreateObject("ADODB.Recordset")
			RSListBox.Open SQLListBox, Conn, 1, 3
%>
													<br><b><%=Testo_Modulo_CampoAutore%> *</b> <%=Testo_Modulo_SpiegazioneCampoAutore%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select id="Autore" name="Autore" size="1">
<%
			Do While NOT RSListBox.EOF
%>
														<option <%If RSArticolo("Autore") = RSListBox("Nick") Then Response.Write "selected" End If%> value="<%=Server.HTMLEncode(RSListBox("Nick"))%>"><%=RSListBox("Nick")%></option>
<%
				RSListBox.MoveNext
			Loop
			Set RSListBox = Nothing
%>
													</select>
<%
		End If
%>
													<br><b><%=Testo_Modulo_CampoTitolo%></b> <%=Testo_Modulo_SpiegazioneCampoTitolo%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="Titolo" name="Titolo" value="<%=Server.HTMLEncode(RSArticolo("Titolo"))%>" size="50" maxlength="100">
													<br><b><%=Testo_Modulo_CampoContenuto%> *</b> <%=Testo_Modulo_SpiegazioneCampoContenuto%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<textarea id="Testo" name="Testo" cols="43" rows="7"><%
			If Left(FileToVar(Path_DirPublic & RSArticolo("Testo"), 0), 4) <> "#nd#" Then
				Response.Write FileToVar(Path_DirPublic & RSArticolo("Testo"), 0)
			End If
													%></textarea>
													<br><%=Testo_Modulo_SpiegazioneEditorHTML%> <a href="javascript:popup('<%=Path_Editor%>editor.asp', 660, 440, 'editor');"><%=Testo_Modulo_LinkEditorHTML%></a>
													<br><%=Testo_Modulo_SpiegazioneConversioneSmile%> <a href="javascript:popup('conversioni.asp', 400, 380, 'conversioni');"><%=Testo_Modulo_LinkPopupConversioneSmile%></a>.
													<br><b><%=Testo_Modulo_CampoPodcast%></b> <%=Testo_Modulo_SpiegazioneCampoPodcast%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="NomeFile" name="NomeFile" value="<%If Len(RSArticolo("Podcast")) > 0 Then Response.Write Server.HTMLEncode(RSArticolo("Podcast")) End If%>" size="50" maxlength="250"> <%=Testo_SceltaOppure%> <a href="javascript:popup('elencofile.asp', 400, 380, 'elenco');"><%=Testo_Modulo_LinkPopupCampoFilePodcast%></a>
													<br><b><%=Testo_Modulo_CampoData%></b> <%=Testo_Modulo_SpiegazioneCampoData%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="Data" name="Data" value="<%=Server.HTMLEncode(RSArticolo("Data"))%>" size="50" maxlength="8"> o <a href="javascript:popup('calendario.asp', 400, 450, 'calendario');">scegli</a>
													<br><b><%=Testo_Modulo_CampoOra%></b> <%=Testo_Modulo_SpiegazioneCampoOra%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="Ora" name="Ora" value="<%=Server.HTMLEncode(RSArticolo("Ora"))%>" size="50" maxlength="6"> o <a href="javascript:popup('orologio.asp', 400, 260, 'orologio');">scegli</a>
													<br><b><%=Testo_Modulo_CampoLetture%></b> <%=Testo_Modulo_SpiegazioneCampoLetture%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="Letture" name="Letture" value="<%=Server.HTMLEncode(RSArticolo("Letture"))%>" size="50" maxlength="5">
													<br><b><%=Testo_Modulo_CampoBozze%></b> <%=Testo_Modulo_SpiegazioneCampoBozze%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=Testo_Modulo_CampoBozzeSi%> <input type="radio" id="Bozza" name="Bozza" value="si" <%If RSArticolo("Bozza") Then Response.Write "checked" End If%>> <%=Testo_Modulo_CampoBozzeNo%> <input type="radio" id="Bozza" name="Bozza" value="no" <%If NOT RSArticolo("Bozza") Then Response.Write "checked" End If%>>
													<div align="right">
														<input type="submit" id="Modifica" name="Modifica" value="<%=Testo_Modulo_PulsanteModifica%>">
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
										<b><%=Testo_TabellaArticoli_ErroreNessunArticoloTrovato%></b>: <%=Testo_Errore_PassaggioParametri%>
										<br><a href="javascript:history.back(-1);"><%=Testo_Articoli_LinkTornaIndietro%></a> <%=Testo_SceltaOppure%> <a href="Articoli_elenco.asp"><%=Testo_LinkTornaElenco%></a>.
									</p>
<%
		End If

		Set RSArticolo = Nothing
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