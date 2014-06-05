<!--#include file="./constants.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>RBlog - Login</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/style1.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="760" border="0" cellspacing="0" cellpadding="3">
  <tr>
        <td valign="top">
		<span class="subhead1">Login</span>
		<p>
		<form action="logit.asp" method=POST>
		<input type=hidden name=locale value="<% =Server.HTMLEncode(Request.QueryString("locale")) %>">
		<input type=hidden name=rq value="<% =Server.URLEncode(Request.QueryString("rq")) %>">
		<table>
		<tr>
			<td class="subhead3">User Name</td>
			<td><input type=text name=UserName></td>
		</tr>
		<tr>
			<td class="subhead3">Password</td>
			<td><input type=password name=Password></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><input type=submit value="Log In"></td>
		</tr>
		</table>
		</p></td>
	</tr>
	</table>
	<form>
</body>
</html>


