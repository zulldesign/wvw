
<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
       <script language="javascript" type="text/javascript">
        var largh = screen.width;
        var alt = screen.height;
        if((largh>1550))
        {
        document.write(' <link rel="Stylesheet" href="./styles/style.css" type="text/css" media="all" />');
        }
        else if((largh>1250)&&(largh<1550))
        {
        document.write('<link rel="Stylesheet" href="./styles/style1280.css" type="text/css" media="all" /> ');
        }
        else {
            document.write('<link rel="Stylesheet" href="./styles/style1280.css" type="text/css" media="all" /> ');
        }
    </script>
     <script runat="server">
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
   <!-- #include virtual="config.inc" -->
   <table id="tbcal">
   <tr align="center"><td><u style="font-weight: bold;">Archive</u></td></tr>
   <!-- #include virtual="formcal.aspx" -->
   </table>
   <table id="tbnews" width="660" cellpadding="15">
   <tr align="center"><td class="titn"><b>News - <%= Request.QueryString["cat"] %></b></td></tr>
    <%
       mc.Open();
       string qnws = "SELECT * FROM news WHERE idn='"+Request.QueryString["idn"]+"'";
       MySqlCommand mcommnws = new MySqlCommand(qnws, mc);
       MySqlDataReader mdrnews = mcommnws.ExecuteReader();
       mdrnews.Read();
       string s = Convert.ToString(mdrnews["teston"]);
       s = s.Replace("[B]", "<b>");
       s = s.Replace("[/B]", "</b>");
       s = s.Replace("[U]", "<u>");
       s = s.Replace("[/U]", "</u>");
       s = s.Replace("[I]", "<i>");
       s = s.Replace("[/I]", "</i>");
       s = s.Replace("[URL=http://", "<a href=http://");
       s = s.Replace(" ]", ">");
       s = s.Replace("[/URL]", "</a>");
       s = s.Replace(Environment.NewLine, "<br/>");
       string trep = Convert.ToString(Session["testoric"]);
       s = s.Replace(trep, "<b style='background-color: #FFFF00'>"+trep+"</b>" );
           %>
       <tr><td class="rn"><%= s  %></td></tr>
       <%
       
       
       mdrnews.Close();
       mc.Close();
            %> 
            </table>
            <table id="tblg">
   <!-- #include virtual="logo.html" -->
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
            <tr><td>Welcome back <u><b><%= Request.Cookies["ut"].Value %></b></u>&nbsp;<img src="./images/user-prof.png" /> </td></tr>   
            <tr><td><a href="logout.aspx">logout</a> </td></tr>
            <%
       
       }
            %>
            
   </table>
    <table id="latsx" width="170">
    <!-- #include virtual="latsx.html" -->
   </table>
   <table id="tbup" width="180">
   <tr align="center"><td colspan="2" class="tit" ><b>Last Posts</b></td></tr>
   <!-- #include virtual="lastposts.aspx" -->
   </table>
   <table id="tbcat" width="180">
   <tr align="center"><td colspan="2" class="tit" ><b>Categories</b></td></tr>
   <!-- #include virtual="categories.aspx" -->
   </table>
   </div>
  
</body>
</html>
