<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>

<!-- #include virtual="config.inc" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>
   
   
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
    <%
    
        mc.Open();
        MySqlCommand mcommbt = new MySqlCommand("SELECT * FROM admin", mc);
        MySqlDataReader mdrbt = mcommbt.ExecuteReader();
        mdrbt.Read();
        
        %>
   <%= mdrbt["blogtit"] %>
   <% 
       Session["titoloblog"] = mdrbt["blogtit"];
       mc.Close();
       mdrbt.Close();
        %>
    </title>
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
    else
    {
        document.write('<link rel="Stylesheet" href="./styles/style1280.css" type="text/css" media="all" /> ');
    }
        
    </script>
         
    
  
            
            
           
    <script language="javascript" src="tooltip.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        function validaric() {
            var a = document.formric.txtric.value;
            if (a.length < 4) {
                document.getElementById("avvric").innerHTML = "<b style='color: red'>You must enter at least 4 chars</b>";
                return false;
            }
            return true;
        }
    
    </script>
   </head>
<body>

   
   
<div id="container">
   
   <table id="tblg">
   <!-- #include virtual="logo.html" -->
   </table>
   <table id="latlogin" width="180">
   <% 
       if (Request.Cookies["ut"] == null)
       {
       %>
   <tr><td><img src="./images/icon_logout1.gif" />   <a href="login.aspx">Login</a> or <img src="./images/icon_register.gif" />  <a href="reg.aspx">Register</a></td></tr>
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
          <tr><td><img src="./images/Administrator-icon.png" />  <a href="./admin/Default.aspx">Admin Control Panel</a></td></tr>
          <%
                }
            mc.Close();
          
           %>
            
            <tr><td>Welcome back <a class="arb" onMouseover="ddrivetip('<b>Your Profile</b>', 100)"; onMouseout="hideddrivetip()"
 href="profuser.aspx?nick=<%= Request.Cookies["ut"].Value %>"><u><b><%= Request.Cookies["ut"].Value %></b></u></a>&nbsp;<img src="./images/user-prof.png" /></td></tr>   
            <tr><td> <img src="./images/icon_logout2.gif" />  <a href="logout.aspx">logout</a> </td></tr>
             </table>
             <table id="tbuo" width="180">
   <tr align="center"><td class="tit">Online Users</td></tr>
   
   <%
       
       //utenti online
       mc.Open();
       string quo = "INSERT INTO online(nick, lastlogin) VALUES (?nick, ?lastlogin)";
       MySqlCommand mcommuo = new MySqlCommand(quo, mc);
       mcommuo.Parameters.AddWithValue("?nick", Request.Cookies["ut"].Value);
       mcommuo.Parameters.AddWithValue("?lastlogin", Convert.ToString(DateTime.Now));
       mcommuo.ExecuteNonQuery();
       mc.Close();
       //mc.Open();
       //string quo1 = "SELECT DISTINCT nick FROM online WHERE lastlogin> '"+DateTime.Now.AddHours(-1.0)+"'";
       string quo1 = "SELECT MAX(id) AS mid FROM online GROUP BY nick";
           
       MySqlCommand mcommuo1 = new MySqlCommand(quo1, mc);
       //MySqlDataReader mdruo = mcommuo1.ExecuteReader();
       
       //DateTime ora = DateTime.Now;
       DataSet dsuo = new DataSet();
       MySqlDataAdapter mdauo = new MySqlDataAdapter(quo1, mc);
       mdauo.Fill(dsuo);
       int numuo = dsuo.Tables[0].Rows.Count;        
       //    while (mdruo.Read())
       DataRowCollection drcuo = dsuo.Tables[0].Rows;
       int[] mid = new int[drcuo.Count];
            
        %>
       
        <%
            int numusr = 0;
           for(int iuo=0; iuo<numuo; iuo++)
       {
           DataRow drapp = drcuo[iuo];  
           mid[iuo] = Convert.ToInt32(drapp["mid"]);
           }
           for(int ii=0; ii<mid.Length-1; ii++) 
           {
           string quo2 = "SELECT * FROM online WHERE id='"+mid[ii]+"'";
           DataSet dsuo2 = new DataSet();
           MySqlCommand mcommuo2 = new MySqlCommand(quo1, mc);
           MySqlDataAdapter mdauo2 = new MySqlDataAdapter(quo2, mc);
           mdauo2.Fill(dsuo2);
           DataRowCollection drcuo2 = dsuo2.Tables[0].Rows;
           DataRow druo2 = drcuo2[0];
           DateTime t1 = Convert.ToDateTime(druo2["lastlogin"]);
           DateTime t2 = DateTime.Now.AddMinutes(-3);
           TimeSpan ts = t1-t2;
           
               if(Math.Abs(ts.TotalMinutes)<3)
           {
               numusr++;   
                 %>
   <tr align="center"><td><a href="profuserpubb.aspx?nick=<%= druo2["nick"] %>"><%= druo2["nick"]%></a></td></tr>
   
   <%
            
           }    
               
       }
       //mc.Close();
        %>
        
       <tr align="center"><td><font size="2"> There are <b style="color: Red"><%= numusr%></b> active users</font></td></tr>
       </table>
                
          <%
                    }
            %>
            
  
  
   <table id="latsx" width="170">
    <!-- #include virtual="latsx.html" -->
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
        s = s.Replace("<script", " ");
        s = s.Replace("<%", " ");
        s = s.Replace("%&gt;", " ");
        s = s.Replace("<=", " ");            
       string sst = substr(Convert.ToString(dr["datan"]));
         
            %>
       <tr align="center"><td colspan="4" class="titn"><img class="imfolder" src="./images/news.png" />&nbsp;&nbsp;&nbsp;<%= dr["titolon"]  %>&nbsp - in <%= dr["categoria"] %></td></tr>
       <tr><td class="rn" colspan="4"><%= s %> <br /><br /><br />
       <div id="fb-root"></div>
        <script>    (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=161057123979453";
        fjs.parentNode.insertBefore(js, fjs);
      } (document, 'script', 'facebook-jssdk'));</script>
     
      <div class="fb-like" data-href="<%= Request.ServerVariables["SERVER_NAME"] %>/blogdotnet/displaycomm1.aspx?idn=<%= dr["idn"] %>" data-send="false" data-layout="button_count" data-width="250" data-show-faces="true"></div>
            </td></tr>
       
       <tr><td>Posted by <b><u><%= dr["autore"] %></u></b>&nbsp;<img src="./images/user-prof.png" /></td><td>&nbsp;</td><td>&nbsp;</td><td><%= sst  %></td></tr>
       <%
           if(Request.Cookies["ut"]!=null){
               
            %>
            
       <tr><td><a href="displaycomm1.aspx?idn=<%= dr["idn"] %>">Read Comments(<%
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
       <tr><td>&nbsp;</td></tr>
         <tr><td align="center" colspan="4" id="rcpy"><a href="http://www.dnproblog.com">dnProBlog Software @ www.dnproblog.com</a></td></tr> 
       </table>
   <table id="tbup" width="180">
   <tr align="center"><td class="tit" colspan="2"><b>Last Posts</b></td></tr>
   <!-- #include virtual="lastposts.aspx" -->
   </table>
   <table id="tbcat" width="180">
   <tr align="center"><td colspan="2" class="tit" ><b>Categories</b></td></tr>
   <!-- #include virtual="categories.aspx" -->
   </table>
   <table id="tbcal">
   <tr align="center"><td><u style="font-weight: bold;">Archive</u></td></tr>
  
   <!-- #include virtual="formcal.aspx" -->
   </table>
   <!-- #include virtual="archive.aspx" -->
   <!-- #include virtual="ric.aspx" -->
 
   <% 
       mc.Close();
           %>
           </div>
           
</body>
</html>
