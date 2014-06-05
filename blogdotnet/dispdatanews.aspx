<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <script language="javascript" type="text/javascript">
        var largh = screen.width;
        var alt = screen.height;
        if ((largh > 1550)) {
            document.write(' <link rel="Stylesheet" href="./styles/style.css" type="text/css" media="all" />');
        }
        else if ((largh > 1250) && (largh < 1550)) {
            document.write('<link rel="Stylesheet" href="./styles/style1280.css" type="text/css" media="all" /> ');
        }
        else {
            document.write('<link rel="Stylesheet" href="./styles/style1280.css" type="text/css" media="all" /> ');
         }
    </script>
    <script runat="server">
        public string subst(string st)
        {
            string str = st;
            if (str.Length < 9)
            {
                str = str.Substring(0, 8);
            }
            else
            {
                str = str.Substring(0, 9);
            }
            return str;
        }
       protected void cal_SelectionChanged(object sender, EventArgs e)
       {
           string g = Convert.ToString(cal.SelectedDate.Day);
           string m = Convert.ToString(cal.SelectedDate.Month);
           string a = Convert.ToString(cal.SelectedDate.Year);
           string dt = a + "-" + m + "-" + g;
           Session["data"] = dt;
           Response.Redirect("dispdatanews.aspx");
       }
      
    </script>
    </head>
<body>

   <div id="container">
   <table id="latsx" width="170">
    <!-- #include virtual="latsx.html" -->
   </table>
   <table id="tbcal">
   <tr align="center"><td><u style="font-weight: bold;">Archive</u></td></tr>
   <!-- #include virtual="formcal.aspx" -->
   </table>
     <table id="latlogin" width="180">
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
            <tr><td>Welcome back <a onMouseover="ddrivetip('<b>Your Profile</b>', 100)"; onMouseout="hideddrivetip()"
 href="profuser.aspx?nick=<%= Request.Cookies["ut"].Value %>"><u><b><%= Request.Cookies["ut"].Value %></b></u></a>&nbsp;<img src="./images/user-prof.png" /> </td></tr>   
            <tr><td><a href="logout.aspx">logout</a> </td></tr>
            <%
       
       }
            %>
            
   </table>
   <!-- #include virtual="config.inc" -->
  <table id="tbnews" width="660" cellpadding="15">
  <tr align="center"><td class="titn" colspan="3">News&nbsp;&nbsp;<%= Session["data"] %></td></tr>
   <%   
       
        mc.Open();
        string qqd = "SELECT * FROM news WHERE datan='" + Session["data"] + "'";
        MySqlCommand mcommdt = new MySqlCommand(qqd, mc);
        MySqlDataReader mdrdt = mcommdt.ExecuteReader();
        while (mdrdt.Read())
        { 
          string st =  Convert.ToString(mdrdt["datan"]); 
        %>
        <tr><td><img src="./images/news.png" />&nbsp;&nbsp; <a href="readnews.aspx?idn=<%= mdrdt["idn"] %>"><%= mdrdt["titolon"] %></a></td><td><%= subst(st) %></td></tr>
      
        <%
            } 
        mc.Close();    
            %>
   </table>
    <table id="tblg">
   <!-- #include virtual="logo.html" -->
   </table>
   <table id="tbup" width="180">
   <tr align="center"><td colspan="2" class="tit">Last Posts</td></tr>
   <!-- #include virtual="lastposts.aspx" -->
   </table>
   <table id="tbcat" width="180">
   <tr align="center"><td colspan="2" class="tit" ><b>Categories</b></td></tr>
   <!-- #include virtual="categories.aspx" -->
   </table>
   </div>
</body>
</html>
