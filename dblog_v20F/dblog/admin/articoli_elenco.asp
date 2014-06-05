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
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <%=Testo_Sezione_Articoli%></b>
									</p>
									<table border="0" width="450" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
<%
	Dim SQLListBox, RSListBox, SQLArticoli, RSArticoli, RecordPerPagina, Pagina, I, Temp, FiltroAutore, FiltroSezione, ArrayFiltroAutore, ArrayFiltroSezione, Z

	SQLArticoli = " SELECT Articoli.ID, Articoli.Sezione, Count(Commenti.ID) AS ConteggioID, Articoli.Titolo, Articoli.Autore, Articoli.Data, Articoli.Ora, Articoli.Testo, Articoli.Letture, Articoli.Bozza FROM Commenti RIGHT JOIN Articoli ON Commenti.IDArticolo = Articoli.ID WHERE Articoli.ID <> 0"
	If Session("BLOGAdmin") = True Then
		If Request.QueryString("a") <> "" Then
			SQLArticoli = SQLArticoli & " AND Articoli.Autore = '"& ControlloSQLInjection(Request.QueryString("a")) &"'"
		End If
	Else
		SQLArticoli = SQLArticoli & " AND Articoli.Autore = '"& Session("BLOGNick") &"'"
	End If
	If Request.QueryString("s") <> "" Then
		SQLArticoli = SQLArticoli & " AND Articoli.Sezione = '"& ControlloSQLInjection(Request.QueryString("s")) &"'"
	End If
	If LCase(Request.QueryString("b")) = "si" Then
		SQLArticoli = SQLArticoli & " AND Articoli.Bozza = True"
	End If
	SQLArticoli = SQLArticoli & " GROUP BY Articoli.ID, Articoli.Sezione, Articoli.Titolo, Articoli.Autore, Articoli.Data, Articoli.Ora, Articoli.Testo, Articoli.Letture, Articoli.Bozza ORDER BY Articoli.Data DESC, Articoli.Ora DESC "
	Set RSArticoli = Server.CreateObject("ADODB.Recordset")
	RSArticoli.Open SQLArticoli, Conn, 1, 3
%>
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<%=Testo_Articoli_IntroduzioneElenco%> <a href="articoli_aggiungi.asp"><%=Testo_Modulo_PulsanteAggiungi%></a>.
												<br><%=Testo_Articoli_IntroduzioneTotaleArticoli%>: <b><%=RSArticoli.RecordCount%></b>
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

	If RSArticoli.EOF = False OR RSArticoli.BOF = False Then
		RSArticoli.PageSize = RecordPerPagina
		RSArticoli.AbsolutePage = Pagina

		For I = 1 To RecordPerPagina
			If NOT RSArticoli.EOF Then
%>
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<b><%=Testo_TabellaArticoli_RigaTitolo%></b> <%=RSArticoli("Titolo")%> 
<%
				If RSArticoli("Bozza") = True Then
%>
												(<font color="red"><%=Testo_TabellaArticoli_CaratteristicaBozza%></font>)
<%
				End If
%>
												<br><a href="articoli_modifica.asp?id=<%=RSArticoli("ID")%>"></a><b><%=Testo_TabellaArticoli_RigaAutore%></b> <%=RSArticoli("Autore")%> (<%=StrToData(RSArticoli("Data"))%> @ <%=StrToOra(RSArticoli("Ora"))%>)
												<br><b><%=Testo_TabellaArticoli_RigaSezione%></b> <%=RSArticoli("Sezione")%> (<%=RSArticoli("Letture")%>&nbsp;<%=Testo_TabellaArticoli_CaratteristicaHit%>)
												<br><b><%=Testo_TabellaArticoli_RigaOperazioni%></b> <a href="articoli_modera.asp?id=<%=RSArticoli("ID")%>"><%=Testo_TabellaArticoli_LinkModeraCommenti%></a> (<%=RSArticoli("ConteggioID")%>) | <a href="articoli_modifica.asp?id=<%=RSArticoli("ID")%>"><%=Testo_TabellaArticoli_LinkModifica%></a> | <a href="articoli_cancella.asp?id=<%=RSArticoli("ID")%>" onclick="return confirm('<%=Testo_Conferma_CancellazioneFileJavascript%>?');"><%=Testo_TabellaArticoli_LinkCancella%></a> | <a href="/dblog/articolo.asp?id=<%=RSArticoli("ID")%>" target="_blank"><%=Testo_TabellaArticoli_LinkVisualizza%></a> | <a href="javascript:popup('preview.asp?id=<%=RSArticoli("ID")%>', 560, 380, 'preview');"><%=Testo_TabellaArticoli_LinkPreview%></a>
											</td>
										</tr>
<%
				RSArticoli.MoveNext
			End If
		Next

		FiltroAutore = ""
		FiltroSezione = ""
	
		SQLListBox = " SELECT [Autore], [Sezione] FROM [Articoli] "
		Set RSListBox = Server.CreateObject("ADODB.Recordset")
		RSListBox.Open SQLListBox, Conn, 1, 3

		Do While NOT RSListBox.EOF
			If InStr(LCase(FiltroAutore), "|" & LCase(RSListBox("Autore"))) = False Then
				FiltroAutore = FiltroAutore & "|" & RSListBox("Autore")
			End If
			If InStr(LCase(FiltroSezione), "|" & LCase(RSListBox("Sezione"))) = False Then
				FiltroSezione = FiltroSezione & "|" & RSListBox("Sezione")
			End If
			RSListBox.MoveNext
		Loop

		Set RSListBox = Nothing

		ArrayFiltroAutore = Split(FiltroAutore, "|", -1, 1)
		ArrayFiltroSezione = Split(FiltroSezione, "|", -1, 1)
%>
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<div align="right">
													<b><%=Testo_TabellaArticoli_Paginazione%>:</b> 
<%
		For Temp = 1 To RSArticoli.PageCount
			Response.Write "<a href=""articoli_elenco.asp?b="& Server.HtmlEncode(Request.QueryString("b")) &"&s="& Server.HtmlEncode(Request.QueryString("s")) &"&a="& Server.HtmlEncode(Request.QueryString("a")) &"&pagina=" & Temp & """>"
			Response.Write Temp
			Response.Write "</a> "
		Next
%>
												</div>
												<form action="Articoli_elenco.asp" method="get">
                    								<b><%=Testo_TabellaArticoli_FiltriPer%></b> (solo le bozze? <input type="checkbox" name="b" id="b" value="si" <%If LCase(Request.QueryString("b")) = "si" Then Response.Write "checked" End If%>>)
                    								<br>
<%
		If Session("BLOGAdmin") = True Then
%>
                    								<%=Testo_TabellaArticoli_FiltroPerAutori%>&nbsp;
                    								<select name="a" size="1">
	                      								<option value=""><%=Testo_TabellaArticoli_FiltroPerAutoriNessunaScelta%></option>
<%
			For Z = 1 To UBound(ArrayFiltroAutore)
%>
														<option <%If Request.QueryString("a") = ArrayFiltroAutore(Z) Then Response.Write "selected" End If%> value="<%=ArrayFiltroAutore(Z)%>"><%=ArrayFiltroAutore(Z)%></option>
<%
			Next
%>
													</select>
                    							 	<%=Testo_TabellaArticoli_FiltroANDOR%>&nbsp;
<%
		End If
%>
                    							 	<%=Testo_TabellaArticoli_FiltroPerSezioni%>&nbsp;
                    							 	<select name="s" size="1">
	                      								<option value=""><%=Testo_TabellaArticoli_FiltroPerSezioniNessunaScelta%></option>
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
	Else
%>
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<%=Testo_TabellaArticoli_ErroreNessunArticoloTrovato%>, <a href="articoli_elenco.asp"><%=Testo_LinkTornaElenco%></a>.
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
	Set RSArticoli = Nothing

	Conn.Close
	Set Conn = Nothing
%>