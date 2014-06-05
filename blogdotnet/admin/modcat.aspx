<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link rel="Stylesheet" href="styleacp.css" type="text/css" />
    <script src="ctrclient.js" language="javascript" type="text/javascript">
             
    </script>
    
</head>
<body onload="inscat()">
<div id="container">
  <%
      
      if (Request.Cookies["adm"]!=null)
      {
          string uu = Request.Cookies["adm"].Value;  
      %>
    <table id="tblg">
    <!-- #include virtual="toplogo.html -->
    </table>
    <table id="menulat">
    <!-- #include virtual="menulat.html -->
    </table>   
    <!-- #include virtual="../config.inc" -->
    <% 
        Session["ncat"] = Request.QueryString["nomecat"];
               %>
    <table id="tbins" width="600">
    <tr align="center" class="tit"><td>Change Category</td></tr>
    <tr><td>
    <form method="post" action="aggcat.aspx">
    <input name="txtcat" type="text" value="<%= Session["ncat"] %>" />
    <input type="submit" value="change" class="btn" />
    </form> 
    </td></tr>
   
    
    <%
    }
    else
    {
        Response.Redirect("errcp.html");
    }
    %>
           </table>
           </div>
</body>
</html>
