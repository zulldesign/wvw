<%@ Page Language="C#"  %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link rel="Stylesheet" href="styleacp.css" type="text/css" />
    <script src="ctrclient.js" language="javascript" type="text/javascript">
             
    </script>
</head>
<body onload="inscat()">
<div id="container">
  <%
      
      if (Request.Cookies["adm"]!=null)
      {
          string uu = Request.Cookies["adm"].Value;  
      %>
    <table id="tblg">
    <!-- #include virtual="toplogo.html -->
    </table>
    <table id="menulat">
    <!-- #include virtual="menulat.html -->
    </table>   
    <!-- #include virtual="../config.inc" -->
    <table id="tbins" width="600">
    <form method="post" action="aggnews.aspx" name="fin" onsubmit="return valida()">
    <tr align="center" class="tit"><td colspan="3">Modify News</td></tr>
    <tr><td>Choose Category</td>
    <td><select name="selcat" onchange="inscat()">
    
    <%
         
      Session["titn"] = Request.QueryString["titn"];
      Session["idn"] = Request.QueryString["idn"];
         
      mc.Open();
      string q = "SELECT DISTINCT categoria FROM news";
      MySqlCommand mcomm = new MySqlCommand(q, mc);
      MySqlDataReader mdr = mcomm.ExecuteReader();
      while (mdr.Read())
      {
          string cat = Convert.ToString(mdr["categoria"]);  
        %>
        
    <option value="<%= cat %>"><%= cat%></option>
    
    <%
      }
      mdr.Close();
          
             %>
    </select> </td></tr>
    <tr><td>Or write Category</td><td><input type="text" name="txtcat" /> </td></tr>
    <tr><td>Author</td><td><input type="text" name="aut" value="<%= uu %>" /> </td></tr>
    <tr><td>Title</td><td><input type="text" name="tit" value="<%= Session["titn"] %>" /></td><td><div id="attztit"></div></td> </tr> 
    <tr><td>Receive Mail<br /> when users post a message</td><td><br />
    <input type="radio"  name="rd" value="yes"  />Yes<br />
    <input type="radio" name="rd" value="no" checked />No<br />
    <br />
    </td></tr>
    <tr><td></td><td><input class="btn" value="B" type="button" onclick="boldfin()" />
                <input class="btn" value="U" type="button" onclick="sottolinfin()" />
                <input class="btn" value="i" type="button" onclick="italicfin()" />
                <input class="btn" value="img" type="button" onclick="imgfin()" />
                <input class="btn" value="url" type="button" onclick="httpfin()" />
                <%
                    mc.Close();
                    mc.Open();
                    string qt = "SELECT * FROM news WHERE idn=" + Session["idn"];
                    MySqlCommand mcommt = new MySqlCommand(qt, mc);
                    MySqlDataReader mdrt = mcommt.ExecuteReader();
                    mdrt.Read();
           %>
    <tr><td>Text of article</td><td><textarea id="txtnews" rows="20" cols="30" name="txt"><%= mdrt["teston"] %></textarea> </td><td><div id="attz"></div></td></tr>
    <tr><td>&nbsp;</td></tr>
    <tr align="center"><td colspan="2"><input class="btn" type="submit" value="send news" /> </td></tr>
    </form>
     <%
         mdrt.Close();
         mc.Close(); 
      }
      else
      {
          Response.Redirect("errcp.html");
      }
           %>
           </table>
           </div>
</body>
</html>
