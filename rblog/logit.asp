<!--#include file="./constants.asp" -->
<%
If Request.QueryString = "out" Then
	Session("UserName") = NULL
	Response.Redirect("/")
End If

If checkValid(Request.Form("UserName")) = FALSE Or checkValid(Request.Form("Password")) = FALSE Then
	Response.Redirect("login.asp?" & Request.Form("locale"))
End If

AdminData = LocalGroup & DataDir & "\rblog.mdb"

	Set Conn = Server.CreateObject("ADODB.Connection")
	DataSource = DataProvider & AdminData
	Conn.Open DataSource

	Response.Write(AdminData)

sql = "SELECT * FROM Users Where ID > 0 AND UserName='" & Request.Form("UserName") & "' AND Password='" & Request.Form("Password") & "'"
Set RS = Conn.Execute(sql)

If RS.EOF Then
	RS.Close 
	Set RS=Nothing 
	Conn.Close 
	Set Conn=Nothing
	Response.Redirect("login.asp?" & Request.Form("locale"))
Else
	Session("UserName") = Request.Form("UserName")
	Session("RealName") = RS("RealName")
	RS.Close 
	Set RS=Nothing 
	Conn.Close 
	Set Conn=Nothing

	If Len(Request.Form("locale")) > 1 Then
		Response.Redirect(Request.Form("locale") & "?" & Request.Form("rq"))
	Else
		Response.Redirect("/users.asp")
	End If
End If
%>