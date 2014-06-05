  
    <%
        mc.Open();
        string qct = "SELECT categoria, COUNT(categoria) AS nc FROM news GROUP BY categoria";
        MySqlCommand mcommct = new MySqlCommand(qct, mc);
        DataSet dsct = new DataSet();
        MySqlDataAdapter mdact = new MySqlDataAdapter(mcommct);
        mdact.Fill(dsct);
        DataRowCollection drccat = dsct.Tables[0].Rows;
        int nrct = drccat.Count; 
        if (nrct <= 5) 
            {
       
        for(int k = 0; k<nrct; k++)
        {
            DataRow drct = drccat[k];
            %>
        <tr align="center"><td><a href="newscat.aspx?cat=<%= drct["categoria"] %>"><%= drct["categoria"] %></a> (<%= drct["nc"]  %>)</tr>
        <% 
           } 
            }
            else
             {
            for(int p = 0; p<5; p++)
        {
            DataRow drct = drccat[p];
            %>
             <tr align="center"><td><a href="newscat.aspx?cat=<%= drct["categoria"] %>"><%= drct["categoria"] %></a> (<%= drct["nc"]  %>)</tr>
            <%
            }
           %>
           <tr><td></td></tr>
           <tr align="center"><td><a  href="allcat.aspx">See All</a></td></tr>
           <%     
            }
            %>

