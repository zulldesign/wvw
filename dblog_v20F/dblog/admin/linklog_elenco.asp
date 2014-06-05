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
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <%=Testo_Sezione_LinkLog%></b>
									</p>
									<table border="0" width="450" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
<%
	Dim SQLLinkLog, RSLinkLog, RecordPerPagina, Pagina, I, Temp, FiltroAutore, ArrayFiltroAutore, SQLListBox, RSListBox
	
	SQLLinkLog = " SELECT ID, Introduzione, Data, URL FROM LinkLog"
	If Session("BLOGAdmin") = True AND Request.QueryString("a") <> "" Then
		SQLLinkLog = SQLLinkLog & " WHERE LinkLog.Autore = '"& ControlloSQLInjection(Request.QueryString("a")) &"'"
	End If
	SQLLinkLog = SQLLinkLog & " ORDER BY LinkLog.Data DESC "

	Set RSLinkLog = Server.CreateObject("ADODB.Recordset")
	RSLinkLog.Open SQLLinkLog, Conn, 1, 3
%>
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<%=Testo_LinkLog_IntroduzioneElenco%> <a href="linklog_aggiungi.asp"><%=Testo_Modulo_PulsanteAggiungi%></a>.
												<br><%=Testo_LinkLog_IntroduzioneTotaleLink%>: <b><%=RSLinkLog.RecordCount%></b>
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

	If RSLinkLog.EOF = False OR RSLinkLog.BOF = False Then
		RSLinkLog.PageSize = RecordPerPagina
		RSLinkLog.AbsolutePage = Pagina

		For I = 1 To RecordPerPagina
			If NOT RSLinkLog.EOF Then
%>
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<b><%=Testo_TabellaLinkLog_RigaIntroduzione%></b> <%=RSLinkLog("Introduzione")%>
												<br><b><%=Testo_TabellaLinkLog_RigaData%></b> <%=StrToData(RSLinkLog("Data"))%>
												<br><b><%=Testo_TabellaLinkLog_RigaOperazioni%></b> <a href="linklog_modifica.asp?id=<%=RSLinkLog("ID")%>"><%=Testo_TabellaLinkLog_LinkModifica%></a> | <a href="linklog_cancella.asp?id=<%=RSLinkLog("ID")%>" onclick="return confirm('<%=Testo_Conferma_CancellazioneFileJavascript%>?');"><%=Testo_TabellaLinkLog_LinkCancella%></a> | <a href="<%=RSLinkLog("URL")%>" target="_blank"><%=Testo_TabellaLinkLog_LinkVisualizza%></a>
											</td>
										</tr>
<%
				RSLinkLog.MoveNext
			End If
		Next

		FiltroAutore = ""

		SQLListBox = " SELECT [Autore] FROM [LinkLog] "
		Set RSListBox = Server.CreateObject("ADODB.Recordset")
		RSListBox.Open SQLListBox, Conn, 1, 3

		Do While NOT RSListBox.EOF
			If InStr(FiltroAutore, "|" & RSListBox("Autore")) = False Then
				FiltroAutore = FiltroAutore & "|" & RSListBox("Autore")
			End If
			RSListBox.MoveNext
		Loop

		ArrayFiltroAutore = Split(FiltroAutore, "|", -1, 1)

		Set RSListBox = Nothing
%>
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<div align="right">
													<b><%=Testo_TabellaLinkLog_Paginazione%>:</b> 
<%
		For Temp = 1 To RSLinkLog.PageCount
			Response.Write "<a href=""linklog_elenco.asp?pagina=" & Temp & """>"
			Response.Write Temp
			Response.Write "</a> "
		Next
%>
												</div>
<%
		If Session("BLOGAdmin") = True Then
%>
												<form action="linklog_elenco.asp" method="get">
                    								<b><%=Testo_TabellaLinkLog_FiltriPer%></b>
                    								<br>
                    								<%=Testo_TabellaLinkLog_FiltroPerAutori%>&nbsp;
                    								<select name="a" size="1">
	                      								<option value=""><%=Testo_TabellaLinkLog_FiltroPerAutoriNessunaScelta%></option>
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
												<%=Testo_TabellaLinkLog_ErroreNessunLinkTrovato%>, <a href="linklog_elenco.asp"><%=Testo_LinkTornaElenco%></a>.
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
	Set RSLinkLog = Nothing

	Conn.Close
	Set Conn = Nothing
%>