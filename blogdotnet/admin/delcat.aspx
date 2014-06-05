<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<%
      
    if (Request.Cookies["adm"] != null)
    {
        string uu = Request.Cookies["adm"].Value;  
      %>
<!-- #include virtual="../config.inc" -->
   <%
    string qd = "DELETE FROM news WHERE categoria='" + Request.QueryString["nomecat"] + "'";
    mc.Open();
    MySqlCommand mcomm = new MySqlCommand(qd, mc);
    mcomm.ExecuteNonQuery();
    mc.Close();
    Response.Redirect("managecat.aspx");
        %>
        <%
    }
    else
    {
        Response.Redirect("erracp.html");
    }
              %>
</body>
</html>
