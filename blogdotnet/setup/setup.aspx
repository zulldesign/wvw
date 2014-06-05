<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Setup the Blog</title>
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
       DateTime d = DateTime.Now;
       int a = d.Year;
       int m = d.Month;
       int g = d.Day;
       int h = d.Hour;
       int min = d.Minute;
       int se = d.Second;
       string dat = a + "-" + m + "-" + g + " " + h + ":" + min + ":" + se;
       string nick = Request.Form["auid"];
       string spwd = Request.Form["apwd"];
       string email = Request.Form["aemail"];
       string bt = Request.Form["blogtit"];
       string loc = Request.Form["aloc"];
       string ms = Request.Form["ms"];

       string pwd = indicipasswd(spwd);

       //string f = Server.MapPath("queryblog.sql");
       //StreamReader osr = File.OpenText(f);
       //string s = osr.ReadToEnd();
       //osr.Close();
       
       try
       {
            //mc.Open();
            //MySqlCommand mcommand = new MySqlCommand(s, mc); 
            //mcommand.ExecuteNonQuery();
            //mc.Close();
           
           
            mc.Open();
                string qi = "INSERT INTO admin(auid, apwd, aemail, blogtit, alocazione, emailsrv) ";
                qi += "VALUES (?auid, ?apwd, ?aemail, ?blogtit, ?alocazione, ?emailsrv)";
                
                    MySqlCommand mcomm = new MySqlCommand(qi, mc);
                    MySqlParameter mpar = new MySqlParameter();
                    mpar.ParameterName = "?auid";
                    mpar.Value = nick;
                    mpar.MySqlDbType = MySqlDbType.String;
                    mcomm.Parameters.Add(mpar);

                    mpar = new MySqlParameter();
                    mpar.ParameterName = "?apwd";
                    mpar.Value = pwd;
                    mpar.MySqlDbType = MySqlDbType.String;
                    mcomm.Parameters.Add(mpar);
                   
                    mpar = new MySqlParameter();
                    mpar.ParameterName = "?aemail";
                    mpar.Value = email;
                    mpar.MySqlDbType = MySqlDbType.String;
                    mcomm.Parameters.Add(mpar);

                    mpar = new MySqlParameter();
                    mpar.ParameterName = "?blogtit";
                    mpar.Value = bt;
                    mpar.MySqlDbType = MySqlDbType.String;
                    mcomm.Parameters.Add(mpar);
             
           
                    mpar = new MySqlParameter();
                    mpar.ParameterName = "?alocazione";
                    mpar.Value = loc;
                    mpar.MySqlDbType = MySqlDbType.String;
                    mcomm.Parameters.Add(mpar);
                    
                    mpar = new MySqlParameter();
                    mpar.ParameterName = "?emailsrv";
                    mpar.Value = ms;
                    mpar.MySqlDbType = MySqlDbType.String;
                    mcomm.Parameters.Add(mpar);
                    
                    mcomm.ExecuteNonQuery();
                    mc.Close();

                    
                    mc.Open();
     
                    string qq = "INSERT INTO utenti(nick, password, email, locazione, datareg) ";
                    qq += "VALUES (?nick, ?password, ?email, ?locazione, ?datareg)";
                    MySqlCommand mcomm1 = new MySqlCommand(qq, mc);
                    MySqlParameter mpar1 = new MySqlParameter();
                    mpar1.ParameterName = "?nick";
                    mpar1.Value = nick;
                    mpar1.MySqlDbType = MySqlDbType.String;
                    mcomm1.Parameters.Add(mpar1);

                    mpar1 = new MySqlParameter();
                    mpar1.ParameterName = "?password";
                    mpar1.Value = pwd;
                    mpar1.MySqlDbType = MySqlDbType.String;
                    mcomm1.Parameters.Add(mpar1);

                    mpar1 = new MySqlParameter();
                    mpar1.ParameterName = "?email";
                    mpar1.Value = email;
                    mpar1.MySqlDbType = MySqlDbType.String;
                    mcomm1.Parameters.Add(mpar1);
            
                    mpar1 = new MySqlParameter();
                    mpar1.ParameterName = "?locazione";
                    mpar1.Value = loc;
                    mpar1.MySqlDbType = MySqlDbType.String;
                    mcomm1.Parameters.Add(mpar1);

                    mpar1 = new MySqlParameter();
                    mpar1.ParameterName = "?datareg";
                    mpar1.Value = dat;
                    mpar1.MySqlDbType = MySqlDbType.String;
                    mcomm1.Parameters.Add(mpar1);


                    mcomm1.ExecuteNonQuery();
                   
                    mc.Close();
                    Response.Redirect("afterinst.aspx");
                }
                catch (Exception e)
                {
                    Response.Write(e.Message);
                }
           
       
           
                   %>
   
</body>
</html>
