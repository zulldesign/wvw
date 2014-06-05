<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di gestire il modulo per la ricerca interna

	If Abilita_Ricerca Then
%>
	<div class="modulo">
		<div class="modtitolo">

		</div>
		<div class="modcontenuto">
			<div style="text-align:center;">
				<form action="cerca.asp" method="get">
					<div><%=Testo_Cerca%></div>
					<div><input type="text" name="cosa" value="<%=Server.HTMLEncode(Request.QueryString("cosa"))%>" size="13" maxlength="50" />&nbsp;<input type="image" src="<%=Path_Skin%>pulsante_cerca.gif" alt="<%=ALT_Pulsante_Cerca%>" name="Cerca" value="Cerca" /></div>
				</form>
			</div>
		</div>
	</div>
<%
	End If
%>