<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di visualizzare informazioni sugli autori del blog
%>
<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--#include file="inc_db.asp"-->
<!--#include file="inc_funzioni.asp"-->
<!--#include file="inc_moduli.asp"-->
<%
	Sub Contenuto()
		Dim SQLAutori, RSAutori, SQLFotografiaAutore, RSFotografiaAutore, SQLArticoloAutore, RSArticoloAutore, FChi, PaginaA, PaginaF, Z, Temp, RecordPerPagina

		'Effettuo il controllo sul parametro chi
		If Request.QueryString("chi") <> "" Then
			FChi = Request.QueryString("chi")
		Else
			FChi = ""
		End If

		RecordPerPagina = Num_Max_ArticoliFotografiePerPagina

		PaginaA = Request("paginaa")
		If PaginaA = "" OR PaginaA = "0" OR IsNumeric(PaginaA) = False Then
			PaginaA = 1
		End If

		PaginaF = Request("paginaf")
		If PaginaF = "" OR PaginaF = "0" OR IsNumeric(PaginaF) = False Then
			PaginaF = 1
		End If

		If FChi = "" Then
%>
	<div id="briciole">\\ <span><a href="default.asp"><%=Sezione_HomePage%></a> : <%=Sezione_Autori%></span></div>
<%
		Else
%>
	<div id="briciole">\\ <span><a href="default.asp"><%=Sezione_HomePage%></a> : <a href="autori.asp"><%=Sezione_Autori%></a> : <%=Server.HTMLEncode(FChi)%></span></div>
<%
		End If
%>
	<div class="giustificato"><%=Testo_Introduzione_Autori%></div>
<%
		If FChi <> "" Then
			'Se è stato richiesto un autore specifico lo cerco nel database
			SQLAutori = " SELECT [Immagine], [Nick], [Mail], [Testo], [Sito], [ICQ], [MSN] FROM [Autori] WHERE Autori.Nick = '"& ControlloSQLInjection(FChi) &"' "
			Set RSAutori = Server.CreateObject("ADODB.Recordset")
			RSAutori.Open SQLAutori, Conn, 1, 3

			'E visualizzo gli eventuali risultati
			If NOT RSAutori.EOF Then
				Do While NOT RSAutori.EOF
%>
	<div class="fotoautore">
		<img src="<%If RSAutori("Immagine") <> "" Then Response.Write Path_DirPublic & RSAutori("Immagine") Else Response.Write Path_Skin & "nd.gif" End If%>" alt="<%=RSAutori("Nick")%>" class="fleft" /><strong><%=RSAutori("Nick")%></strong>
		<br /><br />
    
		<img src="<%=Path_Skin%>icona_sito.gif" alt="Home page" /> <%If RSAutori("Sito") <> "" Then Response.Write "<a href="""& RSAutori("Sito") &""" onclick=""this.target='_blank';"">"& RSAutori("Sito") &"</a>" Else Response.Write "-" End If%><br />
		<img src="<%=Path_Skin%>icona_icq.gif" alt="ICQ UIN" /> <%If RSAutori("ICQ") <> "" Then Response.Write "#"& RSAutori("ICQ") Else Response.Write "-" End If%><br />
		<img src="<%=Path_Skin%>icona_msn.gif" alt="MSN Messenger" /> <%If RSAutori("MSN") <> "" Then Response.Write RSAutori("MSN") Else Response.Write "-" End If%><br />
		<img src="<%=Path_Skin%>icona_mail.gif" alt="e-Mail" /> <%If RSAutori("Mail") <> "" Then Response.Write "<a href=""mailto:"& RSAutori("Mail") &""">"& RSAutori("Mail") &"</a>" Else Response.Write "-" End If%>
	</div>
	<div class="giustificato"><%=RSAutori("Testo")%></div>
	<br />
<%
					RSAutori.MoveNext
				Loop

				'Cerco i contributi dell'autore richiesto
				SQLArticoloAutore = " SELECT [ID], [Titolo], [Sezione], [Data], [Ora], [Letture] FROM [Articoli] WHERE Articoli.Autore = '"& ControlloSQLInjection(FChi) &"' AND NOT Articoli.Bozza ORDER BY Articoli.Data DESC, Articoli.Ora DESC "
				Set RSArticoloAutore = Server.CreateObject("ADODB.Recordset")
				RSArticoloAutore.Open SQLArticoloAutore, Conn, 1, 3

				SQLFotografiaAutore = " SELECT [ID], [Descrizione], [Sezione], [Data], [Ora], [Letture] FROM [Fotografie] WHERE Fotografie.Autore = '"& ControlloSQLInjection(FChi) &"' ORDER BY Fotografie.Data DESC, Fotografie.Ora DESC "
				Set RSFotografiaAutore = Server.CreateObject("ADODB.Recordset")
				RSFotografiaAutore.Open SQLFotografiaAutore, Conn, 1, 3
%>
	<div class="titolo"><%=Articoli_Di%>&nbsp;<%=Server.HTMLEncode(FChi)%> (<%=RSArticoloAutore.RecordCount%>)</div>
<%
				If RSArticoloAutore.EOF = False OR RSArticoloAutore.BOF = False Then
					RSArticoloAutore.PageSize = RecordPerPagina
					RSArticoloAutore.AbsolutePage = PaginaA

					For Z = 1 To RecordPerPagina
						If NOT RSArticoloAutore.EOF Then

%>
	<div class="giustificato">
		<%=Pubblicato_In%>&nbsp;<a href="storico.asp?s=<%=RSArticoloAutore("Sezione")%>"><%=RSArticoloAutore("Sezione")%></a> <%=Pubblicato_il%>&nbsp;<%=StrToData(RSArticoloAutore("Data"))%>&nbsp;<%=Pubblicato_alle%>&nbsp;<%=StrToOra(RSArticoloAutore("Ora"))%>&nbsp;<%=Pubblicato_Letture%>&nbsp;<%=RSArticoloAutore("Letture")%>&nbsp;<%=Pubblicato_Letture_chiudi%><br />
		<a href="articolo.asp?articolo=<%=RSArticoloAutore("ID")%>"><%=RSArticoloAutore("Titolo")%></a>
	</div>
	<br />
<%
							RSArticoloAutore.MoveNext
						End If
					Next
				Else
%>
	<%=Errore_Articolo_NonTrovato%>
<%
				End If
%>
	<div class="pagine">
		<span><%=Testo_Paginazione%>:</span>
<%
				For Temp = 1 To RSArticoloAutore.PageCount
					Response.Write "<a href=autori.asp?chi="& Server.URLEncode(FChi) &"&paginaa=" & Temp & "&paginaf=" & PaginaF & ">"
					Response.Write Temp
					Response.Write "</a> "
				Next

				Set RSArticoloAutore = Nothing
%>
	</div>
	<div class="titolo"><%=Fotografie_Di%>&nbsp;<%=Server.HTMLEncode(FChi)%> (<%=RSFotografiaAutore.RecordCount%>)</div>
<%
				If RSFotografiaAutore.EOF = False OR RSFotografiaAutore.BOF = False Then
					RSFotografiaAutore.PageSize = RecordPerPagina
					RSFotografiaAutore.AbsolutePage = PaginaF

					For Z = 1 To RecordPerPagina
						If NOT RSFotografiaAutore.EOF Then
%>
	<div class="giustificato">
		<%=Pubblicato_In%>&nbsp;<a href="foto.asp?s=<%=RSFotografiaAutore("Sezione")%>"><%=RSFotografiaAutore("Sezione")%></a> <%=Pubblicato_il%>&nbsp;<%=StrToData(RSFotografiaAutore("Data"))%>&nbsp;<%=Pubblicato_alle%>&nbsp;<%=StrToOra(RSFotografiaAutore("Ora"))%>&nbsp;<%=Pubblicato_Letture%>&nbsp;<%=RSFotografiaAutore("Letture")%>&nbsp;<%=Pubblicato_Letture_chiudi%><br />
		<a href="fotografia.asp?fotografia=<%=RSFotografiaAutore("ID")%>"><%=RSFotografiaAutore("Descrizione")%></a>
	</div>
	<br />
<%
							RSFotografiaAutore.MoveNext
						End If
					Next
				Else
%>
	<%=Errore_Fotografia_NonTrovata%>
<%
				End If
%>
	<div class="pagine">
		<span><%=Testo_Paginazione%>:</span>
<%
				For Temp = 1 To RSFotografiaAutore.PageCount
					Response.Write "<a href=autori.asp?chi="& Server.URLEncode(FChi) &"&paginaf=" & Temp & "&paginaa="& PaginaA &">"
					Response.Write Temp
					Response.Write "</a> "
				Next
%>
	</div>
<%
				Set RSFotografiaAutore = Nothing
			Else
%>
	<div class="giustificato"><%=Errore_Autore_NonTrovato%></div>
<%
			End If
		Else
			'Altrimenti cerco tutti gli autori
			SQLAutori = " SELECT [Nick], [Mail] FROM [Autori] ORDER BY Autori.Nick "
			Set RSAutori = Server.CreateObject("ADODB.Recordset")
			RSAutori.Open SQLAutori, Conn, 1, 3

			'E visualizzo gli eventuali risultati
			If NOT RSAutori.EOF Then
%>
	<ul class="elencoautori">
<%
				Do While NOT RSAutori.EOF
%>
		<li>
			<a href="autori.asp?chi=<%=RSAutori("Nick")%>"><%=RSAutori("Nick")%></a>&nbsp;<%If RSAutori("Mail") <> "" Then Response.Write "(<a href=""mailto:"& RSAutori("Mail") &""">"& RSAutori("Mail") &"</a>)" End If%>
		</li>
<%
					RSAutori.MoveNext
				Loop
%>
	</ul>
<%
			Else
%>
	<div class="giustificato"><%=Errore_Autore_NonTrovato%></div>
<%
			End If
		End If

		Set RSAutori = Nothing

		If FChi = "" Then
%>
	<a name="perche"></a>
	<div class="giustificato"><%=Testo_Il_perche%></div>
	<br /><a name="copyright"></a>
	<div class="giustificato"><%=Testo_Copyright%></div>
<%
		End If
	End Sub

	'Generazione dinamica del Titolo
	Dim FChi, METATitleDinamicoPagina

	'Effettuo il controllo sul parametro chi
	If Request.QueryString("chi") <> "" Then
		FChi = Request.QueryString("chi")
	Else
		FChi = ""
	End If

	METATitleDinamicoPagina = Sezione_Autori
	If FChi <> "" Then
		METATitleDinamicoPagina = METATitleDinamicoPagina & " (" & Server.HTMLEncode(FChi) & ")"
	End If

	Call GeneraPagina(Server.MapPath(Path_Template & "pagina.htm"), METATitleDinamicoPagina, "", "")

	Conn.Close
	Set Conn = Nothing
%>