<%@ Page Language="C#" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link rel="Stylesheet" href="styleacp.css" type="text/css" />
    <script src="ctrclient.js" language="javascript" type="text/javascript">
    </script>
    <script runat="server">
        public string passwd(string ipw)
        {
            string s = "abcdefghijklmnopqrstuvxyzABCDEFGHIJKLMNOPQRSTXYZ123456789";
            int lun = ipw.Length;
            string si = "";
            for (int j = 0; j < lun; j++)
            {
                string sc = "";
                for (int k = 0; k < s.Length; k++)
                {

                    if (ipw[j].Equals(s[k]))
                    {
                        int ic = k;
                        sc = Convert.ToString(ic);
                    }
                }
                si = si + sc;
            }
            return si;
        }
    </script>
    
</head>
<body>
<%
      
    if (Request.Cookies["adm"] != null)
    {
        string uu = Request.Cookies["adm"].Value;  
      %>
 <!-- #include virtual="../config.inc -->
<%
    mc.Open();
    string q = "SELECT * FROM admin";
    MySqlCommand mcomm = new MySqlCommand(q, mc);
    MySqlDataReader mdr = mcomm.ExecuteReader();
    mdr.Read();
    
         %>
<div id="container">
<table id="tblg">
    <!-- #include virtual="toplogo.html -->
</table>
<table id="menulat">
    <!-- #include virtual="menulat.html -->
    </table>
   
<form method="post" action="changead.aspx">
    <table id="tbad" width="310">
    <tr><td>Change email</td><td><input name="aemail" type="text" value="<%= mdr.GetString("aemail") %>" /> </td></tr>
    <tr><td>Change Title of blog</td><td><input name="blogtit" type="text" value="<%= mdr.GetString("blogtit") %>" /> </td></tr>
    <tr><td>Change Mail Server</td><td><input name="ms" type="text" value="<%= mdr.GetString("emailsrv") %>" /> </td></tr>
    <tr><td><input class="btn" type="submit" value="change" /></td></tr>
    </table>
    </form>
    <form method="post" action="changepw.aspx">
    <table id="tbad1" width="310">
    <tr><td>Change password</td><td><input name="apwd" type="text" value="Your new Password" /> </td></tr>
    <tr><td><input class="btn" type="submit" value="change" /></td></tr>
    </table>
    </form>
    </div>
    <%
    }
    else
    {
        Response.Redirect("../Default.aspx");
    }
              %>
</body>
</html>
