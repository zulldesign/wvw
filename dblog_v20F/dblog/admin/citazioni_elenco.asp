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
								<td width="550" valign="top" style="PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px">
									<p align="justify">
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <%=Testo_Sezione_Citazioni%></b>
									</p>
<%
	Dim SQLCitazioni, RSCitazioni, RecordPerPagina, Pagina, I, Temp

	If Session("BLOGAdmin") = True Then
%>
									<table border="0" width="450" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
<%

		SQLCitazioni = " SELECT * FROM [Citazioni] ORDER BY [ID] DESC "
		Set RSCitazioni = Server.CreateObject("ADODB.Recordset")
		RSCitazioni.Open SQLCitazioni, Conn, 1, 3
%>
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<%=Testo_Citazioni_IntroduzioneElenco%> <a href="citazioni_aggiungi.asp"><%=Testo_Modulo_PulsanteAggiungi%></a>.
												<br><%=Testo_Citazioni_IntroduzioneTotaleCitazioni%>: <b><%=RSCitazioni.RecordCount%></b>
											</td>
										</tr>
<%
		RecordPerPagina = 4

	Pagina = Request.QueryString("pagina")
	If Pagina = "" OR Pagina = "0" OR IsNumeric(Pagina) = False Then
		Pagina = 1
	Else
		If Pagina <= 0 Then
			Pagina = 1
		End If
	End If

		If RSCitazioni.EOF = False OR RSCitazioni.BOF = False Then
			RSCitazioni.PageSize = RecordPerPagina
			RSCitazioni.AbsolutePage = Pagina

			For I = 1 To RecordPerPagina
				If NOT RSCitazioni.EOF Then
%>
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<a href="citazioni_modifica.asp?id=<%=RSCitazioni("ID")%>"></a><b><%=Testo_TabellaCitazioni_RigaAutore%></b> <%=RSCitazioni("Autore")%> (<font color="<%If RSCitazioni("Header") Then Response.Write "green" Else Response.Write "red" End If%>"><%=Testo_TabellaCitazioni_IdentificaRotazioneHeader%></font>)
												<br><b><%=Testo_TabellaCitazioni_RigaTesto%></b> <%=Left(RSCitazioni("Citazione"), 30)%>...
												<br><b><%=Testo_TabellaCitazioni_RigaOperazioni%></b> <a href="citazioni_modifica.asp?id=<%=RSCitazioni("ID")%>"><%=Testo_TabellaCitazioni_LinkModifica%></a> | <a href="citazioni_cancella.asp?id=<%=RSCitazioni("ID")%>" onclick="return confirm('<%=Testo_Conferma_CancellazioneFileJavascript%>?');"><%=Testo_TabellaCitazioni_LinkCancella%></a>
											</td>
										</tr>
<%
					RSCitazioni.MoveNext
				End If
			Next
%>
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<div align="right">
													<b><%=Testo_TabellaCitazioni_Paginazione%>:</b> 
<%
			For Temp = 1 To RSCitazioni.PageCount
				Response.Write "<a href=""citazioni_elenco.asp?a="& Server.HtmlEncode(Request.QueryString("a")) &"&pagina=" & Temp & """>"
				Response.Write Temp
				Response.Write "</a> "
			Next
%>
												</div>
											</td>
										</tr>
<%
		Else
%>
										<tr>
											<td width="450" bgcolor="#FBFBFB" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<%=Testo_TabellaCitazioni_ErroreNessunaCitazioneTrovata%>, <a href="citazioni_elenco.asp"><%=Testo_Citazioni_LinkVaiElenco%></a>.
											</td>
										</tr>
<%
		End If
%>
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
	Set RSCitazioni = Nothing

	Conn.Close
	Set Conn = Nothing
%>