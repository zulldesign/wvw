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
         public string subs(string st)
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
         public string lastpostut(MySqlConnection mcn, int idc)
         {
             //mcn.Open();
             //string idc = Request.QueryString["idc"];
             string qps = "SELECT * FROM commenti WHERE idc='" + idc + "'";
             MySqlCommand mcommc = new MySqlCommand(qps, mcn);
             //MySqlDataReader mdrc = mcommc.ExecuteReader();
             //mdrc.Read();
             DataSet dslp = new DataSet();
             MySqlDataAdapter mdalp = new MySqlDataAdapter(qps, mcn);
             mdalp.Fill(dslp);
             DataTable dtlp = dslp.Tables[0];
             DataRowCollection drclp = dtlp.Rows;
             DataRow drlp = drclp[0];
             string s = Convert.ToString(drlp["testoc"]);
             s = s.Replace("[B]", "<b>");
             s = s.Replace("[/B]", "</b>");
             s = s.Replace("[U]", "<u>");
             s = s.Replace("[/U]", "</u>");
             s = s.Replace("[I]", "<i>");
             s = s.Replace("[/I]", "</i>");
             s = s.Replace("[URL=http://", "<a href=http://");
             s = s.Replace(" ]", ">");
             s = s.Replace("[/URL]", "</a>");
             return s;
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
   <tr align="center"><td colspan="2" class="titn"><b>News - <%= Request.QueryString["cat"] %></b></td></tr>
   <% 
       try
       {
           mc.Open();
           string qnws = "SELECT * FROM news WHERE categoria='" + Request.QueryString["cat"] + "'";
           MySqlCommand mcommnws = new MySqlCommand(qnws, mc);
           MySqlDataReader mdrnews = mcommnws.ExecuteReader();
           while (mdrnews.Read())
           {
               string st = Convert.ToString(mdrnews["datan"]);
           %>
       <tr><td><img src="./images/news.png" />&nbsp;&nbsp; <a href="readnews.aspx?idn=<%= mdrnews["idn"] %>"><%= mdrnews["titolon"]%></a></td><td><%= subs(st)%><br /></td></tr>
       
       <%
       
       }
           mdrnews.Close();
           mc.Close();
       }
       catch (Exception e)
       {
           Response.Redirect("Default.aspx");
       }
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
