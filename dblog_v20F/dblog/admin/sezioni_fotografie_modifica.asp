<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include file="inc_header.asp"-->
<body bgcolor="<%=Colore_Sfondo_Pagina%>">
<table border="0" width="320" align="center" cellspacing="0" cellpadding="15" bgcolor="<%=Colore_Sfondo_Content%>">
	<tr>
		<td>
			<table border="0" width="320" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
				<tr>
					<td width="320">
						<table border="0" width="320" cellspacing="0" cellpadding="0">
							<tr>
								<td width="320" valign="top" style="PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px">
									<b>\\ <a href="javascript:opener.location.href='default.asp';self.close();"><%=Testo_Path_Pannello%></a> : <%=Testo_Sezione_RinominaSezioni%></b>
<%
	If Request.QueryString("a") = "modifica" Then
		FNomeVecchio = Request.Form("NomeVecchio")
		FNomeNuovo = Request.Form("NomeNuovo")

		Errore = False

		SQLControllo = " SELECT TOP 1 ID FROM Fotografie WHERE [Sezione] = '"& DoppioApice(FNomeVecchio) &"' "
		Set RSControllo = Server.CreateObject("ADODB.Recordset")
		RSControllo.Open SQLControllo, Conn, 1, 3

		If RSControllo.EOF Then
			Errore = True
		End If

		RSControllo.Close
		Set RSControllo = Nothing

		If FNomeNuovo = "" Then
			Errore = True
		End If

		If LCase(FNomeVecchio) = LCase(FNomeNuovo) Then
			Errore = True
		End If

		If Errore = False Then
			SQLModifica = " UPDATE Fotografie SET [Sezione] = '"& DoppioApice(FNomeNuovo) &"' WHERE [Sezione] = '"& DoppioApice(FNomeVecchio) &"' "
			Set RSModifica = Server.CreateObject("ADODB.Recordset")
			RSModifica.Open SQLModifica, Conn, 1, 3

			Set RSModifica = Nothing
%>
									<p align="justify">
										<%=Testo_SezioniModifica_Conferma%>
										<br><a href="sezioni_fotografie_elenco.asp"><%=Testo_Fotografie_LinkTornaIndietro%></a></a>.
									</p>
<%
		Else
%>
									<p align="justify">
										<%=Testo_SezioniModifica_ErroreNonABuonFine%>
										<br><a href="javascript:history.back(-1);"><%=Testo_Fotografie_LinkTornaIndietro%></a></a>.
									</p>
<%
		End If
	Else
%>
									<p align="justify">
										<%=Testo_Sezioni_IntroduzioneRinominaSezioni%>
									</p>
<%
		SQLSezioni = " SELECT Sezione FROM Fotografie GROUP BY Fotografie.Sezione ORDER BY Fotografie.Sezione "
		Set RSSezioni = Server.CreateObject("ADODB.Recordset")
		RSSezioni.Open SQLSezioni, Conn, 1, 3

		If RSSezioni.EOF = False Then
%>
									<form action="sezioni_fotografie_modifica.asp?a=modifica" method="post">
										<b><%=Testo_Sezioni_TitoloNomeSezioniDisponibili%> *</b>
										<br><select name="NomeVecchio" id="NomeVecchio" size="1">
<%
			Do While NOT RSSezioni.EOF
%>
											<option value="<%=Server.HTMLEncode(RSSezioni("Sezione"))%>" <%If LCase(Request.QueryString("s")) = LCase(RSSezioni("Sezione")) Then Response.Write "selected" End If%>><%=RSSezioni("Sezione")%></option>
<%
				RSSezioni.MoveNext
			Loop
%>
										</select>
										<br><b><%=Testo_Sezioni_TitoloNuovoNomeSezione%> *</b>
										<br><input type="textbox" id="NomeNuovo" name="NomeNuovo" size="35" maxlength="100">
										<br><input type="submit" id="Modifica" name="Modifica" value="<%=Testo_Modulo_PulsanteModifica%>">
									</form>
<%
		Else
%>
									<p>
										<%=Testo_SezioniDisponibili_ErroreNessunaTrovata%>
									</p>
<%
		End If
	End If
%>
									<p align="right">
										<br><a href="javascript:self.close();"><%=Testo_LinkChiudi%></a>
									</p>
								</td>
							</tr>
						</table>
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
