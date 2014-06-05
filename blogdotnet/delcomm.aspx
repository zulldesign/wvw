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
<!-- #include virtual="config.inc" -->
    <%
        mc.Open();
        string idc = Request.QueryString["idc"];
        string qd = "DELETE FROM commenti WHERE idc='"+idc+"'";
        MySqlCommand mcomm = new MySqlCommand(qd, mc);
        mcomm.ExecuteNonQuery();
        Response.Redirect("displaycomm.aspx?idn="+Session["idn"]);  
         %>
</body>
</html>
