<!--#include file="./constants.asp" -->
<%
website = "http://" & request.servervariables("HTTP_HOST")
%>
<%
Dim Quary
Dim Listing
Function BuildSearch (Qry,Fielz)
		Qry = Replace(Qry,")"," ")
		Qry = Replace(Qry,"("," ")
		Qry = Replace(Qry,"  "," ")

		Quary = split(Qry," ")
		For Each Item In Quary
			If Len(Refusion) > 3 AND UCase(Right(Refusion,4)) <> " AND" AND UCase(Right(Refusion,3)) <> " OR" AND UCase(Item) <> "AND" AND UCase(Item) <> "OR" Then
				Refusion = Refusion & " OR "
			End If 
			If UCase(Item) <> "AND" AND UCase(Item) <> "OR" Then
				Refusion = Refusion & " ZaBu" & Item & "%'"
			Else
				Refusion = Refusion & " " & Item
			End If
		Next
		Refusion = LTrim(Refusion)

		Listing = split(Fielz,",")
		For Each Item In Listing
			If Len(Partz) > 3 Then
				Partz = Partz & " OR "
			End If 
			KK = Item & " LIKE '%"
			JJ = Replace(Refusion,"ZaBu", KK)
			Partz = Partz &  "(" & JJ & ")"
		Next

	BuildSearch = Partz
End Function

RSSData = LocalGroup & DataDir & "\rblog.mdb" 

If Request.QueryString("xml") = "yes" Then
	Set ObjConn = Server.CreateObject("ADODB.Connection")
	DataSource = DataProvider & RSSData
	ObjConn.Open DataSource

	SQStart = CInt(Request.QueryString("start"))
	SQrecords = CInt(Request.QueryString("records"))

	If IsNull(SQStart) Then
		SQStart = 0
	End If
	If IsNull(SQrecords) OR SQrecords < 1 Then
		SQrecords = 20
	End If

	List = "Title,Description,ExtLink,Category,UserName"

	SQL = "SELECT TOP " & (SQStart + SQrecords) & " Title,Description,ExtLink,UserName FROM RSS WHERE (" &  BuildSearch(Request.QueryString("text"),List) & ") AND DropOutDate > Now() ORDER BY InputDate DESC"

	Set RS = ObjConn.Execute(SQL)
	x = 0
	Response.ContentType = "text/xml"
	If Not(RS.EOF) Then
		Do While (x < SQStart) AND Not(RS.EOF)
			RS.MoveNext
			x = x + 1
		Loop
If Not(RS.EOF) Then %><?xml version="1.0"?>
<rss version="0.92">
<channel>
<title><% =RSSSafe("RBlog") %></title>
<link><% =RSSSafe(website) %></link>
<description>Your one stop spot for RSS information</description>
<language>en-us</language>
<% Do While Not(RS.EOF)
			WrTitle = RS("Title")
			WrDescription = RS("Description")
			WrLink = RS("ExtLink")

			If IsNull(WrLink) Then
				WrLink = ""
			End If

			Response.Write("  <item>")
			Response.Write("  <title>" & RSSSafe(WrTitle) & "</title>")
			Response.Write("  <link>" & RSSSafe(WrLink) & "</link>")
			Response.Write("  <description>" & RSSSafe(WrDescription) & "</description>")
			Response.Write("</item>")
			RS.MoveNext
		Loop		
	End If
%>
</channel>
</rss>
<%
End If
	RS.Close 
	Set RS=Nothing 
	ObjConn.Close 
	Set ObjConn=Nothing
Else
%>
<HTML>
<HEAD>
<TITLE> RBlog - Instant News Syndication - Search RBlog Feeds</TITLE>
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
	<% If Len(Request.QueryString("text")) > 2 Then %>
	<h1>Search Results</h1>
	<h4>
	<ul>
	<% 
	Set ObjConn = Server.CreateObject("ADODB.Connection")
	DataSource = DataProvider & RSSData
	ObjConn.Open DataSource

	SQStart = CInt(Request.QueryString("start"))
	SQrecords = CInt(Request.QueryString("records"))

	If IsNull(SQStart) Then
		SQStart = 0
	End If
	If IsNull(SQrecords) OR SQrecords < 1 Then
		SQrecords = 20
	End If

	List = "Title,Description,ExtLink,Category,UserName"

	SQL = "SELECT TOP " & (SQStart + SQrecords) & " Title,Description,ExtLink,UserName FROM RSS WHERE (" &  BuildSearch(Request.QueryString("text"),List) & ") AND DropOutDate > Now() ORDER BY InputDate DESC"

	Set RS = ObjConn.Execute(SQL)
	Response.Write("<!--" & SQL & "-->")
	x = 0
	If Not(RS.EOF) Then
		Do While (x < SQStart) AND Not(RS.EOF)
			RS.MoveNext
			x = x + 1
		Loop
		Do While Not(RS.EOF)
				%>
				<li><a href="/rss/<% =Replace(RS("UserName")," ","_") %>.xml"><% =RS("Title") %></a> - 
				<% =RS("Description") %><br>
				<i><a href="<% =RS("ExtLink") %>"><% =RS("ExtLink") %></a></i>
			<%
			RS.MoveNext
		Loop		
	End If

	RS.Close 
	Set RS=Nothing 
	ObjConn.Close 
	Set ObjConn=Nothing
	%>
	</ul>
	<a href="searchfeeds.asp?<% =Request.QueryString %>&xml=yes">See these results as an RSS feed</a>
	<br><br>
	<i><a href="searchfeeds.asp">Search Again?</a></i>
	</h4>
	<% Else %>
	<h1>Search</h1>
	<h4>
	<form action="searchfeeds.asp">
		Search: <input type="text" name="text" size=30>
		<input type="submit" value="Search">
	</form>
	</h4>
	<% End If %>
	<img src="spacer.gif" border=0 width=450 height=1>
	</td></tr>
	</table>
	</td>
	<td style="border: #990033 1px solid; background: #FFFFFF;" valign=top><!-- BODY HOLD OUT -->
	<table width=100% cellspacing=5 border=0 cellpadding=0>
		<tr><td>
		<img src="spacer.gif" border=0 width=120 height=1>
		<br>
		<script type="text/javascript"><!--
		google_ad_client = "pub-6469669121241651";
		google_ad_width = 120;
		google_ad_height = 600;
		google_ad_format = "120x600_as";
		google_color_border = "DDB7BA";
		google_color_bg = "FFF5F6";
		google_color_link = "0000CC";
		google_color_url = "008000";
		google_color_text = "6F6F6F";
		//--></script>
		<script type="text/javascript"
		  src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
		</script>
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
<% End If %>