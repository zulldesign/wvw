<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include file="inc_header.asp"-->
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
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <%=Testo_Sezione_Fotografie%></b>
									</p>
									<table border="0" width="450" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
<%
	Dim SQLListBox, RSListBox, SQLFotografie, RSFotografie, FSTFotografia, RecordPerPagina, Pagina, I, Temp, FiltroAutore, FiltroSezione, ArrayFiltroAutore, ArrayFiltroSezione, Z

	SQLFotografie = " SELECT Fotografie.ID, Fotografie.NomeFile, Count(Commenti.ID) AS ConteggioID, Fotografie.Sezione, Fotografie.Autore, Fotografie.Descrizione, Fotografie.Data, Fotografie.Ora, Fotografie.Letture, Fotografie.Header FROM Commenti RIGHT JOIN Fotografie ON Commenti.IDFotografia = Fotografie.ID WHERE Fotografie.ID <> 0"
	If Session("BLOGAdmin") = True Then
		If Request.QueryString("a") <> "" Then
			SQLFotografie = SQLFotografie & " AND Fotografie.Autore = '"& ControlloSQLInjection(Request.QueryString("a")) &"'"
		End If
	Else
		SQLFotografie = SQLFotografie & " AND Fotografie.Autore = '"& Session("BLOGNick") &"'"
	End If
	If Request.QueryString("s") <> "" Then
		SQLFotografie = SQLFotografie & " AND Fotografie.Sezione = '"& ControlloSQLInjection(Request.QueryString("s")) &"'"
	End If
	SQLFotografie = SQLFotografie & " GROUP BY Fotografie.ID, Fotografie.NomeFile, Fotografie.Sezione, Fotografie.Autore, Fotografie.Descrizione, Fotografie.Data, Fotografie.Ora, Fotografie.Letture, Fotografie.Header ORDER BY Fotografie.Data DESC, Fotografie.Ora DESC"
	Set RSFotografie = Server.CreateObject("ADODB.Recordset")
	RSFotografie.Open SQLFotografie, Conn, 1, 3
%>
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<%=Testo_Fotografie_IntroduzioneElenco%> <a href="fotografie_aggiungi.asp"><%=Testo_Modulo_PulsanteAggiungi%></a>.
												<br><%=Testo_Fotografie_IntroduzioneTotaleFotografie%>: <b><%=RSFotografie.RecordCount%></b>
											</td>
										</tr>
<%
	RecordPerPagina = 4

	Pagina = Request.QueryString("pagina")
	If Pagina = "" OR Pagina = "0" OR IsNumeric(Pagina) = False Then
		Pagina = 1
	Else
		If Pagina <= 0 Then
			Pagina = 1
		End If
	End If

	If RSFotografie.EOF = False OR RSFotografie.BOF = False Then
		RSFotografie.PageSize = RecordPerPagina
		RSFotografie.AbsolutePage = Pagina

		For I = 1 To RecordPerPagina
			If NOT RSFotografie.EOF Then
				Set FSTFotografia = CreateObject("Scripting.FileSystemObject")
%>
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<a href="fotografie_modifica.asp?id=<%=RSFotografie("ID")%>">
<%
								If NOT Abilita_ResizeASPNET Then
%>
													<img src="<%If FSTFotografia.FileExists(Server.MapPath(Path_DirPublic & "T-" & RSFotografie("NomeFile"))) Then%><%=Path_DirPublic%>T-<%=RSFotografie("NomeFile")%><%Else%><%=Path_Skin%>T-nd.gif<%End If%>" width="112" border="0" align="left" alt="Modifica">
<%
								Else
%>
													<img src="/dblog/resize.aspx?img=<%If FSTFotografia.FileExists(Server.MapPath(Path_DirPublic & RSFotografie("NomeFile"))) Then%><%=Path_DirPublic%><%=RSFotografie("NomeFile")%><%Else%><%=Path_Skin%>T-nd.gif<%End If%>&amp;opx=<%=Num_ResizeASPNET_LarghezzaFotoThumbnail%>" border="0" align="left" alt="Modifica">
<%
								End If
%>
												</a><b><%=Testo_TabellaFotografie_RigaAutore%></b> <%=RSFotografie("Autore")%> (<%=StrToData(RSFotografie("Data"))%> @ <%=StrToOra(RSFotografie("Ora"))%>)
												<br><b><%=Testo_TabellaFotografie_RigaSezione%></b> <%=RSFotografie("Sezione")%> (<%=RSFotografie("Letture")%>&nbsp;<%=Testo_TabellaFotografie_CaratteristicaHit%> - <font color="<%If RSFotografie("Header") Then Response.Write "green" Else Response.Write "red" End If%>"><%=Testo_TabellaFotografie_IdentificaRotazioneHeader%></font>)
												<br><b><%=Testo_TabellaFotografie_RigaOperazioni%></b> <a href="fotografie_modera.asp?id=<%=RSFotografie("ID")%>"><%=Testo_TabellaFotografie_LinkModeraCommenti%></a> (<%=RSFotografie("ConteggioID")%>) | <a href="fotografie_modifica.asp?id=<%=RSFotografie("ID")%>"><%=Testo_TabellaFotografie_LinkModifica%></a> | <a href="fotografie_cancella.asp?id=<%=RSFotografie("ID")%>" onclick="return confirm('<%=Testo_Conferma_CancellazioneFileJavascript%>?');"><%=Testo_TabellaFotografie_LinkCancella%></a>
											</td>
										</tr>
<%
				Set FSTFotografia = Nothing
				RSFotografie.MoveNext
			End If
		Next

		FiltroAutore = ""
		FiltroSezione = ""
	
		SQLListBox = " SELECT [Autore], [Sezione] FROM [Fotografie] "
		Set RSListBox = Server.CreateObject("ADODB.Recordset")
		RSListBox.Open SQLListBox, Conn, 1, 3

		Do While NOT RSListBox.EOF
			If InStr(FiltroAutore, "|" & RSListBox("Autore")) = False Then
				FiltroAutore = FiltroAutore & "|" & RSListBox("Autore")
			End If
			If InStr(FiltroSezione, "|" & RSListBox("Sezione")) = False Then
				FiltroSezione = FiltroSezione & "|" & RSListBox("Sezione")
			End If
			RSListBox.MoveNext
		Loop

		ArrayFiltroAutore = Split(FiltroAutore, "|", -1, 1)
		ArrayFiltroSezione = Split(FiltroSezione, "|", -1, 1)
%>
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<div align="right">
													<b><%=Testo_TabellaFotografie_Paginazione%>:</b> 
<%
		For Temp = 1 To RSFotografie.PageCount
			Response.Write "<a href=""fotografie_elenco.asp?s="& Server.HtmlEncode(Request.QueryString("s")) &"&a="& Server.HtmlEncode(Request.QueryString("a")) &"&pagina=" & Temp & """>"
			Response.Write Temp
			Response.Write "</a> "
		Next
%>
												</div>
												<form action="fotografie_elenco.asp" method="get">
                    								<b><%=Testo_TabellaFotografie_FiltriPer%></b>
                    								<br>
<%
		If Session("BLOGAdmin") = True Then
%>
                    								<%=Testo_TabellaFotografie_FiltroPerAutori%> 
                    								<select name="a" size="1">
	                      								<option value=""><%=Testo_TabellaFotografie_FiltroPerAutoriNessunaScelta%></option>
<%
			For Z = 1 To UBound(ArrayFiltroAutore)
%>
														<option <%If Request.QueryString("a") = ArrayFiltroAutore(Z) Then Response.Write "selected" End If%> value="<%=ArrayFiltroAutore(Z)%>"><%=ArrayFiltroAutore(Z)%></option>
<%
			Next
%>
													</select>
                    							 	<%=Testo_TabellaFotografie_FiltroANDOR%> 
<%
		End If
%>
                    							 	<%=Testo_TabellaFotografie_FiltroPerSezioni%> 
                    							 	<select name="s" size="1">
	                      								<option value=""><%=Testo_TabellaFotografie_FiltroPerSezioniNessunaScelta%></option>
<%
		For Z = 1 To UBound(ArrayFiltroSezione)
%>
														<option <%If Request.QueryString("s") = ArrayFiltroSezione(Z) Then Response.Write "selected" End If%> value="<%=ArrayFiltroSezione(Z)%>"><%=ArrayFiltroSezione(Z)%></option>
<%
		Next
%>
													</select>
													<input type="submit" name="cerca" value="<%=Testo_Modulo_PulsanteRicerca%>">
												</form>
											</td>
										</tr>
<%
		Set RSListbox = Nothing
	Else
%>
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<%=Testo_TabellaFotografie_ErroreNessunaFotografiaTrovata%>, <a href="fotografie_elenco.asp"><%=Testo_Fotografie_LinkVaiElenco%></a>.
											</td>
										</tr>
<%
	End If
%>
									</table>
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
	Set RSFotografie = Nothing

	Conn.Close
	Set Conn = Nothing
%>