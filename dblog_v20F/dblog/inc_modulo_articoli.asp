<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di gestire le categorie degli articoli
%>
	<div class="modulo">
		<div class="modtitolo">
			<img src="<%=Path_Skin%>titolo_articoli.gif" alt="Titolo" />
		</div>
		<div class="modcontenuto">
<%
	'Visualizzo le sezioni e gli articoli in esse contenuti
	Dim SQLCategorieArticoli, RSCategorieArticoli

	SQLCategorieArticoli = " SELECT Count(Articoli.ID) AS TotaleArticoli, Articoli.Sezione FROM Articoli WHERE Articoli.Data & Articoli.Ora <= '"& DataToStr(Date()) & OraToStr(Time()) &"' AND Articoli.Bozza = False GROUP BY Articoli.Sezione "
	Set RSCategorieArticoli = Server.CreateObject("ADODB.Recordset")
	RSCategorieArticoli.Open SQLCategorieArticoli, Conn, 1, 3

	If NOT RSCategorieArticoli.EOF Then
		Do While NOT RSCategorieArticoli.EOF
%>
			<a href="storico.asp?s=<%=Server.URLEncode(RSCategorieArticoli("Sezione"))%>"><%=RSCategorieArticoli("Sezione")%></a> (<%=RSCategorieArticoli("TotaleArticoli")%>)<br />
<%
			RSCategorieArticoli.MoveNext
		Loop
	End If

	RSCategorieArticoli.Close
	Set RSCategorieArticoli = Nothing
%>
			<br /><%=Testo_Catalogati_Mese%><br />
<%
	'Creo i link allo storico per mese
	Do Until StrToData(Data_Prima_Pubblicazione) > Date()
		Response.Write "<a href=""storico.asp?m="& Data_Prima_Pubblicazione &""">" & UCase(Mid(MonthName(Mid(Data_Prima_Pubblicazione, 5, 2), False), 1, 1)) & Mid(MonthName(Mid(Data_Prima_Pubblicazione, 5, 2), False), 2, Len(MonthName(Mid(Data_Prima_Pubblicazione, 5, 2), False)) - 1) & " " & Mid(Data_Prima_Pubblicazione, 1, 4) & "</a><br />"
		Data_Prima_Pubblicazione = DataToStr(DateAdd("m", 1, StrToData(Data_Prima_Pubblicazione)))
	Loop

	'Se la classifica articoli è abilitata eseguo il codice relativo
	If Abilita_PiuLetti Then
%>
			<br />
			<div class="fright"><%=Testo_Link_Classifica_Articoli%>&nbsp;<a href="classifica.asp"><%=Testo_Link_Classifica_Articoli_chiudi%></a></div>
			<div style="clear:both;"></div>
<%
	End If

	'Se la visualizzazione degli ultimi Commenti è abilitata eseguo il codice relativo
	If Abilita_UltimiCommenti Then
%>
			<br /><%=Testo_Ultimi_Commenti%><br />
<%
		Dim SQLUltimiCommenti, RSUltimiCommenti

		SQLUltimiCommenti = " SELECT TOP "& Num_Max_UltimiCommenti &" [ID], [IDArticolo], [IDFotografia], [Testo], [Autore], [Data], [Ora] FROM Commenti ORDER BY [Data] DESC, [Ora] DESC "
		Set RSUltimiCommenti = Server.CreateObject("ADODB.Recordset")
		RSUltimiCommenti.Open SQLUltimiCommenti, Conn, 1, 3

		If NOT RSUltimiCommenti.EOF Then
			Do While NOT RSUltimiCommenti.EOF
				If RSUltimiCommenti("IDArticolo") > 0 Then
					If NOT Abilita_PopupCommenti Then
%>
			<a href="articolo.asp?articolo=<%=RSUltimiCommenti("IDArticolo")%>#commento<%=RSUltimiCommenti("ID")%>">
<%
					Else
%>
			<a href="javascript:popup('commenti_articolo.asp?articolo=<%=RSUltimiCommenti("IDArticolo")%>#commento<%=RSUltimiCommenti("ID")%>');">
<%
					End If
				Else
					If NOT Abilita_PopupCommenti Then
%>
			<a href="fotografia.asp?fotografia=<%=RSUltimiCommenti("IDFotografia")%>#commento<%=RSUltimiCommenti("ID")%>">
<%
					Else
%>
			<a href="javascript:popup('commenti_foto.asp?fotografia=<%=RSUltimiCommenti("IDFotografia")%>#commento<%=RSUltimiCommenti("ID")%>');">
<%
					End If
				End If
				If Len(NoHTML(RSUltimiCommenti("Testo"))) > Num_Max_UltimiCommentiCaratteri Then
%>
				<%=Mid(NoHTML(RSUltimiCommenti("Testo")), 1, Num_Max_UltimiCommentiCaratteri) & "..."%>
<%
				Else
%>
				<%=NoHTML(RSUltimiCommenti("Testo"))%>
<%
				End If
%>
			</a>
			<br /><span class="piccolo"><%=StrToData(RSUltimiCommenti("Data"))%>&nbsp;<%=Pubblicato_alle%>&nbsp;<%=StrToOra(RSUltimiCommenti("Ora"))%><br /><%=Contributo_Di%>&nbsp;<%=RSUltimiCommenti("Autore")%><br /></span>
<%
				RSUltimiCommenti.MoveNext
			Loop
		End If

		RSUltimiCommenti.Close
		Set RSUltimiCommenti = Nothing
%>
		</div>
	</div>
<%
	End If
%>