<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Blog in ASP.NET</title>
     <script language="javascript" type="text/javascript">
        var largh = screen.width;
        var alt = screen.height;
        if((largh>1550))
        {
        document.write(' <link rel="Stylesheet" href="./styles/style.css" type="text/css" media="all" />');
        }
        if((largh>1250)&&(largh<1550))
        {
        document.write('<link rel="Stylesheet" href="./styles/style1280.css" type="text/css" media="all" /> ');
        }
        
    </script>
    <script language="javascript" src="tooltip.js" type="text/javascript">
    
    </script>
    <script runat="server">
    
        public string subpost(string ss)
        {
            if (ss.Length > 50)
            {
                ss = ss.Substring(0, 50);
                ss += ".............";
                return ss; 
            }
            else{
            return ss;
            }
        }
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
   <!-- #include virtual="config.inc" -->
   <table id="tblg">
   <!-- #include virtual="logo.html" -->
   </table>
   <!-- #include virtual="archive.aspx" -->
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
            
             mc.Open();
             MySqlDataReader mdrad1;
             
                 string su = Request.Cookies["ut"].Values[0].ToString();
                 string pu = Request.Cookies["utt"].Values[0].ToString();
                 Aute a = new Aute(su, pu, mc);
                 mdrad1 = a.aut();
                 bool vb = mdrad1.Read();
                 if (vb)
                 {            
            
          %>
          <tr><td><a href="./admin/Default.aspx">Admin Control Panel</a>&nbsp;<img src="./images/Administrator-icon.png" /></td></tr>
          <%
                }
            mc.Close();
             
           %>
            
            <tr><td>Welcome back <a onMouseover="ddrivetip('<b>Your Profile</b>', 100)"; onMouseout="hideddrivetip()"
 href="profuser.aspx?nick=<%= Request.Cookies["ut"].Value %>"><u><b><%= Request.Cookies["ut"].Value %></b></u></a>&nbsp;<img src="./images/user-prof.png" /> </td></tr>   
            <tr><td><a href="logout.aspx">logout</a> </td></tr>
            <%
       
       }
            %>
            
   </table>
   <table id="latsx" width="170">
    <!-- #include virtual="latsx.html" -->
   </table>
    <!-- #include virtual="ric.aspx" -->
   <table id="tbcal">
   <tr align="center"><td><u style="font-weight: bold;">Archive</u></td></tr>
   <!-- #include virtual="formcal.aspx" -->
   </table>
   <table id="tbnews" width="660" cellpadding="15">
   <% 
       
       //string nick = Request.Cookies["ut"].Value;
       DataSet ds = new DataSet();
       MySqlDataAdapter mda = new MySqlDataAdapter("SELECT * FROM news WHERE idn<=(SELECT MAX(idn) FROM news) AND idn>=(SELECT MAX(idn)-5 FROM news)", mc);
       mda.Fill(ds);
       DataTable dt = ds.Tables[0];
       DataRowCollection drc = dt.Rows;
       int nr = drc.Count;
       for(int i=nr-1; i>=0; i--)
       {
        DataRow dr = drc[i];
        string s = Convert.ToString(dr["teston"]);
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
        s = s.Replace(Environment.NewLine, "<br/>");
               
       string sst = substr(Convert.ToString(dr["datan"]));
           %>
       <tr align="center"><td colspan="5" class="titn"><img src="./images/news.png" />&nbsp;&nbsp;&nbsp;<%= dr["titolon"]  %>&nbsp - in <%= dr["categoria"] %></td></tr>
       <tr><td class="rn" colspan="5"><%= s %> 
       <br /><br /><br />
       <div id="fb-root"></div>
        <script>    (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=161057123979453";
        fjs.parentNode.insertBefore(js, fjs);
      } (document, 'script', 'facebook-jssdk'));</script>
     
      <div class="fb-like" data-href="http://localhost:84/blogdotnet/displaycomm.aspx?idn=<%= dr["idn"] %>" data-send="false" data-layout="button_count" data-width="250" data-show-faces="true"></div>
       </td></tr>
       
       <tr><td>Posted by <b><u><%= dr["autore"]%></u></b>&nbsp;<img src="./images/user-prof.png" /> </td><td>&nbsp;</td><td>&nbsp;</td><td><%= sst  %></td></tr>
       <%
           if(Request.Cookies["ut"]!=null){
               
            %>
            
       <tr><td><a href="displaycomm.aspx?idn=<%= dr["idn"] %>">Read Comments(<%
          string qcont = "SELECT * FROM commenti WHERE idn='" + dr["idn"] + "'";
          DataSet dat = new DataSet();
          MySqlCommand myscomm = new MySqlCommand(qcont, mc);
          MySqlDataAdapter mysda = new MySqlDataAdapter(myscomm);
          mysda.Fill(dat);
          DataTable dtab = dat.Tables[0];
          DataRowCollection drcoll = dtab.Rows;
          int numcomm = drcoll.Count;                         
                                              %>
       <%= numcomm %>)</a></td><td>&nbsp;</td><td>&nbsp;</td><td><a href="formcomm.aspx?idn=<%=dr["idn"] %>&nck=<%= Request.Cookies["ut"].Value  %>">Add Comment</a></td></tr>
       <%
              
           }
          
       }
        %>
      
   </table>
    <table id="tbup" width="180">
    <tr class="tit" align="center"><td>Post</td></tr>
      <%
       try {
       mc.Open();
       string idc = Request.QueryString["idc"];
       string qps = "SELECT * FROM commenti WHERE idc='" + idc + "'";
       MySqlCommand mcommc = new MySqlCommand(qps, mc);
       MySqlDataReader mdrc = mcommc.ExecuteReader();
       mdrc.Read();
       string s = Convert.ToString(mdrc["testoc"]);
       s = s.Replace("[B]", "<b>");
       s = s.Replace("[/B]", "</b>");
       s = s.Replace("[U]", "<u>");
       s = s.Replace("[/U]", "</u>");
       s = s.Replace("[I]", "<i>");
       s = s.Replace("[/I]", "</i>");
       s = s.Replace("[URL=http://", "<a href=http://");
       s = s.Replace(" ]", ">");
       s = s.Replace("[/URL]", "</a>");     
                %>
     <tr align="center"><td><b><%= mdrc["nick"]%>&nbsp;<%= mdrc["datac"]%></b></td></tr>        
    <tr align="center"><td><%= subpost(s) %></td></tr> 
    <%
       mc.Close();
       mdrc.Close();
       }
       catch (Exception e)
       {
           Response.Redirect("Default.aspx");
       }
         %>        
     </table>
   <table id="tbcat" width="180">
   <tr align="center"><td colspan="2" class="tit" ><b>Categories</b></td></tr>
   <!-- #include virtual="categories.aspx" -->
   </table>
    
   <% 
       mc.Close();
           %>
</div>
</body>
</html>
