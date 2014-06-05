<%
If Len(Session("AdminName") & "") < 2 OR checkValid(Session("AdminName") & "") = FALSE Then
	Cooker = split(Request.ServerVariables("URL"),"/")
	Cooked = Cooker(UBound(Cooker))
	' Response.Redirect("adminlogin.asp?locale=" & Cooked & "&rq=" & Request.QueryString)
	Response.Write(Session("AdminName"))
End If
%>