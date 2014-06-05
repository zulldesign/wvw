<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di visualizzare la singola fotografia ed i relativi dettagli
%>
<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--#include file="inc_db.asp"-->
<!--#include file="inc_funzioni.asp"-->
<!--#include file="inc_moduli.asp"-->
<%
	Sub Contenuto()
		Dim SQLFotografia, RSFotografia, FID, FSTFotografia, SQLAggiornaFotografie, RSAggiornaFotografie, FotografiaTrovata

		'Effettuo il controllo sul parametro id
		If Request.QueryString("fotografia") <> "" AND Request.QueryString("fotografia") <> "0" AND IsNumeric(Request.QueryString("fotografia")) = True  Then
			FID = Request.QueryString("fotografia")
		Else
			'Gestione della cache dei motori di ricerca dopo la modifica del parametro ID
			If Request.QueryString("id") <> "" AND Request.QueryString("id") <> "0" AND IsNumeric(Request.QueryString("id")) = True  Then
				FID = Request.QueryString("id")
			Else
				FID = 0
			End If
		End If

		'Cerco la fotografia in base al parametro id
		SQLFotografia = "SELECT Fotografie.ID, Fotografie.NomeFile, Count(Commenti.ID) AS ConteggioID, Fotografie.Sezione, Fotografie.Autore, Fotografie.Descrizione, Fotografie.Data, Fotografie.Ora, Fotografie.Letture FROM [Commenti] RIGHT JOIN Fotografie ON Commenti.IDFotografia = Fotografie.ID WHERE Fotografie.Data <= '"& DataToStr(Date()) &"' AND Fotografie.ID = "& FID &" GROUP BY Fotografie.ID, Fotografie.NomeFile, Fotografie.Sezione, Fotografie.Autore, Fotografie.Descrizione, Fotografie.Data, Fotografie.Ora, Fotografie.Letture ORDER BY Fotografie.Data, Fotografie.Ora DESC"
		Set RSFotografia = Server.CreateObject("ADODB.Recordset")
		RSFotografia.Open SQLFotografia, Conn, 1, 3
%>
	<div id="briciole">\\ <span><a href="default.asp"><%=Sezione_HomePage%></a> : <a href="foto.asp"><%=Sezione_Fotografie%></a> : <%=Link_Fotografie%></span></div>
<%
		'E visualizzo gli eventuali risultati
		If NOT RSFotografia.EOF Then
			FotografiaTrovata = False
			Do While NOT RSFotografia.EOF
				If Now() > cDate(StrToData(RSFotografia("Data")) & " " & StrToOra(RSFotografia("Ora"))) Then
					FotografiaTrovata = True
					Set FSTFotografia = CreateObject("Scripting.FileSystemObject")
%>
	<div class="sopra">
		<div class="piccolo">
			<%=Contributo_Di%>&nbsp;<a href="autori.asp?chi=<%=RSFotografia("Autore")%>"><%=RSFotografia("Autore")%></a>&nbsp;<%=Pubblicato_alle_singola%>&nbsp;<%=StrToOra(RSFotografia("Data"))%>&nbsp;<%=Pubblicato_In%>&nbsp;<a href="foto.asp?s=<%=Server.URLEncode(RSFotografia("Sezione"))%>"><%=RSFotografia("Sezione")%></a><%=Pubblicato_chiudi%>
		</div>
	</div>

	<div class="giustificato">
		<%=RSFotografia("Descrizione")%>
	</div>

	<div class="foto">
<%
					If NOT Abilita_ResizeASPNET Then
%>
		<img src="<%If FSTFotografia.FileExists(Server.MapPath(Path_DirPublic & RSFotografia("NomeFile"))) Then Response.Write Path_DirPublic & RSFotografia("NomeFile") Else Response.Write Path_Skin & "F-nd.gif" End If%>" alt="<%=ALT_Immagine_Fotografia%>" />
<%
					Else
%>
		<img src="resize.aspx?img=<%If FSTFotografia.FileExists(Server.MapPath(Path_DirPublic & RSFotografia("NomeFile"))) Then Response.Write Path_DirPublic & RSFotografia("NomeFile") Else Response.Write Path_Skin & "F-nd.gif" End If%>&amp;opx=<%=Num_ResizeASPNET_LarghezzaFotoGrande%>" alt="<%=ALT_Immagine_Fotografia%>" />
<%
					End If
%>
	</div>

	<div class="sotto">
		<%If Abilita_Commenti AND Abilita_PopupCommenti Then%><a href="javascript:popup('commenti_foto.asp?fotografia=<%=RSFotografia("ID")%>');"><img src="<%=Path_Skin%>commenti.gif" alt="<%=ALT_Ico_Commenti%>" />&nbsp;<%=Link_Commenti%></a> (<%=RSFotografia("ConteggioID")%>)<%End If%>&nbsp;<a href="foto.asp"><img src="<%=Path_Skin%>storico.gif" alt="<%=ALT_Ico_Sezioni%>" />&nbsp;<%=Categorie_Fotografie%></a>
	</div>
<%
					'Ed aggiorno il numero di hit ricevute
					SQLAggiornaFotografie = " UPDATE [Fotografie] SET Fotografie.Letture = Fotografie.Letture + 1 WHERE Fotografie.ID = "& FID &" "
					Set RSAggiornaFotografie = Server.CreateObject("ADODB.Recordset")
					RSAggiornaFotografie.Open SQLAggiornaFotografie, Conn, 1, 3
		
					Set RSAggiornaFotografie = Nothing
				End If
				RSFotografia.MoveNext
				Set FSTFotografia = Nothing

				'Ed aggiorno il numero di hit ricevute
				SQLAggiornaFotografie = " UPDATE [Fotografie] SET Fotografie.Letture = Fotografie.Letture + 1 WHERE Fotografie.ID = "& FID &" "
				Set RSAggiornaFotografie = Server.CreateObject("ADODB.Recordset")
				RSAggiornaFotografie.Open SQLAggiornaFotografie, Conn, 1, 3
	
				Set RSAggiornaFotografie = Nothing
			Loop

			If FotografiaTrovata = False Then
%>
	<div class="giustificato"><%=Errore_Fotografia_NonTrovata%></div>
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
						'Cerco i commenti relativi alla fotografia richiesta
						SQLCommenti = " SELECT * FROM [Commenti] WHERE Commenti.IDFotografia = "& FID &" ORDER BY [Data] ASC, [Ora] ASC "
						Set RSCommenti = Server.CreateObject("ADODB.Recordset")
						RSCommenti.Open SQLCommenti, Conn, 1, 3

						'E visualizzo gli eventuali risultati
						If NOT RSCommenti.EOF Then
							I = 0
							Do While NOT RSCommenti.EOF
								I = I + 1
%>
	<div class="com<%If I Mod 2 Then%>dis<%End If%>pari">
		<div class="comnumero"><a name="#commento<%=RSCommenti("ID")%>"></a># <%=I%></div>
		<div class="comtesto"><%=RSCommenti("Testo")%></div>
		<div class="comautore">
			<%=Contributo_Di%>&nbsp;
<%
								If RSCommenti("Link") <> "" Then
									Response.Write "<a href="""& RSCommenti("Link") &""" onclick=""this.target='_blank';""><strong>"& RSCommenti("Autore") &"</strong></a>"
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
		<form action="commenti_invio.asp?fotografia=<%=Server.HTMLEncode(FID)%>" method="post">
			<div><input type="hidden" name="Tipologia" value="F" /></div>
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
			End If
		Else
%>
	<div class="giustificato"><%=Errore_Fotografia_NonTrovata%></div>
<%
		End If
	End Sub

	'Generazione dinamica di Titolo, Meta Keyword e Meta Description
	Dim SQLFotografia, RSFotografia, FID, METATitleDinamicoPagina, METAKeywordDinamicoPagina, METADescriptionDinamicoPagina

	'Effettuo il controllo sul parametro id
	If Request.QueryString("fotografia") <> "" AND Request.QueryString("fotografia") <> "0" AND IsNumeric(Request.QueryString("fotografia")) = True  Then
		FID = Request.QueryString("fotografia")
	Else
		'Gestione della cache dei motori di ricerca dopo la modifica del parametro ID
		If Request.QueryString("id") <> "" AND Request.QueryString("id") <> "0" AND IsNumeric(Request.QueryString("id")) = True  Then
			FID = Request.QueryString("id")
		Else
			FID = 0
		End If
	End If

	'Cerco la fotografia in base al parametro id
	SQLFotografia = "SELECT Fotografie.ID, Fotografie.NomeFile, Count(Commenti.ID) AS ConteggioID, Fotografie.Sezione, Fotografie.Autore, Fotografie.Descrizione, Fotografie.Data, Fotografie.Ora, Fotografie.Letture FROM [Commenti] RIGHT JOIN Fotografie ON Commenti.IDFotografia = Fotografie.ID WHERE Fotografie.Data & Fotografie.Ora <= '"& DataToStr(Date()) & OraToStr(Time()) &"' AND Fotografie.ID = "& FID &" GROUP BY Fotografie.ID, Fotografie.NomeFile, Fotografie.Sezione, Fotografie.Autore, Fotografie.Descrizione, Fotografie.Data, Fotografie.Ora, Fotografie.Letture ORDER BY Fotografie.Data, Fotografie.Ora DESC"
	Set RSFotografia = Server.CreateObject("ADODB.Recordset")
	RSFotografia.Open SQLFotografia, Conn, 1, 3

	If NOT RSFotografia.EOF Then
		RSFotografia.MoveFirst
		METATitleDinamicoPagina = Server.HTMLEncode(RSFotografia("Descrizione"))
		METAKeywordDinamicoPagina = Server.HTMLEncode(EstrapolaKeyword(RSFotografia("Sezione") &" "& RSFotografia("Descrizione")))
		METADescriptionDinamicoPagina = Server.HTMLEncode(RSFotografia("Sezione") &" - "& RSFotografia("Descrizione"))

		RSFotografia.MoveFirst
	Else
		METATitleDinamicoPagina = ""
		METAKeywordDinamicoPagina = ""
		METADescriptionDinamicoPagina = ""
	End If

	Call GeneraPagina(Server.MapPath(Path_Template & "pagina.htm"), METATitleDinamicoPagina, METAKeywordDinamicoPagina, METADescriptionDinamicoPagina)

	Conn.Close
	Set Conn = Nothing
%>
