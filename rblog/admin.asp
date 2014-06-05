<!--#include file="./constants.asp" -->
<!--#include file="./admintopstuff.asp" -->
<%
If (Session("Clearance") <> "system") Then
	Response.Redirect("/adminlogin.asp")
End If
%>
<html>
<head>
<title>RBlog 
<% 
Fnctn = Request.QueryString
If len(Request.Form("deed")) > len(Fnctn) Then
	Fnctn = Request.Form("deed")
End If
Select Case Fnctn
Case "delete"
	%> - Delete<%
Case "edit"
	%> - Edit<%
Case Else
	%> - Add<%
End Select
%>
</title>
<META NAME="Author" CONTENT="Mike DeWolfe">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<script LANGUAGE="JavaScript">
<!-- hide contents from old browsers
var Item,Wid,Heit;
function opener(Item,Wid,Heit)
	{
	window.open(Item,"NewWindow","scrollbars=yes,toolbar=no,location=no,width="+Wid+",height="+Heit)
	}
//--></script>
<LINK REL="stylesheet" TYPE="text/css" HREF="/style.css">
<STYLE TYPE="text/css">
<!--
@import url(/style.css); /* @import comes first */
-->
</STYLE>
</HEAD>
<BODY bgcolor=#cc3366>
<table width=100% border=0 cellpadding=5 cellspacing=10>
<tr>
	<td colspan=2 nowrap><!--RSS WebLog Title--><img src="rblog_bann.jpg">
	<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=5,0,0,0" WIDTH=360 HEIGHT=90>
	<PARAM NAME=movie VALUE="logo.swf"> <PARAM NAME=quality VALUE=high> <PARAM NAME=bgcolor VALUE=#cc3366> <EMBED src="logo.swf" quality=high bgcolor=#cc3366 align="" WIDTH=360 HEIGHT=90 TYPE="application/x-shockwave-flash" PLUGINSPAGE="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash"></EMBED>
	</OBJECT>
	</td>
</tr>
<tr>
	<td style="border: #990033 1px solid; background: #FFFFFF;" valign=top><!-- BODY HOLD OUT -->
	<!--<table width=100% cellspacing=5 border=0 cellpadding=0>
	<tr><td valign=top>-->
    <h2>Administration - RBlog 			
			<table>
	<%
		' 1 --- Choose from A menu of Admin People
		' 2 --- Delete chosen story
	If Request.QueryString = "edit" Or Request.QueryString = "delete" Then
		%><tr><td><%
		If Request.QueryString = "edit" Then
			Action = "Edit"
		End If 
		If Request.QueryString = "delete" Then
			Action = "!! Delete !!"
		End If
		NewsData = LocalGroup & DataDir & "\admin.mdb"

		Set ObjConn = Server.CreateObject("ADODB.Connection")
		DataSource = DataProvider & NewsData
		ObjConn.Open DataSource

		Set RS = ObjConn.Execute("SELECT * FROM Admin ORDER BY [Level]")
		%></h2><%
		If Not(RS.EOF) Then
			%><table border=1 noshade cellpadding=0 cellspacing=0 bordercolor=#800000 width=100%><tr><td><table border=0 noshade cellpadding=3 cellspacing=0 width=100%>
			<tr class=bodytext1 bgcolor="<% =TblHeadline %>">
					<td><b>Name</b></td>
					<td>&nbsp; </td>
					<td><b>Level</b></td>
					<td>&nbsp; </td>
					<td>&nbsp; </td></tr><%

			RS.MoveFirst

			BGC = TblDarkline
			Do While Not (RS.EOF)
				If BGC = "#FFFFFF" Then
					BGC = TblDarkline
				Else
					BGC = "#FFFFFF"
				End If
				%>
				<form action="admin.asp" method=POST>
				<tr class=etc bgcolor="<% =BGC %>">
					<td align=center><i><% =RS("RealName") %> (<% =RS("UserName") %>)</i></td><td align=center> ||</td>
					<td align=center><% =RS("Level") %></td><td align=center> ||</td>
					<td>
					<input type=hidden name="newedit" value="edit">
					<input type=hidden name="ID" value="<% =RS("ID") %>">
					<input type=hidden name="action" value="<% =Request.QueryString %>">
					 &nbsp; <input type="submit" value="<% =Action %>"> &nbsp; 
					</td>
				<%
				RS.MoveNext
				%>
				</form>
				</tr>
				<%
			Loop
			%></table></td></tr></table><%
		Else
			%><i>There are no items available</i><%
		End If

		RS.Close 
		Set RS=Nothing 
		ObjConn.Close 
		Set ObjConn=Nothing
		%><!-- End Menu --></td></tr><%
	Else
		%><!-- Start Editor --><%
		' 3 --- Add New or Edit Current Administrators

		' 3.1 The branching
		' - new
		' - edit an existing entry
		' - repair a faulty new entry
		' - repair a faulty existing entry

		If Request.Form("newedit") = "edit" Then
			NewEdit = "edit"
		Else
			NewEdit = "new"
		End If

		If Request.Form("pass") = "again" Or NewEdit = "new" Then
			ID = Request.Form("ID")
			UserName = Request.Form("UserName")
			RealName = Request.Form("RealName")
			Notes = Request.Form("Notes")
			Password = Request.Form("Password")
			Password1 = Request.Form("Password1")
			Level = Request.Form("Level")
			Sure = Request.Form("Sure")
			ControlArea = Request.Form("ControlArea")

			If Request.Form("pass") = "again" Then
				If len(UserName)< 3 Then
					Problem = Problem & "<li>That User Name is too short" & chr(13)
				End If
				If Len(Password) < 3 Then
					Problem = Problem & "<li>Your password is too short" & chr(13)
				End If
			End If
			If Password <> Password1 Then
				Problem = Problem & "<li>The passwords have to match" & chr(13)
			End If
			If Password = "password" Then
				Problem = Problem & "<li>'password' isn't good as a password" & chr(13)
			End If
			If InStr(Password,"****") > 0 Then
				Problem = Problem & "<li>What? Are you the pointy haired boss?" & chr(13)
			End If
			If Level = "system" And NewEdit = "new" And Sure <> "yes" Then
				Problem = Problem & "<li>Are you sure you want to hand out system control? If so, click the 'Sure' box" & chr(13)
			End If

		Else
			NewsData = LocalGroup & DataDir & "\admin.mdb"

			Set ObjConn = Server.CreateObject("ADODB.Connection")
			DataSource = DataProvider & NewsData
			ObjConn.Open DataSource

			Set RS = ObjConn.Execute("SELECT * FROM Admin WHERE ID = " & Request.Form("ID"))

			If Not(RS.EOF) Then
				ID = RS("ID")
				UserName = RS("UserName")
				RealName = RS("RealName")
				Password = RS("Password")
				Notes = RS("Notes")
				Level = RS("Level")
				ControlArea = RS("ControlArea")
			End If
			RS.Close 
			Set RS=Nothing 
			ObjConn.Close 
			Set ObjConn=Nothing
		End If

	If len(Problem) > 2 Or Request.Form("pass") <> "again" Then
		If Request.Form("action") <> "delete" Then
	%>
	<tr><td>
	<ul><% =Problem %></ul>
	<form action="admin.asp" method="post">
	<input type=hidden name=newedit value="<% =NewEdit %>">
	<input type=hidden name=pass value="again">
	<input type=hidden name=ID value="<% =ID %>">
	<table width="100%" cellspacing="2" cellpadding="0" border="0">
	<tr>
	  <td class="toc" width="150" align="left" valign="top"><b>User Name :</b></td>
	  <td align="left" valign="middle"><input type="text" name="UserName" size="40" value="<% =Cookdown(UserName) %>"></td>
	</tr>
	<tr>
	  <td class="toc" width="150" align="left" valign="top"><b>Real Name :</b></td>
	  <td align="left" valign="middle"><input type="text" name="RealName" size="40" value="<% =Cookdown(RealName) %>"></td>
	</tr>
	<%
	if Session("Clearance") = "system" then
		PassText = "text"
	else
		PassText = "password"
	end if
	%>
	<tr>
	  <td class="toc" width="150" align="left" valign="top"><b>Password :</b></td>
	  <td align="left" valign="middle"><input type="<% =PassText %>" name="Password" size="40"<% 	if Session("Clearance") = "system" then %> value="<% =Password %>"<% end if %>></td>
	</tr>
	<tr>
	  <td class="toc" width="150" align="left" valign="top"><b>RETYPE Password :</b></td>
	  <td align="left" valign="middle"><input type="<% =PassText %>" name="Password1" size="40"<% 	if Session("Clearance") = "system" then %> value="<% =Password %>"<% end if %>></td>
	</tr>
	<tr>
	  <td class="toc" width="150" align="left" valign="top"><b>Control Level :</b></td>
	  <td align="left" valign="middle">
		<SELECT NAME="Level">
			<OPTION VALUE="system"<% If Level = "system" Then %> SELECTED<% End If %>>System
			<OPTION VALUE="region"<% If Level = "region" Then %> SELECTED<% End If %>>Regional
		</SELECT>
	  </td>
	</tr>
	<% If Level = "system" And NewEdit = "new" And Len(Problem) > 5 Then %>
	<tr>
	  <td class="toc" width="150" align="left" valign="top"><b>Sure?</b></td>
	  <td align="left" valign="middle"><input type="checkbox" name="Sure" value="yes">Are you sure?</td>
	</tr>
	<% End If %>
	<input type=hidden name=ControlArea value="0">
	<tr>
	  <td class="toc" width="150" align="left" valign="top"><b>Notes :</b></td>
	  <td align="left" valign="middle"><textarea name="Notes" cols="40" rows="10"><% If Len(Notes) > 1 Then %><% =Cookdown(Notes) %><% End If %></textarea></td>
	</tr>
	<tr>
	  <td width="150" align="left" valign="middle"></td>
	  <td align="left" valign="middle"><input type="submit" value="<% Select Case NewEdit
Case "edit"
	%>Edit<%
Case Else
	%>Add<%
End Select%> Admin Profile"> || <input type=reset value="Start Over"></td>
	</tr>
	</table>
	</form>
	<% 
		End If
	Else %>
	<%
	' 4 --- Add new or update edited story

	NewsData = LocalGroup & DataDir & "\admin.mdb"
	
	Set InsConn = Server.CreateObject("ADODB.Connection")
	DataSource = DataProvider & NewsData
	InsConn.Open DataSource

	If NewEdit = "new" Then
		List = "UserName,RealName,Notes,Password,Level,ControlArea"
		InsStatement = BuildStatement(List,"Insert","Admin","Form")
	Else
		List = "UserName,RealName,Notes,Password,Level,ControlArea"
		InsStatement = BuildStatement(List,"Update","Admin","Form") & " WHERE ID = " & Request.Form("ID")
	End If

	Set qryInsert = InsConn.Execute(InsStatement)

	InsConn.Close 
	Set InsConn=Nothing	
	%><tr><td>
	<table width="100%" cellspacing="2" cellpadding="0" border="0">
	<tr>
	  <td class="toc" width="150" align="left" valign="top"><b>User Name :</b></td>
	  <td align="left" valign="middle"><% =Cookdown(UserName) %></td>
	</tr>
	<tr>
	  <td class="toc" width="150" align="left" valign="top"><b>Real Name :</b></td>
	  <td align="left" valign="middle"><% =Cookdown(RealName) %></td>
	</tr>
	<tr>
	  <td class="toc" width="150" align="left" valign="top"><b>Control Level :</b></td>
	  <td align="left" valign="middle"><% =Cookdown(Level) %></td>
	</tr>
	<tr>
	  <td class="toc" width="150" align="left" valign="top"><b>Notes :</b></td>
	  <td align="left" valign="middle"><% =Cookdown(Notes) %></td>
	</tr>
	</table>
	<% End If %>
	</td></tr>
	<%
	End If 
	If Request.Form("action") = "delete" And IsNumeric(Request.Form("ID")) Then
		NewsData = LocalGroup & DataDir & "\admin.mdb"
		
		Set InsConn = Server.CreateObject("ADODB.Connection")
		DataSource = DataProvider & NewsData
		InsConn.Open DataSource

		InsStatement = "DELETE FROM Admin WHERE ID = " & Request.Form("ID")
		Set qryInsert = InsConn.Execute(InsStatement)

		InsConn.Close 
		Set InsConn=Nothing	
		%>	<tr><td><b>This administrator has been deleted</b></td></tr><%
	End If
		%>
		</table>
	</td>
	<td style="border: #990033 1px solid; background: #FFFFFF;" valign=top><!-- BODY HOLD OUT -->
	<table width=100% cellspacing=5 border=0 cellpadding=0>
		<tr><td>
		<!--#include file="soon.asp"-->
		<img src="spacer.gif" border=0 width=120 height=1>
		</td></tr>
	</table>
	</td></tr>
	</table>
		</td>
	</tr>
</table>
<!--#include file="./footer.asp" -->
<br>
<!--#include file="./adminfooter.asp" -->
</body>
</html>