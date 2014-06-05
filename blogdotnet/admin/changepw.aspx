<%@ Page Language="C#" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
     string spw = Request.Form["apwd"];
     string pw = indicipw(spw);
     mc.Open();
     string qv = "SELECT * FROM admin";
     MySqlCommand mcommval = new MySqlCommand(qv, mc);
     MySqlDataReader mdrval = mcommval.ExecuteReader();
     mdrval.Read();
     Session["valpw"] = Convert.ToString(mdrval["apwd"]);
     mc.Close();            
     string q = "UPDATE admin SET apwd='" + pw + "'";
     mc.Open();
     MySqlCommand mcomm = new MySqlCommand(q, mc);
     mcomm.ExecuteNonQuery();
     mc.Close();
     mc.Open();
     string q1 = "SELECT * FROM admin";
     MySqlCommand mcomm1 = new MySqlCommand(q1, mc);
     MySqlDataReader mdr1 = mcomm1.ExecuteReader();
     mdr1.Read();
     
     string q2 = "UPDATE utenti SET password='" + pw + "' WHERE nick='"+mdr1.GetString("auid")+"' AND password='"+Session["valpw"]+"'";
     mc.Close();
     mc.Open();
     MySqlCommand mcomm2 = new MySqlCommand(q2, mc);
     mcomm2.ExecuteNonQuery();
     Response.Redirect("./index.aspx");

     }
     else
     {
         Response.Redirect("../Default.aspx");
     } 
        
        %>
         
</body>
</html>
