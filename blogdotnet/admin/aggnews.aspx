<%@ Page Language="C#" ValidateRequest="false" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script runat="server">
    public string sost(string s){
        
        switch (s)
        {
        
        case "1":
        //string sm1 = Convert.ToString(m);
        s = s.Replace(s, "January");
        break;
        case "2":
        //string sm2 = Convert.ToString(m);
        s = s.Replace(s, "February");
        break;
        case "3":
        //string sm3 = Convert.ToString(m);
        s = s.Replace(s, "March");
        break;
        case "4":
        //string sm4 = Convert.ToString(m);
        s = s.Replace(s, "April");
        break;
        case "5":
        //string sm5 = Convert.ToString(m);
        s = s.Replace(s, "May");
        break;
        case "6":
        //string sm6 = Convert.ToString(m);
        s = s.Replace(s, "June");
        break;
        case "7":
        //string sm7 = Convert.ToString(m);
        s = s.Replace(s, "July");
        break;
        case "8":        //string sm8 = Convert.ToString(m);
        s = s.Replace(s, "August");
        break;
        case "9":
        //string sm9 = Convert.ToString(m);
        s = s.Replace(s, "September");
        break;
        case "10":
        //string sm10 = Convert.ToString(m);
        s = s.Replace(s, "October");
        break;
        case "11":
        //string sm11 = Convert.ToString(m);
        s = s.Replace(s, "November");
        break;
        case "12":
        //string sm12 = Convert.ToString(m);
        s = s.Replace(s, "December");
        break; 
                       
      }
        return s;
     }
    </script>
</head>
<body>
   <!-- #include virtual="../config.inc -->
    <%  
        //ConnManager1 cm = new ConnManager1("root", "alex", "localhost", "blogdb");
        //MySqlConnection mc = cm.msc();
        //string sc = "Data Source=localhost;User Id=root;Password=alex;Database=blogdb";
        //MySqlConnection mc = new MySqlConnection(sc);
        mc.Open();
        DateTime d = DateTime.Now;
        int a = d.Year;
        int m = d.Month;
        int g = d.Day;
        int h = d.Hour;
        int min = d.Minute;
        int s = d.Second;
        string dat = a + "-" + m + "-" + g;
        string cat = Request.Form["txtcat"];
        string aut = Request.Form["aut"];
        string txt = Request.Form["txt"];
        string mem = Request.Form["rd"];
        string ann = Convert.ToString(a);
        string mon = sost(Convert.ToString(m));
        
        try
        {
        //txt = txt.Replace("'", "\\'");    
        string tit = Request.Form["tit"];
        string q = "UPDATE news SET " ;
        q += "categoria='"+cat+"', autore= '"+aut+"', titolon='"+tit+"', anno='"+ann+"', mese='"+mon+"', datan='"+dat+"', teston='"+txt+"', msgemail='"+Request.Form["rd"]+"' WHERE idn='"+Session["idn"]+"'";
        MySqlCommand mcomm = new MySqlCommand(q, mc);
        int nra = mcomm.ExecuteNonQuery();
        mc.Close();
        }
        catch (Exception e)
        {
            Response.Redirect("index.aspx");
         }
         Response.Redirect("afterinsnews.aspx");
         %>
</body>
</html>
