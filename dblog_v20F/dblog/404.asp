<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di visualizzare il messaggio di errore "File not found"
%>
<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--#include file="inc_db.asp"-->
<!--#include file="inc_funzioni.asp"-->
<!--#include file="inc_moduli.asp"-->
<%
	Sub Contenuto()
%>
	<div id="briciole">\\ <span><a href="default.asp"><%=Sezione_HomePage%></a> : <%=Testo_Titolo_Pagina404%></span></div><br />
    
	<div id="intro"><%=Testo_Spiegazione_Pagina404%></div><br />
    
	<div id="form404">
		<form action="cerca.asp" method="get">
			<%=Testo_CosaCercare_Pagina404%>
			<input type="textbox" name="cosa" size="13" maxlength="50" /> <input type="image" src="<%=Path_Skin%>pulsante_cerca.gif" alt="<%=ALT_Pulsante_Cerca%>" name="Cerca" value="Cerca" /><br /><br />

			<span class="explain"><%=Testo_Errore_Pagina404%></span>
		</form>
	</div>
<%
	End Sub

	Call GeneraPagina(Server.MapPath(Path_Template & "pagina.htm"), Testo_Titolo_Pagina404, "", "")

	Conn.Close
	Set Conn = Nothing
%>