<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="Stylesheet" href="styleacp.css" type="text/css" />
    <script language="javascript" src="ctrclient.js" type="text/javascript">
       </script>
       
     <script runat="server">
        public string indicipasswd(string pw)
    { 
        string s = "abcdefghijklmnopqrstuvxyzABCDEFGHIJKLMNOPQRSTXYZ123456789";
        int lun = pw.Length;
        string si = "";
        for (int j = 0; j < lun; j++)
        {
            string sc = "";
            for (int k = 0; k < s.Length; k++)
            {
               
                if (pw[j].Equals(s[k]))
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
   <!-- #include virtual="../config.inc" -->
   <%  
       string qa = "SELECT * FROM admin";
       mc.Open();
       MySqlCommand mcomma = new MySqlCommand(qa, mc);
       MySqlDataReader mdra = mcomma.ExecuteReader();
       mdra.Read();
     
       string u = mdra.GetString("auid");
       string p = mdra.GetString("apwd"); 
       string uid = Request.Form["uid"];
       string pwd="";
       string spwd = Request.Form["pwd"];
       if (spwd != null)
       {
           pwd = indicipasswd(spwd);
       }
       
       
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
    <!-- #include virtual="cnt.html -->
</table> 
<%
       }
      
            %>
            </div>
</body>
</html>
