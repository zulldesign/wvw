<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di mostrare il tempo di esecuzione dello script

	FineScript = GetTime()
%>
	<div class="modulo">
		<div class="modtitolo">

		</div>
		<div class="modcontenuto">
			<div class="tempoesec">
				<%=Date()%> @ <%=Time()%><br />
				<%=Testo_ScriptEseguitoIn%>&nbsp;<%=FineScript - InizioScript%> ms
			</div>
		</div>
	</div>