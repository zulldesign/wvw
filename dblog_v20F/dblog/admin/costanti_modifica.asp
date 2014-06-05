<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include file="inc_header.asp"-->
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
	If Session("BLOGAdmin") = True Then

		Dim I, StrutturaFileCostanti, FilCostanti, Costanti, NomeFileCostanti, Appoggio

		If Request.QueryString("a") = "modifica" AND Request.QueryString("s") <> "" AND Request.Form <> "" Then
			Select Case Request.QueryString("s")
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

			StrutturaFileCostanti = ""
			StrutturaFileCostanti = StrutturaFileCostanti & "<%" & VbCrLf
			StrutturaFileCostanti = StrutturaFileCostanti & "    'dBlog 2.0 CMS Open Source" & VbCrLf
			StrutturaFileCostanti = StrutturaFileCostanti & "    'Versione file 2.0.0" & VbCrLf
			StrutturaFileCostanti = StrutturaFileCostanti & "%" & ">" & VbCrLf
			StrutturaFileCostanti = StrutturaFileCostanti & "<" & "%" & VbCrLf
			StrutturaFileCostanti = StrutturaFileCostanti & "    Dim "
			For I = 1 To Request.Form.Count
				If Left(Request.Form.Key(I), 1) <> "'" AND Left(Request.Form.Key(I), 1) <> " " AND Left(Request.Form.Key(I), 5) <> "Area_" AND Left(Request.Form.Key(I), 9) <> "Commento_" Then
					StrutturaFileCostanti = StrutturaFileCostanti & Request.Form.Key(I) & ", "
				End If
			Next
			StrutturaFileCostanti = Mid(StrutturaFileCostanti, 1, Len(StrutturaFileCostanti) - 2)
			StrutturaFileCostanti = StrutturaFileCostanti & VbCrLf & VbCrLf

			For I = 1 To Request.Form.Count
				If Left(Request.Form.Key(I), 5) = "Area_" Then
					StrutturaFileCostanti = StrutturaFileCostanti & "'---"& Request.Form(I) & VbCrLf
				Else
					If Left(Request.Form.Key(I), 9) = "Commento_" Then
						StrutturaFileCostanti = StrutturaFileCostanti & "'"& Request.Form(I) & VbCrLf
					Else
						If Left(Request.Form.Key(I), 8) = "Abilita_" Then
							If Request.Form(I) = "si" Then
								StrutturaFileCostanti = StrutturaFileCostanti & Request.Form.Key(I) &" = True" & VbCrLf
							Else
								StrutturaFileCostanti = StrutturaFileCostanti & Request.Form.Key(I) &" = False" & VbCrLf
							End If
						Else
							If Left(Request.Form.Key(I), 4) = "Num_" Then
								On Error Resume Next
								Appoggio = cInt(Request.Form(I))
								If Err = 0 Then
									StrutturaFileCostanti = StrutturaFileCostanti & Request.Form.Key(I) &" = "& Request.Form(I) & VbCrLf
								Else
									StrutturaFileCostanti = StrutturaFileCostanti & Request.Form.Key(I) &" = 0" & VbCrLf
								End If			
								On Error Goto 0
							Else
								StrutturaFileCostanti = StrutturaFileCostanti & Request.Form.Key(I) &" = """& Replace(Replace(Replace(Request.Form(I), """", """"""), VbCrLf, "<br>"), VbCr, "<br>") & """" & VbCrLf
							End If
						End If
					End If
				End If
			Next

			StrutturaFileCostanti = StrutturaFileCostanti & "%" & ">" & VbCrLf
			Set FilCostanti = CreateObject("Scripting.FileSystemObject")
			Set Costanti = FilCostanti.OpenTextFile(Server.MapPath("/mdb-database/" & NomeFileCostanti), 2, 0, 0)
			Costanti.Write StrutturaFileCostanti
			Set FilCostanti = Nothing
			Set Costanti = Nothing
%>
									<p align="justify">
										<%=Testo_Conferma_ConfigurazioneModificata%> <a href="costanti_elenco.asp"><%=Testo_Sezione_Configurazione%></a>.
									</p>
<%
		Else
%>
									<p align="justify">
										<%=Testo_Errore_PassaggioParametri%>
									</p>
<%
		End If
	Else
%>
									<%=Testo_Errore_FunzioneRiservataAdmin%>
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