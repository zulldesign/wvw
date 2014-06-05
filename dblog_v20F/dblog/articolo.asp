<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di visualizzare il singolo articolo (permalink)
%>
<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--#include file="inc_db.asp"-->
<!--#include file="inc_funzioni.asp"-->
<!--#include file="inc_moduli.asp"-->
<%
	Sub Contenuto()
%>
	<div id="briciole">\\ <span><a href="default.asp"><%=Sezione_HomePage%></a> : <%=Sezione_Articolo%></span></div>
<%
		Dim SQLArticoli, RSArticoli, SQLAggiornaArticoli, RSAggiornaArticoli, FID, SQLCommenti, RSCommenti, ArticoloTrovato

		'Effettuo il controllo sul parametro ID
		If Request.QueryString("articolo") <> "" AND Request.QueryString("articolo") <> "0" AND IsNumeric(Request.QueryString("articolo")) = True  Then
			FID = Request.QueryString("articolo")
		Else
			'Gestione della cache dei motori di ricerca dopo la modifica del parametro ID
			If Request.QueryString("id") <> "" AND Request.QueryString("id") <> "0" AND IsNumeric(Request.QueryString("id")) = True  Then
				FID = Request.QueryString("id")
			Else
				FID = 0
			End If
		End If

		'Effettuo la ricerca negli articoli per ID
		SQLArticoli = " SELECT Articoli.ID, Articoli.Sezione, Count(Commenti.ID) AS ConteggioID, Articoli.Titolo, Articoli.Autore, Articoli.Data, Articoli.Ora, Articoli.Testo, Articoli.Letture, Articoli.Podcast FROM [Commenti] RIGHT JOIN [Articoli] ON Commenti.IDArticolo = Articoli.ID WHERE Articoli.Data <= '"& DataToStr(Date()) &"' AND Articoli.ID = "& FID &" AND NOT Articoli.Bozza GROUP BY Articoli.ID, Articoli.Sezione, Articoli.Titolo, Articoli.Autore, Articoli.Data, Articoli.Ora, Articoli.Testo, Articoli.Letture, Articoli.Podcast ORDER BY Articoli.Data DESC, Articoli.Ora DESC"
		Set RSArticoli = Server.CreateObject("ADODB.Recordset")
		RSArticoli.Open SQLArticoli, Conn, 1, 3

		'Visualizzo gli eventuali risultati
		ArticoloTrovato = False

		If NOT RSArticoli.EOF Then
			Do While NOT RSArticoli.EOF
				If Now() > cDate(StrToData(RSArticoli("Data")) & " " & StrToOra(RSArticoli("Ora"))) Then
					ArticoloTrovato = True
%>
	<div class="sopra">
		<div class="titolo"><%=RSArticoli("Titolo")%></div>
		<div class="piccolo">
			<%=Contributo_Di%>&nbsp;<a href="autori.asp?chi=<%=RSArticoli("Autore")%>"><%=RSArticoli("Autore")%></a>&nbsp;<%=Pubblicato_il%>&nbsp;<%If DataToStr(Date()) = RSArticoli("Data") Then%><b><%=StrToData(RSArticoli("Data"))%></b><%Else%><%=StrToData(RSArticoli("Data"))%><%End If%>&nbsp;<%=Pubblicato_alle%>&nbsp;<%=StrToOra(RSArticoli("Ora"))%>, <%=Pubblicato_In%>&nbsp;<a href="storico.asp?s=<%=Server.URLEncode(RSArticoli("Sezione"))%>"><%=RSArticoli("Sezione")%></a>, <%=Pubblicato_Clic%>&nbsp;<%=RSArticoli("Letture")%>&nbsp;<%=Pubblicato_Clic_chiudi%>
		</div>
	</div>

	<div class="giustificato">
		<%=Replace(FileToVar(Path_DirPublic & RSArticoli("Testo"), 0), Tag_Trailer, "")%>
<%
					If RSArticoli("Podcast") <> "" AND NOT IsNull(RSArticoli("Podcast")) Then
						Call PodcastPlayer(RSArticoli("Podcast"), RSArticoli("Podcast"))
					End If
%>
	</div>

	<div class="sotto">
		<img src="<%=Path_Skin%>articolo.gif" alt="<%=ALT_Ico_Articolo%>" border="0" />&nbsp;<%=Link_Articolo%>&nbsp;<%If Abilita_Commenti AND Abilita_PopupCommenti Then%><a href="javascript:popup('commenti_articolo.asp?articolo=<%=RSArticoli("ID")%>');"><img src="<%=Path_Skin%>commenti.gif" alt="<%=ALT_Ico_Commenti%>" border="0" />&nbsp;<%=Link_Commenti%></a> (<%=RSArticoli("ConteggioID")%>)<%End If%>&nbsp;<a href="storico.asp"><img src="<%=Path_Skin%>storico.gif" alt="<%=ALT_Ico_Storico%>" border="0" />&nbsp;<%=Link_Storico%></a>&nbsp;<a href="stampa.asp?articolo=<%=RSArticoli("ID")%>"><img src="<%=Path_Skin%>stampa.gif" alt="<%=ALT_Ico_Stampa%>" border="0" />&nbsp;<%=Link_Stampa%></a>
	</div>
<%
				End If
				RSArticoli.MoveNext
			Loop

			If ArticoloTrovato = False Then
%>
	<div class="giustificato"><%=Errore_Articolo_NonTrovato%></div>
<%
			Else
				If NOT Abilita_PopupCommenti Then

					'Se i commenti sono abilitati
					If Abilita_Commenti Then
%>
	<div class="divider">&nbsp;</div>
	<div class="titolo">
		<a name="commenti"><strong><%=Testo_Titolo_AreaCommenti%></strong></a>
	</div>
<%
						'Cerco i commenti relativi all'articolo richiesto
						SQLCommenti = " SELECT * FROM [Commenti] WHERE Commenti.IDArticolo = "& FID &" ORDER BY [Data] ASC, [Ora] ASC "
						Set RSCommenti = Server.CreateObject("ADODB.Recordset")
						RSCommenti.Open SQLCommenti, Conn, 1, 3

						'E visualizzo gli eventuali risultati
						If NOT RSCommenti.EOF Then
							I = 0
							Do While NOT RSCommenti.EOF
								I = I + 1
%>
	<div class="com<%If I Mod 2 Then%>dis<%End If%>pari">
		<div class="comnumero"><a name="commento<%=RSCommenti("ID")%>"></a># <%=I%></div>
		<div class="comtesto"><%=RSCommenti("Testo")%></div>
		<div class="comautore">
			<%=Contributo_Di%>&nbsp;
<%
								If RSCommenti("Link") <> "" Then
									If Abilita_NoFollow Then
										Response.Write "<a href="""& RSCommenti("Link") &""" rel=""nofollow"" onclick=""this.target='_blank';""><strong>"& RSCommenti("Autore") &"</strong></a>"
									Else
										Response.Write "<a href="""& RSCommenti("Link") &""" onclick=""this.target='_blank';""><strong>"& RSCommenti("Autore") &"</strong></a>"
									End If
								Else
									Response.Write "<strong>"& RSCommenti("Autore") &"</strong>"
								End If
%>
			&nbsp;<%=Inviato_il%>&nbsp;<%=StrToData(RSCommenti("Data"))%>&nbsp;<%=Inviato_alle%>&nbsp;<%=StrToOra(RSCommenti("Ora"))%><%=Inviato_chiudi%>
		</div>
	</div>
<%
								RSCommenti.MoveNext
							Loop
						Else
%>
	<div class="giustificato"><%=Errore_Commento_NonTrovato%><br /><br /></div>
<%
						End If

						Set RSCommenti = Nothing
%>
	<div class="formcommenti">
		<form action="commenti_invio.asp?articolo=<%=Server.HTMLEncode(FID)%>" method="post">
			<div><input type="hidden" name="Tipologia" value="A" /></div>
			<div><%=Testo_Campo_Commento%></div>
			<div><textarea name="commento" rows="5" cols="42"></textarea></div>
			<div><%=Testo_Campo_Nome%></div>
			<div><input type="text" name="Autore" size="52" maxlength="50" /></div>
			<div><%=Testo_Campo_EMailLink%></div>
			<div><input type="text" name="Link" size="52" maxlength="50" /><br /><br /></div>
			<div class="right">
				<input type="image" src="<%=Path_Skin%>pulsante_invia.gif" alt="<%=ALT_Pulsante_Commento%>" name="Invia" value="Invia" />
			</div>
		</form>
	</div>
	
	<div class="giustificato"><%=Testo_Disclaimer_Commenti%></div>
<%
					Else
%>
	<div class="giustificato"><%=Errore_Commenti_NonAbilitati%></div>
<%
					End If
				End If

				'Ed aggiorno il numero di hit per l'articolo
				SQLAggiornaArticoli = " UPDATE [Articoli] SET Articoli.Letture = Articoli.Letture + 1 WHERE Articoli.ID = "& FID &" AND NOT Articoli.Bozza "
				Set RSAggiornaArticoli = Server.CreateObject("ADODB.Recordset")
				RSAggiornaArticoli.Open SQLAggiornaArticoli, Conn, 1, 3

				Set RSAggiornaArticoli = Nothing
			End If
		Else
%>
	<div class="giustificato"><%=Errore_Articolo_NonTrovato%></div>
<%
		End If
	End Sub

	'Generazione dinamica di Titolo, Meta Keyword e Meta Description
	Dim SQLArticoli, RSArticoli, FID, METATitleDinamicoPagina, METAKeywordDinamicoPagina, METADescriptionDinamicoPagina

	'Effettuo il controllo sul parametro ID
	If Request.QueryString("articolo") <> "" AND Request.QueryString("articolo") <> "0" AND IsNumeric(Request.QueryString("articolo")) = True  Then
		FID = Request.QueryString("articolo")
	Else
		'Gestione della cache dei motori di ricerca dopo la modifica del parametro ID
		If Request.QueryString("id") <> "" AND Request.QueryString("id") <> "0" AND IsNumeric(Request.QueryString("id")) = True  Then
			FID = Request.QueryString("id")
		Else
			FID = 0
		End If
	End If

	'Effettuo la ricerca negli articoli per ID
	SQLArticoli = " SELECT Articoli.ID, Articoli.Sezione, Count(Commenti.ID) AS ConteggioID, Articoli.Titolo, Articoli.Autore, Articoli.Data, Articoli.Ora, Articoli.Testo, Articoli.Letture FROM [Commenti] RIGHT JOIN [Articoli] ON Commenti.IDArticolo = Articoli.ID WHERE Articoli.Data & Articoli.Ora <= '"& DataToStr(Date()) & OraToStr(Time()) &"' AND Articoli.ID = "& FID &" AND NOT Articoli.Bozza GROUP BY Articoli.ID, Articoli.Sezione, Articoli.Titolo, Articoli.Autore, Articoli.Data, Articoli.Ora, Articoli.Testo, Articoli.Letture ORDER BY Articoli.Data DESC, Articoli.Ora DESC"
	Set RSArticoli = Server.CreateObject("ADODB.Recordset")
	RSArticoli.Open SQLArticoli, Conn, 1, 3

	If NOT RSArticoli.EOF Then
		RSArticoli.MoveFirst
		METATitleDinamicoPagina = RSArticoli("Titolo")
		METAKeywordDinamicoPagina = EstrapolaKeyword(Replace(FileToVar(Path_DirPublic & RSArticoli("Testo"), 0), Tag_Trailer, ""))
		METADescriptionDinamicoPagina = RSArticoli("Titolo")

		RSArticoli.MoveFirst
	Else
		METATitleDinamicoPagina = ""
		METAKeywordDinamicoPagina = ""
		METADescriptionDinamicoPagina = ""
	End If

	Call GeneraPagina(Server.MapPath(Path_Template & "pagina.htm"), METATitleDinamicoPagina, METAKeywordDinamicoPagina, METADescriptionDinamicoPagina)

	Conn.Close
	Set Conn = Nothing
%>