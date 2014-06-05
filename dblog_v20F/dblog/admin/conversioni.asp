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
									<b>\\ <a href="javascript:opener.location.href='default.asp';self.close();"><%=Testo_Path_Pannello%></a> : <%=Testo_Sezione_Conversioni%></b>
									<p align="justify">
										<%=Testo_Introduzione_Conversioni%>
										<br>
										<br><img src="<%=Path_Skin%>smile_diavolo.gif" alt="E - )"> <%=Testo_RelazioneSmile%> <b>E-)</b>
										<br><img src="<%=Path_Skin%>smile_sorriso.gif" alt=": - )"> <%=Testo_RelazioneSmile%> <b>:-)</b>
										<br><img src="<%=Path_Skin%>smile_arrabbiato.gif" alt="S - ("> <%=Testo_RelazioneSmile%> <b> S-(</b>
										<br><img src="<%=Path_Skin%>smile_triste.gif" alt=": - ("> <%=Testo_RelazioneSmile%> <b>:-(</b>
										<br><img src="<%=Path_Skin%>smile_timido.gif" alt=": - \"> <%=Testo_RelazioneSmile%> <b>:-\</b>
										<br><img src="<%=Path_Skin%>smile_shockato.gif" alt=": - o"> <%=Testo_RelazioneSmile%> <b>:-o</b>
										<br><img src="<%=Path_Skin%>smile_assonnato.gif" alt=": - Z"> <%=Testo_RelazioneSmile%> <b>:-Z</b>
										<br><img src="<%=Path_Skin%>smile_bacio.gif" alt=": - *"> <%=Testo_RelazioneSmile%> <b>:-*</b>
										<br><img src="<%=Path_Skin%>smile_lingua.gif" alt=": - P"> <%=Testo_RelazioneSmile%> <b>:-P</b>
										<br><img src="<%=Path_Skin%>smile_morto.gif" alt="X - |"> <%=Testo_RelazioneSmile%> <b>X-|</b>
										<br><img src="<%=Path_Skin%>smile_occhiali.gif" alt="8 - )"> <%=Testo_RelazioneSmile%> <b>8-)</b>
										<br><img src="<%=Path_Skin%>smile_occhiolino.gif" alt="; - )"> <%=Testo_RelazioneSmile%> <b>;-)</b>
										<br><img src="<%=Path_Skin%>smile_risatona.gif" alt=": - D"> <%=Testo_RelazioneSmile%> <b>:-D</b>
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