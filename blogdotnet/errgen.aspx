﻿<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style  type="text/css">
    #tbs
    {
    position: absolute;
    top: 100px;
    left: 362px;    
    background-color: #FF7000;
    color: White;    
        }
    a
    {
    color: Blue;    
        }
    
    </style>
</head>
<body>
    <table id="tbs" width="500">
<tr><td><h3>General Error!!</h3><a href="Default.aspx">Back</a></td></tr>
<tr><td><%= Session["errins"] %></td></tr>
</table>
</body>
</html>