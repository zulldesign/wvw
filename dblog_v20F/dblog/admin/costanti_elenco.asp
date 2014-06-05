<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include file="inc_header.asp"-->
<%
	'Struttura del file delle costanti da NON modificare a mano:
	'   '---AREA
	'   'Commento
	'   miacostante = miovalore
	'   'Commento
	'   miacostante = miovalore
	'   '---AREA
	'   'Commento
	'   miacostante = miovalore
	'
	'   Struttura interna (da non usare/modificare):
	'   Le variabili che iniziano con "Num_" sono numeriche (non stringhe), mentre quelle che iniziano con "Abilita_" sono booleane (non stringhe)
	'   Nel FORM di modifica sono stati introdotti i campi "Commento_" e "Area_" per riportare la stessa gerarchia

	Dim FilCostanti, Costanti, Riga, I, NomeFileCostanti
%>
<body bgcolor="<%=Colore_Sfondo_Pagina%>">
<table border="0" width="700" align="center" cellspacing="0" cellpadding="15" bgcolor="<%=Colore_Sfondo_Content%>">
	<tr>
		<td>
			<table border="0" width="700" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
				<tr>
					<td width="700">
						<table border="0" width="700" cellspacing="0" cellpadding="0">
							<tr>
								<td width="550" valign="top" style="PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px">
									<p align="justify">
										\\ <b><a href="default.asp"><%=Testo_Path_Pannello%></a> : <%=Testo_Sezione_Configurazione%></b>
									</p>
<%
	If Request.QueryString("a") = "elenca" Then
		If Session("BLOGAdmin") = True Then

			Select Case Request.Form("Sezione")
				Case "1" NomeFileCostanti = "inc_costanti_articoli.asp"
				Case "2" NomeFileCostanti = "inc_costanti_autori.asp"
				Case "3" NomeFileCostanti = "inc_costanti_blog.asp"
				Case "4" NomeFileCostanti = "inc_costanti_classifica.asp"
				Case "5" NomeFileCostanti = "inc_costanti_colori.asp"
				Case "6" NomeFileCostanti = "inc_costanti_commenti.asp"
				Case "7" NomeFileCostanti = "inc_costanti_condivise.asp"
				Case "8" NomeFileCostanti = "inc_costanti_fotografie.asp"
				Case "9" NomeFileCostanti = "inc_costanti_homepage.asp"
				Case "10" NomeFileCostanti = "inc_costanti_immagini.asp"
				Case "11" NomeFileCostanti = "inc_costanti_intestazione.asp"
				Case "12" NomeFileCostanti = "inc_costanti_navigazione.asp"
				Case "13" NomeFileCostanti = "inc_costanti_pubblicazioni.asp"
				Case "14" NomeFileCostanti = "inc_costanti_ricerca.asp"
				Case "15" NomeFileCostanti = "inc_costanti_sistema.asp"
				Case "16" NomeFileCostanti = "inc_costanti_sondaggio.asp"
				Case "17" NomeFileCostanti = "inc_costanti_storico.asp"
				Case "18" NomeFileCostanti = "inc_costanti_pannello.asp"
				Case Else NomeFilEcostanti = ""
			End Select

			Set FilCostanti = CreateObject("Scripting.FileSystemObject")
			If FilCostanti.FileExists(Server.MapPath("/mdb-database/" & NomeFileCostanti)) = True Then
%>
									<p align="justify">
										<%=Testo_IntroduzioneTesti_Configurazione%>
									</p>
									<form action="costanti_modifica.asp?a=modifica&s=<%=Request.Form("Sezione")%>" method="post">
									<table border="0" width="450" align="center" cellspacing="0" cellpadding="0"  style="BORDER-RIGHT: <%=Colore_Contorni%> 1px solid; BORDER-TOP: <%=Colore_Contorni%> 1px solid; BORDER-LEFT: <%=Colore_Contorni%> 1px solid; BORDER-BOTTOM: <%=Colore_Contorni%> 1px solid">
<%
				Set Costanti = FilCostanti.OpenTextFile(Server.MapPath("/mdb-database/" & NomeFileCostanti), 1, 0, 0)
				I = 0
				Do While Costanti.AtEndOfStream <> True
					Riga = ""
					Riga = Costanti.ReadLine
					I = I + 1
					If Left(Riga, 4) = "'---" Then
%>
									<tr>
										<td width="450" bgcolor="#DEDEDE" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
											<b><%=UCase(Mid(Riga, 5, Len(Riga) - 4))%></b><input type="hidden" name="Area_<%=I%>" value="<%=Mid(Riga, 5, Len(Riga) - 4)%>">
										</td>
									</tr>
<%
					Else
						If Left(Riga, 1) = "'" Then
%>
									<tr>
										<td width="450" bgcolor="#EFEFEF" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
											<div class="piccolo"><b><%=Mid(Riga, 2, Len(Riga) - 1)%>:</b></div><input type="hidden" name="Commento_<%=I%>" value="<%=Mid(Riga, 2, Len(Riga) - 1)%>">
										</td>
									</tr>
<%
						Else
							If Left(Riga, 1) <> "" AND Left(Riga, 1) <> " " AND Left(Riga, 1) <> "<" AND Left(Riga, 1) <> "%" AND Left(Riga, 8) <> "Abilita_" AND Left(Riga, 4) <> "Num_" Then
%>
									<tr>
										<td width="450" bgcolor="#FEFEFE" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<textarea name="<%=Mid(Riga, 1, InStr(Riga, "=") - 2)%>" cols="47" rows="5"><%=Replace(Replace(Mid(Riga, InStr(Riga, "=") + 3, Len(Riga) - InStr(Riga, "=") - 3), """""", """"), "<br>", VbCrLf)%></textarea>
										</td>
									</tr>
<%
							Else
								If Left(Riga, 8) = "Abilita_" Then
%>
									<tr>
										<td width="450" bgcolor="#FEFEFE" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="<%=Mid(Riga, 1, InStr(Riga, "=") - 2)%>" value="si" <%If Mid(Riga, InStr(Riga, "=") + 2, Len(Riga) - InStr(Riga, "=") - 1) = "True" Then Response.Write "checked" End If%>> Si <input type="radio" name="<%=Mid(Riga, 1, InStr(Riga, "=") - 2)%>" value="no" <%If Mid(Riga, InStr(Riga, "=") + 2, Len(Riga) - InStr(Riga, "=") - 1) = "False" Then Response.Write "checked" End If%>> No
										</td>
									</tr>
<%
								End If
								If Left(Riga, 4) = "Num_" Then
%>
									<tr>
										<td width="450" bgcolor="#FEFEFE" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="textbox" name="<%=Mid(Riga, 1, InStr(Riga, "=") - 2)%>" size="55" maxlength="5" value="<%=Mid(Riga, InStr(Riga, "=") + 2, Len(Riga) - InStr(Riga, "=") - 1)%>">
										</td>
									</tr>
<%
								End If
							End If
						End If
					End If
				Loop
%>
										<tr>
											<td width="450" bgcolor="#DEDEDE" align="right" style="PADDING-RIGHT: 7px; PADDING-LEFT: 7px; PADDING-BOTTOM: 7px; PADDING-TOP: 7px">
												<input type="submit" value="<%=Testo_Modulo_PulsanteModifica%>">
											</td>
										</tr>
									</table>
									</form>
<%
			Else
%>
									<%=Testo_Errore_FileCostanti_NonTrovato%>
<%
			End If
		Else
%>
									<%=Testo_Errore_FunzioneRiservataAdmin%>
<%
		End If

		Set FilCostanti = Nothing
		Set Costanti = Nothing
	Else
%>
									<p align="justify">
										<%=Testo_Introduzione_Configurazione%>
									</p>
									<p align="center">
										<form name="QualeSezione" action="costanti_elenco.asp?a=elenca" method="post">
											<%=Testo_SezioniDisponibili_Configurazione%>&nbsp;<select name="Sezione" size="1" onChange="javascript:document.QualeSezione.submit();">
												<option value="0"></option>
												<option value="1"><%=Testo_Sezione_Articoli%></option>
	              								<option value="2"><%=Testo_Sezione_Autori%></option>
	              								<option value="3"><%=Testo_Sezione_Blog%></option>
	              								<option value="4"><%=Testo_Sezione_Classifica%></option>
	              								<option value="5"><%=Testo_Sezione_Colori%></option>
	              								<option value="6"><%=Testo_Sezione_Commenti%></option>
	              								<option value="7"><%=Testo_Sezione_Condivise%></option>
	              								<option value="8"><%=Testo_Sezione_Fotografie%></option>
	              								<option value="9"><%=Testo_Sezione_Homepage%></option>
	              								<option value="10"><%=Testo_Sezione_Immagini%></option>
	              								<option value="11"><%=Testo_Sezione_Intestazione%></option>
	              								<option value="12"><%=Testo_Sezione_Navigazione%></option>
	              								<option value="13"><%=Testo_Sezione_Pubblicazioni%></option>
	              								<option value="14"><%=Testo_Sezione_Ricerca%></option>
	              								<option value="15"><%=Testo_Sezione_Sistema%></option>
	              								<option value="16"><%=Testo_Sezione_Sondaggio%></option>
	              								<option value="17"><%=Testo_Sezione_Storico%></option>
	              								<option value="18"><%=Testo_Sezione_Pannello%></option>
	              							</select>
										</form>
									</p>
<%
	End If
%>
								</td>
								<td width="150" valign="top" style="PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px">
									<!--#include file="inc_destra.asp"-->
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td width="700" bgcolor="<%=Colore_Sfondo_Footer%>">
						<!--#include file="inc_footer.asp"-->
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</body>
</html>
<%
	Conn.Close
	Set Conn = Nothing
%>