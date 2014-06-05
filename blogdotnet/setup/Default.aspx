<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Setup the Blog step 1</title>
     <script language="javascript" type="text/javascript">
        var largh = screen.width;
        var alt = screen.height;
        if((largh>1550))
        {
        document.write(' <link rel="Stylesheet" href="../styles/style.css" type="text/css" media="all" />');
        }
        else if((largh>1250)&&(largh<1550))
        {
        document.write('<link rel="Stylesheet" href="../styles/style1280.css" type="text/css" media="all" /> ');
    }
    else
    {
        document.write('<link rel="Stylesheet" href="../styles/style1280.css" type="text/css" media="all" /> ');
    }
        
    </script>
         
</head>
<body>
<div id="container">
   <table id="tblg">
   <!-- #include virtual="logo.html" -->
   </table>
    <table id="tbinst" width="500">
    <tr align="center"><td>
    <h3 class="tit">1st step</h3>
    </td></tr>
    <tr><td> - Create a Database in MySql Server</td></tr>
    <tr><td> - Execute queryblog.sql located in setup folder with phpmyadmin or other</td></tr>
    <tr><td> - Set your MySql credentials in config.inc located in the root blog folder<br /><br />
    <b>ServerIP</b>: your IP of MySql Server<br />
    <b>userid</b>: the userid of your db server<br />
    <b>password</b>: your password of MySql Server<br />
    <b>db</b>: your db name in MySql Server<br />
    <br />
    After this go to second step<br /><br />
    </td></tr>
    
    <tr align="center"><td><h3 class="tit">2st step</h3>
    <a href="Default1.aspx">Go to second step!</a></td></tr>
    </td></tr>
    
    </table>
    
    </div>
</body>
</html>
