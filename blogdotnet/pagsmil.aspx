<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Pagina senza titolo</title>
<link rel="Stylesheet" href="./styles/style.css" type="text/css" media="all" />
<style type="text/css">
a
{
text-decoration: underline;
color: Blue;
}


</style>
  <script language="JavaScript" type="text/javascript">
	<!--
	function insertsmilie(val)
	{
	    window.opener.document.fcomm.txt.value += val
	}
	function cl()
	{
	window.close();
	}
	//-->
	</script>
</head>
<body>
   
    <table width="200" id="tbsm">
   <tr align="center"><td colspan="4" class="tit"><b>Smilies</b></td></tr>
   <tr><td colspan="4">&nbsp;</td></tr>
    <tr>
    <%
   
   for(int i=1 ;i<=4; i++){
    %>
    <td align="center"><a href="Javascript:insertsmilie(':1<%= i %>');"><img src="./images/smile/1<%= i %>.gif" border="0"></a></td>
    <%
   }
     %>
     </tr>
      <tr>
     <%
    for(int j=1; j<=4; j++){
    %>
   <td align="center"><a href="Javascript:insertsmilie(':2<%= j %>');"><img src="./images/smile/2<%= j %>.gif" border="0"></a></td>
    <%
    }
     %>
     </tr>
     <tr>
     <%
    for(int k=1; k<=4; k++){
    %>
   <td align="center"><a href="Javascript:insertsmilie(':3<%= k %>');"><img src="./images/smile/3<%= k %>.gif" border="0"></a></td>
    <%
    }
     %>
     </tr>
     <tr>
     <%
    for(int l=1; l<=4; l++){
    %>
   <td align="center"><a href="Javascript:insertsmilie(':4<%= l %>');"><img src="./images/smile/4<%= l %>.gif" border="0"></a></td>
    <%
    }
     %>
     </tr>
     <tr>
     <%
    for(int m=1; m<=4; m++){
    %>
   <td align="center"><a href="Javascript:insertsmilie(':5<%= m %>');"><img src="./images/smile/5<%= m %>.gif" border="0"></a></td>
    <%
    }
     %>
     </tr>
     <tr>
    <% 
    for(int m=1; m<=4; m++){
    %>
   <td align="center"><a href="Javascript:insertsmilie(':6<%= m %>');"><img src="./images/smile/6<%= m %>.gif" border="0"></a></td>
    <%
    }
     %>
     
     </tr>
     <tr>
    <% 
    for(int m=1; m<=4; m++){
    %>
   <td align="center"><a href="Javascript:insertsmilie(':7<%= m %>');"><img src="./images/smile/7<%= m %>.gif" border="0"></a></td>
    <%
    }
     %>
     
     </tr>
     <tr>
    <% 
    for(int m=1; m<=4; m++){
    %>
   <td align="center"><a href="Javascript:insertsmilie(':8<%= m %>');"><img src="./images/smile/8<%= m %>.gif" border="0"></a></td>
    <%
    }
     %>
     
     </tr>
     <tr>
    <% 
    for(int m=1; m<=4; m++){
    %>
   <td align="center"><a href="Javascript:insertsmilie(':9<%= m %>');"><img src="./images/smile/9<%= m %>.gif" border="0"></a></td>
    <%
    }
     %>
     
     </tr>
     <tr align="center"><td colspan="4"><h5><a id="closesm" href="Default.aspx" onclick="cl()">Close</a></h5></td></tr>
     </table>
     
</body>
</html>
