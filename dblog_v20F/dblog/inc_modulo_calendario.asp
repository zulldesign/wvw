<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di gestire il calendario
%>
	<div class="modulo">
		<div class="modtitolo">

		</div>
		<div class="modcontenuto">
<%
	Dim MeseTemp, GiornoTemp, I, Y, Colore, SQLArticoliCalendario, RSArticoliCalendario, GiorniPieni, SQLFotografieCalendario, RSFotografieCalendario, FineForCreaCalendario

	'Effettuo il controllo sul parametro data
	If Request.QueryString("d") = "" OR IsNull(Request.QueryString("d")) OR IsNumeric(Request.QueryString("d")) = False OR Len(Request.QueryString("d")) <> 8 OR IsDate(StrToData(Request.QueryString("d"))) = False Then
		GiornoTemp = Date() - Day(Date()) + 1
		MeseTemp = Month(Date())
	Else
		GiornoTemp = StrToData(Request.QueryString("d")) - Day(StrToData(Request.QueryString("d"))) + 1
		MeseTemp = Month(StrToData(Request.QueryString("d")))
	End If
%>
			<table class="calendario">
				<tr>
					<td>
						<a href="<%=Request.ServerVariables("SCRIPT_NAME")%>?d=<%=DataToStr(DateAdd("m", -1, GiornoTemp))%>">&lt;</a>
					</td>
					<td colspan="5" class="wide">
						<strong><%=MonthName(Month(GiornoTemp))%>&nbsp;<%=Year(GiornoTemp)%></strong>
					</td>
					<td>
						<a href="<%=Request.ServerVariables("SCRIPT_NAME")%>?d=<%=DataToStr(DateAdd("m", 1, GiornoTemp))%>">&gt;</a>
					</td>
				</tr>

				<tr class="giorni">
					<td><div><%=Testo_InizialeLunedi%></div></td>
					<td><div><%=Testo_InizialeMartedi%></div></td>
					<td><div><%=Testo_InizialeMercoledi%></div></td>
					<td><div><%=Testo_InizialeGiovedi%></div></td>
					<td><div><%=Testo_InizialeVenerdi%></div></td>
					<td><div><%=Testo_InizialeSabato%></div></td>
					<td><div><%=Testo_InizialeDomenica%></div></td>
				</tr>
<%
	'Cerco le date in cui sono disponibili i vari articoli
	SQLArticoliCalendario = " SELECT [Data], [Ora] FROM [Articoli] WHERE NOT Articoli.Bozza "
	Set RSArticoliCalendario = Server.CreateObject("ADODB.Recordset")
	RSArticoliCalendario.Open SQLArticoliCalendario, Conn, 1, 3

	'Cerco le date in cui sono disponibili le varie fotografie
	SQLFotografieCalendario = " SELECT [Data], [Ora] FROM [Fotografie] "
	Set RSFotografieCalendario = Server.CreateObject("ADODB.Recordset")
	RSFotografieCalendario.Open SQLFotografieCalendario, Conn, 1, 3

	'E rendo cliccabili i giorni in cui è stato pubblicato almeno un articolo o una fotografia
	GiorniPieni = ""
	If RSArticoliCalendario.EOF = False Then
		Do While NOT RSArticoliCalendario.EOF
			If RSArticoliCalendario("Data") <> DataToStr(Date()) Then
				GiorniPieni = GiorniPieni & "-" & RSArticoliCalendario("Data")
			Else
				If RSArticoliCalendario("Ora") <= OraToStr(Time()) Then
					GiorniPieni = GiorniPieni & "-" & RSArticoliCalendario("Data")
				End If
			End If
			RSArticoliCalendario.MoveNext
		Loop
	End If
	If RSFotografieCalendario.EOF = False Then
		Do While NOT RSFotografieCalendario.EOF
			If RSFotografieCalendario("Data") <> DataToStr(Date()) Then
				GiorniPieni = GiorniPieni & "-" & RSFotografieCalendario("Data")
			Else
				If RSFotografieCalendario("Ora") <= OraToStr(Time()) Then
					GiorniPieni = GiorniPieni & "-" & RSFotografieCalendario("Data")
				End If
			End If
			RSFotografieCalendario.MoveNext
		Loop
	End If

	'In bae alla mese/anno richiesto creo dinamicamente la tabella del calendario
	For Y = 1 to 6
		Response.Write "<tr>"

		If WeekDay(GiornoTemp) <> 2 Then
			FineForCreaCalendario = WeekDay(GiornoTemp) - 2
			If WeekDay(GiornoTemp) = 1 Then
				FineForCreaCalendario = 6
			End If
			For I = 1 To FineForCreaCalendario
				Response.Write "<td>&nbsp;</td>"
			Next
		End If

		Do
			If Month(GiornoTemp) = MeseTemp Then
				If GiornoTemp = Date() Then
					Colore = "oggi"
				Else
					If Day(GiornoTemp) mod 2 = 1 Then
						Colore = "chiaro"
					Else
						Colore = "scuro"
					End If
				End If
				Response.Write "<td class="""& Colore &"""><div class=""piccolo"">"
				If InStr(1, Giornipieni, DataToStr(GiornoTemp)) <> 0 Then
					If DataToStr(GiornoTemp) <= DataToStr(Date) Then
						Response.Write "<a href=""pubblicazioni.asp?d="& DataToStr(GiornoTemp) &""">"& Day(GiornoTemp) &"</a>" & VbCrLf
					Else
						Response.Write Day(GiornoTemp)
					End If
				Else
					Response.Write Day(GiornoTemp)
				End If
				Response.Write "</div></td>" & VbCrLf
			Else
				Response.Write "<td class="""& Colore_Sfondo_Content &""">&nbsp;</td>" & VbCrLf
			End If
			GiornoTemp = GiornoTemp + 1
		Loop Until WeekDay(GiornoTemp) = 2
		Response.Write "</tr>"
	Next

	Set RSArticoliCalendario = Nothing
	Set RSFotografieCalendario = Nothing
%>
			</table>
		</div>
	</div>