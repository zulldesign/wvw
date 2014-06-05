<%@ Page Language="C#" %> 
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link rel="Stylesheet" href="styleacp.css" type="text/css" />
    <script runat="server">
        void Page_load(object sender, EventArgs e)
        { 
        
        }
        
    </script>
</head>
<body>
    <!-- #include virtual="../config.inc" -->
    <table id="tblg">
    <!-- #include virtual="toplogo.html -->
    </table>
    <table id="menulat">
    <!-- #include virtual="menulat.html -->
    </table>
    <table id="cntacp" width="500">
    <tr class="tit" align="center"><td colspan="2">Delete the news</td></tr>
    <%
        string q = "SELECT * FROM news";
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
        <tr><td><%= dr["titolon"] %></td><td><a href="delnews.aspx?idn=<%= dr["idn"] %>">delete</a></td></tr>
        <%
            
        }
        %>
        <tr><td>&nbsp;</td></tr>
       </table>         
</body>
</html>
