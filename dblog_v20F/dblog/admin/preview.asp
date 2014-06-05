<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include file="inc_header.asp"-->
<body bgcolor="<%=Colore_Sfondo_Pagina%>">
<table border="0" width="480" align="center" cellspacing="0" cellpadding="15" bgcolor="<%=Colore_Sfondo_Content%>">
	<tr>
		<td>
			<table border="0" width="480" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
				<tr>
					<td width="480">
						<table border="0" width="480" cellspacing="0" cellpadding="0">
							<tr>
								<td width="480" valign="top" style="PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px">
									<b>\\ <a href="javascript:opener.location.href='default.asp';self.close();"><%=Testo_Path_Pannello%></a> : <%=Testo_Sezione_Preview%></b>
<%
	Dim SQLArticoli, RSArticoli, FID

	If Request.QueryString("id") <> "" AND Request.QueryString("id") <> "0" AND IsNumeric(Request.QueryString("id")) = True  Then
		FID = Request.QueryString("id")
	Else
		FID = 0
	End If

	SQLArticoli = " SELECT Articoli.ID, Articoli.Sezione, Count(Commenti.ID) AS ConteggioID, Articoli.Titolo, Articoli.Autore, Articoli.Data, Articoli.Ora, Articoli.Testo, Articoli.Letture FROM [Commenti] RIGHT JOIN [Articoli] ON Commenti.IDArticolo = Articoli.ID WHERE Articoli.ID = "& FID &" GROUP BY Articoli.ID, Articoli.Sezione, Articoli.Titolo, Articoli.Autore, Articoli.Data, Articoli.Ora, Articoli.Testo, Articoli.Letture ORDER BY Articoli.Data DESC, Articoli.Ora DESC"
	Set RSArticoli = Server.CreateObject("ADODB.Recordset")
	RSArticoli.Open SQLArticoli, Conn, 1, 3

	If NOT RSArticoli.EOF Then
		Do While NOT RSArticoli.EOF
%>
									<p align="justify">
										<b><%=RSArticoli("Titolo")%></b>
										<br><div class="piccolo"><%=Contributo_Di%>&nbsp;<a href="autori.asp?chi=<%=RSArticoli("Autore")%>"><%=RSArticoli("Autore")%></a>&nbsp;<%=Pubblicato_il%>&nbsp;<%If DataToStr(Date()) = RSArticoli("Data") Then%><b><%=StrToData(RSArticoli("Data"))%></b><%Else%><%=StrToData(RSArticoli("Data"))%><%End If%>&nbsp;<%=Pubblicato_alle%>&nbsp;<%=StrToOra(RSArticoli("Ora"))%>, <%=Pubblicato_In%>&nbsp;<a href="storico.asp?s=<%=RSArticoli("Sezione")%>"><%=RSArticoli("Sezione")%></a>, <%=Pubblicato_Clic%>&nbsp;<%=RSArticoli("Letture")%>&nbsp;<%=Pubblicato_Clic_chiudi%></div>
									</p>
									<%=FileToVar(Path_DirPublic & RSArticoli("Testo"), 0)%>
<%
			RSArticoli.MoveNext
		Loop
	Else
%>
									<p align="justify">
										<%=Errore_Articolo_NonTrovato%>
									</p>
<%
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
	Set RSArticoli = Nothing

	Conn.Close
	Set Conn = Nothing
%>