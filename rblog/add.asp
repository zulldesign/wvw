<!--#include file="./constants.asp" -->
<!--#include file="./topstuff.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>RBlog - 
<% 
RSSData = LocalGroup & DataDir & "\rblog.mdb"
Fnctn = Request.QueryString
If len(Request.Form("deed")) > len(Fnctn) Then
	Fnctn = Request.Form("deed")
End If
Select Case Fnctn
Case "delete"
	%>Delete<%
Case "edit"
	%>Edit<%
Case Else
	%>Add<%
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
	<table width=100% cellspacing=5 border=0 cellpadding=0>
	<tr><td valign=top>
    <td><h2>Administration - RBlog <% 
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
%></h2></td>
  </tr>
</table>
<table border="0" cellspacing="0" cellpadding="3">
  <tr>
			<td valign="top"><table>
	<%
		' 1 --- Choose from A menu of Stories
		' 2 --- Delete chosen Description
	If Request.QueryString = "edit" Or Request.QueryString = "delete" Then
		%><tr><td><%
		If Request.QueryString = "edit" Then
			Action = "Edit"
		End If 
		If Request.QueryString = "delete" Then
			Action = "!! Delete !!"
		End If
		RSSData = LocalGroup & DataDir & "\rblog.mdb"

		Set ObjConn = Server.CreateObject("ADODB.Connection")
		DataSource = DataProvider & RSSData
		ObjConn.Open DataSource

		Set RS = ObjConn.Execute("SELECT ID,Title,ExtLink,InputDate FROM RSS WHERE UserName = '" & Session("UserName") & "' ORDER BY InputDate")
		If Not(RS.EOF) Then
			%><table border=1 noshade cellpadding=0 cellspacing=0 bordercolor=#800000><tr><td><table border=0 noshade cellpadding=3 cellspacing=0 class="footer2">
			<tr class=bodytext1 bgcolor="#FF3333">
					<td><b>Title</b></td>
					<td><b>Input Date</b></td>
					<td>&nbsp; </td></tr><%
			RS.MoveFirst

			BGC = "#FFCCCC"
			Do While Not (RS.EOF)
				If BGC = "#FFFFFF" Then
					BGC = "#FFCCCC"
				Else
					BGC = "#FFFFFF"
				End If
				%>
				<form action="add.asp" method=POST>
				<tr bgcolor="<% =BGC %>">
					<td><b><a href="<% =RS("ExtLink") %>" target="new"><% =RS("Title") %></a></b></td>
					<td align=center><i><% =RS("InputDate") %></i></td>
					<td>
					<input type=hidden name="newedit" value="edit">
					<input type=hidden name="ID" value="<% =RS("ID") %>">
					<input type=hidden name="UserName" value="<% =Session("UserName") %>">
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
		' 3 --- Add News or Edit Current Entries

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
			DropOutDateM = Request.Form("DropOutDateM")
			DropOutDateD = Request.Form("DropOutDateD")
			DropOutDateY = Request.Form("DropOutDateY")
			title = Request.Form("title")
			Description = Request.Form("Description")
			ExtLink = Request.Form("ExtLink")

			If DropOutDateM = 2 And DropOutDateD > 29 Then
				Problem = Problem & "<li>There is something wrong with the date" & chr(13)
			End If
			If Request.Form("pass") = "again" And len(title)< 3 Then
				Problem = Problem & "<li>That title is too short" & chr(13)
			End If
			If Len(ExtLink) > 8 AND (left(ExtLink,4) <> "http" AND left(ExtLink,4) <> "mail") Then
				ExtLink = "http://" & ExtLink
			End If
			If DropOutDateM <> "N/A" Then
				MadeDate = DropOutDateM & "/" & DropOutDateD & "/" & DropOutDateY 
			Else
				MadeDate = Now()
			End If

		Else
			RSSData = LocalGroup & DataDir & "\rblog.mdb"

			Set ObjConn = Server.CreateObject("ADODB.Connection")
			DataSource = DataProvider & RSSData
			ObjConn.Open DataSource

			Set RS = ObjConn.Execute("SELECT * FROM RSS WHERE ID = " & Request.Form("ID") & " AND UserName = '" & Session("UserName") & "'")

			' Response.Write("We're in the DATABASE with <i>SELECT * FROM RSS WHERE ID = " & Request.Form("ID") & "</i>")

			If Not(RS.EOF) Then
				' RS.MoveFirst
				ID = RS("ID")
				DropOutDateM = Month(RS("DropOutDate"))
				DropOutDateD = Day(RS("DropOutDate"))
				DropOutDateY = Year(RS("DropOutDate"))
				title = RS("Title")
				Description = RS("Description")
				ExtLink = RS("ExtLink")
			End If
			RS.Close 
			Set RS=Nothing 
			ObjConn.Close 
			Set ObjConn=Nothing
		End If

		If NewEdit = "new" And Request.Form("pass") <> "again" Then
			ExtLink = "http://"
		End If

	If len(Problem) > 2 Or Request.Form("pass") <> "again" Then
		If Request.Form("action") <> "delete" Then
	%>
	<tr><td>
	<ul><% =Problem %></ul>
	<form action="add.asp" method="post">
	<input type=hidden name=newedit value="<% =NewEdit %>">
	<input type=hidden name=pass value="again">
	<input type=hidden name=ID value="<% =ID %>">
					<input type=hidden name="UserName" value="<% =Session("UserName") %>">
	<table width="100%" cellspacing="2" cellpadding="0" border="0" class="bodytext1">
	<tr>
	  <td class="toc" width="150" align="left" valign="top"><b>Title :</b></td>
	  <td align="left" valign="middle"><input type="text" name="title" size="40" maxlength=149 value="<% =Cookdown(title) %>"></td>
	</tr>
	<tr>
	  <td class="toc" width="150" align="left" valign="top"><b>Description :</b></td>
	  <td align="left" valign="middle"><textarea name="Description" cols="40" rows="10"><% If Len(Description) > 1 Then %><% =Cookdown(Description) %><% End If %></textarea>
	  </td>
	</tr>
	<tr>
	  <td class="toc" width="150" align="left" valign="top"><b>Link :</b></td>
	  <td align="left" valign="middle"><input type="text" name="ExtLink" size="40"  maxlength=149 value="<% If IsNull(ExtLink) Then Response.Write(ExtLink) Else Response.Write(Cookdown(ExtLink)) End If %>"></td>
	</tr>
	<tr>
	  <td class="toc" width="150" align="left" valign="top"><b>Disappearance Date :</b></td>
	  <td align="left" valign="middle">
		<SELECT NAME="DropOutDateM">
			<OPTION VALUE="0"<% If DropOutDateM = "0" Then %> SELECTED<% End If %>>N/A
			<OPTION VALUE="1"<% If DropOutDateM = "1" Then %> SELECTED<% End If %>>January
			<OPTION VALUE="2"<% If DropOutDateM = "2" Then %> SELECTED<% End If %>>Febuary
			<OPTION VALUE="3"<% If DropOutDateM = "3" Then %> SELECTED<% End If %>>March
			<OPTION VALUE="4"<% If DropOutDateM = "4" Then %> SELECTED<% End If %>>April
			<OPTION VALUE="5"<% If DropOutDateM = "5" Then %> SELECTED<% End If %>>May
			<OPTION VALUE="6"<% If DropOutDateM = "6" Then %> SELECTED<% End If %>>June
			<OPTION VALUE="7"<% If DropOutDateM = "7" Then %> SELECTED<% End If %>>July
			<OPTION VALUE="8"<% If DropOutDateM = "8" Then %> SELECTED<% End If %>>August
			<OPTION VALUE="9"<% If DropOutDateM = "9" Then %> SELECTED<% End If %>>September
			<OPTION VALUE="10"<% If DropOutDateM = "10" Then %> SELECTED<% End If %>>October
			<OPTION VALUE="11"<% If DropOutDateM = "11" Then %> SELECTED<% End If %>>November
			<OPTION VALUE="12"<% If DropOutDateM = "12" Then %> SELECTED<% End If %>>December
		</SELECT>
		<SELECT NAME="DropOutDateD">
			<OPTION VALUE="0"<% If DropOutDateD = "0" Then %> SELECTED<% End If %>>N/A
			<% For x = 1 to 30 %>
			<OPTION VALUE="<% =x %>"<% If DropOutDateD = x Then %> SELECTED<% End If %>><% =x %>
			<% Next %>
		</SELECT>
		<SELECT NAME="DropOutDateY">
			<OPTION VALUE="0"<% If DropOutDateY = "0" Then %> SELECTED<% End If %>>N/A
			<% For x = (Year(Now())-1) to (Year(Now())+2) %>
			<OPTION VALUE="<% =x %>"<% If DropOutDateY = x Then %> SELECTED<% End If %>><% =x %>
			<% Next %>
		</SELECT>
	  </td>
	</tr>
	<tr>
	  <td width="150" align="left" valign="middle"></td>
	  <td align="left" valign="middle"><input type="submit" value="<% Select Case NewEdit
Case "edit"
	%>Edit<%
Case Else
	%>Add<%
End Select%> RSS Entry"> || <input type=reset value="Start Over"></td>
	</tr>
	</table>
	</form>
	<% 
		End If
	Else %>
	<%
	' 4 --- Add new or update edited Description

	RSSData = LocalGroup & DataDir & "\rblog.mdb"
	
	Set InsConn = Server.CreateObject("ADODB.Connection")
	DataSource = DataProvider & RSSData
	InsConn.Open DataSource

	If NewEdit = "new" Then
		If DropOutDateM <> "N/A" And (CInt(DropOutDateM) > 0) Then
			MadeDate = DropOutDateM & "/" & DropOutDateD & "/" & DropOutDateY 
			List = "Title,Description,ExtLink,DropOutDate,UserName"
		Else
			MadeDate = "12/25/2525"
			List = "Title,Description,ExtLink,UserName"
		End If

		If Request.Form("verbatim") <> "yes" Then
			Description = Replace(Description,vbCRLF,"<br>")
		End If
		InsStatement = BuildStatement(List,"Insert","RSS","Form")
	Else
		If DropOutDateM <> "N/A" And (CInt(DropOutDateM) > 0) And (CInt(DropOutDateY) > 0) Then
			MadeDate = DropOutDateM & "/" & DropOutDateD & "/" & DropOutDateY 
			List = "Title,Description,ExtLink,DropOutDate"
		Else
			MadeDate = "12/25/2525"
			List = "Title,Description,ExtLink"
		End If
		InsStatement = BuildStatement(List,"Update","RSS","Form") & " WHERE UserName = '" & Session("UserName")  & "' AND ID = " & Request.Form("ID")
	End If

	' Response.Write(InsStatement)
	Set qryInsert = InsConn.Execute(InsStatement)

	InsConn.Close 
	Set InsConn=Nothing	

	Call StaticBuilder(DataDir & "\rblog.mdb","\rss\" & Replace(Session("UserName")," ","_"),Session("UserName"))
	%><tr><td>
	<table width="100%" cellspacing="2" cellpadding="0" border="0" class="bodytext1">
	<tr>
	  <td class="toc" width="150" align="left" valign="top"><b>Title :</b></td>
	  <td align="left" valign="middle"><% =Cookdown(title) %></td>
	</tr>
	<tr>
	  <td class="toc" width="150" align="left" valign="top"><b>Description :</b></td>
	  <td align="left" valign="middle"><% =Cookdown(Description) %></td>
	</tr>
	<tr>
	  <td class="toc" width="150" align="left" valign="top"><b>Link :</b></td>
	  <td align="left" valign="middle"><% If IsNull(ExtLink) Then Response.Write(ExtLink) Else Response.Write(Cookdown(ExtLink)) End If %></td>
	</tr>
	<tr>
	  <td class="toc" width="150" align="left" valign="top"><b>Disappearance Date :</b></td>
	  <td align="left" valign="middle">
	  <% =DropOutDateM %>/<% =DropOutDateD %>/<% =DropOutDateY %>
	  </td>
	</tr>
	</table>
	<% End If %>
	</td></tr>
	<%
	End If 
	If Request.Form("action") = "delete" And IsNumeric(Request.Form("ID")) Then
		RSSData = LocalGroup & DataDir & "\rblog.mdb"
		
		Set InsConn = Server.CreateObject("ADODB.Connection")
		DataSource = DataProvider & RSSData
		InsConn.Open DataSource

		InsStatement = "DELETE FROM RSS WHERE UserName = '" & Session("UserName")  & "' AND ID = " & Request.Form("ID")
		Set qryInsert = InsConn.Execute(InsStatement)

		InsConn.Close 
		Set InsConn=Nothing	

		Call StaticBuilder(DataDir & "\rblog.mdb","\rss\" & Replace(Session("UserName")," ","_"),Session("UserName"))
		%>	<tr><td><b>This item has been deleted</b></td></tr><%
	End If
		%>
		</table>
		</td></tr>
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
<!--#include file="footer.asp"-->
</BODY>
</HTML>