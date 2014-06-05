<table id="tbsmilie">
<tr><td colspan="4" align="center"  class="tit">Smilies</td></tr>


    <tr>
    <%
   
   for(int i=1 ;i<=4; i++){
    %>
    <td align="center"><a href="Javascript:insertsmilie(':1<%= i %>');"><img src="./images/smile/smile1/1<%= i %>.gif" border="0"></a></td>
    <% 
     }
    %>
    </tr><tr>
    <%
    for(int j=1; j<=4; j++){
    %>
   <td align="center"><a href="Javascript:insertsmilie(':2<%= j %>');"><img src="./images/smile/smile1/2<%= j %>.gif" border="0"></a></td>
    <%
    }
     %>
    </tr><tr>
     <%
    for(int k=1; k<=4; k++){
    %>
   <td align="center"><a href="Javascript:insertsmilie(':3<%= k %>');"><img src="./images/smile/smile1/3<%= k %>.gif" border="0"></a></td>
    <%
    }
     %>
     </tr><tr>
     <%
      for(int l=1; l<=4; l++){
    %>
   <td align="center"><a href="Javascript:insertsmilie(':4<%= l %>');"><img src="./images/smile/smile1/4<%= l %>.gif" border="0"></a></td>
    <%
    }
    %>
    </tr><tr>
    <% 
    for(int m=1; m<=4; m++){
    %>
   <td align="center"><a href="Javascript:insertsmilie(':5<%= m %>');"><img src="./images/smile/smile1/5<%= m %>.gif" border="0"></a></td>
    <%
    }
     %>
     
     </tr>
    <tr><td colspan="4"  align="center"><a href="#" onclick="aprifin()">See All Smilies</a></td></tr>
     </table>
     
     

