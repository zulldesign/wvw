<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di modificare la tabella Articoli per passare dalla versione 2.0RC2 alla versione 2.0, da cancellare assolutamente dopo l'uso
%>
<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--#include file="dblog/inc_db.asp"-->
<!--#include file="dblog/inc_funzioni.asp"-->
	<p>
		<b>Inserimento del campo Podcast nella tabella Articoli</b>
	</p>
<%
	SQLAlterArticoli = " ALTER TABLE Articoli ADD [Podcast] TEXT(250)"	
	Conn.Execute SQLAlterArticoli
%>
	<p>
		Tabella Articoli modificata!
	</p>
	<p>
		<font color="red"><b>RICORDA: cancellare subito i file "da_20rc2_a_20.asp" e "da_14_a_20.asp" dalla root del sito!!</b></font>
	</p>
<%
	Conn.Close
	Set Conn = Nothing
%>
