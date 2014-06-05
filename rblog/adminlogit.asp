<!--#include file="./constants.asp" -->
<%
If Request.QueryString = "out" Then
	Session("AdminName") = NULL
	Session.Abandon
	Response.Redirect("/")
End If

If checkValid(Request.Form("UserName")) = FALSE Or checkValid(Request.Form("Password")) = FALSE Then
	Response.Redirect("adminlogin.asp?" & Request.Form("locale"))
End If

AdminData = LocalGroup & DataDir & "\admin.mdb"
AdminSource = DataProvider & AdminData
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open AdminSource
sql = "SELECT * FROM Admin Where ID > 0 AND UserName='" & Request.Form("UserName") & "' AND Password='" & Request.Form("Password") & "'"
Set RS = Conn.Execute(sql)

If RS.EOF Then
	RS.Close 
	Set RS=Nothing 
	Conn.Close 
	Set Conn=Nothing
	Response.Redirect("adminlogin.asp?" & Request.Form("locale"))
Else
	Session("AdminName") = Request.Form("UserName")
	Session("Clearance") = RS("level")
	Session("RealName") = RS("RealName")
	RS.Close 
	Set RS=Nothing 
	Conn.Close 
	Set Conn=Nothing

	If Len(Request.Form("locale")) > 1 Then
		Response.Redirect(Request.Form("locale") & "?edit")
	Else
		Response.Redirect("/adminusers.asp?edit")
	End If
End If
%>