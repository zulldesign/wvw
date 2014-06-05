<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script language="javascript" type="text/javascript">
        var largh = screen.width;
        var alt = screen.height;
        if((largh>1550))
        {
        document.write(' <link rel="Stylesheet" href="./styles/style.css" type="text/css" media="all" />');
        }
        if((largh>1250)&&(largh<1550))
        {
        document.write('<link rel="Stylesheet" href="./styles/style1280.css" type="text/css" media="all" /> ');
        }
        
    </script>
</head>
<body>
<div id="container">
   <table id="tblg">
   <!-- #include virtual="logo.html" -->
   </table>
     <form method="post" action="auth.aspx">
    <table id="tblogin" width="300">
    <tr align="center"><td colspan="2" class="tit">Do login</td></tr>
    <tr><td>User id</td><td><input type="text" name="uid" /></td></td></tr>
    <tr><td>Password</td><td><input type="password" name="pwd" /></td></tr>
    <tr><td><input class="btn" type="submit" value="login" /></td></tr>
    </table>
    </form>
    </div>
</body>
</html>
