﻿<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <%
    Response.Cookies["ut"].Expires = DateTime.Now.AddDays(-1);
    Response.Cookies["utt"].Expires = DateTime.Now.AddDays(-1);    
    Response.Redirect("Default.aspx");
     %>

</body>
</html>