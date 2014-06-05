<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
   <link rel="Stylesheet" href="./styles/style.css" type="text/css" media="all" />
</head>
<body>
    <!-- #include virtual="config.inc" -->
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
            <tr><td>Welcome back <u><b><%= Request.Cookies["ut"].Value %></b></u> </td></tr>   
            <tr><td><a href="logout.aspx">logout</a> </td></tr>
            <%
       
       }
            %>
            
   </table>
   <table id="latsx" width="150">
    <!-- #include virtual="latsx.html" -->
   </table>
   <table id="tbnews" width="600">
   <%
       //string nick = Request.Cookies["ut"].Value;
       try
       {
           DataSet ds = new DataSet();
           MySqlDataAdapter mda = new MySqlDataAdapter("SELECT * FROM news WHERE idn<=(SELECT MAX(idn) FROM news) AND idn>(SELECT MAX(idn)-5 FROM news)", mc);
           mda.Fill(ds);
           DataTable dt = ds.Tables[0];
           DataRowCollection drc = dt.Rows;
           int nr = drc.Count;
           for (int i = nr - 1; i >= 0; i--)
           {
               DataRow dr = drc[i];
            
       %>
       <tr align="center"><td colspan="2" class="tit"><%= dr["titolon"]%>&nbsp;&nbsp;in <%= dr["categoria"]%></td></tr>
       <tr><td><%= dr["teston"]%> </td></tr>
       <tr><td>&nbsp;</td></tr>
       <tr><td>Posted by <%= dr["autore"]%> </td><td><%= dr["datan"]%></td></tr>
       <tr><td>&nbsp;</td></tr>
       <%
       if (Request.Cookies["ut"] != null)
       {
               
            %>
       <tr><td><a href="displaycomm1.aspx?idn=<%= dr["idn"] %>">Read Comments</a></td><td><a href="formcomm.aspx?idn=<%=dr["idn"] %>&nck=<%= Request.Cookies["ut"].Value  %>">Add Comment</a></td></tr>
       <%
       }
           }
        %>
   </table>
   <table id="tbup" width="180">
      <%
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
     <tr><td><%= mdrc["nick"]%>&nbsp;<%= mdrc["datac"]%></td></tr>        
    <tr><td><%= s %></td></tr> 
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
</body>
</html>
