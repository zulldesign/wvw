<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di gestire le categorie delle fotografie
%>
	<div class="modulo">
		<div class="modtitolo">
			<img src="<%=Path_Skin%>titolo_fotografie.gif" alt="Titolo" />
		</div>
		<div class="modcontenuto">
<%
	'Visualizzo le sezioni e le fotografie in esse contenute
	Dim SQLCategorieFotografie, RSCategorieFotografie

	SQLCategorieFotografie = " SELECT Count(Fotografie.ID) AS TotaleFotografie, Fotografie.Sezione FROM Fotografie WHERE Fotografie.Data & Fotografie.Ora <= '"& DataToStr(Date()) & OraToStr(Time()) &"' AND Fotografie.Bozza = False GROUP BY Fotografie.Sezione "
	Set RSCategorieFotografie = Server.CreateObject("ADODB.Recordset")
	RSCategorieFotografie.Open SQLCategorieFotografie, Conn, 1, 3

	If NOT RSCategorieFotografie.EOF Then
		Do While NOT RSCategorieFotografie.EOF
%>
			<a href="foto.asp?s=<%=Server.URLEncode(RSCategorieFotografie("Sezione"))%>"><%=RSCategorieFotografie("Sezione")%></a> (<%=RSCategorieFotografie("TotaleFotografie")%>)<br />
<%
			RSCategorieFotografie.MoveNext
		Loop
	End If

	RSCategorieFotografie.Close
	Set RSCategorieFotografie = Nothing

	'Se la classifica fotografie è abilitata eseguo il codice relativo
	If Abilita_PiuLetti Then
%>
			<br />
			<div class="fright"><%=Testo_Link_Classifica_Fotografie%>&nbsp;<a href="classifica.asp#fotografie"><%=Testo_Link_Classifica_Fotografie_chiudi%></a></div>
			<div style="clear:both;"></div>
		</div>
	</div>
<%
	End If

	Set FilFoto = Nothing
	Set Foto = Nothing
%>