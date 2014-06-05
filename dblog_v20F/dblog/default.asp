<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di visualizzare gli ultimi N articoli inviati ed il linklog
%>
<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--#include file="inc_db.asp"-->
<!--#include file="inc_funzioni.asp"-->
<!--#include file="inc_moduli.asp"-->
<%
	Sub Contenuto()
%>
	<div id="briciole">\\ <span><%=Sezione_HomePage%></span></div>
	<div id="intro"><%=Testo_Intro_HomePage%></div><br />
<%
		'Cerco gli ultimi N link
		If Abilita_LinkLog Then
			Dim SQLLinkLog, RSLinkLog

			SQLLinkLog = " SELECT TOP "& Num_Max_LinkLog &" * FROM LinkLog WHERE LinkLog.Data <= '"& DataToStr(Date()) &"' ORDER BY LinkLog.Data DESC "
			Set RSLinkLog = Server.CreateObject("ADODB.Recordset")
			RSLinkLog.Open SQLLinkLog, Conn, 1, 3
%>
	<%=Testo_Titolo_AreaLinklog_HomePage%>
	<div class="divider">&nbsp;</div>
	<div id="linklog">
<%
'E visualizzo gli eventuali risultati
			If NOT RSLinkLog.EOF Then
				Do While NOT RSLinkLog.EOF
%>
		<span><%=StrToData(RSLinkLog("Data"))%> - <%=RSLinkLog("Introduzione")%> - <a href="<%=RSLinkLog("URL")%>" onclick="this.target='_blank';"><%=RSLinkLog("TestoLinkato")%></a></span><br />
<%
					RSLinkLog.MoveNext
				Loop
%>
		<div class="sotto">
			<a href="linklog.asp"><img src="<%=Path_Skin%>storico.gif" alt="<%=ALT_Ico_StoricoLinkLog%>" border="0" /> <%=Link_StoricoLinkLog%></a>
		</div>
<%
			Else
%>
		<%=Testo_AreaLinklog_ErroreNessunRecord%>
<%
			End If
%>
		<br />
	</div>
<%
		End If
%>
	<%=Testo_Titolo_AreaWeblog_HomePage%>
	<div class="divider">&nbsp;</div>
<%
		Dim SQLArticoli, RSArticoli, ArticoloTrovato

'Cerco gli ultimi N articoli
		SQLArticoli = "SELECT TOP "& Num_Max_Articoli &" Articoli.ID, Articoli.Sezione, Count(Commenti.ID) AS ConteggioID, Articoli.Titolo, Articoli.Autore, Articoli.Data, Articoli.Ora, Articoli.Testo, Articoli.Letture, Articoli.Podcast FROM [Commenti] RIGHT JOIN [Articoli] ON Commenti.IDArticolo = Articoli.ID WHERE Articoli.Data <= '"& DataToStr(Date()) &"' AND NOT Articoli.Bozza GROUP BY Articoli.ID, Articoli.Sezione, Articoli.Titolo, Articoli.Autore, Articoli.Data, Articoli.Ora, Articoli.Testo, Articoli.Letture, Articoli.Podcast ORDER BY Articoli.Data DESC, Articoli.Ora DESC"
		Set RSArticoli = Server.CreateObject("ADODB.Recordset")
		RSArticoli.Open SQLArticoli, Conn, 1, 3

'E visualizzo gli eventuali risultati
		ArticoloTrovato = False

		If NOT RSArticoli.EOF Then
			Do While NOT RSArticoli.EOF
				If Now() > cDate(StrToData(RSArticoli("Data")) & " " & StrToOra(RSArticoli("Ora"))) Then
					ArticoloTrovato = True
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
		<%=Trailer(FileToVar(Path_DirPublic & RSArticoli("Testo"), 0), "articolo.asp?articolo="& RSArticoli("ID") &"", True)%>
<%
					If RSArticoli("Podcast") <> "" AND NOT IsNull(RSArticoli("Podcast")) Then
						Call PodcastPlayer(RSArticoli("Podcast"), RSArticoli("Podcast"))
					End If
%>
	</div>
    <div class="sotto">
		<a href="articolo.asp?articolo=<%=RSArticoli("ID")%>"><img src="<%=Path_Skin%>articolo.gif" alt="<%=ALT_Ico_Articolo%>" border="0" />&nbsp;<%=Link_Articolo_permalink%></a>&nbsp;<% If Abilita_Commenti Then %><a href="<% If Abilita_PopupCommenti Then %>javascript:popup('commenti_articolo.asp?articolo=<%=RSArticoli("ID")%>');<% Else %>articolo.asp?articolo=<%=RSArticoli("ID")%>#commenti<% End If %>"><img src="<%=Path_Skin%>commenti.gif" alt="<%=ALT_Ico_Commenti%>" border="0" />&nbsp;<%=Link_Commenti%></a> (<%=RSArticoli("ConteggioID")%>)<% End If %>&nbsp;<a href="storico.asp"><img src="<%=Path_Skin%>storico.gif" alt="<%=ALT_Ico_Storico%>" border="0" />&nbsp;<%=Link_Storico%></a>&nbsp;<a href="stampa.asp?articolo=<%=RSArticoli("ID")%>"><img src="<%=Path_Skin%>stampa.gif" alt="<%=ALT_Ico_Stampa%>" border="0" />&nbsp;<%=Link_Stampa%></a>
	</div>
	<div class="divider">&nbsp;</div>
<%
				End If
				RSArticoli.MoveNext
			Loop

			If ArticoloTrovato = False Then
%>
	<div class="giustificato"><%=Errore_Articolo_NonTrovato%></div>
<%
			End If
		Else
%>
	<div class="giustificato"><%=Errore_Articolo_NonTrovato%></div>
<%
		End If

		Set RSArticoli = Nothing
	End Sub

	Call GeneraPagina(Server.MapPath(Path_Template & "pagina.htm"), Sezione_HomePage, "", "")

	Conn.Close
	Set Conn = Nothing
%>