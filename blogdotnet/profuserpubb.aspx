﻿<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
     <script language="javascript" type="text/javascript">
        var largh = screen.width;
        var alt = screen.height;
        if((largh>1550))
        {
        document.write(' <link rel="Stylesheet" href="./styles/style.css" type="text/css" media="all" />');
        }
        else if((largh>1250)&&(largh<1550))
        {
        document.write('<link rel="Stylesheet" href="./styles/style1280.css" type="text/css" media="all" /> ');
        }
        else {
            document.write('<link rel="Stylesheet" href="./styles/style1280.css" type="text/css" media="all" /> ');
        }
    </script>
</head>
<body>
   <div id="container">
    <table id="tblg">
   <!-- #include virtual="logo.html" -->
   </table>
    <!-- #include virtual="config.inc" -->
    <form method="post" action="elabchange.aspx" name="fp" onsubmit="return validapwd()">
    <table id="tbnews" width="600">
    <tr align="center"><td colspan="4" class="tit">Profile</td></tr>
    <% 
       mc.Open(); 
       string nck = Convert.ToString(Request.QueryString["nick"]);
       string q = "SELECT * FROM utenti WHERE nick='"+nck+"'";
       MySqlCommand mcomm = new MySqlCommand(q, mc);
       MySqlDataReader mdr = mcomm.ExecuteReader();
       Session["nck"] = Request.Cookies["ut"].Value; 
       mdr.Read();
           %>
           <tr><td>Nick</td><td>&nbsp;</td><td><%= mdr["nick"] %></td></tr>
           <tr><td>Email</td><td>&nbsp;</td><td><a href="mailto:<%= mdr["email"] %>"><%= mdr["email"] %></a></td></tr>
           <tr><td>Date Registration</td><td>&nbsp;</td><td><%= mdr["datareg"] %></td></tr>
           <tr><td>Location</td><td>&nbsp;</td><td><%= mdr["locazione"] %></td></tr>
           <tr><td><div id="btnid"></div></td><td>&nbsp;</td><td><div id="inpwd"></div></td></tr>
            </form>
           
           
           <tr align="center"><td colspan="3"><a href="Default.aspx">Back</a></td></tr>
         </table>
     </div>
</body>
</html>
