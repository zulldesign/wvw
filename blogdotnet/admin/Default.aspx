<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="Stylesheet" href="../styles/style.css" type="text/css" />
</head>
<body>
<div id="container">
<table id="tblg">
    <!-- #include virtual="toplogo.html -->
</table>
    <table id="tbacpl" width="310">
    <form method="post" action="index.aspx">
    <tr align="center"><td colspan="2" class="tit">Admin Control Panel</td></tr>
    <tr align="center"><td>User Id</td><td><input type="text" name="uid" /> </td></tr>
    <tr align="center"><td>Password</td><td><input type="password" name="pwd" /> </td></tr>
    <tr align="center"><td><input id="btnreg"  type="submit" value="enter"  /> </td></tr>
    </form>
    </table>
    </div>
</body>
</html>
