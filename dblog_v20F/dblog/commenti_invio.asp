<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di ricevere e gestire i commenti inviati agli articoli ed alle fotografie
%>
<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--#include file="inc_db.asp"-->
<!--#include file="inc_funzioni.asp"-->
<!--#include file="inc_moduli.asp"-->
<%
	Sub Contenuto()
%>
	<div class="titolo"><%=Testo_Titolo_Conferma%></div>
<%
		Dim SQLCommenti, RSCommenti, FIDA, FIDF, FIDFotografia, FIDArticolo, FCommento, FAutore, FLink, FTipologia, Errore, SQLControlloAutore, RSControlloAutore, ArrayParoleNonAmmesse, IArrayParoleNonAmmesse, ParolaNonAmmessaFiltrata, IParolaNonAmmessa, SQLCommentiTitoloRelativo, RSCommentiTitoloRelativo, TitoloRelativo

		'Se i commenti sono abilitati eseguo l'invio
		If Abilita_Commenti Then

			'Effettuo il controllo sul parametro id
			If Request.QueryString("articolo") <> "" AND Request.QueryString("articolo") <> "0" AND IsNumeric(Request.QueryString("articolo")) = True  Then
				FIDA = Request.QueryString("articolo")
			Else
				FIDA = 0
			End If
			If Request.QueryString("fotografia") <> "" AND Request.QueryString("fotografia") <> "0" AND IsNumeric(Request.QueryString("fotografia")) = True  Then
				FIDF = Request.QueryString("fotografia")
			Else
				FIDF = 0
			End If

			If FIDA <> 0 OR FIDF <> 0 Then
				FCommento = Replace(SostituisciCaratteri(Request.Form("Commento"), "No"), VbCrLf, "<br />")
				If Len(Testo_Parole_NonAmmesse) > 0 AND Len(FCommento) > 0 Then
					ArrayParoleNonAmmesse = Split(Testo_Parole_NonAmmesse, ",")
					For IArrayParoleNonAmmesse = 0 To UBound(ArrayParoleNonAmmesse)
						ParolaNonAmmessaFiltrata = ""
						For IParolaNonAmmessa = 1 To Len(ArrayParoleNonAmmesse(IArrayParoleNonAmmesse))
							If IParolaNonAmmessa <> 1 AND IParolaNonAmmessa <> Len(ArrayParoleNonAmmesse(IArrayParoleNonAmmesse)) Then
								ParolaNonAmmessaFiltrata = ParolaNonAmmessaFiltrata & "*"
							Else
								ParolaNonAmmessaFiltrata = ParolaNonAmmessaFiltrata & Mid(ArrayParoleNonAmmesse(IArrayParoleNonAmmesse), IParolaNonAmmessa, 1)
							End If
						Next
						FCommento = Replace(FCommento, ArrayParoleNonAmmesse(IArrayParoleNonAmmesse), ParolaNonAmmessaFiltrata, 1, -1, 1)
					Next
				End If

				FAutore = SostituisciCaratteri(Request.Form("Autore"), "No")
				FLink = SostituisciCaratteri(Request.Form("Link"), "No")
				FTipologia = Request.Form("Tipologia")

				'Gestisco l'associazione all'articolo o alla fotografia
				If FTipologia = "F" Then
					FIDFotografia = FIDF
					FIDArticolo = 0
				End If
				If FTipologia = "A" Then
					FIDFotografia = 0
					FIDArticolo = FIDA
				End If

				Errore = False

				If FCommento = "" Then
					Errore = True
				End If

				If FAutore = "" Then
					FAutore = "Anonimo"
				Else
					SQLControlloAutore = " SELECT [UserID] FROM Autori WHERE Autori.UserID = '"& ControlloSQLInjection(FAutore) &"' "
					Set RSControlloAutore = Server.CreateObject("ADODB.Recordset")
					RSControlloAutore.Open SQLControlloAutore, Conn, 1, 3
	
					If NOT RSControlloAutore.EOF AND (Session("BLOGNick") = "" OR Session("BLOGNick") = Null) Then
						Errore = True
					End If
				End If

				If FLink <> "" Then
					If InStr(FLink, "@") <> 0 AND InStr(FLink, ".") <> 0 Then
						FLink = "mailto:" & FLink
					Else
						If Mid(FLink, 1, 7) <> "http://" Then
							FLink = "http://" & FLink
						End If
					End If
				End If

				'Inserisco il commento nel database
				If Errore = False Then
					SQLCommenti = " INSERT INTO [Commenti] ([IDArticolo], [IDFotografia], [Testo], [Autore], [Link], [Data], [Ora], [IP]) VALUES ('"& FIDArticolo &"', '"& FIDFotografia &"', '"& Left(DoppioApice(FCommento), Num_Max_CaratteriCommento) &"', '"& DoppioApice(FAutore) &"', '"& DoppioApice(FLink) &"', '"& DataToStr(Date()) &"', '"& OraToStr(Time()) &"', '"& Request.ServerVariables("REMOTE_ADDR") &"') "
					Set RSCommenti = Server.CreateObject("ADODB.Recordset")
					RSCommenti.Open SQLCommenti, Conn, 1, 3

					Set RSCommenti = Nothing

					'Se la notifica è abilitata inoltro il link via mail al webmaster
					If Abilita_AvvisoCommenti Then
						If FTipologia = "A" Then
							SQLCommentiTitoloRelativo = " SELECT Titolo FROM Articoli WHERE Articoli.ID = "& FIDArticolo &" "
						Else
							SQLCommentiTitoloRelativo = " SELECT Descrizione FROM Fotografie WHERE Fotografie.ID = "& FIDFotografia &" "
						End If
						Set RSCommentiTitoloRelativo = Server.CreateObject("ADODB.Recordset")
						RSCommentiTitoloRelativo.Open SQLCommentiTitoloRelativo, Conn, 1, 3
						If NOT RSCommentiTitoloRelativo.EOF Then
							RSCommentiTitoloRelativo.MoveFirst
							If FTipologia = "A" Then
								TitoloRelativo = RSCommentiTitoloRelativo("Titolo")
							Else
								TitoloRelativo = RSCommentiTitoloRelativo("Descrizione")
							End If
						Else
							TitoloRelativo = "???"
						End If
						RSCommentiTitoloRelativo.Close
						Set RSCommentiTitoloRelativo = Nothing

						If FTipologia = "A" Then
							InviaMail Server_SMTP, Mail_Ufficiale, Mail_Ufficiale, "[" & Nome_Blog & "] Notifica nuovo commento", TitoloRelativo & vbCrLf & Date() & " @ " & Time() & vbCrLf & URL_Blog & "commenti_articolo.asp?articolo=" & FIDA
						Else
							InviaMail Server_SMTP, Mail_Ufficiale, Mail_Ufficiale, "[" & Nome_Blog & "] Notifica nuovo commento", TitoloRelativo & vbCrLf & Date() & " @ " & Time() & vbCrLf & URL_Blog & "commenti_foto.asp?fotografia=" & FIDF
						End If
					End If
%>
	<div class="giustificato"><%=Conferma_Commento_ricevuto%>&nbsp;<a href="<%=Request.ServerVariables("HTTP_REFERER")%>#commenti"><%=Testo_Commento_Visualizza%></a>.</div>
<%
				Else
%>
	<div class="giustificato"><%=Errore_Commento_CampoObbligatorio_e_AutoreLoggato%>&nbsp;<a href="javascript:history.back(-1);"><%=Testo_Commento_Riprova%></a>.</div>
<%
				End If
			Else
%>
	<div class="giustificato"><%=Errore_Commento_Parametri%>&nbsp;<a href="javascript:history.back(-1);"><%=Testo_Commento_Riprova%></a>.</div>
<%
			End If
		Else
%>
	<div class="giustificato"><%=Errore_Commenti_NonAbilitati%></div>
<%
		End If

		If Abilita_PopupCommenti Then
%>
	<div class="right"><a href="javascript:self.close();"><%=Link_Chiudi%></a></div>
<%
		End If
	End Sub

	Call GeneraPagina(Server.MapPath(Path_Template & "popup.htm"), "", "", "")

	Conn.Close
	Set Conn = Nothing
%>