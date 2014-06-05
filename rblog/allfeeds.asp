<!--#include file="./constants.asp" -->
<%
website = "http://" & request.servervariables("HTTP_HOST")
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> RBlog - Instant News Syndication - Available RBlog Feeds</TITLE>
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
	<h1>Available Feeds</h1>
	<h4>
	<ul>
	<% 
	RSSData = LocalGroup & DataDir & "\rblog.mdb" 

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

	SQL = "SELECT TOP " & (SQStart + SQrecords) & " Title,UserName,WebSite,Descrip FROM Users WHERE Len(UserName) > 2 AND Len(Title) > 1 AND (Status = 'Active' OR IsNull(Status)) ORDER BY UserName ASC"

	Set RS = ObjConn.Execute(SQL)
	x = 0
	If Not(RS.EOF) Then
		Do While (x < SQStart) AND Not(RS.EOF)
			RS.MoveNext
			x = x + 1
		Loop
		Do While Not(RS.EOF)
				%>
				<li><a href="/rss/<% =Replace(RS("UserName")," ","_") %>.xml"><% =RS("Title") %></a> - 
				<% =RS("Descrip") %>
				<i><a href="<% =RS("WebSite") %>"><% =RS("WebSite") %></a> - <a href="/rsshtml.asp?<% =website %>/rss/<% =Replace(RS("UserName")," ","_") %>.xml" class="etc">See RSS as HTML</a></i> 
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
	</h4>
	<img src="spacer.gif" border=0 width=450 height=1>
	</td></tr>
	</table>
	</td>
	<td style="border: #990033 1px solid; background: #FFFFFF;" valign=top><!-- BODY HOLD OUT -->
	<table width=100% cellspacing=5 border=0 cellpadding=0>
		<tr><td>
		<img src="spacer.gif" border=0 width=120 height=1>
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