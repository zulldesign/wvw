<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di mostrare il numero di utenti online

	If Abilita_UtentiOnLine Then
%>
	<div class="modulo">
		<div class="modtitolo">

		</div>
		<div class="modcontenuto">
			<div class="utentionline">
				<%=Testo_UtentiOnline%><span>&nbsp;<%=Application("UtentiOnLine")%>&nbsp;</span><%=Testo_UtentiOnline_chiudi%>
			</div>
		</div>
	</div>
<%
	End If
%>