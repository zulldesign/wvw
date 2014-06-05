<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di mostrare il testo stuff

	Dim FilStuff, Stuff, ContenutoStuff

	'Carico il file contenente il testo di quest'area (stuff)
	Set FilStuff = CreateObject("Scripting.FileSystemObject")
	If FilStuff.FileExists(Server.MapPath(Path_DirScrittura & "destra_stuff.txt")) = True Then
		Set Stuff = FilStuff.OpenTextFile(Server.MapPath(Path_DirScrittura & "destra_stuff.txt"))
		ContenutoStuff = Stuff.ReadAll
		If Left(ContenutoStuff, 4) <> "#nd#" Then
%>
	<div class="modulo">
		<div class="modtitolo">
			<img src="<%=Path_Skin%>titolo_stuff.gif" alt="Titolo" />
		</div>
		<div class="modcontenuto">
			<%=ContenutoStuff%>
		</div>
	</div>
<%
		End If
	End If

	Set FilStuff = Nothing
	Set Stuff = Nothing
%>