
<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<%@ Import Namespace="paginaz2" %>

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
        public string substr(string st)
        {
            string str = st.Substring(0, 8);
            return str;
        }
    
    </script>
</head>
<body>
<div id="container">
   <table id="tblg">
   <!-- #include virtual="logo.html" -->
   </table>
   <table id="latlogin">
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
            <tr><td>Welcome back <u><b><%= Request.Cookies["ut"].Value %></b></u> </td></tr>   
            <tr><td><a href="logout.aspx">logout</a> </td></tr>
            <%
       
       }
            %>
            
   </table>
   <table id="latsx" width="170">
    <!-- #include virtual="latsx.html" -->
   </table>
   <!-- #include virtual="config.inc" -->
  
    <table id="tbnews" width="660" cellpadding="5">
        <%
        mc.Open();
        int idn = Convert.ToInt32(Session["idn"]);
        string qs = "SELECT * FROM news WHERE idn='" + idn+"'";
        MySqlCommand mcomms = new MySqlCommand(qs, mc);
        MySqlDataReader mdrs = mcomms.ExecuteReader();
        mdrs.Read();
         %>
       <tr align="center"><td colspan="2" class="titart"><%= mdrs["titolon"] %>&nbsp;&nbsp;in <%= mdrs["categoria"] %></td></tr>  
       <tr><td colspan="2" class="rn"><%= mdrs["teston"] %> </td></tr>
       <tr><td>&nbsp;</td></tr>
       <tr><td>Posted by <u><b><%= mdrs["autore"] %></b></u>
         <%
           for (int ii = 0; ii < 65; ii++)
           { 
            %>
            &nbsp;
            <%
           }
               string sd = substr(Convert.ToString(mdrs["datan"]));
                %>
              <%= sd %></td></tr>  
       <%
           int i = Convert.ToInt32(Request.QueryString["id"]);
           i = i - 1;
           
            %>
       <tr><td><a href="prev.aspx?id=<%= i %>">Previous</a>
       <%
           for (int ii = 0; ii < 72; ii++)
           { 
            %>
            &nbsp;
            <%
           }
                %>
       <a href="next.aspx?id=<%= i %>">Next</a></td></tr>
       <tr><td></td></tr>
       <%  
           mdrs.Close();
           string qcs = "SELECT * FROM commenti WHERE idn='" + idn + "' ORDER BY idc";
           MySqlCommand mcomm = new MySqlCommand(qcs, mc);
           DataSet ds = new DataSet();
           MySqlDataAdapter mda = new MySqlDataAdapter(mcomm);
           mda.Fill(ds);
           DataTable dt = ds.Tables[0];
           DataRowCollection drc = dt.Rows;
           int nr = drc.Count;
           
           try
           {
               Pagin pg = new Pagin(i, 4, "nick", "datac", "testoc", drc);
               string sp = pg.getPagin();
               string ss = Convert.ToString(sp);
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
              
               ss = ss.Replace(Environment.NewLine, "<br/>");
               
                %>
           
           <%= ss %>
          
          <%
           }
           catch (Exception e)
           {
               Response.Redirect("Default.aspx");
           }  
              
                
            %>
     </table>  
     </div>  
</body>
</html>
