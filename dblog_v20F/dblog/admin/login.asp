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
								<td width="700" valign="top" style="PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px">
									<p align="justify">
										\\ <b><%=Testo_Path_Pannello%></b>
									</p>
									<p align="justify">
										<%=Testo_Introduzione_Login%>
									</p>
									<form action="controllo.asp" method="post">
										<%=Testo_Campo_UserID%> <input type="textbox" name="UserID" size="15" maxlength="15">&nbsp;<%=Testo_Campo_Password%>&nbsp;<input type="password" name="Password" size="15" maxlength="15"> <input type="submit" value="<%=Testo_Pulsante_Login%>">
									</form>
<%
	If Session("BLOGNick") <> "" Then
%>
									<p align="justify">
										<%=Testo_UserID_Gia_Autenticata%> <a href="default.asp"><%=Testo_Path_Pannello%></a>.
									</p>
<%
	End If
%>
									<br>
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