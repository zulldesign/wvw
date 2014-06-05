<%
	'dBlog 2.0 CMS Open Source
	'Versione file 2.0.0
%>
<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--#include file="inc_db.asp"-->
<!--#include virtual="/dblog/inc_funzioni.asp"-->
<!--#include file="inc_sha-1.asp"-->
<%
	Dim SQLAutori, RSAutori, FUserID, FPassword

	FUserID = Request.Form("UserID")
	FPassword = Request.Form("Password")

	If FUserID <> "" AND FPassword <> "" Then
		SQLAutori = " SELECT [Nick], [UserID], [Password], [Admin] FROM [Autori] WHERE [UserID] = '"& ControlloSQLInjection(FUserID) &"' "
		Set RSAutori = Server.CreateObject("ADODB.Recordset")
		RSAutori.Open SQLAutori, Conn, 1, 3

		If NOT RSAutori.EOF Then
			RSAutori.MoveFirst
			If RSAutori("Password") = getSHAPassword(FPassword) Then
				Session("BLOGNick") = RSAutori("Nick")
				Session.TimeOut = 60
				If RSAutori("Admin") = True Then
					Session("BLOGAdmin") = True
				Else
					Session("BLOGAdmin") = False
				End If
				Response.Redirect "default.asp"
			Else
				Session("BLOGNick") = ""
				Session("BLOGAdmin") = False
				Response.Redirect "login.asp"
			End If
		Else
			Session("BLOGNick") = ""
			Session("BLOGAdmin") = False
			Response.Redirect "login.asp"
		End If
	Else
		Session("BLOGNick") = ""
		Session("BLOGAdmin") = False
		Response.Redirect "login.asp"
	End If
%>
<%
	Set RSAutori = Nothing

	Conn.Close
	Set Conn = Nothing
%>