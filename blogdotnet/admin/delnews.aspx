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
    <!-- #include virtual="../config.inc" -->
   <%  
       try
       {
           mc.Open();
           string idn = Request.QueryString["idn"];
           string qd = "DELETE FROM news WHERE idn='" + idn + "'";
           MySqlCommand mcomm = new MySqlCommand(qd, mc);
           mcomm.ExecuteNonQuery();
           Response.Redirect("admdeletenews.aspx");
       }
       catch (Exception e)
       {
           Response.Redirect("admdeletenews.aspx");
       }
          
        %>
</body>
</html>
