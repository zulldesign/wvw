<%@ Page Language="C#" ValidateRequest="false" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Net.Mail" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
   <!-- #include virtual="config.inc" -->
    <% 
       
        DateTime d = DateTime.Now;
        int a = d.Year;
        int m = d.Month;
        int g = d.Day;
        int h = d.Hour;
        int min = d.Minute;
        int s = d.Second;
        string dat = a + "-" + m + "-" + g + " " + h + ":" + min + ":" + s;
        int idn = Convert.ToInt32(Session["idn"]);
        int idu = Convert.ToInt32(Session["idu"]); 
        string n = Request.Cookies["ut"].Value;
        mc.Open();
        string t = Request.Form["txt"];
        try
        {
        if (t.IndexOf(" ", 0) == -1)
        {
            Response.Redirect("errspam.html");
        }
        
           
        //t = t.Replace("'", "\\'");  
        StringBuilder sb = new StringBuilder(HttpUtility.HtmlEncode(t));
   
        sb.Replace(":11", "<img src='./images/smile/smile1/11.gif'></img>");
        sb.Replace(":12", "<img src='./images/smile/smile1/12.gif'></img>");
        sb.Replace(":13", "<img src='./images/smile/smile1/13.gif'></img>");
        sb.Replace(":14", "<img src='./images/smile/smile1/14.gif'></img>");
        sb.Replace(":21", "<img src='./images/smile/smile1/21.gif'></img>");
        sb.Replace(":22", "<img src='./images/smile/smile1/22.gif'></img>");
        sb.Replace(":23", "<img src='./images/smile/smile1/23.gif'></img>");
        sb.Replace(":24", "<img src='./images/smile/smile1/24.gif'></img>");
        sb.Replace(":31", "<img src='./images/smile/smile1/31.gif'></img>");
        sb.Replace(":32", "<img src='./images/smile/smile1/32.gif'></img>");
        sb.Replace(":33", "<img src='./images/smile/smile1/33.gif'></img>");
        sb.Replace(":34", "<img src='./images/smile/smile1/34.gif'></img>");
        sb.Replace(":41", "<img src='./images/smile/smile1/41.gif'></img>");
        sb.Replace(":42", "<img src='./images/smile/smile1/42.gif'></img>");
        sb.Replace(":43", "<img src='./images/smile/smile1/43.gif'></img>");
        sb.Replace(":44", "<img src='./images/smile/smile1/44.gif'></img>");
        sb.Replace(":51", "<img src='./images/smile/smile1/51.gif'></img>");
        sb.Replace(":52", "<img src='./images/smile/smile1/52.gif'></img>");
        sb.Replace(":53", "<img src='./images/smile/smile1/53.gif'></img>");
        sb.Replace(":54", "<img src='./images/smile/smile1/54.gif'></img>");
        sb.Replace(":61", "<img src='./images/smile/61.gif'></img>");
        sb.Replace(":62", "<img src='./images/smile/62.gif'></img>");
        sb.Replace(":63", "<img src='./images/smile/63.gif'></img>");
        sb.Replace(":64", "<img src='./images/smile/64.gif'></img>");
        sb.Replace(":71", "<img src='./images/smile/71.gif'></img>");
        sb.Replace(":72", "<img src='./images/smile/72.gif'></img>");
        sb.Replace(":73", "<img src='./images/smile/73.gif'></img>");
        sb.Replace(":74", "<img src='./images/smile/74.gif'></img>");
        sb.Replace(":81", "<img src='./images/smile/81.gif'></img>");
        sb.Replace(":82", "<img src='./images/smile/82.gif'></img>");
        sb.Replace(":83", "<img src='./images/smile/83.gif'></img>");
        sb.Replace(":84", "<img src='./images/smile/84.gif'></img>");
        sb.Replace(":91", "<img src='./images/smile/91.gif'></img>");
        sb.Replace(":92", "<img src='./images/smile/92.gif'></img>");
        sb.Replace(":93", "<img src='./images/smile/93.gif'></img>");
        sb.Replace(":94", "<img src='./images/smile/94.gif'></img>");
        
              
        sb.Replace("&lt;b&gt;", "<b>");
        sb.Replace("&lt;/b&gt;", "</b>");
        sb.Replace("&lt;i&gt;", "<i>");
        sb.Replace("&lt;/i&gt;", "</i>");
        
        
        
        string qi = "INSERT INTO commenti(idn, idu, nick, datac, testoc) ";
        qi += "VALUES(?idn, ?idu, ?n, ?dat, ?t)";
        
            MySqlCommand mcomm = new MySqlCommand(qi, mc);
            mcomm.Parameters.AddWithValue("?idn", idn);
            mcomm.Parameters.AddWithValue("?idu", idu);
            mcomm.Parameters.AddWithValue("?n", n);
            mcomm.Parameters.AddWithValue("?dat", dat);
            mcomm.Parameters.AddWithValue("?t", sb);
            MySqlDataReader mdr = mcomm.ExecuteReader();
            mdr.Close();
            mc.Close();
            mc.Open();
            string qs = "SELECT * FROM news WHERE idn='"+idn+"'";
            MySqlCommand mcoma = new MySqlCommand(qs, mc);
            MySqlDataReader mdrem = mcoma.ExecuteReader();
            mdrem.Read();
           
            if (mdrem.GetString("msgemail") == "yes")
            {
                try
                {
                    mc.Close();
                    mc.Open();
                    string qs1 = "SELECT * FROM admin";
                    MySqlCommand mcoma1 = new MySqlCommand(qs1, mc);
                    MySqlDataReader mdrem1 = mcoma1.ExecuteReader();
                    mdrem1.Read();
                    MailMessage mm = new MailMessage();
                    mm.From = new MailAddress(mdrem1.GetString("aemail"));
                    mm.To.Add(new MailAddress(mdrem1.GetString("aemail")));
                    mm.Subject = n + " wrote a new Message";
                    mm.Body = t;
                    SmtpClient scl = new SmtpClient(mdrem1.GetString("emailsrv"));
                    scl.Send(mm);
                    //mm.UrlContentLocation = "http://localhost:84/blogdotnet/displaycomm.aspx?idn=" + idn;
                    //SmtpMail.SmtpServer = mdrem1.GetString("emailsrv");
                    //SmtpMail.Send(mm);
                    mc.Close();
                }
                catch (Exception e)
                {
                    Response.Write(e.Message);
                }
            }
            Response.Redirect("displaycomm1.aspx?idn=" + idn);
            
        }
        catch (Exception e)
        {
            
            
        }
                    %>
</body>
</html>
