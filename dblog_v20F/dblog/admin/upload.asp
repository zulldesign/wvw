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
									<b>\\ <a href="javascript:opener.location.href='default.asp';self.close();"><%=Testo_Path_Pannello%></a> : <%=Testo_Sezione_Upload%></b>
<%
	If Request.QueryString("errore") = "" Then
%>
									<p align="justify">
										<%=Testo_Introduzione_Upload%>
									</p>
									<form method="post" enctype="multipart/form-data" action="outputfile.asp">
										<%=Testo_Modulo_FileDaCaricare%>
										<br><input type="file" name="blob" size="30">
										<br><input type="file" name="blob1" size="30">
										<br><input type="file" name="blob2" size="30">
										<br><input type="file" name="blob3" size="30">
										<br><input type="file" name="blob4" size="30">
										<br><input type="submit" name="enter" value="<%=Testo_Modulo_PulsanteUpload%>">
									</form>
									<p align="justify">
										<i><%=Testo_Spiegazione_Upload%></i>
									</p>
<%
	Else
		If Request.QueryString("errore") = "si" Then
%>
									<p align="justify">
										
										<%=Testo_Errore_Upload%>
										<br><a href="upload.asp"><%=Testo_Link_RiprovaAzione%></a> <%=Testo_SceltaOppure%> <a href="elencofile.asp?m=visualizzazione"><%=Testo_Link_AccediElencoFile%></a>.
									</p>
<%
		End If
		If Request.QueryString("errore") = "no" AND Request.QueryString("file") <> "" Then
%>
									<p align="justify">
										<%=Testo_Upload_Conferma%>&nbsp;<%=Server.HTMLEncode(Request.QueryString("file"))%>
										<br>
										<br><a href="upload.asp"><%=Testo_Link_NuovoUpload%></a>.
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