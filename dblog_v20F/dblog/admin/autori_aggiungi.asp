<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include file="inc_header.asp"-->
<!--#include file="inc_sha-1.asp"-->

<%
	Dim SQLAggiungi, RSAggiungi, SQLCerca, RSCerca, FID, FUserID, FPassword, FPasswordConferma, FNick, FMail, FSito, FICQ, FMSN, FTesto, FImmagine, FAdmin, Errore
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
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <a href="autori_elenco.asp"><%=Testo_Sezione_Autori%></a> : <%=Testo_Modulo_PulsanteAggiungi%></b>
									</p>
<%
	If Session("BLOGAdmin") = True Then
%>
									<p align="justify">
										<%=Testo_Autori_IntroduzioneAggiungi%>
									</p>
<%
		If Request.QueryString("a") = "aggiungi" Then
			FUserID = DoppioApice(Request.Form("UserID"))
			FPassword = Request.Form("Password")
			FPasswordConferma = Request.Form("PasswordConferma")
			FNick = DoppioApice(Request.Form("Nick"))
			FMail = DoppioApice(Request.Form("Mail"))
			FSito = DoppioApice(Request.Form("Sito"))
			FICQ = DoppioApice(Request.Form("ICQ"))
			FMSN = DoppioApice(Request.Form("MSN"))
			FTesto = DoppioApice(SostituisciCaratteri(Request.Form("Testo"), "Si"))
			FImmagine = DoppioApice(Request.Form("NomeFile"))
			FAdmin = Request.Form("Admin")

			Errore = False
			If FUserID = "" Then
				Errore = True
			Else
				If InStr(FUserID, "%") > 0 OR InStr(FUserID, "[") > 0 OR InStr(FUserID, "]") > 0 OR InStr(FUserID, "_") > 0 OR InStr(FUserID, "#") > 0 Then
					Errore = True
				End If
			End If

			If FPassword = "" Then
				Errore = True
			Else
				If FPassword <> FPasswordConferma Then
					Errore = True
				End If
			End If

			If FNick = "" Then
				Errore = True
			End If

			If FNick <> "" AND FUserID <> "" Then
				SQLCerca = " SELECT [UserID], [Nick] FROM [Autori] WHERE [UserID] = '"& FUserID &"' OR [Nick] = '"& FNick &"' "
				Set RSCerca = Server.CreateObject("ADODB.Recordset")
				RSCerca.Open SQLCerca, Conn, 1, 3
				If RSCerca.RecordCount > 0 Then
					Errore = True
				End If

				Set RSCerca = Nothing
			End If

			If Errore = False Then
				SQLAggiungi = " INSERT INTO [Autori] ([UserID], [Password], [Nick], [Mail], [Sito], [ICQ], [MSN], [Testo], [Immagine], [Admin]) VALUES ('"& FUserID &"', '"& getSHAPassword(FPassword) &"', '"& FNick &"', '"& FMail &"', '"& FSito &"', '"& FICQ &"', '"& FMSN &"', '"& FTesto &"', '"& FImmagine &"', "
				If FAdmin = "si" Then
					SQLAggiungi = SQLAggiungi & "True)"
				Else
					SQLAggiungi = SQLAggiungi & "False)"
				End If
				Set RSAggiungi = Server.CreateObject("ADODB.Recordset")
				RSAggiungi.Open SQLAggiungi, Conn, 1, 3

				Set RSAggiungi = Nothing
%>
									<p align="justify">
										<%=Testo_Autori_AggiuntaABuonFine%>
										<br><a href="javascript:history.back(-1);"><%=Testo_Autori_LinkTornaIndietro%></a>, <a href="autori_elenco.asp"><%=Testo_Autori_LinkVaiElenco%></a> <%=Testo_SceltaOppure%> <a href="javascript:popup('upload.asp', 400, 430, 'upload');"><%=Testo_Link_AvviaUploadFile%></a>.
									</p>
<%
			Else
%>
									<p align="justify">
										<%=Testo_Autori_ErroreInserimento%>
										<br><a href="javascript:history.back(-1);"><%=Testo_Autori_LinkTornaIndietro%></a> <%=Testo_SceltaOppure%> <a href="autori_elenco.asp"><%=Testo_Autori_LinkVaiElenco%></a>.
									</p>
<%
			End If
		Else
%>
									<table border="0" width="450" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<form action="Autori_aggiungi.asp?a=aggiungi" method="post">
													<b><%=Testo_Modulo_CampoUserID%> *</b> <%=Testo_Modulo_SpiegazioneCampoUserID%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="UserID" name="UserID" value="" size="50" maxlength="15">
													<br><b><%=Testo_Modulo_CampoPassword%> *</b> <%=Testo_Modulo_SpiegazioneCampoPassword%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" id="Password" name="Password" size="50" maxlength="40">
													<br><b><%=Testo_Modulo_CampoPasswordConferma%> *</b> <%=Testo_Modulo_SpiegazioneCampoPasswordConferma%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" id="PasswordConferma" name="PasswordConferma" value="" size="50" maxlength="40">
													<br><b><%=Testo_Modulo_CampoNick%> *</b> <%=Testo_Modulo_SpiegazioneCampoNick%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="Nick" name="Nick" size="50" maxlength="50">
													<br><b><%=Testo_Modulo_CampoMail%></b> <%=Testo_Modulo_SpiegazioneCampoMail%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="Mail" name="Mail" size="50" maxlength="150">
													<br><b><%=Testo_Modulo_CampoSito%></b> <%=Testo_Modulo_SpiegazioneCampoSito%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="Sito" name="Sito" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoICQ%></b> <%=Testo_Modulo_SpiegazioneCampoICQ%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="ICQ" name="ICQ" size="50" maxlength="15">
													<br><b><%=Testo_Modulo_CampoMSN%></b> <%=Testo_Modulo_SpiegazioneCampoMSN%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="MSN" name="MSN" size="50" maxlength="150">
													<br><b><%=Testo_Modulo_CampoProfilo%></b> <%=Testo_Modulo_SpiegazioneCampoProfilo%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<textarea id="Testo" name="Testo" cols="43" rows="7"></textarea>
													<br><b><%=Testo_Modulo_CampoImmagine%></b> <%=Testo_Modulo_SpiegazioneCampoImmagine%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="NomeFile" name="NomeFile" size="50" maxlength="250"> <a href="javascript:popup('elencofile.asp', 400, 380, 'elenco');"><%=Testo_Modulo_LinkPopupCampoFileFotografia%></a>
													<br><b><%=Testo_Modulo_CampoAdmin%></b> <%=Testo_Modulo_SpiegazioneCampoAdmin%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=Testo_Modulo_CampoAdminSi%> <input type="radio" id="Admin" name="Admin" value="si"> <%=Testo_Modulo_CampoAdminNo%> <input type="radio" id="Admin" name="Admin" value="no" checked>
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
	Else
%>
									<p align="justify">
										<%=Testo_Errore_PermessiMancanti%>
										<br><a href="javascript:history.back(-1);"><%=Testo_Autori_LinkTornaIndietro%></a> <%=Testo_SceltaOppure%> <a href="autori_elenco.asp"><%=Testo_Autori_LinkVaiElenco%></a>.
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