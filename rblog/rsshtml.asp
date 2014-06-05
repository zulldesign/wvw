 <%
Function OpXML(earl)
	 Set objXML = Server.CreateObject("Microsoft.XMLDOM")
	 objXML.async = False
	 objXML.LoadXML(earl)
	 If objXML.parseError.errorCode <> 0 Then
		 response.write reason
	 End If
	 Set objLst = objXML.getElementsByTagName("item")
	 intNoOfHeadlines = objLst.length -1

	On Error Resume Next
	For i = 0 To (intNoOfHeadlines)
		 Set objHdl = objLst.item(i)
		 Response.Write("<H3>" & objHdl.childNodes(0).text & "</H3>")
		 Response.Write(objHdl.childNodes(2).childNodes(0).text)
		 If Len(objHdl.childNodes(1).childNodes(0).text) > 0 Then 
			 Response.Write( "<BR>&nbsp;<a href=""" & objHdl.childNodes(1).childNodes(0).text & """>" & "More...</A>")
		End If
		Response.Write("<P>")
	Next
End Function %>
<HTML><BODY>
<% 
mylogo = "./presentation/images/TNLwlogo.bmp"
myRSSfile = "/newsletter/channel.xml"

Set objXMLHTTP = Server.CreateObject("Microsoft.XMLHTTP")   'create the xmlhttp object
objXMLHTTP.Open "GET", Request.QueryString, false   'use the open command to get the url
objXMLHTTP.Send
OpXML(objXMLHTTP.responseText)
Set objXMLHTTP = Nothing

%>
</HTML>
