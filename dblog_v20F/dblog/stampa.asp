<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di visualizzare un singolo articolo in un formato adatto alla stampa
%>
<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--#include file="inc_db.asp"-->
<!--#include file="inc_funzioni.asp"-->
<!--#include file="inc_moduli.asp"-->
<%
	Sub Contenuto()
%>
	<div id="briciole">\\ <span><a href="default.asp"><%=Sezione_HomePage%></a> : <a href="articolo.asp?articolo=<%=Server.HtmlEncode(Request.QueryString("articolo"))%>"><%=Sezione_Articolo%></a> : <%=Sezione_Stampa%></span></div>
<%
		Dim SQLArticoli, RSArticoli, FID, ArticoloTrovato

		'Effettuo un controllo sul parametro ID
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

		'Cerco nel database l'articolo richiesto
		SQLArticoli = " SELECT * FROM [Articoli] WHERE Articoli.Data <= '"& DataToStr(Date()) &"' AND Articoli.ID = "& FID &" AND NOT Articoli.Bozza "
		Set RSArticoli = Server.CreateObject("ADODB.Recordset")
		RSArticoli.Open SQLArticoli, Conn, 1, 3

		'E lo visualizzo avviando in automatico il processo di stampa
		If NOT RSArticoli.EOF Then
			ArticoloTrovato = False
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
	</div>
          
	<script type="text/javascript">
		self.print();
	</script>
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
	End Sub

	Call GeneraPagina(Server.MapPath(Path_Template & "stampa.htm"), "", "", "")

	Conn.Close
	Set Conn = Nothing
%>