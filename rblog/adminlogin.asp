<!--#include file="./constants.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Administration - Login</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/repstyle.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFFF">
<h1>Administration - Login</h1>
<hr noshade>
<table width="760" border="0" cellspacing="0" cellpadding="3">
  <tr>
            <td width="10">&nbsp;</td>
			<td valign="top">
		<h1>Login</h1>
		<p>
		<form action="adminlogit.asp" method=POST>
		<input type=hidden name=locale value="<% =Server.HTMLEncode(Request.QueryString) %>">
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
	</td>
    <td width="1" align="center" valign="top"><img src="../menu/spacer.gif" width="1" height="600"></td>
  </tr>
</table>
<!--#include file="./footer.asp" -->
<br>
<!--#include file="./adminfooter.asp" -->
</body>
</html>


