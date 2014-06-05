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
									<b>\\ <a href="javascript:opener.location.href='default.asp';self.close();"><%=Testo_Path_Pannello%></a> : <%=Testo_Sezione_FileElenco%></b>
									<p align="justify">
										<%=Testo_Introduzione_ElencoFile%>
									</p>
<%
	Dim FSO, Cartella, ElencoFile, Documento, I, QSFiltro

	QSFiltro = Request.QueryString("filtro")
	If QSFiltro = "" Then
		QSFiltro = "tutti"
	End If
%>
									<form name="ElencoFile" action="elencofile.asp?m=<%=Server.HtmlEncode(Request.QueryString("m"))%>" method="get">
									<p align="center">
										<%=Testo_Scelta_FiltroFile%>&nbsp;
										<select name="filtro" size="1" onChange="javascript:document.ElencoFile.submit();">
											<option value="tutti" <%If QSFiltro = "tutti" Then Response.Write "selected" End If%>><%=Testo_FiltroFile_Tutti%></a>
											<option value="immagini" <%If QSFiltro = "immagini" Then Response.Write "selected" End If%>><%=Testo_FiltroFile_Immagini%></a>
											<option value="documenti" <%If QSFiltro = "documenti" Then Response.Write "selected" End If%>><%=Testo_FiltroFile_Documenti%></a>
											<option value="podcast" <%If QSFiltro = "podcast" Then Response.Write "selected" End If%>><%=Testo_FiltroFile_Podcast%></a>
										</select>
									</p>
									</form>
<script type="text/javascript">
	function save(Nome){
		window.opener.document.getElementById('NomeFile').value = Nome;
		self.close();
	}
</script>
									<table border="0" cellpadding="0" cellspacing="3" width="300" align="center">
										<tr>
											<td width="200"><b><%=Testo_FiltroFile_ColonnaNome%></b></td>
											<td width="50" align="right"><b><%=Testo_FiltroFile_ColonnaKb%></b></td>
											<td width="50">&nbsp;</td>
										</tr>
<%
	Set FSO = CreateObject("Scripting.FileSystemObject")
	Set Cartella = FSO.GetFolder(Server.MapPath(Path_DirPublic))
	Set ElencoFile = Cartella.Files

	Function ControlloEstensione(NomeDelFile, TipoDiFiltro)
		Dim EstensioneDelFile

		EstensioneDelFile = LCase(Mid(NomeDelFile, Len(NomeDelFile) - 3, 4))

		If EstensioneDelFile = ".txt" AND Len(NomeDelFile) = 10 AND IsNumeric(Mid(NomeDelFile, 1, 7)) Then
			ControlloEstensione = False
		Else
			Select Case QSFiltro
				Case "tutti"
					ControlloEstensione = True
				Case "immagini"
					If EstensioneDelFile = ".jpg" OR EstensioneDelFile = ".gif" OR EstensioneDelFile = ".png" Then
						ControlloEstensione = True
					Else
						ControlloEstensione = False
					End If
				Case "documenti"
					If EstensioneDelFile <> ".jpg" AND EstensioneDelFile <> ".gif" AND EstensioneDelFile <> ".png" AND EstensioneDelFile <> ".mp3" Then
						ControlloEstensione = True
					Else
						ControlloEstensione = False
					End If
				Case "podcast"
					If EstensioneDelFile = ".mp3" Then
						ControlloEstensione = True
					Else
						ControlloEstensione = False
					End If
			End Select
		End If
	End Function

	I = 0
	For Each Documento in ElencoFile
		If ControlloEstensione(Documento.Name, QSFiltro)Then
			I = I + 1
%>
										<tr>
											<td>
<%
			If Request.QueryString("m") <> "visualizzazione" Then
%>
												<a href="javascript:save('<%=Replace(Replace(Documento.Name, "'", "\'"), """", "\&quot;")%>');"><%If Len(Documento.Name) > 25 Then Response.Write Mid(Documento.Name, 1, 25) & "..." Else Response.Write Documento.Name End If%></a>
<%
			Else
				If InStr(Documento.Name, ".") > 0 Then
					If InStr(Testo_Upload_EstensioniNonAbilitate, Mid(Documento.Name, InStrRev(Documento.Name, "."), Len(Documento.Name) - InStrRev(Documento.Name, ".") + 1)) <= 0 Then
%>
												<a href="<%=Path_DirPublic & Documento.Name%>" target="_blank"><%=Documento.Name%></a>
<%
					Else
%>
												<%=Documento.Name%>
<%
					End If
				Else
%>
												<%=Documento.Name%>
<%
				End If
			End If
%>
											</td>
											<td align="right"><%=Documento.Size \ 1024%>&nbsp;</td>
											<td><a href="elencofile_cancella.asp?f=<%=Documento.Name%>"><%=Testo_LinkCancella%></a></td>
										</tr>
<%
		End If
	Next
%>
										<tr>
											<td colspan="3">
												<br><%=I%>&nbsp;<%=Testo_FiltroFile_TotaleFile%>
											</td>
										</tr>
									</table>
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
