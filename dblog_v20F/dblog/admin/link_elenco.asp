<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include file="inc_header.asp"-->

<%
	Dim FilLink, Link, ContenutoLink, TSLink
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
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <%=Testo_Sezione_Link%></b>
									</p>
<%
	If Session("BLOGAdmin") = True Then
%>
									<p align="justify">
										<%=Testo_Introduzione_LinkAmici%>
									</p>
									<table border="0" width="450" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
<%
		Set FilLink = CreateObject("Scripting.FileSystemObject")

		If FilLink.FileExists(Server.MapPath(Path_DirScrittura & "destra_link.txt")) = False Then
			Set Link = FilLink.CreateTextFile(Server.MapPath(Path_DirScrittura & "destra_link.txt"), True)
			Link.WriteLine("#nd#")
			Set Link = Nothing
		End If

		If FilLink.FileExists(Server.MapPath(Path_DirScrittura & "destra_link.txt")) = True Then
			If Request.QueryString("a") = "modifica" AND Request.Form("Testo") <> "" AND Request.Form("Testo") <> " " Then
				Set Link = FilLink.GetFile(Server.MapPath(Path_DirScrittura & "destra_link.txt")) 
				Set TSLink = Link.OpenAsTextStream(2, 0)
				TSLink.Write Request.Form("Testo")
				TSLink.Close
				Set Link = Nothing
%>
												<p>
													<%=Testo_LinkAmici_ModificaABuonFine%>
													<br><a href="link_elenco.asp"><%=Testo_LinkAmici_LinkTornaIndietro%></a></a>.
												</p>
<%
			Else
%>
												<form name="FormSorgente" action="Link_elenco.asp?a=modifica" method="post">
													<br><b><%=Testo_Modulo_CampoContenuto%></b> <%=Testo_Modulo_SpiegazioneCampoContenuto%>
													<textarea name="Testo" rows="10" cols="50"><%
				If FilLink.FileExists(Server.MapPath(Path_DirScrittura & "destra_link.txt")) = True Then
					Set Link = FilLink.OpenTextFile(Server.MapPath(Path_DirScrittura & "destra_link.txt"))
					ContenutoLink = Link.ReadAll
					If Left(ContenutoLink, 4) <> "#nd#" Then
%>
											<%=ContenutoLink%>
<%
					End If
					Set Link = Nothing
				End If
													%></textarea>
													<br><%=Testo_Modulo_SpiegazioneEditorHTML%> <a href="javascript:popup('<%=Path_Editor%>editor.asp', 660, 440, 'editor');"><%=Testo_Modulo_LinkEditorHTML%></a>.
													<div align="right">
														<br><input type="submit" name="Modifica" value="<%=Testo_Modulo_PulsanteModifica%>">
													</div>
												</form>
<%
			End If
		End If

		Set FilLink = Nothing
%>
											</td>
										</tr>
									</table>
<%
	Else
%>
									<%=Testo_Errore_FunzioneRiservataAdmin%>
<%
	End If
%>
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