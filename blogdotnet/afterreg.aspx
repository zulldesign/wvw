<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<html xmlns="http://www.w3.org/1999/xhtml">
 
<head>
    <title></title>
    <link rel="Stylesheet" href="./styles/style.css" type="text/css" media="all" />
     <META http-equiv="Refresh" content="3;url=Default.aspx" /> 
</head>
<body>
<div id="container">
 <table id="tblg">
   <!-- #include virtual="logo.html" -->
   </table>
   <table id="tbs" width="300">
   <tr><td class="mr">You are authenticated <u><b><%= Request.Cookies["ut"].Value %></b></u><br />
   An email with your data was sent to your email address.<br /><br />
   <a href="Default.aspx">Click here if your browser doesn't redirect you automatically</a>
   
   </td></tr>
        </table> 
        </div>
</body>
</html>
