<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--#include file="inc_db.asp"-->
<!--#include virtual="/dblog/inc_funzioni.asp"-->
<!--#include file="inc_controllo.asp"-->
<html>
<head>
<script language="javascript">
	function popup(link,largo,alto,nome){
	msg=open(link,nome,"toolbar=no,directories=no,menubar=no,width="+largo+",height="+alto+",resizable=no,scrollbars=yes,left=10,top=10");
	}
</script>
<link rel="stylesheet" type="text/css" href="admin.css">
<title><%=Testo_Path_Pannello%></title>
</head>