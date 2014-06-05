<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
	'FUNZIONE: questo script si occupa di visualizzare tutti i link (LinkLog) pubblicati nel tempo
%>
<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--#include file="inc_db.asp"-->
<!--#include file="inc_funzioni.asp"-->
<!--#include file="inc_moduli.asp"-->
<%
	Sub Contenuto()
%>
	<div id="briciole">\\ <span><a href="default.asp"><%=Sezione_HomePage%></a> : <%=Sezione_StoricoLinkLog%></span></div>

	<div class="giustificato"><%=Testo_Seguono_TuttiLink_LinkLog%></div><br />
<%
		Dim SQLLinkLog, RSLinkLog, Pagina, Z, Temp, RecordPerPagina

		'Costruisco la query in base al passaggio di parametri
		SQLLinkLog = " SELECT * FROM LinkLog ORDER BY LinkLog.Data DESC "
		Set RSLinkLog = Server.CreateObject("ADODB.Recordset")
		RSLinkLog.Open SQLLinkLog, Conn, 1, 3

		RecordPerPagina = Num_Max_LinkPerPagina

		Pagina = Request.QueryString("pagina")
		If Pagina = "" OR Pagina = "0" OR IsNumeric(Pagina) = False Then
			Pagina = 1
		Else
			If Pagina <= 0 Then
				Pagina = 1
			End If
		End If

		'Visualizzo gli eventuali articoli trovati
		If RSLinkLog.EOF = False OR RSLinkLog.BOF = False Then
			RSLinkLog.PageSize = RecordPerPagina
			RSLinkLog.AbsolutePage = Pagina

			For Z = 1 To RecordPerPagina
				If NOT RSLinkLog.EOF Then
					If RSLinkLog("Data") =< DataToStr(Date()) Then
%>
	<div class="giustificato">
		<%=StrToData(RSLinkLog("Data"))%> - <%=RSLinkLog("Introduzione")%> - <a href="<%=RSLinkLog("URL")%>" onclick="this.target='_blank';"><%=RSLinkLog("TestoLinkato")%></a>
	</div>
	<div class="divider">&nbsp;</div>
<%
					End If
					RSLinkLog.MoveNext
				End If
			Next
%>
	<div class="pagine">
		<span><%=Testo_Paginazione%>:</span> 
<%
			For Temp = 1 To RSLinkLog.PageCount
				Response.Write "<a href=linklog.asp?pagina=" & Temp & ">"
				Response.Write Temp
				Response.Write "</a> "
			Next
%>
	</div>
<%
		Else
%>
	<div class="giustificato"><%=Errore_Link_NonTrovato%></div>
<%
		End If
	End Sub

	Call GeneraPagina(Server.MapPath(Path_Template & "pagina.htm"), "", "", "")

	Conn.Close
	Set Conn = Nothing
%>