<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="Stylesheet" href="styleacp.css" type="text/css" />
    <script src="ctrclient.js" language="javascript" type="text/javascript">
             
    </script>
</head>
<body>

     <%
         if (Request.Cookies["adm"] != null)
         {
      %>
     <div id="container">
         <!-- #include virtual="../config.inc" -->
    <table id="tblg">
    <!-- #include virtual="toplogo.html -->
    </table>
    <table id="menulat">
    <!-- #include virtual="menulat.html -->
    </table>
    <table id="cntacp" width="600">
    <tr class="tit" align="center"><td colspan="2">Delete the Users</td></tr>
    <%
         string q = "SELECT * FROM utenti";
         MySqlCommand mcomm = new MySqlCommand(q, mc);
         DataSet ds = new DataSet();
         MySqlDataAdapter mda = new MySqlDataAdapter(mcomm);
         mda.Fill(ds);
         DataRowCollection drc = ds.Tables[0].Rows;
         int nr = drc.Count;
         for (int i = nr - 1; i >= 0; i--)
         {
             DataRow dr = drc[i];
            
            %>
        <tr><td><img src="../images/user-prof.png" />&nbsp;&nbsp;<%= dr["nick"]%></td><td><a title="Delete User" href="delusers.aspx?idu=<%= dr["idu"] %>"><img src="../images/Button-Close-icon.png" /></a></td></tr>
        <%
            
         }
         }
         else
         {
             Response.Redirect("errgen.aspx");
         }
        %>
        </div>
       </table>      
</body>
</html>
