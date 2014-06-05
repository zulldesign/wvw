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
									<b>\\ <a href="javascript:opener.location.href='default.asp';self.close();"><%=Testo_Path_Pannello%></a> : <%=Testo_Sezione_ElencoSezioni%></b>
									<p align="justify">
										<%=Testo_Articoli_IntroduzioneSezioniDisponibili%>
									</p>
<script type="text/javascript">
	function save(Nome){
		window.opener.document.getElementById('Sezione').value = Nome;
		self.close();
	}
</script>

									<table border="0" width="300">
										<tr>
											<td width="230">
												<b><%=Testo_Articoli_TitoloNomeSezioniDisponibili%></b>
											</td>
											<td width="70">
												&nbsp;
											</td>
										</tr>
<%
	SQLSezioni = " SELECT Sezione FROM Articoli GROUP BY Articoli.Sezione ORDER BY Articoli.Sezione "
	Set RSSezioni = Server.CreateObject("ADODB.Recordset")
	RSSezioni.Open SQLSezioni, Conn, 1, 3

	If RSSezioni.EOF = False Then
		Do While NOT RSSezioni.EOF
%>
										<tr>
											<td valign="top">
												<a href="javascript:save('<%=Replace(Replace(RSSezioni("Sezione"), "'", "\'"), """", "\&quot;")%>');"><%=RSSezioni("Sezione")%></a><br>
											</td>
											<td valign="top" align="right">
												<a href="sezioni_articoli_modifica.asp?s=<%=Server.URLEncode(RSSezioni("Sezione"))%>"><%=Testo_Sezioni_LinkRinomina%></a>
											</td>
										</tr>
<%
			RSSezioni.MoveNext
		Loop
	Else
%>
										<%=Testo_SezioniDisponibili_ErroreNessunaTrovata%>
<%
	End If
%>
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
