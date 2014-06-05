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
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <a href="articoli_elenco.asp"><%=Testo_Sezione_Articoli%></a> : <%=Testo_Sezione_ModeraCommenti%></b>
									</p>
									<table border="0" width="450" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<p align="justify">
													<%=Testo_Introduzione_ModeraCommenti%>
												</p>
											</td>
										</tr>
<%
	Dim SQLCommenti, RSCommenti, RecordPerPagina, Pagina, I, Temp, FID

	If Request.QueryString("id") <> "" AND Request.QueryString("id") <> "0" AND IsNumeric(Request.QueryString("id")) = True  Then
		FID = Request.QueryString("id")
	Else
		FID = 0
	End If

	SQLCommenti = " SELECT * FROM [Commenti] WHERE Commenti.IDArticolo = "& cInt(FID) &" AND Commenti.IDArticolo <> 0 "
	Set RSCommenti = Server.CreateObject("ADODB.Recordset")
	RSCommenti.Open SQLCommenti, Conn, 1, 3

	RecordPerPagina = 5

	Pagina = Request.QueryString("pagina")
	If Pagina = "" OR Pagina = "0" OR IsNumeric(Pagina) = False Then
		Pagina = 1
	Else
		If Pagina <= 0 Then
			Pagina = 1
		End If
	End If

	If RSCommenti.EOF = False OR RSCommenti.BOF = False Then
		RSCommenti.PageSize = RecordPerPagina
		RSCommenti.AbsolutePage = Pagina

		For I = 1 To RecordPerPagina
			If NOT RSCommenti.EOF Then
%>
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<p align="justify">
													<%=RSCommenti("Testo")%>
													<br><b><%=Testo_TabellaCommenti_RigaAutore%></b> <%=RSCommenti("Autore")%>&nbsp;<%If RSCommenti("Link") <> "" Then Response.Write "("& RSCommenti("Link") &")" Else Response.Write Testo_TabellaCommenti_AutoreLinkNonDisponibile End If%>
													<br><%=Testo_TabellaCommenti_RigaInviato%>&nbsp;<%=StrToData(RSCommenti("Data"))%> @ <%=StrToOra(RSCommenti("Ora"))%>&nbsp;<%=Testo_TabellaCommenti_RigaInviatoIndirizzoIP%>&nbsp;<%=RSCommenti("IP")%>
													<br><b><%=Testo_TabellaCommenti_RigaOperazioni%></b> <a href="commento_cancella.asp?id=<%=RSCommenti("ID")%>" onclick="return confirm('<%=Testo_Conferma_CancellazioneFileJavascript%>?');"><%=Testo_Modulo_PulsanteCancella%></a>
													<hr style="BORDER: <%=Colore_Contorni%> 1px dashed" size="1">
												</p>
											</td>
										</tr>
<%
				RSCommenti.MoveNext
			End If
		Next
%>
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<div align="right">
													<b><%=Testo_TabellaCommenti_Paginazione%>:</b> 
<%
		For Temp = 1 To RSCommenti.PageCount
			Response.Write "<a href=""articoli_modera.asp?id="& Server.HTMLEncode(FID) &"&s="& Server.HtmlEncode(Request.QueryString("s")) &"&a="& Server.HtmlEncode(Request.QueryString("a")) &"&pagina=" & Temp & """>"
			Response.Write Temp
			Response.Write "</a> "
		Next
%>
												</div>
											</td>
										</tr>
<%
	Else
%>
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<%=Testo_TabellaCommenti_ErroreNessunCommentoTrovato%>, <a href="articoli_elenco.asp"><%=Testo_LinkTornaElenco%></a>.
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
	Set RSCommenti = Nothing

	Conn.Close
	Set Conn = Nothing
%>