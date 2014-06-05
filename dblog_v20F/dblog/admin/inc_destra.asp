<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
									<%=Testo_Pannello_Benvenuto_UserID%>&nbsp;<%=Session("BLOGNick")%>&nbsp;<%=Testo_Pannello_Benvenuto_Funzioni%>
									<ul>
										<li><a href="articoli_elenco.asp"><%=Testo_Pannello_LinkMenu_Articoli%></a></li>
										<li><a href="fotografie_elenco.asp"><%=Testo_Pannello_LinkMenu_Fotografie%></a></li>
										<li><a href="linklog_elenco.asp"><%=Testo_Pannello_LinkMenu_LinkLog%></a></li>
										<br><li><a href="javascript:popup('upload.asp', 400, 500, 'upload');"><%=Testo_Pannello_LinkMenu_Upload%></a> o <a href="javascript:popup('elencofile.asp?m=visualizzazione', 400, 380, 'elenco');"><%=Testo_Pannello_LinkMenu_ElencoFile%></a></li>
										<hr style="BORDER: <%=Colore_Contorni%> 1px dashed" size="1" width="90%" align="left">
<%
	If Session("BLOGAdmin") = True Then
%>
										<li><a href="sondaggi_elenco.asp"><%=Testo_Pannello_LinkMenu_Sondaggi%></a></li>
										<li><a href="citazioni_elenco.asp"><%=Testo_Pannello_LinkMenu_Citazioni%></a></li>
										<li><a href="stuff_elenco.asp"><%=Testo_Pannello_LinkMenu_Stuff%></a></li>
										<li><a href="link_elenco.asp"><%=Testo_Pannello_LinkMenu_Link%></a></li>
										<li><a href="costanti_elenco.asp"><%=Testo_Pannello_LinkMenu_Configurazione%></a></li>
										<li><a href="javascript:popup('compatta_db.asp', 400, 480, 'CompattaDB');"><%=Testo_Pannello_LinkMenu_Manutenzione%></a></li>
										<hr style="BORDER: <%=Colore_Contorni%> 1px dashed" size="1" width="90%" align="left">
<%
	End If
%>
										<li><a href="autori_elenco.asp"><%=Testo_Pannello_LinkMenu_Autori%></a></li>
										<li><a href="statistiche_elenco.asp"><%=Testo_Pannello_LinkMenu_Statistiche%></a></li>
										<br>
										<br>
										<br>
										<br>
										<li><a href="../"><%=Testo_Pannello_LinkMenu_HomePage%></a></li>
										<li><a href="logout.asp"><%=Testo_Pannello_LinkMenu_Logout%></a></li>
									</ul>