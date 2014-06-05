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
    <script runat="server">
 public class Aute
 {
     private string nick;
     private string passwd;
     private MySqlConnection mconn;
     public  Aute(string u, string p, MySqlConnection conn)
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
         string q = "SELECT * FROM utenti " +
             "WHERE nick='" + nick + "' AND password='" + passwd +"'";
         MySqlCommand mcomm = new MySqlCommand();
         mcomm.CommandText = q;
         mcomm.Connection = mconn;
         MySqlDataReader mdr = mcomm.ExecuteReader();
         return mdr;
         }
 }
    
       
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
 <!-- #include virtual="config.inc" -->
    <%
        string uid = Request.Form["uid"];
        string spwd = Request.Form["pwd"];
        string pwd = indicipasswd(spwd);
        
        Aute a = new Aute(uid, pwd, mc);
        MySqlDataReader dr = a.aut();
            if (dr.Read())
            {
              HttpCookie ck = new HttpCookie("ut", uid);
              HttpCookie ck1 = new HttpCookie("utt", pwd);  
              Response.Cookies.Add(ck);
              Response.Cookies.Add(ck1);
              TimeSpan ts = new TimeSpan(365, 0, 0, 0);
              ck.Expires = DateTime.Now+ts;
              ck1.Expires = DateTime.Now + ts;         
              Response.Redirect("Default.aspx");
            }
            else
          {
            Response.Redirect("reg.aspx");
            }
            
        
     %>

</body>
</html>
