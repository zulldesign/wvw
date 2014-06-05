<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di visualizzare i commenti relativi ad una fotografia
%>
<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--#include file="inc_db.asp"-->
<!--#include file="inc_funzioni.asp"-->
<!--#include file="inc_moduli.asp"-->
<%
	Sub Contenuto()
%>
	<div id="briciole">\\ <span><a href="javascript:opener.location.href='default.asp';self.close();"><%=Sezione_HomePage%></a> : <a href="javascript:opener.location.href='fotografia.asp?fotografia=<%=Server.HtmlEncode(Request.QueryString("fotografia"))%>';self.close();"><%=Link_Fotografie%></a> : <%=Sezione_Commenti%></span></div>
<%
		Dim SQLCommenti, RSCommenti, FID, I

		'Se i commenti sono abilitati
		If Abilita_Commenti Then

			'Effettuo il controllo sul parametro id
			If Request.QueryString("fotografia") <> "" AND Request.QueryString("fotografia") <> "0" AND IsNumeric(Request.QueryString("fotografia")) = True  Then
				FID = Request.QueryString("fotografia")
			Else
				FID = 0
			End If

			If FID > 0 Then
				SQLTitolo = " SELECT Descrizione FROM [Fotografie] WHERE Fotografie.ID = "& FID &" "
				Set RSTitolo = Server.CreateObject("ADODB.Recordset")
				RSTitolo.Open SQLTitolo, Conn, 1, 3

				If NOT RSTitolo.EOF Then
					RSTitolo.MoveFirst
%>
				<p>
					<b><%=RSTitolo("Descrizione")%></b> <a href="fotografia.asp?fotografia=<%=FID%>" target="_blank"><%=Link_Fotografie%></a>
				</p>
<%
				End If

				RSTitolo.Close
				Set RSTitolo = Nothing
			End If

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
		<form action="commenti_invio.asp?fotografia=<%=Server.HTMLEncode(FID)%>" method="post">
			<input type="hidden" name="Tipologia" value="F" />
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