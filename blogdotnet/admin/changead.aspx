<%@ Page Language="C#" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script runat="server">
     public string indicipw(string pw)
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
 <% 
     if (Request.Cookies["adm"] != null)
     {
         string uu = Request.Cookies["adm"].Value;  
      %>
 <!-- #include virtual="../config.inc -->
    <%
      
     string emu = Request.Form["aemail"];
     string bt = Request.Form["blogtit"];
     string msrv = Request.Form["ms"];
     string q = "UPDATE admin SET aemail='" + emu + "', blogtit='"+bt+"', emailsrv='" + msrv + "'";
     mc.Open();
     MySqlCommand mcomm = new MySqlCommand(q, mc);
     mcomm.ExecuteNonQuery();
     MySqlDataReader mdrcad = mcomm.ExecuteReader();
     mdrcad.Read();        
     mc.Close();
     
         
     Response.Redirect("./index.aspx");

     }
     else
     {
         Response.Redirect("../Default.aspx");
     } 
        
        %>
         
</body>
</html>
