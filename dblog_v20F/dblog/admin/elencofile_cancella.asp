<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include file="inc_header.asp"-->
<%
	Dim FSO

	If Request.QueryString("f") <> "" AND Request.QueryString("a") = "conferma" AND NOT InStr(Request.QueryString("f"), "..") AND NOT InStr(Request.QueryString("f"), "\") AND NOT InStr(Request.QueryString("f"), "/") Then
		Set FSO = CreateObject("Scripting.FileSystemObject")
		If FSO.FileExists(Server.MapPath(Path_DirPublic & Request.QueryString("f"))) Then
			FSO.DeleteFile(Server.MapPath(Path_DirPublic & Request.QueryString("f")))
		End If

		Response.Redirect "elencofile.asp"
	End If
%>
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
									<b>\\ <a href="javascript:opener.location.href='default.asp';self.close();"><%=Testo_Path_Pannello%></a> : <%=Testo_Sezione_FileCancella%></b>
									<p align="justify">
										<%=Testo_FiltroFile_IntroduzioneCancellazione%>
										<br>
										<br><b><%=Server.HTMLEncode(Request.QueryString("f"))%></b>
									</p>
									<p align="center">
										<a href="elencofile_cancella.asp?f=<%=Server.URLEncode(Request.QueryString("f"))%>&a=conferma"><%=Testo_FiltroFile_ConfermaCancellazione%></a> - <a href="elencofile.asp"><%=Testo_FiltroFile_NonConfermaCancellazione%></a>
									</p>
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