<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="Stylesheet" href="styleacp.css" type="text/css" />
    <script language="javascript" src="ctrclient.js" type="text/javascript">
       
    </script>
</head>
<body>
  <div id="container">
     <table id="tblg">
    <!-- #include virtual="toplogo.html -->
    </table>
    <table id="menulat">
    <!-- #include virtual="menulat.html -->
   <!-- #include virtual="../config.inc" -->
    <table id="cntacp" width="500">
    <tr><td align="center" colspan="4"  class="tit">Delete News</td></tr>
    <tr><td colspan="3">&nbsp;</td></tr>
    <%
        DataSet dsn = new DataSet();
        string qnp = "SELECT * FROM news WHERE idn<=(SELECT MAX(idn) FROM news)";
            qnp+= "AND idn>=(SELECT MAX(idn)-5 FROM news) ORDER BY idn DESC";
        MySqlDataAdapter mdanp = new MySqlDataAdapter(qnp, mc);
        mdanp.Fill(dsn);
        DataRowCollection drcnp = dsn.Tables[0].Rows;
        int n = drcnp.Count;
        for (int i = 0; i <= n-1; i++)
        {
            DataRow d = drcnp[i];
            %>
        <tr><td><img src="../images/news.png" />&nbsp;&nbsp;<%= d["titolon"] %></td><td><%= d["datan"] %></td><td><a href="modnews.aspx?titn=<%=d["titolon"] %>&idn=<%= d["idn"] %>"><img src="../images/Text-Edit-icon.png" /></a> </td><td><a title="Delete News" href="delnews.aspx?idn=<%= d["idn"] %>"><img src="../images/Button-Close-icon.png" /></a></td></tr>
        <tr><td>&nbsp;</td></tr>
        <%
        }
           
            %>
        </table>
        </div>
</body>
</html>
