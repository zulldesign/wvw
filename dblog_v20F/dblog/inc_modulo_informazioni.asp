<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di gestire il modulo delle informazioni sul blog

	Dim FilInformazioni, Informazioni, ContenutoInformazioni

	'Carico il file contenente il testo di quest'area (informazioni sul sito)
	Set FilInformazioni = CreateObject("Scripting.FileSystemObject")
	If FilInformazioni.FileExists(Server.MapPath(Path_DirScrittura & "destra_informazioni.txt")) = True Then
		Set Informazioni = FilInformazioni.OpenTextFile(Server.MapPath(Path_DirScrittura & "destra_Informazioni.txt"))
		ContenutoInformazioni = Informazioni.ReadAll
%>
	<div class="modulo">
		<div class="modtitolo">
			<img src="<%=Path_Skin%>titolo_Informazioni.gif" alt="Titolo" />
		</div>
		<div class="modcontenuto">
			<%=ContenutoInformazioni%>
		</div>
	</div>
<%
	End If

	Set FilInformazioni = Nothing
	Set Informazioni = Nothing
%>