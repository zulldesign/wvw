<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di mostrare i meta tag (dinamici e non)
%>
	<title><%If METATitlePagina <> "" Then Response.Write METATitlePagina & " - " End If%><%=Titolo_Blog%></title>
	<meta name="description" content="<%If METADescriptionPagina = "" Then Response.Write Meta_Description Else Response.Write METADescriptionPagina End If%>" />
	<meta name="keywords" content="<%If METAKeywordPagina = "" Then Response.Write Meta_Keywords Else Response.Write METAKeywordPagina End If%>, dBlog 2.0 CMS Open Source" />
	<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
	<meta http-equiv="revisit-after" content="5 days" />
	<meta name="category" content="Blog CMS Content Management System" />
	<meta name="copyright" content="<%=Meta_Copyright%>, dBLog CMS Open Source powered by: info@dblog.it http://www.dblog.it" />
	<meta name="language" content="italian" />
	<meta name="robots" content="index,follow" />
	<link rel="alternate" type="application/rss+xml" title="<%=Nome_Blog%>" href="<%=URL_Blog%>feedrss.asp" />

	<script type="text/javascript">
		function popup(link){
		msg=open(link,"winpopup","toolbar=no,directories=no,menubar=no,width=430,height=500,resizable=no,scrollbars=yes,left=10,top=10");
		}
	</script>

	<script type="text/javascript" src="dblog_podcastscriptjs.js"></script>
	<script type="text/vbscript" src="dblog_podcastscriptvb.js"></script>