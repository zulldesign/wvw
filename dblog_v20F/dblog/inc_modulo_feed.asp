<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di mostrare i link ai feed disponibili
%>
	<div class="modulo">
		<div class="modtitolo">
        
		</div>
		<div class="modcontenuto">
			<div class="feed">
				<a href="feedrss.asp" onclick="this.target='_blank';"><img src="<%=Path_Skin%>feed_rss.gif" alt="<%=ALT_Ico_FeedRSS%>" style="vertical-align:middle" border="0" /> Feed RSS 0.91</a><br />
				<a href="feedatom.asp" onclick="this.target='_blank';"><img src="<%=Path_Skin%>feed_atom.gif" alt="<%=ALT_Ico_FeedAtom%>" style="vertical-align:middle" border="0" /> Feed Atom 0.3</a>
			</div>        
		</div>
	</div>