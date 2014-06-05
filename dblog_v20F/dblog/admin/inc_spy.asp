<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.1

	Function AttendiNSecondi(QuantiSecondi)
		Dim I, TempoInizio, TempoFine

		TempoInizio = Timer()
		TempoFine = TempoInizio + QuantiSecondi

		I = QuantiSecondi
		Do While TempoInizio < TempoFine
			If I = Int(TempoFine) - Int(TempoInizio) Then
				I = I - 1
			End if
			TempoInizio = Timer()
		Loop
	End Function

	Call AttendiNSecondi(1)

	On Error Resume Next

	URL = "http://www.dblog.it/dblogger/leggi.asp?rss=" & URL_Blog & "feedrss.asp"
	Set XML = Server.CreateObject("MSXML2.ServerXMLHTTP")
	XML.Open "GET", URL, False

	XML.SetRequestHeader "Content-Type", "application/x-www-form-urlencoded"
	XML.Send ""
%>
	<p align="justify">
		<b>dBlog Spy (auto-ping)</b>
		<br />
<%
	If Err.Number = 0 Then
		Response.Write NoHTML(XML.ResponseText)
	Else
		Response.Write NoHTML(Err.Number)
	End If
%>
	</p>
<%
	Set XML = Nothing

	On Error GoTo 0
%>