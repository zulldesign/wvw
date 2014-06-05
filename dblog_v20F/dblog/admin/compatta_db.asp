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
									<b>\\ <a href="javascript:opener.location.href='default.asp';self.close();"><%=Testo_Path_Pannello%></a> : <%=Testo_Sezione_Manutenzione%></b>
									<p align="justify">
										<%=Testo_Introduzione_Manutenzione%>
									</p>
									<p align="justify">
										<%=Testo_DimensioniDB%>&nbsp;
<%
	Conn.Close
	Set Conn = Nothing

	Dim Azione, FileDaCancellare, FSO
	Azione = "<a href=""compatta_db.asp?azione=si"" title="""& Testo_Link_Compatta &""">"& Testo_Link_Compatta &"</a></strong><div>&nbsp;</div>"
	FileDaCancellare = Request.Querystring("file")

	If Request.QueryString("azione") = "cancella" AND Len(FileDaCancellare) > 0 Then
		Set FSO = Server.CreateObject("Scripting.FileSystemObject")
		If FSO.FileExists(Server.MapPath(Path_DirScrittura & FileDaCancellare)) Then
			FSO.DeleteFile(Server.MapPath(Path_DirScrittura & FileDaCancellare))
		End If

		Set FSO= Nothing
	End If

	If Request.QueryString("azione") = "si" Then
		Dim filBk, strDb, strBk, strConnDb, strConnBk

		filBk = Year(Now()) & Right("0" & Month(Now()), 2) & Right("0" & Day(Now()), 2) & ".mdb"
		Set FSO = Server.CreateObject("Scripting.FileSystemObject")
		If FSO.FileExists(Server.MapPath(Path_DirScrittura & filBk)) Then
			FSO.DeleteFile(Server.MapPath(Path_DirScrittura & filBk))
		End If
		strDb = Server.MapPath(Path_DirScrittura & Nome_Database)
		strBk = Server.MapPath(Path_DirScrittura & filBk)
		FSO.MoveFile strDb, strBk

		Set FSO= Nothing

		strConnDb = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & strDb
		strConnBk = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & strBk

		Dim oJRO : Set oJRO = Server.CreateObject("JRO.JetEngine")
		oJRO.CompactDatabase strConnBk, strConnDb
		Set oJRO = Nothing

		Azione = ""& Testo_Conferma_Compattazione &"</strong><div><i>"& Testo_Conferma_BackupDatabase &" " & filBk & ".</i></div>"
	End If

	Set FSO = Server.CreateObject("Scripting.FileSystemObject")
	Set File = FSO.GetFile(Server.MapPath(Path_DirScrittura & Nome_Database))
	Response.Write "<strong>" & Int(file.Size / 1024) & " KB &nbsp; " & Azione

	Set File = Nothing
%>
									</p>
									<p align="justify">
										<i><%=Testo_Spiegazione_Compattazione%></i>
									</p>
									<table border="0" width="300" align="center">
										<tr>
											<td width="190">
												<b><%=Testo_NomeFile_TabellaDBBackup%></b>
											</td>
											<td width="50" align="right">
												<b><%=Testo_KbFile_TabellaDBBackup%></b>
											</td>
											<td width="60">
												&nbsp;
											</td>
										</tr>
                  <%
	Set fldr = fso.GetFolder(Server.MapPath(Path_DirScrittura))

	For Each file In fldr.Files
		If Lcase(Right(file.Name,3)) = "mdb" AND file.Name <> Nome_Database Then
%>
										<tr>
											<td><%=file.Name%></td>
											<td align="right"><%=Int(file.Size / 1024)%></td>
											<td align="right"><a href="compatta_db.asp?azione=cancella&file=<%=file.Name%>" onclick="return confirm('<%=Testo_Conferma_CancellazioneFileJavascript%> <%=file.Name%>?');"><%=Testo_LinkCancella%></a></td>
										</tr>
<%
		End If
	Next

	Set file = Nothing
	Set fldr = Nothing
	Set FSO = Nothing
%>
									</table>
									
									<p align="right">
										<a href="javascript:self.close();"><%=Testo_LinkChiudi%></a>
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
