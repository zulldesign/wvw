<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di visualizzare i risultati della ricerca in articoli e fotografie
%>
<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--#include file="inc_db.asp"-->
<!--#include file="inc_funzioni.asp"-->
<!--#include file="inc_moduli.asp"-->
<%
	Sub Contenuto()
%>
	<div id="briciole">\\ <span><a href="default.asp"><%=Sezione_HomePage%></a> : <%=Sezione_Cerca%></span></div>
<%
		'Se la ricerca non è abilitata visualizzo il messaggio
		If Abilita_Ricerca = False Then
%>
	<div class="giustificato"><%=Errore_Ricerca_NonAbilitata%></div>
<%
		Else
			Dim SQLArticoli, RSArticoli, Parole, SQLFotografie, RSFotografie, FSTFotografia, ArticoloTrovato, FotografiaTrovata

			'Altrimenti eseguo il controllo sulle parole cercate
			If Request.QueryString("cosa") = "" OR IsNull(Request.QueryString("cosa")) OR Len(Request.QueryString("cosa")) < 3 Then
				Parole = ""
			Else
				Parole = Request.QueryString("cosa")
			End If

			'Il minimo di caratteri richiesti per la ricerca è 3
			If Parole = "" Then
%>
	<div class="giustificato"><%=Errore_Ricerca_Minimo3car%></div>
<%
			Else
%>
	<div class="giustificato"><%=Testo_Seguono_risultati%></div>
	<br />
	<div class="giustificato"><strong><%=Ricerca_Articoli_per%>&nbsp;<%=Server.HTMLEncode(Parole)%></strong></div>
	<br />
<%
				'Effettuo la ricerca per parole chiave negli articoli
				SQLArticoli = "SELECT Articoli.ID, Articoli.Sezione, Count(Commenti.ID) AS ConteggioID, Articoli.Titolo, Articoli.Autore, Articoli.Data, Articoli.Ora, Articoli.Testo, Articoli.Letture, Articoli.Podcast FROM Commenti RIGHT JOIN Articoli ON Commenti.IDArticolo = Articoli.ID WHERE Articoli.Data <= '"& DataToStr(Date()) &"' AND NOT Articoli.Bozza GROUP BY Articoli.ID, Articoli.Sezione, Articoli.Titolo, Articoli.Autore, Articoli.Data, Articoli.Ora, Articoli.Testo, Articoli.Letture, Articoli.Podcast ORDER BY Articoli.Ora DESC"
				Set RSArticoli = Server.CreateObject("ADODB.Recordset")
				RSArticoli.Open SQLArticoli, Conn, 1, 3

				If RSArticoli.EOF = False Then
					ArticoloTrovato = False

					'E visualizzo gli eventuali risultati
					Do While NOT RSArticoli.EOF
						If Now() > cDate(StrToData(RSArticoli("Data")) & " " & StrToOra(RSArticoli("Ora"))) Then
							If InStr(LCase(FileToVar(Path_DirPublic & RSArticoli("Testo"), 0)), LCase(Parole)) > 0 OR InStr(LCase(RSArticoli("Titolo")), LCase(Parole)) > 0 Then
								ArticoloTrovato = True
								StatoAttualeTrailer = Abilita_Trailer
								Abilita_Trailer = True
%>
	<div class="sopra">
		<div class="titolo">
			<a href="articolo.asp?articolo=<%=RSArticoli("ID")%>"><%=Evidenzia(RSArticoli("Titolo"), Parole)%></a>
		</div>
		<div class="piccolo">
			<%=Contributo_Di%>&nbsp;<a href="autori.asp?chi=<%=RSArticoli("Autore")%>"><%=RSArticoli("Autore")%></a>&nbsp;<%=Pubblicato_il%>&nbsp;<%=StrToData(RSArticoli("Data"))%>&nbsp;<%=Pubblicato_alle%>&nbsp;<%=StrToOra(RSArticoli("Ora"))%>&nbsp;<%=Pubblicato_In%>&nbsp;<a href="storico.asp?s=<%=Server.URLEncode(RSArticoli("Sezione"))%>"><%=RSArticoli("Sezione")%></a>, <%=Pubblicato_Clic%>&nbsp;<%=RSArticoli("Letture")%>&nbsp;<%=Pubblicato_Clic_chiudi%>
		</div>
	</div>

	<div class="giustificato">
		<%=Evidenzia(Trailer(FileToVar(Path_DirPublic & RSArticoli("Testo"), 0), "articolo.asp?articolo="& RSArticoli("ID") &"", False), Parole)%>
<%
								If RSArticoli("Podcast") <> "" AND NOT IsNull(RSArticoli("Podcast")) Then
									Call PodcastPlayer(RSArticoli("Podcast"), RSArticoli("Podcast"))
								End If
%>
	</div>

	<div class="sotto">
		<a href="articolo.asp?articolo=<%=RSArticoli("ID")%>"><img src="<%=Path_Skin%>articolo.gif" alt="<%=ALT_Ico_Articolo%>" border="0" />&nbsp;<%=Link_Articolo_permalink%></a>&nbsp;<%If Abilita_Commenti Then%><a href="<%If Abilita_PopupCommenti Then%>javascript:popup('commenti_articolo.asp?articolo=<%=RSArticoli("ID")%>');<%Else%>articolo.asp?articolo=<%=RSArticoli("ID")%>#commenti<%End If%>"><img src="<%=Path_Skin%>commenti.gif" alt="<%=ALT_Ico_Commenti%>" border="0" />&nbsp;<%=Link_Commenti%></a> (<%=RSArticoli("ConteggioID")%>)<%End If%>&nbsp;<a href="storico.asp"><img src="<%=Path_Skin%>storico.gif" alt="<%=ALT_Ico_Storico%>" border="0" />&nbsp;<%=Link_Storico%></a>&nbsp;<a href="stampa.asp?articolo=<%=RSArticoli("ID")%>"><img src="<%=Path_Skin%>stampa.gif" alt="<%=ALT_Ico_Stampa%>" border="0" />&nbsp;<%=Link_Stampa%></a>
	</div>
	<div class="divider">&nbsp;</div>
<%
								Abilita_Trailer = StatoAttualeTrailer
							End If
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
%>
	<br />
	<div class="giustificato"><strong><%=Ricerca_Fotografie_per%>&nbsp;<%=Server.HTMLEncode(Parole)%></strong></div>
	<br />
<%
				'Effettuo la ricerca per parole chiave nelle fotografie
				SQLFotografie = "SELECT Fotografie.ID, Fotografie.NomeFile, Count(Commenti.ID) AS ConteggioID, Fotografie.Sezione, Fotografie.Autore, Fotografie.Descrizione, Fotografie.Data, Fotografie.Ora, Fotografie.Letture FROM Commenti RIGHT JOIN Fotografie ON Commenti.IDFotografia = Fotografie.ID WHERE Fotografie.Data <= '"& DataToStr(Date()) &"' GROUP BY Fotografie.ID, Fotografie.NomeFile, Fotografie.Sezione, Fotografie.Autore, Fotografie.Descrizione, Fotografie.Data, Fotografie.Ora, Fotografie.Letture ORDER BY Fotografie.Ora DESC"
				Set RSFotografie = Server.CreateObject("ADODB.Recordset")
				RSFotografie.Open SQLFotografie, Conn, 1, 3

				If RSFotografie.EOF = False Then
					FotografiaTrovata = False

					'E visualizzo gli eventuali risultati
					Do While NOT RSFotografie.EOF
						If Now() > cDate(StrToData(RSFotografie("Data")) & " " & StrToOra(RSFotografie("Ora"))) Then
							If InStr(LCase(RSFotografie("Descrizione")), LCase(Parole)) > 0 Then
								FotografiaTrovata = True
								Set FSTFotografia = CreateObject("Scripting.FileSystemObject")
%>
	<div class="fright">
<%
								If NOT Abilita_ResizeASPNET Then
%>
		<a href="fotografia.asp?fotografia=<%=RSFotografie("ID")%>"><img src="<%If FSTFotografia.FileExists(Server.MapPath(Path_DirPublic & "T-" & RSFotografie("NomeFile"))) Then%><%=Path_DirPublic%>T-<%=RSFotografie("NomeFile")%><%Else%><%=Path_Skin%>T-nd.gif<%End If%>" alt="<%=ALT_Immagine_Thumbnail%>" /></a>
<%
								Else
%>
		<a href="fotografia.asp?fotografia=<%=RSFotografie("ID")%>"><img src="resize.aspx?img=<%If FSTFotografia.FileExists(Server.MapPath(Path_DirPublic & RSFotografie("NomeFile"))) Then%><%=Path_DirPublic%><%=RSFotografie("NomeFile")%><%Else%><%=Path_Skin%>T-nd.gif<%End If%>&amp;opx=<%=Num_ResizeASPNET_LarghezzaFotoThumbnail%>" alt="<%=ALT_Immagine_Thumbnail%>" /></a>
<%
								End If
%>
	</div>
	
	<div class="sopra">
		<div class="piccolo">
			<%=Contributo_Di%>&nbsp;<a href="autori.asp?chi=<%=RSFotografie("Autore")%>"><%=RSFotografie("Autore")%></a>&nbsp;<%=Pubblicato_il%>&nbsp;<%=StrToData(RSFotografie("Data"))%>&nbsp;<%=Pubblicato_alle%>&nbsp;<%=StrToOra(RSFotografie("Ora"))%>, <%=Pubblicato_Letture%>&nbsp;<%=RSFotografie("Letture")%>&nbsp;<%=Pubblicato_Letture_chiudi%>
		</div>
	</div>
	
	<div class="giustificato">
		<%=Evidenzia(RSFotografie("Descrizione"), Parole)%>&nbsp;<a href="fotografia.asp?fotografia=<%=RSFotografie("ID")%>">...</a>
	</div>
	
	<div class="sotto">
		<a href="fotografia.asp?fotografia=<%=RSFotografie("ID")%>"><img src="<%=Path_Skin%>articolo.gif" alt="<%=ALT_Ico_Fotografia%>" border="0" />&nbsp;<%=Link_Fotografie%></a>&nbsp;<%If Abilita_Commenti Then%><a href="<%If Abilita_PopupCommenti Then%>javascript:popup('commenti_foto.asp?fotografia=<%=RSFotografie("ID")%>');<%Else%>fotografia.asp?fotografia=<%=RSFotografie("ID")%>#commenti<%End If%>"><img src="<%=Path_Skin%>commenti.gif" alt="<%=ALT_Ico_Commenti%>" border="0" />&nbsp;<%=Link_Commenti%></a> (<%=RSFotografie("ConteggioID")%>)<%End If%>&nbsp;<a href="foto.asp"><img src="<%=Path_Skin%>storico.gif" alt="<%=ALT_Ico_Storico%>" border="0" />&nbsp;<%=Categorie_Fotografie%></a>
	</div>
	<div class="divider">&nbsp;</div>
<%
								Set FSTFotografia = Nothing
							End If
						End If
						RSFotografie.MoveNext
					Loop
					If FotografiaTrovata = False Then
%>
	<div class="giustificato"><%=Errore_Fotografia_NonTrovata%></div>
<%
					End If
				Else
%>
	<div class="giustificato"><%=Errore_Fotografia_NonTrovata%></div>
<%
				End If
				Set RSFotografie = Nothing
			End If
		End If
	End Sub

	Call GeneraPagina(Server.MapPath(Path_Template & "pagina.htm"), Sezione_Cerca, "", "")

	Conn.Close
	Set Conn = Nothing
%>