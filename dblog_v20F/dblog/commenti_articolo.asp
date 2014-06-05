<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di visualizzare i commenti relativi ad un articolo
%>
<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--#include file="inc_db.asp"-->
<!--#include file="inc_funzioni.asp"-->
<!--#include file="inc_moduli.asp"-->
<%
	Sub Contenuto()
%>
	<div id="briciole">\\ <span><a href="javascript:opener.location.href='default.asp';self.close();"><%=Sezione_HomePage%></a> : <a href="javascript:opener.location.href='articolo.asp?articolo=<%=Server.HtmlEncode(Request.QueryString("articolo"))%>';self.close();"><%=Link_Articolo%></a> : <%=Sezione_Commenti%></span></div>
<%
		Dim SQLCommenti, RSCommenti, SQLTitolo, RSTitolo, FID, I

		'Se i commenti sono abilitati
		If Abilita_Commenti Then

			'Effettuo il controllo sul parametro id
			If Request.QueryString("articolo") <> "" AND Request.QueryString("articolo") <> "0" AND IsNumeric(Request.QueryString("articolo")) = True  Then
				FID = Request.QueryString("articolo")
			Else
				FID = 0
			End If

			If FID > 0 Then
				SQLTitolo = " SELECT Titolo FROM [Articoli] WHERE Articoli.ID = "& FID &" "
				Set RSTitolo = Server.CreateObject("ADODB.Recordset")
				RSTitolo.Open SQLTitolo, Conn, 1, 3

				If NOT RSTitolo.EOF Then
					RSTitolo.MoveFirst
%>
				<p>
					<b><%=RSTitolo("Titolo")%></b> <a href="articolo.asp?articolo=<%=FID%>" target="_blank"><%=Link_Articolo_permalink%></a>
				</p>
<%
				End If

				RSTitolo.Close
				Set RSTitolo = Nothing
			End If

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
	<div class="giustificato">
		<p>
			<%=Errore_Commento_NonTrovato%>
		</p>
	</div>
<%
			End If

			Set RSCommenti = Nothing
%>
	<div class="formpopcommenti">
		<form action="commenti_invio.asp?articolo=<%=Server.HTMLEncode(FID)%>" method="post">
			<input type="hidden" name="Tipologia" value="A" />
			<%=Testo_Campo_Commento%><br />
			<textarea name="commento" rows="5" cols="30"></textarea><br />
			<%=Testo_Campo_Nome%><br />
			<input type="textbox" name="Autore" size="35" maxlength="50" /><br />
			<%=Testo_Campo_EMailLink%><br />
			<input type="textbox" name="Link" size="35" maxlength="50" /><br /><br />

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
%>
	<div class="right"><a href="javascript:self.close();"><%=Link_Chiudi%></a></div>
<%
	End Sub

	Call GeneraPagina(Server.MapPath(Path_Template & "popup.htm"), "", "", "")

	Conn.Close
	Set Conn = Nothing
%>