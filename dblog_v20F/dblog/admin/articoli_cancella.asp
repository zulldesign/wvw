<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include file="inc_header.asp"-->

<%
	Dim SQLArticolo, RSArticolo, SQLCommenti, RSCommenti, SQLSezioneArticoli, RSSezioneArticoli, FilSezioneArticoli, SezioneArticoli, FID, NomeFile, FSO

	If Request.QueryString("id") <> "" AND Request.QueryString("id") <> "0" AND IsNumeric(Request.QueryString("id")) = True  Then
		FID = Request.QueryString("id")
	Else
		FID = 0
	End If

	SQLArticolo = " DELETE * FROM [Articoli] WHERE [ID] = "& cInt(FID) &""
	If Session("BLOGAdmin") = False Then
		SQLArticolo = SQLArticolo & " AND [Autore] = '"& Session("BLOGNick") &"' "
	End If
	Set RSArticolo = Server.CreateObject("ADODB.Recordset")
	RSArticolo.Open SQLArticolo, Conn, 1, 3

	Set RSArticolo = Nothing

	SQLCommenti = " DELETE * FROM [Commenti] WHERE [IDArticolo] = "& cInt(FID) &" "
	Set RSCommenti = Server.CreateObject("ADODB.Recordset")
	RSCommenti.Open SQLCommenti, Conn, 1, 3

	Set RSCommenti = Nothing

	NomeFile = cStr(FID)
	If Len(NomeFile) < 6 Then
		For I = 1 To 6 - Len(NomeFile)
			NomeFile = "0" & NomeFile
		Next
	End If
	NomeFile = NomeFile & ".txt"

	Set FSO = CreateObject("Scripting.FileSystemObject")
	If FSO.FileExists(Server.MapPath(Path_DirPublic & NomeFile)) Then
		FSO.DeleteFile(Server.MapPath(Path_DirPublic & NomeFile))
	End If
	Set FSO = Nothing
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
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <a href="articoli_elenco.asp"><%=Testo_Sezione_Articoli%></a> : <%=Testo_Modulo_PulsanteCancella%></b>
									</p>
									<p align="justify">
										<%=Testo_Articoli_CancellazioneABuonFine%>, <a href="<%=Request.ServerVariables("HTTP_REFERER")%>"><%=Testo_Articoli_LinkTornaIndietro%></a>.
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
	Conn.Close
	Set Conn = Nothing
%>