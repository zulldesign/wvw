<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di gestire la frase (random a rotazione) presente nell'intestazione

	If Abilita_Citazione = True Then
		Dim SQLContaCitaz, RSContaCitaz, SQLRandomCitazioni, RSRandomCitazioni, StrArrayCitazioni, ArrayCitazioni

		IntRandom = 0

		'Cerco le citazioni abilitate per essere visualizzate a rotazione nell'header
		SQLContaCitaz = " SELECT [ID] FROM [Citazioni] WHERE Citazioni.Header = True "
		Set RSContaCitaz = Server.CreateObject("ADODB.Recordset")
		RSContaCitaz.Open SQLContaCitaz, Conn, 1, 3

		'Tra le citazioni disponibili ne scelgo una a caso
		If RSContaCitaz.EOF = False Then
			StrArrayCitazioni = ""
			Do While NOT RSContaCitaz.EOF
				StrArrayCitazioni = StrArrayCitazioni & RSContaCitaz("ID") & ","
				RSContaCitaz.MoveNext
			Loop
			StrArrayCitazioni = Left(StrArrayCitazioni, Len(StrArrayCitazioni) - 1)
			ArrayCitazioni = Split(StrArrayCitazioni, ",", -1, 1)
			Randomize
			IntRandom = Int((UBound(ArrayCitazioni) + 1) *  Rnd)

			'Cerco tutti i dettagli sulla citazione scelta e la visualizzo
			SQLRandomCitazioni = " SELECT [Citazione], [Autore] FROM [Citazioni] WHERE [ID] = "& ArrayCitazioni(IntRandom) &" "
			Set RSRandomCitazioni = Server.CreateObject("ADODB.Recordset")
			RSRandomCitazioni.Open SQLRandomCitazioni, Conn, 1, 3
%>
	<div class="citazione"><%=RSRandomCitazioni("Citazione")%></div><br />
	<div class="citazioneautore"><%=RSRandomCitazioni("Autore")%></div>
<%
			Set RSContaCitaz = Nothing
		Else
%>
	<div class="citazione"><%=Errore_Citazione_NonDisponibile%></div>
<%
		End If

		Set RSRandomCitazioni = Nothing
	End If
%>