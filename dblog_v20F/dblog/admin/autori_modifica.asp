<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include file="inc_header.asp"-->
<!--#include file="inc_sha-1.asp"-->

<%
	Dim SQLAutore, RSAutore, SQLModifica, RSModifica, FID, FPassword, FPasswordConferma, FPasswordVecchia, FMail, FSito, FICQ, FMSN, FTesto, FImmagine, FAdmin, Errore

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
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <a href="autori_elenco.asp"><%=Testo_Sezione_Autori%></a> : <%=Testo_Modulo_PulsanteModifica%></b>
									</p>
									<p align="justify">
										<%=Testo_Autori_IntroduzioneModifica%>
									</p>
<%
	If Request.QueryString("a") = "modifica" Then
		FPassword = Request.Form("Password")
		FPasswordConferma = Request.Form("PasswordConferma")
		FPasswordVecchia = Request.Form("PasswordVecchia")
		FMail = DoppioApice(Request.Form("Mail"))
		FSito = DoppioApice(Request.Form("Sito"))
		FICQ = DoppioApice(Request.Form("ICQ"))
		FMSN = DoppioApice(Request.Form("MSN"))
		FTesto = DoppioApice(SostituisciCaratteri(Request.Form("Testo"), "Si"))
		FImmagine = DoppioApice(Request.Form("NomeFile"))
		FAdmin = Request.Form("Admin")

		Errore = False
		If FPassword = "" Then
			Errore = True
		Else
			If FPassword = FPasswordConferma Then
				If FPassword = FPasswordVecchia Then
					FPassword = FPassword
				Else
					FPassword = getSHAPassword(FPassword)
				End If
			Else
				Errore = True
			End If
		End If

		If Errore = False Then
			SQLModifica = " UPDATE [Autori] SET Autori.Password = '"& FPassword &"', Autori.Mail = '"& FMail &"', Autori.Sito = '"& FSito &"', Autori.ICQ = '"& FICQ &"', Autori.MSN = '"& FMSN &"', Autori.Testo = '"& FTesto &"', Autori.Immagine = '"& FImmagine &"', "
			If FAdmin = "si" Then
				SQLModifica = SQLModifica & "Autori.Admin = True "
			Else
				SQLModifica = SQLModifica & "Autori.Admin = False "
			End If
			SQLModifica = SQLModifica & "WHERE Autori.ID = "& FID &" "
			If Session("BLOGAdmin") = False Then
				SQLModifica = SQLModifica & "AND Autori.Nick = '"& Session("BLOGNick") &"' "
			End If
			Set RSModifica = Server.CreateObject("ADODB.Recordset")
			RSModifica.Open SQLModifica, Conn, 1, 3

			Set RSModifica = Nothing
%>
									<p align="justify">
										<%=Testo_Autori_ModificaABuonFine%>
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

		SQLAutore = " SELECT * FROM [Autori] WHERE [ID] = "& FID &" "
		If Session("BLOGAdmin") = False Then
			SQLAutore = SQLAutore & "AND [Nick] = '"& Session("BLOGNick") &"' "
		End If		
		Set RSAutore = Server.CreateObject("ADODB.Recordset")
		RSAutore.Open SQLAutore, Conn, 1, 3

		If NOT RSAutore.EOF Then
%>
									<table border="0" width="450" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<form action="autori_modifica.asp?id=<%=Server.HTMLEncode(FID)%>&a=modifica" method="post">
													<b><%=Testo_Modulo_CampoUserID%> *</b> <%=Testo_Modulo_SpiegazioneCampoUserID%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=RSAutore("UserID")%>
													<br><b><%=Testo_Modulo_CampoPassword%> *</b> <%=Testo_Modulo_SpiegazioneCampoPassword%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" id="Password" name="Password" value="<%=Server.HTMLEncode(RSAutore("Password"))%>" size="50" maxlength="40"> <input type="hidden" id="PasswordVecchia" name="PasswordVecchia" value="<%=Server.HTMLEncode(RSAutore("Password"))%>">
													<br><b><%=Testo_Modulo_CampoPasswordConferma%> *</b> <%=Testo_Modulo_SpiegazioneCampoPasswordConferma%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" id="PasswordConferma" name="PasswordConferma" value="<%=Server.HTMLEncode(RSAutore("Password"))%>" size="50" maxlength="40">
													<br><b><%=Testo_Modulo_CampoNick%> *</b> <%=Testo_Modulo_SpiegazioneCampoNick%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=RSAutore("Nick")%>
													<br><b><%=Testo_Modulo_CampoMail%></b> <%=Testo_Modulo_SpiegazioneCampoMail%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="Mail" name="Mail" value="<%If RSAutore("Mail") <> "" Then Response.Write Server.HTMLEncode(RSAutore("Mail")) End If%>" size="50" maxlength="150">
													<br><b><%=Testo_Modulo_CampoSito%></b> <%=Testo_Modulo_SpiegazioneCampoSito%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="Sito" name="Sito" value="<%If RSAutore("Sito") <> "" Then Response.Write Server.HTMLEncode(RSAutore("Sito")) End If%>" size="50" maxlength="250">
													<br><b><%=Testo_Modulo_CampoICQ%></b> <%=Testo_Modulo_SpiegazioneCampoICQ%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="ICQ" name="ICQ" value="<%If RSAutore("ICQ") <> "" Then Response.Write Server.HTMLEncode(RSAutore("ICQ")) End If%>" size="50" maxlength="15">
													<br><b><%=Testo_Modulo_CampoMSN%></b> <%=Testo_Modulo_SpiegazioneCampoMSN%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="MSN" name="MSN" value="<%If RSAutore("MSN") <> "" Then Response.Write Server.HTMLEncode(RSAutore("MSN")) End If%>" size="50" maxlength="150">
													<br><b><%=Testo_Modulo_CampoProfilo%></b> <%=Testo_Modulo_SpiegazioneCampoProfilo%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<textarea id="Testo" name="Testo" cols="43" rows="7"><%=RSAutore("Testo")%></textarea>
													<br><b><%=Testo_Modulo_CampoImmagine%></b> <%=Testo_Modulo_SpiegazioneCampoImmagine%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" id="NomeFile" name="NomeFile" value="<%If RSAutore("Immagine") <> "" Then Response.Write Server.HTMLEncode(RSAutore("Immagine")) End If%>" size="50" maxlength="250"> <a href="javascript:popup('elencofile.asp', 400, 380, 'elenco');"><%=Testo_Modulo_LinkPopupCampoFileFotografia%></a>
													<br><b><%=Testo_Modulo_CampoAdmin%></b> <%=Testo_Modulo_SpiegazioneCampoAdmin%>
<%
			If Session("BLOGAdmin") = True Then
%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=Testo_Modulo_CampoAdminSi%> <input type="radio" id="Admin" name="Admin" value="si" <%If RSAutore("Admin") Then Response.Write "checked" End If%>> <%=Testo_Modulo_CampoAdminNo%> <input type="radio" id="Admin" name="Admin" value="no" <%If NOT RSAutore("Admin") Then Response.Write "checked" End If%>>
<%
			Else
%>
													<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%If RSAutore("Admin") Then Response.Write Testo_Modulo_CampoAdminSi Else Response.Write Testo_Modulo_CampoAdminNo End If%>
<%
			End If
%>
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
										<%=Testo_TabellaAutori_ErroreNessunAutoreTrovatoPassaggioParametri%>
										<br><a href="javascript:history.back(-1);"><%=Testo_Autori_LinkTornaIndietro%></a> <%=Testo_SceltaOppure%> <a href="autori_elenco.asp"><%=Testo_Autori_LinkVaiElenco%></a>.
									</p>
<%
		End If

		Set RSAutore = Nothing
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