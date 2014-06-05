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
   <!-- #include virtual="../config.inc" -->
   <%
       mc.Open();
       string qu = "UPDATE news SET categoria='" + Request.Form["txtcat"] + "' WHERE categoria='" + Session["ncat"] + "'";
       MySqlCommand mcomm = new MySqlCommand(qu, mc);
       mcomm.ExecuteNonQuery();
       Response.Redirect("managecat.aspx");     
           %>
   
    
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
