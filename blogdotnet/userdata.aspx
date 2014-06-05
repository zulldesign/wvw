<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body><table id="tbu">

<tr><td>Your IP</td><td><%= Request.ServerVariables["REMOTE_ADDR"] %></td></tr>    
<tr><td>Your Browser</td><td><%= Request.Browser.Browser %> 
<%= Request.Browser.MajorVersion %></td></tr>
<%
    Session.Add("ute", "ale");
     %>
     <tr><td><%= Session.Count %></td></tr>
     <tr><td><%= Session.SessionID %></td></tr>
</table>
</body>
</html>
