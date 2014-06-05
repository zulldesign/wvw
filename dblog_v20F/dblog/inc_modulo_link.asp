<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di mostrare la sezione link del blog

	Dim FilLink, Link, ContenutoLink

	'Carico il file contenente il testo di quest'area (link esterni)
	Set FilLink = CreateObject("Scripting.FileSystemObject")
	If FilLink.FileExists(Server.MapPath(Path_DirScrittura & "destra_link.txt")) = True Then
		Set Link = FilLink.OpenTextFile(Server.MapPath(Path_DirScrittura & "destra_Link.txt"))
		ContenutoLink = Link.ReadAll
		If Left(ContenutoLink, 4) <> "#nd#" Then
%>
	<div class="modulo">
		<div class="modtitolo">
			<img src="<%=Path_Skin%>titolo_Link.gif" alt="Titolo" />
		</div>
		<div class="modcontenuto">
			<%=ContenutoLink%>
		</div>
	</div>
<%
		End If
	End If

	Set FilLink = Nothing
	Set Link = Nothing
%>