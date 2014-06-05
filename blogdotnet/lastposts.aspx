

<%
    DataSet dsp = new DataSet();
    string q = "SELECT * FROM commenti as c WHERE c.idc<=(SELECT MAX(idc) FROM commenti) AND c.idc>(SELECT MAX(idc)-5 FROM commenti)";
    MySqlCommand mcoomp = new MySqlCommand(q, mc);
    MySqlDataAdapter mdap = new MySqlDataAdapter(mcoomp);
    mdap.Fill(dsp);
    DataRowCollection drcp = dsp.Tables[0].Rows;
    int nrp = drcp.Count;
    for (int j = nrp - 1; j >= 0; j--)
    {
        
        DataRow drp = drcp[j];
        
        %>
    <tr><td align="center"><a href="lastuserpost.aspx?idc=<%= drp["idc"] %>"><%= drp["nick"]  %>&nbsp;<%= drp["datac"] %></a></td></tr>
    
 <%
     
    }
     
     
         %>
