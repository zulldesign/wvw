<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include file="inc_header.asp"-->

<%
	Dim SQLFotografia, RSFotografia, SQLCommenti, RSCommenti, SQLSezioneFotografie, RSSezioneFotografie, FilSezioneFotografie, SezioneFotografie, FID, NomeFile, FSO

	If Request.QueryString("id") <> "" AND Request.QueryString("id") <> "0" AND IsNumeric(Request.QueryString("id")) = True  Then
		FID = Request.QueryString("id")
	Else
		FID = 0
	End If

	SQLRecuperaNome = " SELECT NomeFile FROM [Fotografie] WHERE [ID] = "& cInt(FID) &""
	If Session("BLOGAdmin") = False Then
		SQLRecuperaNome = SQLRecuperaNome & " AND [Autore] = '"& Session("BLOGNick") &"' "
	End If
	Set RSRecuperaNome = Server.CreateObject("ADODB.Recordset")
	RSRecuperaNome.Open SQLRecuperaNome, Conn, 1, 3

	If NOT RSRecuperaNome.EOF Then
		RSRecuperaNome.MoveFirst
		NomeFile = RSRecuperaNome("NomeFile")
	Else
		NomeFile = ""
	End If

	Set RSRecuperaNome = Nothing

	SQLFotografia = " DELETE * FROM [Fotografie] WHERE [ID] = "& cInt(FID) &""
	If Session("BLOGAdmin") = False Then
		SQLFotografia = SQLFotografia & " AND [Autore] = '"& Session("BLOGNick") &"' "
	End If
	Set RSFotografia = Server.CreateObject("ADODB.Recordset")
	RSFotografia.Open SQLFotografia, Conn, 1, 3

	SQLCommenti = " DELETE * FROM [Commenti] WHERE [IDFotografia] = "& cInt(FID) &" "
	Set RSCommenti = Server.CreateObject("ADODB.Recordset")
	RSCommenti.Open SQLCommenti, Conn, 1, 3

	If NomeFile <> "" Then
		Set FSO = CreateObject("Scripting.FileSystemObject")
		If FSO.FileExists(Server.MapPath(Path_DirPublic & NomeFile)) Then
			FSO.DeleteFile(Server.MapPath(Path_DirPublic & NomeFile))
		End If
		If FSO.FileExists(Server.MapPath(Path_DirPublic & "T-" & NomeFile)) Then
			FSO.DeleteFile(Server.MapPath(Path_DirPublic & "T-" & NomeFile))
		End If
		Set FSO = Nothing
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
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <a href="fotografie_elenco.asp"><%=Testo_Sezione_Fotografie%></a> : <%=Testo_Modulo_PulsanteCancella%></b>
									</p>
									<p align="justify">
										<%=Testo_Fotografie_CancellazioneABuonFine%>, <a href="<%=Request.ServerVariables("HTTP_REFERER")%>"><%=Testo_Fotografie_LinkTornaIndietro%></a>.
									</p>
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
	Set RSFotografia = Nothing
	Set RSCommenti = Nothing
	Set RSSezioneFotografie = Nothing

	Conn.Close
	Set Conn = Nothing
%>