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
    <table>
    <%
        mc.Open();
        string qd = "SELECT * FROM news WHERE datan='" + Session["data"] + "'";
        MySqlCommand mcommd = new MySqlCommand(qd, mc);
        MySqlDataReader mdrd = mcommd.ExecuteReader();
        while (mdrd.Read())
        { 
        %>
        <tr><td><%= mdrd["titolon"] %></td></tr>
        <%
            } 
            %>
       </table>      
</body>
</html>
