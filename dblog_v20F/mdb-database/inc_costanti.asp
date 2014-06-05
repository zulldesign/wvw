<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<script language="jscript" runat="server">
	function GetTime()
	{
		var d = new Date();
		return d.getTime();
	}
</script>
<%
	Dim InizioScript, FineScript

	InizioScript = GetTime()
%>
<!--#include virtual="/mdb-database/inc_costanti_articoli.asp"-->
<!--#include virtual="/mdb-database/inc_costanti_autori.asp"-->
<!--#include virtual="/mdb-database/inc_costanti_blog.asp"-->
<!--#include virtual="/mdb-database/inc_costanti_classifica.asp"-->
<!--#include virtual="/mdb-database/inc_costanti_colori.asp"-->
<!--#include virtual="/mdb-database/inc_costanti_commenti.asp"-->
<!--#include virtual="/mdb-database/inc_costanti_condivise.asp"-->
<!--#include virtual="/mdb-database/inc_costanti_fotografie.asp"-->
<!--#include virtual="/mdb-database/inc_costanti_homepage.asp"-->
<!--#include virtual="/mdb-database/inc_costanti_immagini.asp"-->
<!--#include virtual="/mdb-database/inc_costanti_intestazione.asp"-->
<!--#include virtual="/mdb-database/inc_costanti_navigazione.asp"-->
<!--#include virtual="/mdb-database/inc_costanti_pubblicazioni.asp"-->
<!--#include virtual="/mdb-database/inc_costanti_ricerca.asp"-->
<!--#include virtual="/mdb-database/inc_costanti_sistema.asp"-->
<!--#include virtual="/mdb-database/inc_costanti_sondaggio.asp"-->
<!--#include virtual="/mdb-database/inc_costanti_storico.asp"-->
<!--#include virtual="/mdb-database/inc_costanti_pannello.asp"-->