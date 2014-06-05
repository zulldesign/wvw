<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di visualizzare tutti gli articoli pubblicati nel tempo
%>
<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--#include file="inc_db.asp"-->
<!--#include file="inc_funzioni.asp"-->
<!--#include file="inc_moduli.asp"-->
<%
	Sub Contenuto()
		Dim SQLArticoli, RSArticoli, Pagina, Z, Temp, RecordPerPagina, MeseDelloStorico, QSSezioneStorico, QSOrdinamento

		Pagina = Request.QueryString("pagina")
		If Pagina = "" OR Pagina = "0" OR IsNumeric(Pagina) = False Then
			Pagina = 1
		Else
			If Pagina <= 0 Then
				Pagina = 1
			End If
		End If

		QSOrdinamento = Request.QueryString("ordinamento")
		If QSOrdinamento = "" OR (LCase(QSOrdinamento) <> "asc" AND LCase(QSOrdinamento) = "desc") Then
			QSOrdinamento = "desc"
		End If

		MeseDelloStorico = Request.QueryString("m")
		QSSezioneStorico = Request.QueryString("s")

		If QSSezioneStorico = "" Then
			If MeseDelloStorico <> "" Then
%>
	<div id="briciole">\\ <span><a href="default.asp"><%=Sezione_HomePage%></a> : <%=Sezione_Storico_Mese%></span> (<a href="storico.asp?s=<%=Server.URLEncode(QSSezioneStorico)%>&amp;m=<%=Server.URLEncode(MeseDelloStorico)%>&amp;pagina=<%=Pagina%>&amp;ordinamento=<%If LCase(QSOrdinamento) = "desc" Then Response.Write "asc" Else Response.Write "desc" End If%>"><%=Link_InvertiOrdineCronologia%></a>)</div>
  
	<div class="giustificato"><%=Testo_Seguono_TuttiContributi_Sito%></div>
<%
			Else
%>
	<div id="briciole">\\ <span><a href="default.asp"><%=Sezione_HomePage%></a> : <%=Sezione_Storico%></span> (<a href="storico.asp?s=<%=Server.URLEncode(QSSezioneStorico)%>&amp;m=<%=Server.URLEncode(MeseDelloStorico)%>&amp;pagina=<%=Pagina%>&amp;ordinamento=<%If LCase(QSOrdinamento) = "desc" Then Response.Write "asc" Else Response.Write "desc" End If%>"><%=Link_InvertiOrdineCronologia%></a>)</div>
  
	<div class="giustificato"><%=Testo_Seguono_TuttiContributi_Sito%></div>
<%
			End If
		Else
%>
	<div id="briciole">\\ <span><a href="default.asp"><%=Sezione_HomePage%></a> : <a href="storico.asp"><%=Sezione_Storico%></a> : <%=Server.HTMLEncode(QSSezioneStorico)%></span> (<a href="storico.asp?s=<%=Server.URLEncode(QSSezioneStorico)%>&amp;m=<%=Server.URLEncode(MeseDelloStorico)%>&amp;pagina=<%=Pagina%>&amp;ordinamento=<%If LCase(QSOrdinamento) = "desc" Then Response.Write "asc" Else Response.Write "desc" End If%>"><%=Link_InvertiOrdineCronologia%></a>)</div>
  
	<div class="giustificato"><%=Testo_Seguono_TuttiContributi_Sezione%></div>
<%
		End If
		If IsDate(StrToData(MeseDelloStorico)) = False Then
			MeseDelloStorico = ""
		End If

		'Costruisco la query in base al passaggio di parametri
		If QSSezioneStorico = "" Then
			If MeseDelloStorico <> "" Then
				SQLArticoli = "SELECT Articoli.ID, Articoli.Sezione, Count(Commenti.ID) AS ConteggioID, Articoli.Titolo, Articoli.Autore, Articoli.Data, Articoli.Ora, Articoli.Testo, Articoli.Letture, Articoli.Podcast FROM Commenti RIGHT JOIN Articoli ON Commenti.IDArticolo = Articoli.ID WHERE Articoli.Data LIKE '"& Mid(MeseDelloStorico, 1, 6) &"%' AND NOT Articoli.Bozza GROUP BY Articoli.ID, Articoli.Sezione, Articoli.Titolo, Articoli.Autore, Articoli.Data, Articoli.Ora, Articoli.Testo, Articoli.Letture, Articoli.Podcast "
			Else
				SQLArticoli = "SELECT Articoli.ID, Articoli.Sezione, Count(Commenti.ID) AS ConteggioID, Articoli.Titolo, Articoli.Autore, Articoli.Data, Articoli.Ora, Articoli.Testo, Articoli.Letture, Articoli.Podcast FROM Commenti RIGHT JOIN Articoli ON Commenti.IDArticolo = Articoli.ID WHERE Articoli.Data <= '"& DataToStr(Date()) &"' AND NOT Articoli.Bozza GROUP BY Articoli.ID, Articoli.Sezione, Articoli.Titolo, Articoli.Autore, Articoli.Data, Articoli.Ora, Articoli.Testo, Articoli.Letture, Articoli.Podcast "
			End If
		Else
			SQLArticoli = "SELECT Articoli.ID, Articoli.Sezione, Count(Commenti.ID) AS ConteggioID, Articoli.Titolo, Articoli.Autore, Articoli.Data, Articoli.Ora, Articoli.Testo, Articoli.Letture, Articoli.Podcast FROM Commenti RIGHT JOIN Articoli ON Commenti.IDArticolo = Articoli.ID WHERE Articoli.Data <= '"& DataToStr(Date()) &"' AND Articoli.Sezione = '"& DoppioApice(QSSezioneStorico) &"' AND NOT Articoli.Bozza GROUP BY Articoli.ID, Articoli.Sezione, Articoli.Titolo, Articoli.Autore, Articoli.Data, Articoli.Ora, Articoli.Testo, Articoli.Letture, Articoli.Podcast "
		End If
		If LCase(QSOrdinamento) = "desc" Then
			SQLArticoli = SQLArticoli & " ORDER BY Articoli.Data DESC, Articoli.Ora DESC "
		Else
			SQLArticoli = SQLArticoli & " ORDER BY Articoli.Data ASC, Articoli.Ora ASC "
		End If
		Set RSArticoli = Server.CreateObject("ADODB.Recordset")
		RSArticoli.Open SQLArticoli, Conn, 1, 3

		RecordPerPagina = Num_Max_ArticoliPerPagina

		'Visualizzo gli eventuali articoli trovati
		If RSArticoli.EOF = False OR RSArticoli.BOF = False Then
			RSArticoli.PageSize = RecordPerPagina
			RSArticoli.AbsolutePage = Pagina

			For Z = 1 To RecordPerPagina
				If NOT RSArticoli.EOF Then
					If Now() > cDate(StrToData(RSArticoli("Data")) & " " & StrToOra(RSArticoli("Ora"))) Then
%>
	<div class="sopra">
		<div class="titolo">
			<a href="articolo.asp?articolo=<%=RSArticoli("ID")%>"><%=RSArticoli("Titolo")%></a>
		</div>
		<div class="piccolo">
			<%=Contributo_Di%>&nbsp;<a href="autori.asp?chi=<%=RSArticoli("Autore")%>"><%=RSArticoli("Autore")%></a>&nbsp;<%=Pubblicato_il%>&nbsp;<% If DataToStr(Date()) = RSArticoli("Data") Then %><strong><%=StrToData(RSArticoli("Data"))%></strong><% Else %><%=StrToData(RSArticoli("Data"))%><% End If %>&nbsp;<%=Pubblicato_alle%>&nbsp;<%=StrToOra(RSArticoli("Ora"))%>, <%=Pubblicato_In%>&nbsp;<a href="storico.asp?s=<%=Server.URLEncode(RSArticoli("Sezione"))%>"><%=RSArticoli("Sezione")%></a>, <%=Pubblicato_Clic%>&nbsp;<%=RSArticoli("Letture")%>&nbsp;<%=Pubblicato_Clic_chiudi%>
		</div>
	</div>
    
		<div class="giustificato">
      <%=Trailer(FileToVar(Path_DirPublic & RSArticoli("Testo"), 0), "articolo.asp?articolo="& RSArticoli("ID") &"", False)%>
<%
						If RSArticoli("Podcast") <> "" AND NOT IsNull(RSArticoli("Podcast")) Then
							Call PodcastPlayer(RSArticoli("Podcast"), RSArticoli("Podcast"))
						End If
%>
    </div>

	<div class="sotto">
		<a href="articolo.asp?articolo=<%=RSArticoli("ID")%>"><img src="<%=Path_Skin%>articolo.gif" alt="<%=ALT_Ico_Articolo%>" border="0" />&nbsp;<%=Link_Articolo_permalink%></a>&nbsp;<% If Abilita_Commenti Then %><a href="<% If Abilita_PopupCommenti Then %>javascript:popup('commenti_articolo.asp?articolo=<%=RSArticoli("ID")%>');<% Else %>articolo.asp?articolo=<%=RSArticoli("ID")%>#commenti<% End If %>"><img src="<%=Path_Skin%>commenti.gif" alt="<%=ALT_Ico_Commenti%>" border="0" />&nbsp;<%=Link_Commenti%></a> (<%=RSArticoli("ConteggioID")%>)<% End If %>
<%
						If QSSezioneStorico = "" Then
%>
		&nbsp;<img src="<%=Path_Skin%>storico.gif" alt="<%=ALT_Ico_Storico%>" />&nbsp;<%=Link_Storico%>&nbsp;
<%
						Else
%>
		&nbsp;<a href="storico.asp"><img src="<%=Path_Skin%>storico.gif" alt="<%=ALT_Ico_Storico%>" />&nbsp;<%=Link_Storico%></a>&nbsp;
<%
						End If
%>
		<a href="stampa.asp?articolo=<%=RSArticoli("ID")%>"><img src="<%=Path_Skin%>stampa.gif" alt="<%=ALT_Ico_Stampa%>" />&nbsp;<%=Link_Stampa%></a>
	</div>
	<div class="divider">&nbsp;</div>
<%
					End If
					RSArticoli.MoveNext
				End If
			Next
%>
	<div class="pagine"><span><%=Testo_Paginazione%>:</span> 
<%
			For Temp = 1 To RSArticoli.PageCount
				Response.Write "<a href=storico.asp?s="& Server.URLEncode(QSSezioneStorico) & "&amp;m="& Server.URLEncode(MeseDelloStorico) &"&amp;pagina="& Temp &"&amp;ordinamento="& QSOrdinamento &">"
				Response.Write Temp
				Response.Write "</a> "
			Next
%>
	</div>
<%
		Else
%>
	<div class="giustificato"><%=Errore_Articolo_NonTrovato%></div>
<%
		End If
	End Sub

	Call GeneraPagina(Server.MapPath(Path_Template & "pagina.htm"), "", "", "")

	Conn.Close
	Set Conn = Nothing
%>