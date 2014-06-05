<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di gestire la fotografia (random a rotazione) presente nell'intestazione

	If Abilita_Fotografie = True Then
		Dim SQLContaFoto, RSContaFoto, SQLRandomFotografie, RSRandomFotografie, StrArrayFotografie, ArrayFotografie, IntRandom

		'Cerco le fotografie abilitate per essere visualizzate a rotazione nell'header
		SQLContaFoto = " SELECT [ID], [Data], [Ora] FROM [Fotografie] WHERE Fotografie.Data <= '"& DataToStr(Date()) &"' AND Fotografie.Header = True "
		Set RSContaFoto = Server.CreateObject("ADODB.Recordset")
		RSContaFoto.Open SQLContaFoto, Conn, 1, 3

		'Scelgo, tra le fotografie disponibili, un'immagine a caso
		If RSContaFoto.EOF = False Then
			StrArrayFotografie = ""
			Do While NOT RSContaFoto.EOF
				If Now() > cDate(StrToData(RSContaFoto("Data")) & " " & StrToOra(RSContaFoto("Ora"))) Then
					StrArrayFotografie = StrArrayFotografie & RSContaFoto("ID") & ","
				End If
				RSContaFoto.MoveNext
			Loop

			If StrArrayFotografie <> "" Then
				StrArrayFotografie = Left(StrArrayFotografie, Len(StrArrayFotografie) - 1)
				ArrayFotografie = Split(StrArrayFotografie, ",", -1, 1)
				Randomize
				IntRandom = Int((UBound(ArrayFotografie) + 1) *  Rnd)
				SQLRandomFotografie = " SELECT [ID], [NomeFile], [Autore], [Descrizione] FROM [Fotografie] WHERE [ID] = "& ArrayFotografie(IntRandom) &" "
			Else
				SQLRandomFotografie = " SELECT [ID], [NomeFile], [Autore], [Descrizione] FROM [Fotografie] WHERE [ID] = 0 "
			End If

			'Cerco tutti i dettagli sulla fotografia scelta e la visualizzo
			Set RSRandomFotografie = Server.CreateObject("ADODB.Recordset")
			RSRandomFotografie.Open SQLRandomFotografie, Conn, 1, 3
			If RSRandomFotografie.EOF = False Then
				If NOT Abilita_ResizeASPNET Then
%>
	<img src="<%=Path_DirPublic & RSRandomFotografie("NomeFile")%>" alt="<%=ALT_Immagine_Fotografia%>" />
<%
				Else
%>
	<img src="resize.aspx?img=<%=Path_DirPublic & RSRandomFotografie("NomeFile")%>&amp;opx=<%=Num_ResizeASPNET_LarghezzaFotoIntestazione%>" alt="<%=ALT_Immagine_Fotografia%>" />
<%
				End If
%>
	<div id="didascalia">&nbsp;<span><%=Left(RSRandomFotografie("Descrizione"), 100)%>...</span> di <a href="autori.asp?chi=<%=RSRandomFotografie("Autore")%>"><%=RSRandomFotografie("Autore")%></a></div>
<%
			End If
			Set RSRandomFotografie = Nothing
		Else
%>
	<%=Errore_Fotografia_NonDisponibile%>
<%
		End If

		Set RSContaFoto = Nothing
	End If
%>