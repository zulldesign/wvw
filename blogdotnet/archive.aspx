 
 
 
 

    
     <%
        //mc.Open();
        string starch = null;
        starch += "<table id='tbarch'>";
        starch += "<tr><td class='tit'>Archive for Months</td></tr>";
        DateTime t = DateTime.Now;
        Session["anno"] = t.Year;
       // Response.Write(t.Year);
        string ricq = "SELECT mese, COUNT(mese) AS nn FROM news WHERE anno ='" + t.Year + "' GROUP BY mese";
        MySqlDataAdapter mdaarch = new MySqlDataAdapter(ricq, mc);
        DataSet dsarch = new DataSet();
        mdaarch.Fill(dsarch);
        DataTable dtarch = dsarch.Tables[0];
        DataRowCollection drcarch = dtarch.Rows;
        int nrarch = drcarch.Count;
        for (int iar = 0; iar < nrarch; iar++ )
        {
           DataRow drarch = drcarch[iar];
        
        string s1 = Convert.ToString(drarch["mese"]);
        string s2 = Convert.ToString(drarch["nn"]);
        starch += "<tr><td><a href='readnewsarch.aspx?mese="+s1+"'>"+s1+"</a> ("+ s2+")</td></tr>";
          
         }
         
         starch += "<tr><td>&nbsp;</td></tr>";
         starch += "<tr align='center'><td id='rcpy'><a target='_blank' href='rss.aspx'><img alt='Make your RSS' src='images/newsfeed_rss20.gif' /></a></td></tr>";
         starch += "</table>"; 
         mc.Close();
        %>
       <%= starch %>