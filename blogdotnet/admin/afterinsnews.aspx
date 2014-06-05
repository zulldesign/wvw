
<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link rel="Stylesheet" href="styleacp.css" type="text/css" />
    <script language="javascript" src="ctrclient.js" type="text/javascript">
       
    </script>
</head>
<body>
   
   <%
       string u = "admin";
       string p = "wpt";
       string uid = Request.Form["uid"];
       string pwd = Request.Form["pwd"];
       if (uid != u && pwd != p)
       {
           if (Request.Cookies["adm"] == null)
           {
               Response.Redirect("erracp.html");
           }
       }
       if (uid == u && pwd == p || Request.Cookies["adm"] != null)
       {
           HttpCookie c = new HttpCookie("adm", u);
           Response.Cookies.Add(c);
           TimeSpan ts = new TimeSpan(365, 0, 0, 0);
           c.Expires = DateTime.Now + ts; 
        %>
<div id="container">
<table id="tblg">
    <!-- #include virtual="toplogo.html -->
</table>
<table id="menulat">
    <!-- #include virtual="menulat.html -->
<table>   
<table id="cntacp" width="500">
    <tr><td><h4>News Added&nbsp; <a href="index.aspx">back</a></h4></td></tr>
</table> 
</div>
<%
       }
      
            %>
</body>
</html>
