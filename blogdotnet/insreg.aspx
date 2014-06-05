<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Net.Mail" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

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

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <!-- #include virtual="config.inc" -->
    <%
        int nv = Convert.ToInt32(Session["numr"]);
        int np = 0;
        try
        {
            np = Convert.ToInt32(Request.Form["cod"]);
        }
        catch (System.FormatException fe)
        {
            Response.Redirect("errcaptcha.html");
        }
        if (np != nv)
        {
            Response.Redirect("errcaptcha.html");
        }
        else
        {
            mc.Open();
            DateTime d = DateTime.Now;
            int a = d.Year;
            int m = d.Month;
            int g = d.Day;
            int h = d.Hour;
            int min = d.Minute;
            int s = d.Second;
            string dat = a + "-" + m + "-" + g + " " + h + ":" + min + ":" + s;
            string nick = Request.Form["nick"];
            string spwd = Request.Form["pwd"];
            string pwd = indicipasswd(spwd);
            string email = Request.Form["email"];
            string loc = Request.Form["loc"];
            if (nick == null && pwd == null && email == null)
            {
                Response.Redirect("errgen.aspx");
            }
            else
            {
                
              
                  
                    
                    string qs1 = "SELECT * FROM admin";
                    MySqlCommand mcoma1 = new MySqlCommand(qs1, mc);
                    MySqlDataReader mdrem1 = mcoma1.ExecuteReader();
                    mdrem1.Read();
                    string t = "Your Account at " + mdrem1["blogtit"]+ ": \n\n Userid = " + nick + "\n\n Password = " + spwd;
                    MailMessage mm = new MailMessage();
                    mm.From = new MailAddress(mdrem1.GetString("aemail"));
                    mm.To.Add(new MailAddress(email));
                    
                    mm.Subject = "Your Account";
                    mm.Body = t;
                    
                    SmtpClient scl = new SmtpClient(mdrem1.GetString("emailsrv"));
                    
                    scl.Send(mm);
                  
                    mc.Close();
                
                
                
                
                string qi = "INSERT INTO utenti(nick, password, email, locazione, datareg) ";
                qi += "VALUES (?nick, ?password, ?email, ?locazione, ?datareg)";
                try
                {
                    mc.Open();
                    MySqlCommand mcomm = new MySqlCommand(qi, mc);
                    MySqlParameter mpar = new MySqlParameter();
                    mpar.ParameterName = "?nick";
                    mpar.Value = nick;
                    mpar.MySqlDbType = MySqlDbType.String;
                    mcomm.Parameters.Add(mpar);

                    mpar = new MySqlParameter();
                    mpar.ParameterName = "?password";
                    mpar.Value = pwd;
                    mpar.MySqlDbType = MySqlDbType.String;
                    mcomm.Parameters.Add(mpar);
                   
                    mpar = new MySqlParameter();
                    mpar.ParameterName = "?email";
                    mpar.Value = email;
                    mpar.MySqlDbType = MySqlDbType.String;
                    mcomm.Parameters.Add(mpar);

                    mpar = new MySqlParameter();
                    mpar.ParameterName = "?locazione";
                    mpar.Value = loc;
                    mpar.MySqlDbType = MySqlDbType.String;
                    mcomm.Parameters.Add(mpar);
                    
                    mpar = new MySqlParameter();
                    mpar.ParameterName = "?datareg";
                    mpar.Value = dat;
                    mpar.MySqlDbType = MySqlDbType.String;
                    mcomm.Parameters.Add(mpar);
                    
                    
                    mcomm.ExecuteNonQuery();
                    
                }
                catch (Exception e)
                {
                    Session["errins"] = e.Message;
                    Response.Redirect("errgen.aspx");
                    
                }
                Session["ut"] = nick;
                Session["pw"] = pwd;
                HttpCookie ck = new HttpCookie("ut", nick);
                HttpCookie ck1 = new HttpCookie("utt", pwd);
                Response.Cookies.Add(ck);
                Response.Cookies.Add(ck1);
                TimeSpan ts = new TimeSpan(365, 0, 0, 0);
                Response.Redirect("afterreg.aspx");
            }
        }      
    %>
</body>
</html>
