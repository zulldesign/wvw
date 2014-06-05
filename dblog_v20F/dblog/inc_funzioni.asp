<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script è una libreria di funzioni utilizzate in tutta la piattaforma

'Impostazione internazionale italiana
	Session.LCID = 1040

'Imposto la durata della sessione in minuti
	Session.Timeout = 20

'Conversione dal formato data (gg/mm/aaaa) al formato stringa (aaaammgg)
	Function DataToStr(Data)
		Dim Anno, Mese, Giorno
		Anno = cStr(Year(Data))
		Mese = cStr(Month(Data))
		If Len(Mese) = 1 Then
			Mese = "0" & Mese
		End If
		Giorno = cStr(Day(Data))
		If Len(Giorno) = 1 Then 
			Giorno = "0" & Giorno
		End If
		DataToStr = Anno & Mese & Giorno
	End Function

'Conversione dal formato stringa (aaaammgg) al formato data (gg/mm/aaaa)
	Function StrToData(Stringa)
		Dim Anno, Mese, Giorno
		Anno = Mid(Stringa, 1, 4)
		Mese = Mid(Stringa, 5, 2)
		Giorno = Mid(Stringa, 7, 2)
		If IsDate(Giorno & "/" & Mese & "/" & Anno) = True Then
			StrToData = cDate(Giorno & "/" & Mese & "/" & Anno)
		Else
			StrToData = Date
		End If
	End Function

'Conversione dal formato ora (hh:mm:ss) al formato stringa (hhmmss)
	Function OraToStr(Ora)
		Dim Ore, Minuti, Secondi
		Ore = cStr(Hour(Ora))
		Minuti = cStr(Minute(Ora))
		Secondi = cStr(Second(Ora))
		If Len(Ore) = 1 Then
			Ore = "0" & Ore
		End If
		If Len(Minuti) = 1 Then
			Minuti = "0" & Minuti
		End If
		If Len(Secondi) = 1 Then
			Secondi = "0" & Secondi
		End If
		OraToStr = Ore & Minuti & Secondi
	End Function

'Conversione dal formato stringa (hhmmss) al formato ora (hh:mm:ss)
	Function StrToOra(Stringa)
		Dim Ore, Minuti, Secondi
		Ore = Mid(Stringa, 1, 2)
		Minuti = Mid(Stringa, 3, 2)
		Secondi = Mid(Stringa, 5, 2)
		StrToOra = Ore & ":" & Minuti & ":" & Secondi
	End Function

'Estrae da un file di testo il contenuto e lo inserisce in una variabile stringa
	Function FileToVar(NomeFile, NumeroCaratteri)
		Dim FilTxt, FilContenuto, FilContenutoTemp
		Set FilTxt = CreateObject("Scripting.FileSystemObject")
		If FilTxt.FileExists(Server.MapPath(NomeFile)) Then
			Set FilContenuto = FilTxt.OpenTextFile(Server.MapPath(NomeFile))
			FilContenutoTemp = FilContenuto.ReadAll
			Set FilContenuto = Nothing
			Set FilTxt = Nothing
			If NumeroCaratteri = 0 Then
				FileToVar = FilContenutoTemp
			Else
				FileToVar = Left(FilContenutoTemp, NumeroCaratteri)
			End If
		Else
			Set FilTxt = Nothing
			FileToVar = "#nd#"
		End If
	End Function

'Invia mail in base al componente attivo
	Sub InviaMail(SMTP, Mittente, Destinatario, Titolo, Testo)
		Dim Mail

		Select Case LCase(Componente_Mail)
			Case "aspemail"
				Set Mail = Server.CreateObject("Persits.MailSender")
				Mail.Host = SMTP
				Mail.From = Mittente
				Mail.AddAddress Destinatario
				Mail.Subject = Titolo
				Mail.Body = Testo
				On Error Resume Next
				Mail.Send
				Set Mail = Nothing
			Case "cdonts"
				Set Mail = Server.CreateObject("CDONTS.NewMail")
				Mail.From = Mittente
				Mail.To = Destinatario
				Mail.Subject = Titolo
				Mail.Body = Testo
				On Error Resume Next
				Mail.Send
				Set Mail = Nothing
			Case "cdosys"
				Set Mail = Server.CreateObject("CDO.Message")
				Mail.From = Mittente
				Mail.To = Destinatario
				Mail.Subject = Titolo
				Mail.TextBody = Testo
				On Error Resume Next
				Mail.Send
				Set Mail = Nothing
		End Select
	End Sub

'Decodifica i caratteri Entity HTML nel loro formato originale (es. &agrave; --> à)
	Function DecodeEntities(stIn)
		'HTML Entity Decoding - http://www.Planet-Source-Code.com/vb/scripts/ShowCode.asp?txtCodeId=7816&lngWId=4
		Dim entitylist, entityvalue, lpos, lpos1, lfound, findstr

		entitylist = ",nbsp,iexcl,curren,cent,pound,yen,brvbar,sect,umi,copy,ordf,laquo,not,shy,reg,macr,deg,plusmn,sup2,sup3,acute,micro,para,middot,cedil,sup1,ordm,raquo,frac14,frac12,frac34,iquest,times,divide,"
		entityvalue = ",160 ,161  ,164   ,162 ,163  ,165,166   ,167 ,168,169 ,170 ,171  ,172,172,174,175 ,176,177   ,178 ,179 ,180  ,181  ,182 ,183   ,184  ,185 ,186 ,187  ,188   ,189   ,190   ,191   ,215  ,247   ,"

		entitylist = entitylist & "Agrave,Aacute,Acirc,Atilde,Aumi,Aring,Aelig,Ccedil,Egrave,Eacute,Ecirc,Euml,Igrave,Iacute,Icirc,Iuml,ETH,Ntilde,Ograve,Oacute,Ocirc,Otilde,Ouml,Oslash,Ugrave,Uacute,Ucirc,Uuml,Yacute,THORN,szlig,agrave,aacute,acirc,atilde,auml,aring,aelig,ccedil,egrave,eacute,ecirc,euml,igrave,iacute,icirc,iuml,eth,ntilde,ograve,oacute,ocirc,otilde,ouml,oslash,ugrave,uacute,ucirc,uuml,yacute,thorn,yuml,"
		entityvalue = entityvalue & "192   ,193   ,194  ,195   ,196 ,197  ,198  ,199   ,200   ,201   ,202  ,203 ,204   ,205   ,206  ,207 ,208,209   ,210   ,211   ,212  ,213   ,214 ,216   ,217   ,218   ,219  ,220 ,221   ,222  ,223  ,224   ,225   ,226  ,227   ,228 ,229  ,230  ,231   ,232   ,233   ,234  ,235 ,236   ,237   ,238  ,239 ,240,241   ,242   ,243   ,244  ,245   ,246 ,248   ,249   ,250   ,251  ,252 ,253   ,254  ,255 ,"

		DecodeEntities = stIn
		lpos = InStr(1, DecodeEntities, "&")

		Do While lpos > 0
			lpos1 = InStr(lpos, DecodeEntities, ";")
			If lpos1 > 0 Then
				findstr = "," & Mid(DecodeEntities, lpos + 1, lpos1 - lpos - 1) & ","
				lfound = InStr(1, entitylist, findstr, vbBinaryCompare)

				If lfound > 0 Then
					'can still be improved for more efficiency. Pls contact me for tips to improve the efficiency for large strings
					DecodeEntities = Mid(DecodeEntities, 1, lpos - 1) & ChrW(cLng(Mid(entityvalue, lfound + 1, 3))) & Mid(DecodeEntities, lpos1 + 1)
				End If
			End If

			lpos = InStr(lpos + 1, DecodeEntities, "&")
		Loop
	End Function

'Elimina i tag HTML da una stringa
	Function NoHTML(Stringa)
		Dim RegEx, Risultato
		Set RegEx = New RegExp
		RegEx.Pattern = "<[^>]*>"
		RegEx.Global = True
		RegEx.IgnoreCase = True
		Risultato = RegEx.Replace(Stringa, "")
		Set RegEx = Nothing
		Risultato = DecodeEntities(Risultato)
		NoHTML = Risultato
	End Function

'Sostituisce caratteri con smile e codifiche html
	Function SostituisciCaratteri(Testo, PermettiTag)
		Dim Risultato
		Risultato = Testo
		If PermettiTag = "No" Then
			Risultato = NoHTML(Risultato)
		End If
		Risultato = Replace(Risultato, " & ", " &amp; ")
		Risultato = Replace(Risultato, "à", "&agrave;")
		Risultato = Replace(Risultato, "è", "&egrave;")
		Risultato = Replace(Risultato, "é", "&eacute;")
		Risultato = Replace(Risultato, "ì", "&igrave;")
		Risultato = Replace(Risultato, "ò", "&ograve;")
		Risultato = Replace(Risultato, "ù", "&ugrave;")
		Risultato = Replace(Risultato, "€", "&euro;")
		Risultato = Replace(Risultato, "©", "&copy;")
		Risultato = Replace(Risultato, "®", "&reg;")
		Risultato = Replace(Risultato, "E-)", "<img src="""& Path_Skin &"smile_diavolo.gif"" alt=""E - )"" />")
		Risultato = Replace(Risultato, ":-)", "<img src="""& Path_Skin &"smile_sorriso.gif"" alt="": - )"" />")
		Risultato = Replace(Risultato, "S-(", "<img src="""& Path_Skin &"smile_arrabbiato.gif"" alt=""S - ("" />")
		Risultato = Replace(Risultato, ":-(", "<img src="""& Path_Skin &"smile_triste.gif"" alt="": - ("" />")
		Risultato = Replace(Risultato, ":-\", "<img src="""& Path_Skin &"smile_timido.gif"" alt="": - \"" />")
		Risultato = Replace(Risultato, ":-o", "<img src="""& Path_Skin &"smile_shockato.gif"" alt="": - o"" />")
		Risultato = Replace(Risultato, ":-Z", "<img src="""& Path_Skin &"smile_assonnato.gif"" alt="": - Z"" />")
		Risultato = Replace(Risultato, ":-*", "<img src="""& Path_Skin &"smile_bacio.gif"" alt="": - *"" />")
		Risultato = Replace(Risultato, ":-P", "<img src="""& Path_Skin &"smile_lingua.gif"" alt="": - P"" />")
		Risultato = Replace(Risultato, "X-|", "<img src="""& Path_Skin &"smile_morto.gif"" alt=""X - |"" />")
		Risultato = Replace(Risultato, "8-)", "<img src="""& Path_Skin &"smile_occhiali.gif"" alt=""8 - )"" />")
		Risultato = Replace(Risultato, ";-)", "<img src="""& Path_Skin &"smile_occhiolino.gif"" alt=""; - )"" />")
		Risultato = Replace(Risultato, ":-D", "<img src="""& Path_Skin &"smile_risatona.gif"" alt="": - D"" />")
		SostituisciCaratteri = Risultato
	End Function

'Esegue il controllo per evitare SQL Injection
	Function ControlloSQLInjection(Testo)
		Dim Risultato

		Risultato = Testo
		Risultato = Replace(Risultato, "[", "[[" & Chr(0))
		Risultato = Replace(Risultato, "]", "[]]")
		Risultato = Replace(Risultato, "[[" & Chr(0), "[[]")
		Risultato = Replace(Risultato, "'", "''")
		Risultato = Replace(Risultato, "%", "[%]")
		Risultato = Replace(Risultato, "_", "[_]")
		Risultato = Replace(Risultato, "#", "[#]")
		ControlloSQLInjection = Risultato
	End function

'Prepara i campi per l'inserimento nel DataBase
	Function DoppioApice(Testo)
		Dim Risultato
		Risultato = Testo
		Risultato = Replace(Risultato, "'", "''")
		DoppioApice = Risultato
	End function

'Genera il trailer di un testo
	Function Trailer(Testo, Link, Attiva)
		Dim Risultato, FinoADove

		If Attiva Then
			FinoADove = 0
			Risultato = Testo
			If Abilita_Trailer Then
				FinoADove = InStr(Risultato, Tag_Trailer) - 1
				If FinoADove < 0 Then
					FinoADove = Len(Risultato)
				End If
				If FinoADove <> Len(Risultato) Then
					Risultato = Left(Risultato, FinoADove)
					Risultato = Risultato & "... <p><a href="""& Link &""">" & Link_Trailer & "</a></p>"
				Else
					Risultato = Left(Risultato, FinoADove)
				End If
			Else
				Risultato = Replace(Testo, Tag_Trailer, "")
			End If
		Else
			Risultato = Replace(Testo, Tag_Trailer, "")
		End If
		Trailer = Risultato
	End Function

'Visualizza dBlog Podcast Player
	Sub PodcastPlayer(FileMP3, TitoloMP3)
%>
			<script type="text/javascript">
				var hasReqestedVersion = DetectFlashVer(requiredMajorVersion, requiredMinorVersion, requiredRevision);
			
				if (hasReqestedVersion) {
				    var oeTags = '<object type="application/x-shockwave-flash" data="dblog_podcastplayer.swf?action=stop&mp3=<%=Path_DirPublic & Replace(FileMP3, "'", "\'")%>&title=<%=Replace(TitoloMP3, "'", "\'")%>" width="260" height="40">'
				    + '<param name="movie" value="dblog_podcastplayer.swf?action=stop&mp3=<%=Path_DirPublic & Replace(FileMP3, "'", "\'")%>&title=<%=Replace(TitoloMP3, "'", "\'")%>" />'
				    + '</object>';
				    document.write('<p>' + oeTags + '</p>');
				  } else {
				    var alternateContent = '<a href="<%=Path_DirPublic & FileMP3%>"><%=FileMP3%></a><br /><a href="http://www.macromedia.com/go/getflash" target="_blank"><%=Testo_PlayerFlash_Necessario%></a>';
				    document.write('<p>' + alternateContent + '</p>');
				  }
			</script>
			<noscript>
				<p>
					<a href="<%=Path_DirPublic & FileMP3%>"><%=FileMP3%></a>
					<br /><a href="http://www.macromedia.com/go/getflash" target="_blank"><%=Testo_PlayerFlash_Necessario%></a>
				</p>
			</noscript>
<%
	End Sub

'Genera le Keyword da inserire dinamicamente nell'apposito tag
	Function EstrapolaKeyword(Testo)
		Dim Risultato, ArrayParole, I, TotaleKeywordTrovate
		Testo = NoHTML(Testo)
		Testo = Replace(Testo, ",", "")
		Testo = Replace(Testo, Chr(13), "")
		Testo = Replace(Testo, Chr(10), "")
		Testo = Replace(Testo, Chr(9), "")
		Testo = LCase(Testo)
		Risultato = ""
		If Len(Testo) > 0 Then
			ArrayParole = Split(Testo, " ")
		Else
			ArrayParole = Array()
		End If
		If UBound(ArrayParole) > 0 Then
			TotaleKeywordTrovate = 0
			For I = 0 To UBound(ArrayParole)
				If Len(ArrayParole(I)) >= Num_Min_CaratteriPerSingolaKeyword Then
					If TotaleKeywordTrovate < Num_Max_KeywordNelTag Then
						TotaleKeywordTrovate = TotaleKeywordTrovate + 1
						Risultato = Risultato & ArrayParole(I) & ", "
					End If
				End If
			Next
		Else
			If Len(Testo) > Num_Max_CaratteriPerTagKeyword Then
				Risultato = Mid(Testo, 1, Num_Max_CaratteriPerTagKeyword)
			Else
				Risultato = Testo
			End If
		End If
		If Len(Risultato) > 0 Then
			Risultato = Mid(Risultato, 1, Len(Risultato) - 2)
		End If
		EstrapolaKeyword = Risultato
	End Function

'Evidenzia le parole ricercate all'interno del blog
	Function Evidenzia(Testo, ParolaCercata)
		Dim RegEx, Temp

		If Abilita_Evidenziatore Then
			Set RegEx = New RegExp
			RegEx.Pattern = ParolaCercata & "(?![^<>]*>)"
			RegEx.Global = True
			RegEx.IgnoreCase = True
			Temp = RegEx.Replace(Testo, "<span class=""evidenziato"">" & ParolaCercata & "</span>")
			Set RegEx = Nothing
			Evidenzia = Temp
		Else
			Evidenzia = Testo
		End If
	End Function

'Carica un file di testo e lo restituisce in una variabile
	Function CaricaDocumento(PercorsoFile)
		Dim Risultato, FSO, Documento
		Risultato = ""
		Set FSO = Server.CreateObject("Scripting.FileSystemObject")

		If FSO.FileExists(PercorsoFile) Then
			Set Documento = FSO.OpenTextFile(PercorsoFile, 1)
			Risultato = Documento.ReadAll
			Documento.Close
			Set Documento = Nothing
		Else
			Risultato = "Template?"
		End If

		Set FSO = Nothing
		CaricaDocumento = Risultato
	End Function

'Elabora il template ed inserisce il contenuto al posto dei tag proprietari
	Sub GeneraPagina(FileTemplate, METATitlePagina, METAKeywordPagina, METADescriptionPagina)
		Dim ContenutoTemplate, Risultato, StringaSplit, Posizione, TemplateDiviso, I
		ContenutoTemplate = CaricaDocumento(FileTemplate)
		Risultato = ""
		StringaSplit = Chr(0)
    
		Risultato = Replace(ContenutoTemplate, "[#", StringaSplit & "[#")
		Risultato = Replace(Risultato, "#]", "#]" & StringaSplit)

		TemplateDiviso = Split(Risultato, StringaSplit)

		For I = 0 To UBound(TemplateDiviso, 1)
				EseguiModulo TemplateDiviso(I), METATitlePagina, METAKeywordPagina, METADescriptionPagina
		Next
	End Sub
%>
