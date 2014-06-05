<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di visualizzare le sezioni contenenti fotografie
%>
<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--#include file="inc_db.asp"-->
<!--#include file="inc_funzioni.asp"-->
<!--#include file="inc_moduli.asp"-->
<%
	Sub Contenuto()
		If Request.QueryString("s") = "" Then
%>
	<div id="briciole">\\ <span><a href="default.asp"><%=Sezione_HomePage%></a> : <%=Sezione_Fotografie%></span></div>
<%
		Else
%>
	<div id="briciole">\\ <span><a href="default.asp"><%=Sezione_HomePage%></a> : <a href="foto.asp"><%=Sezione_Fotografie%></a> : <%=Server.HtmlEncode(Request.QueryString("s"))%></span></div>
<%
		End If

		Dim SQLFotografie, RSFotografie, FSezione, FSTFotografia, FotografiaTrovata, Pagina, Z, Temp, RecordPerPagina

		'Effettuo il controllo sul parametro sezione
		If Request.QueryString("s") <> "" Then
			FSezione = Request.QueryString("s")
		End If

		'Se la sezione esiste cerco le fotografie disponibili per tale sezione
		SQLFotografie = "SELECT Fotografie.ID, Fotografie.NomeFile, Count(Commenti.ID) AS ConteggioID, Fotografie.Sezione, Fotografie.Autore, Fotografie.Descrizione, Fotografie.Data, Fotografie.Ora, Fotografie.Letture FROM [Commenti] RIGHT JOIN Fotografie ON Commenti.IDFotografia = Fotografie.ID WHERE Fotografie.Data <= '"& DataToStr(Date()) &"' AND Fotografie.Sezione = '"& ControlloSQLInjection(FSezione) &"' GROUP BY Fotografie.ID, Fotografie.NomeFile, Fotografie.Sezione, Fotografie.Autore, Fotografie.Descrizione, Fotografie.Data, Fotografie.Ora, Fotografie.Letture ORDER BY Fotografie.Data DESC, Fotografie.Ora DESC"
		Set RSFotografie = Server.CreateObject("ADODB.Recordset")
		RSFotografie.Open SQLFotografie, Conn, 1, 3

		RecordPerPagina = Num_Max_FotografiePerPagina

		Pagina = Request.QueryString("pagina")
		If Pagina = "" OR Pagina = "0" OR IsNumeric(Pagina) = False Then
			Pagina = 1
		Else
			If Pagina <= 0 Then
				Pagina = 1
			End If
		End If

		If RSFotografie.EOF = False OR RSFotografie.BOF = False Then
			RSFotografie.PageSize = RecordPerPagina
			RSFotografie.AbsolutePage = Pagina
%>
	<div class="giustificato"><%=Testo_Seguono_Fotografie%></div>
<%
			'E visualizzo gli eventuali risultati
			FotografiaTrovata = False
			For Z = 1 To RecordPerPagina
				If NOT RSFotografie.EOF Then
					If Now() > cDate(StrToData(RSFotografie("Data")) & " " & StrToOra(RSFotografie("Ora"))) Then
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
		<%=RSFotografie("Descrizione")%>&nbsp;<a href="fotografia.asp?fotografia=<%=RSFotografie("ID")%>">...</a>
	</div>

	<div class="sotto">
		<a href="fotografia.asp?fotografia=<%=RSFotografie("ID")%>"><img src="<%=Path_Skin%>articolo.gif" alt="<%=ALT_Ico_Fotografia%>" border="0" />&nbsp;<%=Link_Fotografie%></a>&nbsp;<%If Abilita_Commenti Then%><a href="<%If Abilita_PopupCommenti Then%>javascript:popup('commenti_foto.asp?fotografia=<%=RSFotografie("ID")%>');<%Else%>fotografia.asp?fotografia=<%=RSFotografie("ID")%>#commenti<%End If%>"><img src="<%=Path_Skin%>commenti.gif" alt="<%=ALT_Ico_Commenti%>" border="0" />&nbsp;<%=Link_Commenti%></a> (<%=RSFotografie("ConteggioID")%>)<%End If%>&nbsp;<a href="foto.asp"><img src="<%=Path_Skin%>storico.gif" alt="<%=ALT_Ico_Sezioni%>" border="0" />&nbsp;<%=Categorie_Fotografie%></a>
	</div>
	<div class="divider">&nbsp;</div>
<%
					End If
					RSFotografie.MoveNext
					Set FSTFotografia = Nothing
				End If
			Next
			If FotografiaTrovata = False Then
%>
	<div class="giustificato"><%=Errore_Fotografia_NonTrovata%></div>
<%
			End If
%>
	<div class="pagine">
		<span><%=Testo_Paginazione%>:</span> 
<%
			For Temp = 1 To RSFotografie.PageCount
				Response.Write "<a href=foto.asp?s="& Server.URLEncode(FSezione) &"&amp;pagina=" & Temp & ">"
				Response.Write Temp
				Response.Write "</a> "
			Next
%>
	</div>
<%
		Else
%>
	<div class="giustificato"><%=Errore_Fotografie_NonTrovate%></div>

	<ul class="elencofoto">
<%
			'Altrimenti cerco tutte le sezioni disponibili in cui sono state pubblicate fotografie
			SQLFotografie = " SELECT [Sezione] FROM [Fotografie] WHERE Fotografie.Data <= '"& DataToStr(Date()) &"' GROUP BY [Sezione] ORDER BY [Sezione] ASC "
			Set RSFotografie = Server.CreateObject("ADODB.Recordset")
			RSFotografie.Open SQLFotografie, Conn, 1, 3

			'E visualizzo gli eventuali risultati
			If NOT RSFotografie.EOF Then
				Do While NOT RSFotografie.EOF
%>
		<li>
			<a href="foto.asp?s=<%=RSFotografie("Sezione")%>"><%=RSFotografie("Sezione")%></a>
		</li>
<%
					RSFotografie.MoveNext
				Loop
%>
	</ul>
<%
			Else
%>
	<div class="giustificato"><%=Errore_Categorie_NonTrovate%></div>
<%
			End If
		End If
	End Sub

	Call GeneraPagina(Server.MapPath(Path_Template & "pagina.htm"), "", "", "")

	Conn.Close
	Set Conn = Nothing
%>