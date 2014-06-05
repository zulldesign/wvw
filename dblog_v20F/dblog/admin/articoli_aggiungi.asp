<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include file="inc_header.asp"-->

<%
	Dim SQLAggiungi, RSAggiungi, SQLCercaID, RSCercaID, SQLNomeFileTXT, RSNomeFileTXT, FilStuff, Stuff, I, NomeFileTXT, FTesto, FSezione, FAutore, FTitolo, FPodcast, FData, FOra, FLetture, FBozza, Errore, SQLSezioneArticoli, RSSezioneArticoli
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
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <a href="articoli_elenco.asp"><%=Testo_Sezione_Articoli%></a> : <%=Testo_Modulo_PulsanteAggiungi%></b>
									</p>
									<p align="justify">
										<%=Testo_Articoli_IntroduzioneAggiungi%>
									</p>
<%
	If Request.QueryString("a") = "aggiungi" Then
		FTesto = SostituisciCaratteri(Request.Form("Testo"), "Si")
		FSezione = DecodeEntities(SostituisciCaratteri(DoppioApice(Request.Form("Sezione")), "No"))
		FAutore = Session("BLOGNick")
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
			SQLAggiungi = " INSERT INTO [Articoli] ([Sezione], [Autore], [Titolo], [Podcast], [Data], [Ora], [Letture], [Bozza]) VALUES ('"& FSezione &"', '"& FAutore &"', '"& FTitolo &"', '"& FPodcast &"', '"& FData &"', '"& FOra &"', '"& FLetture &"', "
			If FBozza = "si" Then
				SQLAggiungi = SQLAggiungi & "True) "
			Else
				SQLAggiungi = SQLAggiungi & "False) "
			End If
			Set RSAggiungi = Server.CreateObject("ADODB.Recordset")
			RSAggiungi.Open SQLAggiungi, Conn, 1, 3

			Set RSAggiungi = Nothing

			SQLCercaID = " SELECT TOP 1 [ID] FROM [Articoli] ORDER BY [ID] DESC "
			Set RSCercaID = Server.CreateObject("ADODB.Recordset")
			RSCercaID.Open SQLCercaID, Conn, 1, 3

			RSCercaID.MoveFirst
			NomeFileTXT = cStr(RSCercaID("ID"))
			If Len(NomeFileTXT) < 6 Then
				For I = 1 To 6 - Len(NomeFileTXT)
					NomeFileTXT = "0" & NomeFileTXT
				Next
			End If
			NomeFileTXT = NomeFileTXT & ".txt"

			SQLNomeFileTXT = " UPDATE [Articoli] SET [Testo] = '"& NomeFileTXT &"' WHERE [ID] = "& RSCercaID("ID") &" "
			Set RSNomeFileTXT = Server.CreateObject("ADODB.Recordset")
			RSNomeFileTXT.Open SQLNomeFileTXT, Conn, 1, 3

			Set RSCercaID = Nothing
			Set RSNomeFileTXT = Nothing

			Set FilStuff = CreateObject("Scripting.FileSystemObject")
			Set Stuff = FilStuff.CreateTextFile(Server.MapPath(Path_DirPublic & NomeFileTXT), True)
			Stuff.Write FTesto
			Set Stuff = Nothing
			Set FilStuff = Nothing
%>
									<p align="justify">
										<%=Testo_Articoli_AggiuntaABuonFine%>.
										<br><a href="javascript:history.back(-1);"><%=Testo_Articoli_LinkTornaIndietro%></a>, <a href="articoli_elenco.asp"><%=Testo_Articoli_LinkVaiElenco%></a> <%=Testo_SceltaOppure%> <a href="javascript:popup('upload.asp', 400, 430, 'upload');"><%=Testo_Link_AvviaUploadFile%></a>.
									</p>
									<p>
										Ping <a href="http://pingomatic.com/ping/?title=<%=Nome_Blog%>&blogurl=<%=URL_Blog%>&chk_weblogscom=on&chk_technorati=on&chk_feedster=on" target="_blank">Weblogs.com/Technorati/Feedster</a> via <a href="http://pingomatic.com/" target="_blank">Ping-o-matic</a>.
									</p>
<!--#include file="inc_spy.asp"-->
<%
		Else
%>
									<p align="justify">
										<%=Testo_Articoli_ErroreInserimento%>
										<br><a href="javascript:history.back(-1);"><%=Testo_Articoli_LinkTornaIndietro%></a> <%=Testo_SceltaOppure%> <a href="articoli_elenco.asp"><%=Testo_Articoli_LinkVaiElenco%></a>.
									</p>
<%
		End If
	Else
%>
									<table border="0" width="450" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<form name="FormSorgente" action="articoli_aggiungi.asp?a=aggiungi" method="post">
													<b><%=Testo_Modulo_CampoSezione%> *</b> <%=Testo_Modulo_SpiegazioneCampoSezione%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="Sezione" name="Sezione" size="50" maxlength="100"> <%=Testo_SceltaOppure%> <a href="javascript:popup('sezioni_articoli_elenco.asp', 400, 380, 'sezioni');"><%=Testo_Modulo_LinkPopupCampoSezione%></a>
													<br><b><%=Testo_Modulo_CampoAutore%> *</b> <%=Testo_Modulo_SpiegazioneCampoAutore%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=Session("BLOGNick")%> <input type="hidden" id="Autore" name="Autore" value="<%=Session("BLOGNick")%>">
													<br><b><%=Testo_Modulo_CampoTitolo%></b> <%=Testo_Modulo_SpiegazioneCampoTitolo%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="Titolo" name="Titolo" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoContenuto%> *</b> <%=Testo_Modulo_SpiegazioneCampoContenuto%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<textarea id="Testo" name="Testo" cols="43" rows="7"></textarea>
													<br><%=Testo_Modulo_SpiegazioneEditorHTML%> <a href="javascript:popup('<%=Path_Editor%>editor.asp', 660, 440, 'editor');"><%=Testo_Modulo_LinkEditorHTML%></a>
													<br><%=Testo_Modulo_SpiegazioneConversioneSmile%> <a href="javascript:popup('conversioni.asp', 400, 380, 'conversioni');"><%=Testo_Modulo_LinkPopupConversioneSmile%></a>.
													<br><b><%=Testo_Modulo_CampoPodcast%></b> <%=Testo_Modulo_SpiegazioneCampoPodcast%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="NomeFile" name="NomeFile" size="50" maxlength="250"> <%=Testo_SceltaOppure%> <a href="javascript:popup('elencofile.asp', 400, 380, 'elenco');"><%=Testo_Modulo_LinkPopupCampoFilePodcast%></a>
													<br><b><%=Testo_Modulo_CampoData%></b> <%=Testo_Modulo_SpiegazioneCampoData%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="Data" name="Data" value="<%=DataToStr(Date())%>" size="50" maxlength="8"> <%=Testo_SceltaOppure%> <a href="javascript:popup('calendario.asp', 400, 450, 'calendario');"><%=Testo_Modulo_LinkPopupCampoData%></a>
													<br><b><%=Testo_Modulo_CampoOra%></b> <%=Testo_Modulo_SpiegazioneCampoOra%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="Ora" name="Ora" value="<%=OraToStr(Time())%>" size="50" maxlength="6"> <%=Testo_SceltaOppure%> <a href="javascript:popup('orologio.asp', 400, 260, 'orologio');"><%=Testo_Modulo_LinkPopupCampoOra%></a>
													<br><b><%=Testo_Modulo_CampoLetture%></b> <%=Testo_Modulo_SpiegazioneCampoLetture%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="Letture" name="Letture" value="0" size="50" maxlength="5">
													<br><b><%=Testo_Modulo_CampoBozze%></b> <%=Testo_Modulo_SpiegazioneCampoBozze%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=Testo_Modulo_CampoBozzeSi%> <input type="radio" id="Bozza" name="Bozza" value="si"> <%=Testo_Modulo_CampoBozzeNo%> <input type="radio" id="Bozza" name="Bozza" value="no" checked>
													<div align="right">
														<input type="submit" id="Aggiungi" name="Aggiungi" value="<%=Testo_Modulo_PulsanteAggiungi%>">
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