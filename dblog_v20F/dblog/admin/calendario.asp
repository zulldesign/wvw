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
									<b>\\ <a href="javascript:opener.location.href='default.asp';self.close();"><%=Testo_Path_Pannello%></a> : <%=Testo_Sezione_Calendario%></b>
									<p align="justify">
										<%=Testo_Introduzione_Calendario%>
									</p>
					<script type="text/javascript">
						function save(NuovaData){
                        window.opener.document.getElementById('Data').value = NuovaData;
                        self.close();
						}
					</script>
<%
	Dim MeseTemp, GiornoTemp, I, Y, Colore

	If Request.QueryString("d") = "" OR IsNull(Request.QueryString("d")) OR IsNumeric(Request.QueryString("d")) = False OR Len(Request.QueryString("d")) <> 8 OR IsDate(StrToData(Request.QueryString("d"))) = False Then
		GiornoTemp = Date() - Day(Date()) + 1
		MeseTemp = Month(Date())
	Else
		GiornoTemp = StrToData(Request.QueryString("d")) - Day(StrToData(Request.QueryString("d"))) + 1
		MeseTemp = Month(StrToData(Request.QueryString("d")))
	End If
%>
									<table border="0" width="182" height="130" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
										<tr>
											<td width="26" height="26" align="center" bgcolor="<%=Colore_Sfondo_Content%>"><b><a href="<%=Request.ServerVariables("SCRIPT_NAME")%>?d=<%=DataToStr(DateAdd("m", -1, GiornoTemp))%>"><</a></b></td>
											<td width="130" height="26" colspan="5" align="center" bgcolor="<%=Colore_Sfondo_Content%>"><b><%=MonthName(Month(GiornoTemp))%>&nbsp;<%=Year(GiornoTemp)%></b></td>
											<td width="26" height="26" align="center" bgcolor="<%=Colore_Sfondo_Content%>"><b><a href="<%=Request.ServerVariables("SCRIPT_NAME")%>?d=<%=DataToStr(DateAdd("m", 1, GiornoTemp))%>">></a></b></td>
										</tr>
										<tr>
											<td width="26" height="26" align="center" bgcolor="<%=Colore_Sfondo_Content%>"><div class="piccolo"><b><%=Testo_InizialeLunedi%></b></div></td>
											<td width="26" height="26" align="center" bgcolor="<%=Colore_Sfondo_Content%>"><div class="piccolo"><b><%=Testo_InizialeMartedi%></b></div></td>
											<td width="26" height="26" align="center" bgcolor="<%=Colore_Sfondo_Content%>"><div class="piccolo"><b><%=Testo_InizialeMercoledi%></b></div></td>
											<td width="26" height="26" align="center" bgcolor="<%=Colore_Sfondo_Content%>"><div class="piccolo"><b><%=Testo_InizialeGiovedi%></b></div></td>
											<td width="26" height="26" align="center" bgcolor="<%=Colore_Sfondo_Content%>"><div class="piccolo"><b><%=Testo_InizialeVenerdi%></b></div></td>
											<td width="26" height="26" align="center" bgcolor="<%=Colore_Sfondo_Content%>"><div class="piccolo"><b><%=Testo_InizialeSabato%></b></div></td>
											<td width="26" height="26" align="center" bgcolor="<%=Colore_Sfondo_Content%>"><div class="piccolo"><b><%=Testo_InizialeDomenica%></b></div></td>
										</tr>
<%
	For Y = 1 to 6
		Response.Write "<tr>"
		If WeekDay(GiornoTemp) <> 2 Then
			For I = 1 To WeekDay(GiornoTemp) - 2
				Response.Write "<td width=""26"" height=""26"" align=""center"" bgcolor="""& Colore_Sfondo_Content &""">&nbsp;</td>"
			Next
		End If
		Do
			If Month(GiornoTemp) = MeseTemp Then
				If Day(GiornoTemp) mod 2 = 1 Then
					Colore = Colore_Sfondo_Footer
				Else
					Colore = "#FCFCFC"
				End If
				Response.Write "<td width=""26"" height=""26"" align=""center"" bgcolor="""& Colore &"""><div class=""piccolo"">"
%>
												<a href="javascript:save('<%=DataToStr(GiornoTemp)%>');"><%=Day(GiornoTemp)%></a>
<%
				Response.Write "</div></td>"
			Else
				Response.Write "<td width=""26"" height=""26"" align=""center"" bgcolor="""& Colore_Sfondo_Content &""">&nbsp;</td>"
			End If
			GiornoTemp = GiornoTemp + 1
		Loop Until WeekDay(GiornoTemp) = 2
		Response.Write "</tr>"
	Next
%>
									</table>
									<p align="center">
										<a href="calendario.asp?d=<%=DataToStr(Date())%>"><%=Testo_TornaAlMese%>&nbsp;<%=MonthName(Month(Date()))%>&nbsp;<%=Year(Date())%></a>
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
