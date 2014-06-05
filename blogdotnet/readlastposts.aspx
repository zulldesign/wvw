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
   <link rel="Stylesheet" href="./styles/style.css" type="text/css" media="all" />
</head>
<body>
   <!-- #include virtual="config.inc" -->
   <table id="tbnews" width="600">
   <%
       mc.Open();
       string idc = Request.QueryString["idc"];
       string qlp = "SELECT * FROM commenti WHERE idc='" + idc +"'";
       MySqlCommand mcommlp = new MySqlCommand(qlp, mc);
       MySqlDataReader mdrlp = mcommlp.ExecuteReader();
       mdrlp.Read();
       %>
       <tr><td><%= mdrlp["testoc"] %></td></tr>
       </table>
   
   <table id="tblg">
   <!-- #include virtual="logo.html" -->
   </table>
   <table id="latlogin" width="150">
   <% 
       if (Request.Cookies["ut"] == null)
       {
       %>
   <tr><td><a href="login.aspx">Login</a> or <a href="reg.aspx">Register</a></td></tr>
   <%
       }
       else
       {
            %>
            <tr><td>Welcome back <u><b><%= Request.Cookies["ut"].Value %></b></u> </td></tr>   
            <tr><td><a href="logout.aspx">logout</a> </td></tr>
            <%
       
       }
            %>
            
   </table>
   <table id="latsx">
    <!-- #include virtual="latsx.html" -->
   </table>
   
</body>
</html>
