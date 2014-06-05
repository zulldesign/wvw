<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script language="javascript" src="tooltip.js" type="text/javascript">
    
    </script>
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
    <script language="javascript" type="text/javascript">
        function boldfin() {
            var t = window.prompt("Insert Text");
            document.fcomm.txt.value += "[B]"+t+"[/B]";
        }
        function sottolinfin() {
            var t = window.prompt("Insert Text");
            document.fcomm.txt.value += "[U]" + t + "[/U]";
        }
        function italicfin() {
            var t = window.prompt("Insert Text");
            document.fcomm.txt.value += "[I]" + t + "[/I]";
        }
        
        function aprifin()
    {
    win = window.open("pagsmil.aspx", "np","width=400,height=300")
      }
      function httpfin() {
          var t = window.prompt("Insert Text");
          var u = window.prompt("Insert url");
          document.fcomm.txt.value += "[URL="+u+" ]" + t + "[/URL]";
      }
     
      
      function valida() {
          var a = document.fcomm.txt.value;
          if (a == "") {
              document.getElementById("attz").innerHTML = "<b style='color: red;'>write the text</b>";
              return false;
          }
          return true;
      }
       
    </script>
    
    <script runat="server">
        public string substr(string st)
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

        public string sost(string sts)
        {
            Regex regEx = new Regex(@"[\n|\r]+");
            string ssst = regEx.Replace(sts, "<br/>");
            return ssst;
        }
        
    </script>
    
    <script runat="server">
        public class Aute
        {
            private string nick;
            private string passwd;
            private MySqlConnection mconn;
            public Aute(string u, string p, MySqlConnection conn)
            {
                nick = u;
                passwd = p;
                mconn = conn;
            }
            public MySqlDataReader aut()
            {
                //ConnManager1 cm = new ConnManager1("localhost", "blogdb", "root", "alex");
                //MySqlConnection conn = cm.mysql();
                mconn.Open();
                string q = "SELECT * FROM admin " +
                    " WHERE auid='" + nick + "' AND apwd='" + passwd + "'";
                MySqlCommand mcomm = new MySqlCommand();
                mcomm.CommandText = q;
                mcomm.Connection = mconn;
                MySqlDataReader mdr = mcomm.ExecuteReader();
                return mdr;
            }
        }
    
    </script>    
</head>
<body>
<div id="container">
    <table id="tbcal">
   <tr align="center"><td><u style="font-weight: bold;">Archive</u></td></tr>
   <!-- #include virtual="formcal.aspx" -->
   </table>
   <table id="tblg">
   <!-- #include virtual="logo.html" -->
   </table>
   <table id="latlogin" width="180">
   <% 
       if (Request.Cookies["ut"] == null)
       {
       %>
   <tr><td><a href="login.aspx">Login</a></td></tr>
   <%
       }
       else
       {
            %>
            <tr><td>Welcome back <b><u><%= Request.Cookies["ut"].Value %></u></b> </td></tr>   
            <tr><td><a href="logout.aspx">logout</a> </td></tr>
            <%
       
       }
            %>
            
   </table>
   <table id="latsx" width="170">
    <!-- #include virtual="latsx.html" -->
   </table>
   <!-- #include virtual="config.inc" -->
  
    <table id="tbnews" width="660" cellpadding="15">
        <%
            
            string su = Request.Cookies["ut"].Values[0].ToString();
            string pu = Request.Cookies["utt"].Values[0].ToString();
            Aute a = new Aute(su, pu, mc);
            MySqlDataReader mdrad = a.aut();
            bool vb = mdrad.Read();
            mc.Close();  
                try
                {
                    mc.Open();
                    string idn = Request.QueryString["idn"];
                    string idu = Request.QueryString["idu"];
                    Session["idn"] = idn;
                    Session["idu"] = idu;
                    string qs = "SELECT * FROM news WHERE idn=" + idn;
                    MySqlCommand mcomms = new MySqlCommand(qs, mc);
                    MySqlDataReader mdrs = mcomms.ExecuteReader();
                    mdrs.Read();
                    string ss = Convert.ToString(mdrs["teston"]);
                   
                    ss = ss.Replace("[B]", "<b>");
                    ss = ss.Replace("[/B]", "</b>");
                    ss = ss.Replace("[U]", "<u>");
                    ss = ss.Replace("[/U]", "</u>");
                    ss = ss.Replace("[I]", "<i>");
                    ss = ss.Replace("[/I]", "</i>");
                    ss = ss.Replace("[URL=http://", "<a href=http://");
                    ss = ss.Replace(" ]", ">");
                    ss = ss.Replace("[/URL]", "</a>");
                    ss = ss.Replace("[IMG SRC=", "<img src=");
                    ss = ss.Replace(Environment.NewLine, "<br />");
                    //ss = sost(ss);
                 
                    string sst = substr(Convert.ToString(mdrs["datan"]));
                    string sn = Request.ServerVariables["SERVER_NAME"];
         %>
       <tr align="center"><td colspan="4" class="titart"><img src="images/news.png" />&nbsp;&nbsp; <%= mdrs["titolon"]%>&nbsp;&nbsp;- in <%= mdrs["categoria"]%></td></tr>  
       <tr><td class="rn" colspan="4"><%= ss %><br /><br />
       <div id="fb-root"></div>
        <script>            (function(d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id)) return;
                js = d.createElement(s); js.id = id;
                js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=161057123979453";
                fjs.parentNode.insertBefore(js, fjs);
            } (document, 'script', 'facebook-jssdk'));</script>
     
      <div class="fb-like" data-href="<%= sn %>/blogdotnet/displaycomm.aspx?idn=<%= mdrs["idn"] %>" data-send="false" data-layout="button_count" data-width="250" data-show-faces="true"></div>
       
        </td></tr>
       <tr><td>&nbsp;</td></tr>
       
       <tr><td>Posted by <b><u><%= mdrs["autore"]%></u></b>&nbsp;<img src="./images/user-prof.png" /></td><td><%= sst%></td></tr>
       <tr><td colspan="4">&nbsp;</td></tr>
       <tr><td><a href="prev.aspx?">Previous</a></td><td><a href="next.aspx?id=1">Next</a></td></tr>
       <tr><td><a id="addcomm" href="formcomm.aspx?idn=<%= Request.QueryString["idn"] %>&nck=<%= Request.Cookies["ut"].Value  %>">Add Comment</a></td></tr>
       <tr><td><a href="displaycomm1.aspx?idn=<%= mdrs["idn"] %>">With Pagination</a></td></tr>
       <tr><td colspan="4"><hr style="color: Green;  border-width: medium;" /></td></tr>
       <%  
            mdrs.Close();
            mc.Close();

            string id = Request.QueryString["idn"];
            string qcs = "SELECT * FROM commenti WHERE idn='" + id + "' ORDER BY idc";

            MySqlCommand mcomm = new MySqlCommand(qcs, mc);
            DataSet ds = new DataSet();
            MySqlDataAdapter mda = new MySqlDataAdapter(mcomm);
            mda.Fill(ds);
            DataTable dt = ds.Tables[0];
            DataRowCollection drc = dt.Rows;
            int nr = drc.Count;
            for (int i = nr - 1; i >= 0; i--)
            {

                DataRow dr = drc[i];
                string qq = "SELECT * FROM utenti WHERE nick='" + dr["nick"] + "'";
                MySqlConnection mc1 = mc;
                mc1.Open();
                DataSet ddss = new DataSet();
                MySqlDataAdapter mdau = new MySqlDataAdapter(qq, mc1);
                mdau.Fill(ddss);
                DataTable ddtt = ddss.Tables[0];
                DataRowCollection drcu = ddtt.Rows;
                DataRow dru = drcu[0];
                string s = Convert.ToString(dr["testoc"]);
                s = s.Replace("[B]", "<b>");
                s = s.Replace("[/B]", "</b>");
                s = s.Replace("[U]", "<u>");
                s = s.Replace("[/U]", "</u>");
                s = s.Replace("[I]", "<i>");
                s = s.Replace("[/I]", "</i>");
                s = s.Replace("[URL=http://", "<a href=http://");
                s = s.Replace(" ]", ">");
                s = s.Replace("[/URL]", "</a>");
                s = s.Replace("[IMG SRC=", "<img src=");
                
                // s = sost(s);  
                s = s.Replace(Environment.NewLine, "<br/>");
                  
                 %>
               
            <tr><td><img src="images/user.png" />&nbsp;<a href="profuserpubb.aspx?nick=<%= dr["nick"] %>"><%= dr["nick"]%></a>
            
            <%
                if (vb)
                {
                 %>
            
            
            &nbsp;&nbsp;<a title="Delete comment" href="delcomm.aspx?idc=<%= dr["idc"] %>"><img  src="./images/Button-Close-icon.png" /></a>
            <%
                }
                     %>
            </td><td><%= dr["datac"]%></td></tr>
            <%
            string st = s.Replace("&lt;script", " ");
            st = st.Replace("&lt;%", " ");
            st = st.Replace("%&gt;", " ");       
            st = HttpUtility.HtmlDecode(st);
                    %>
            <tr><td colspan="4"><%= st%></td></tr>
            <tr><td colspan="3"><hr style="color: #FF7000;" /></td></tr>
            <% 
            mc.Close();
            }
                }
                catch (Exception e)
                {
                    Response.Redirect("Default.aspx");
                }
             
                
               %>
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
                <tr><td><a id="addcomm" href="formcomm.aspx?idn=<%= Request.QueryString["idn"] %>&nck=<%= Request.Cookies["ut"].Value  %>">Add Comment</a></td></tr>   
            
            <%
       
       }
            %>
           <tr><td align="center" colspan="4" id="rcpy"><a href="javascript: history.go(-1)" id="back" title="Go back" href="Default.aspx">Back</a></td></tr>  
     </table>    
      <table id="tbup" width="180">
   <tr align="center"><td class="tit" colspan="2"><b>Last Posts</b></td></tr>
   <!-- #include virtual="lastposts.aspx" -->
   </table>
   <table id="tbcat" width="180">
   <tr align="center"><td colspan="2" class="tit" ><b>Categories</b></td></tr>
   <!-- #include virtual="categories.aspx" -->
   </table>
   </div>
</body>
</html>
