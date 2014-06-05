<%@ Page Language="C#" %> 
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link rel="Stylesheet" href="styleacp.css" type="text/css" />

    <script src="ctrclient.js" type="text/javascript"></script>
</head>
<body>
     <%
      
         if (Request.Cookies["adm"] != null)
         {
             string uu = Request.Cookies["adm"].Value;  
      %>
    <!-- #include virtual="../config.inc" -->
    <div id="container">
    <table id="tblg">
    <!-- #include virtual="toplogo.html -->
    </table>
    <table id="menulat">
    <!-- #include virtual="menulat.html -->
    </table>
    <table id="cntacp" width="500">
    <tr class="tit" align="center"><td colspan="3">Manage Categories</td></tr>
    <tr><td>&nbsp;</td></tr>
    <%
         string q = "SELECT DISTINCT categoria  FROM news";
         MySqlCommand mcomm = new MySqlCommand(q, mc);
         DataSet ds = new DataSet();
         MySqlDataAdapter mda = new MySqlDataAdapter(mcomm);
         mda.Fill(ds);
         DataRowCollection drc = ds.Tables[0].Rows;
         int nr = drc.Count;
         for (int i = 0; i <= nr - 1; i++)
         {
             DataRow dr = drc[i];
            
            %>
        <tr><td><img src="../images/Folder-icon.png" /> <%= dr["categoria"]%></td>
        <td><a title="Modify" href="modcat.aspx?nomecat=<%= dr["categoria"] %>"><img src="../images/Text-Edit-icon.png" /></a></td><td><a title="Delete" href="delcat.aspx?nomecat=<%= dr["categoria"] %>"><img src="../images/Button-Close-icon.png" /> </a></td></tr>
        <tr><td>&nbsp;</td></tr>
        <%
            
         }
        %>
        <tr><td>&nbsp;</td></tr>
       </table> 
        </div> 
        <%
         }
         else
         {
             Response.Redirect("erracp.html");
         }
           %>      
</body>
</html>
