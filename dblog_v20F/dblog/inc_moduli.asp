<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di gestire i TAG proprietari del template

	Sub EseguiModulo(TAG, METATitlePagina, METAKeywordPagina, METADescriptionPagina)
		Select Case TAG
'---CONTENUTO--------------------------
			Case "[#CONTENUTO#]"
        Contenuto()    

'---METATAG----------------------------
			Case "[#METATAG#]"
%>
<!--#include file="inc_modulo_metatag.asp"-->
<%

'---INTESTAZIONEFRASE------------------
			Case "[#INTESTAZIONEFRASE#]"
%>
<!--#include file="inc_modulo_intestazionefrase.asp"-->
<%

'---INTESTAZIONEFOTO-------------------
			Case "[#INTESTAZIONEFOTO#]"
%>
<!--#include file="inc_modulo_intestazionefoto.asp"-->
<%

'---UTENTIONLINE-----------------------
			Case "[#UTENTIONLINE#]"
%>
<!--#include file="inc_modulo_utentionline.asp"-->
<%

'---CALENDARIO-------------------------
			Case "[#CALENDARIO#]"
%>
<!--#include file="inc_modulo_calendario.asp"-->
<%
'---RICERCA----------------------------
			Case "[#RICERCA#]"
%>
<!--#include file="inc_modulo_ricerca.asp"-->
<%

'---ARTICOLI---------------------------
			Case "[#ARTICOLI#]"
%>
<!--#include file="inc_modulo_articoli.asp"-->
<%

'---FOTOGRAFIE-------------------------
			Case "[#FOTOGRAFIE#]"
%>
<!--#include file="inc_modulo_fotografie.asp"-->
<%

'---SONDAGGI---------------------------
			Case "[#SONDAGGI#]"
%>
<!--#include file="inc_modulo_sondaggi.asp"-->
<%
'---STUFF------------------------------
			Case "[#STUFF#]"
%>
<!--#include file="inc_modulo_stuff.asp"-->
<%

'---INFORMAZIONI-----------------------
			Case "[#INFORMAZIONI#]"
%>
<!--#include file="inc_modulo_informazioni.asp"-->
<%

'---LINK-------------------------------
			Case "[#LINK#]"
%>
<!--#include file="inc_modulo_link.asp"-->
<%

'---FEED-------------------------------
			Case "[#FEED#]"
%>
<!--#include file="inc_modulo_feed.asp"-->
<%

'---TEMPOESECUZIONE--------------------
			Case "[#TEMPOESECUZIONE#]"
%>
<!--#include file="inc_modulo_tempoesecuzione.asp"-->
<%

'---FOOTER-----------------------------
			Case "[#FOOTER#]"
%>
<!--#include file="inc_modulo_footer.asp"-->
<%
'---POWEREDBY--------------------------
			Case "[#POWEREDBY#]"
%>
<!--#include file="inc_modulo_poweredby.asp"-->
<%
'---CASE ELSE--------------------------
			Case Else
 				Response.Write TAG
'--------------------------------------
		End Select
	End Sub
%>