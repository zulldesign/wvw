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
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <%=Testo_Sezione_Autori%></b>
									</p>
									<table border="0" width="450" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
<%
	Dim SQLListBox, RSListBox, SQLAutori, RSAutori, RecordPerPagina, Pagina, I, Temp, FiltroAutore, ArrayFiltroAutore, Z

	SQLAutori = " SELECT * FROM [Autori] WHERE [ID] <> 0"
	If Session("BLOGAdmin") = True Then
		If Request.QueryString("a") <> "" Then
			SQLAutori = SQLAutori & " AND [Nick] = '"& ControlloSQLInjection(Request.QueryString("a")) &"'"
		End If
	Else
		SQLAutori = SQLAutori & " AND [Nick] = '"& Session("BLOGNick") &"'"
	End If
	SQLAutori = SQLAutori & " ORDER BY [ID] DESC "
	Set RSAutori = Server.CreateObject("ADODB.Recordset")
	RSAutori.Open SQLAutori, Conn, 1, 3
%>
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
<%
	If Session("BLOGAdmin") = True Then
%>
												<%=Testo_Autori_IntroduzioneElenco%> <a href="autori_aggiungi.asp"><%=Testo_Modulo_PulsanteAggiungi%></a>.
												<br>
<%
	End If
%>
												<%=Testo_Autori_IntroduzioneTotaleAutori%>: <b><%=RSAutori.RecordCount%></b>
											</td>
										</tr>
<%
	RecordPerPagina = 10

	Pagina = Request.QueryString("pagina")
	If Pagina = "" OR Pagina = "0" OR IsNumeric(Pagina) = False Then
		Pagina = 1
	Else
		If Pagina <= 0 Then
			Pagina = 1
		End If
	End If

	If RSAutori.EOF = False OR RSAutori.BOF = False Then
		RSAutori.PageSize = RecordPerPagina
		RSAutori.AbsolutePage = Pagina

		For I = 1 To RecordPerPagina
			If NOT RSAutori.EOF Then
%>
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<a href="autori_modifica.asp?id=<%=RSAutori("ID")%>"><%=RSAutori("Nick")%></a> (<font color="<%If RSAutori("Admin") Then Response.Write "green" Else Response.Write "red" End If%>"><%=Testo_TabellaAutori_IdentificaAdmin%></font>)
												<br><b><%=Testo_TabellaAutori_RigaMail%></b> <%If RSAutori("Mail") <> "" Then%><a href="mailto:<%=RSAutori("Mail")%>"><%=RSAutori("Mail")%></a><%Else%><%=Testo_TabellaAutori_eMailNonDisponibile%><%End If%>
												<br><b><%=Testo_TabellaAutori_RigaOperazioni%></b> <a href="autori_modifica.asp?id=<%=RSAutori("ID")%>"><%=Testo_TabellaAutori_LinkModifica%></a><%If Session("BLOGAdmin") = True Then%> | <a href="autori_cancella.asp?id=<%=RSAutori("ID")%>" onclick="return confirm('<%=Testo_Conferma_CancellazioneFileJavascript%>?');"><%=Testo_TabellaAutori_LinkCancella%></a><%End If%> | <a href="/dblog/autori.asp?chi=<%=RSAutori("Nick")%>" target="_blank"><%=Testo_TabellaAutori_LinkVisualizzazione%></a>
											</td>
										</tr>
<%
				RSAutori.MoveNext
			End If
		Next

		FiltroAutore = ""
	
		SQLListBox = " SELECT [Nick] FROM [Autori] WHERE [ID] <> 0"
		If Session("BLOGAdmin") = False Then
			SQLListBox = SQLListBox & " AND [Nick] = '"& Session("BLOGNick") &"'"
		End If
		SQLListBox = SQLListBox & " ORDER BY [Nick] ASC"
		Set RSListBox = Server.CreateObject("ADODB.Recordset")
		RSListBox.Open SQLListBox, Conn, 1, 3

		Do While NOT RSListBox.EOF
			If InStr(FiltroAutore, "|" & RSListBox("Nick")) = False Then
				FiltroAutore = FiltroAutore & "|" & RSListBox("Nick")
			End If
			RSListBox.MoveNext
		Loop

		Set RSListBox = Nothing

		ArrayFiltroAutore = Split(FiltroAutore, "|", -1, 1)
%>
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<div align="right">
													<b><%=Testo_TabellaAutori_Paginazione%>:</b> 
<%
		For Temp = 1 To RSAutori.PageCount
			Response.Write "<a href=""autori_elenco.asp?s="& Server.HtmlEncode(Request.QueryString("s")) &"&a="& Server.HtmlEncode(Request.QueryString("a")) &"&pagina=" & Temp & """>"
			Response.Write Temp
			Response.Write "</a> "
		Next
%>
												</div>
<%
		If Session("BLOGAdmin") = True Then
%>
												<form action="autori_elenco.asp" method="get">
                    								<b><%=Testo_TabellaAutori_FiltriPer%></b>
                    								<br>
                    								<%=Testo_TabellaAutori_FiltroPerAutori%> 
                    								<select name="a" size="1">
	                      								<option value=""><%=Testo_TabellaAutori_FiltroPerAutoriNessunaScelta%></option>
<%
			For Z = 1 To UBound(ArrayFiltroAutore)
%>
														<option <%If Request.QueryString("a") = ArrayFiltroAutore(Z) Then Response.Write "selected" End If%> value="<%=ArrayFiltroAutore(Z)%>"><%=ArrayFiltroAutore(Z)%></option>
<%
			Next
%>
													</select>
													<input type="submit" name="cerca" value="<%=Testo_Modulo_PulsanteRicerca%>">
												</form>
<%
		End If
%>
											</td>
										</tr>
<%
	Else
%>
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<%=Testo_TabellaAutori_ErroreNessunAutoreTrovato%>, <a href="autori_elenco.asp"><%=Testo_LinkTornaElenco%></a>.
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
	Set RSAutori = Nothing

	Conn.Close
	Set Conn = Nothing
%>