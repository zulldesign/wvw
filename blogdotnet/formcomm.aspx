<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    protected void cal_SelectionChanged(object sender, EventArgs e)
    {
        string g = Convert.ToString(cal.SelectedDate.Day);
        string m = Convert.ToString(cal.SelectedDate.Month);
        string a = Convert.ToString(cal.SelectedDate.Year);
        string dt = a + "-" + m + "-" + g;
        Session["data"] = dt;
        Response.Redirect("dispdatanews.aspx");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Add Comment</title>
   
    <link type='text/css' href='./basic/css/basic.css' rel='stylesheet' media='screen' />
    <script type='text/javascript' src='./basic/js/jquery.js'></script>
   <script type='text/javascript' src='./basic/js/jquery.simplemodal.js'></script>
   <script type='text/javascript' src='./basic/js/basic.js'></script>
    <script language="javascript" type="text/javascript">
        var largh = screen.width;
        var alt = screen.height;
        if ((largh > 1550)) {
            document.write(' <link rel="Stylesheet" href="./styles/style.css" type="text/css" media="all" />');
        }
        if ((largh > 1250) && (largh < 1550)) {
            document.write('<link rel="Stylesheet" href="./styles/style1280.css" type="text/css" media="all" /> ');
        }
        
    </script>
    <script language="javascript" type="text/javascript">

        function insertsmilie(val) {
         document.fcomm.txt.value += val
        }
        function cl() {
            window.close();
        } 
        
        function boldfin() {
            //var t = window.prompt("Insert Text");
            var tb = document.getElementById("txtfc");

            if (document.selection) {
                var st = document.selection.createRange().text;
                var sel = document.selection.createRange();
                sel.text = "[B]" + st + "[/B]";
            } else if (typeof tb.selectionStart != 'undefined') {
                var before, after, selection;
                before = tb.value.substring(0, tb.selectionStart)
                selection = tb.value.substring(tb.selectionStart, tb.selectionEnd)
                after =tb.value.substring(tb.selectionEnd, tb.value.length)

                tb.value = String.concat(before, "[B]", selection, "[/B]", after)
            }
            tb.focus();
        }
        function sottolinfin() {
            // var t = window.prompt("Insert Text");
            var tb = document.getElementById("txtfc");

            if (document.selection) {
                var st = document.selection.createRange().text;
                var sel = document.selection.createRange();
                sel.text = "[U]" + st + "[/U]";
            } else if (typeof tb.selectionStart != 'undefined') {
                var before, after, selection;
                before = tb.value.substring(0, tb.selectionStart)
                selection = tb.value.substring(tb.selectionStart, tb.selectionEnd)
                after = tb.value.substring(tb.selectionEnd, tb.value.length)

                tb.value = String.concat(before, "[U]", selection, "[/U]", after)
            }
            tb.focus();
        }
        function italicfin() {
            // var t = window.prompt("Insert Text");
            var tb = document.getElementById("txtfc");

            if (document.selection) {
                var st = document.selection.createRange().text;
                var sel = document.selection.createRange();
                sel.text = "[I]" + st + "[/I]";
            } else if (typeof tb.selectionStart != 'undefined') {
                var before, after, selection;
                before = tb.value.substring(0, tb.selectionStart)
                selection = tb.value.substring(tb.selectionStart, tb.selectionEnd)
                after = tb.value.substring(tb.selectionEnd, tb.value.length)

                tb.value = String.concat(before, "[I]", selection, "[/I]", after)
            }
            tb.focus();
        }
        
        function aprifin()
    {
    win = window.open("pagsmil.aspx", "np","width=400,height=500")
      }
      function httpfin() {
          //var t = window.prompt("Insert Text");
          //var u = window.prompt("Insert url");
          var tb = document.getElementById("txtfc");

          if (document.selection) {
              var st = document.selection.createRange().text;
              var sel = document.selection.createRange();
              sel.text = document.fcomm.txt.value += "[URL= ] [/URL]";
          } else if (typeof tb.selectionStart != 'undefined') {
              var before, after, selection;
              before = tb.value.substring(0, tb.selectionStart)
              selection = tb.value.substring(tb.selectionStart, tb.selectionEnd)
              after = tb.value.substring(tb.selectionEnd, tb.value.length)

              tb.value = String.concat(before, "[URL= ]", selection, "[/URL]", after)
          }
          tb.focus();
         
      }

      function imgfin() {
          //var t = window.prompt("Insert Text");
          //var u = window.prompt("Insert url");
          var tb = document.getElementById("txtfc");

          if (document.selection) {
              var st = document.selection.createRange().text;
              var sel = document.selection.createRange();
              sel.text = document.fcomm.txt.value += "[IMG SRC= ]";
          } else if (typeof tb.selectionStart != 'undefined') {
              var before, after, selection;
              before = tb.value.substring(0, tb.selectionStart)
              selection = tb.value.substring(tb.selectionStart, tb.selectionEnd)
              after = tb.value.substring(tb.selectionEnd, tb.value.length)

              tb.value = String.concat(before, "[IMG SRC= ]", selection, "", after)
          }
          tb.focus();

      }
      
      
      
      function valida() {
          var a = document.fcomm.txt.value;
          if (a == "") {
              document.getElementById("attz").innerHTML = "<b style='color: red;'>write the text</b>";
              return false;
          }
          return true;
      }
       
    </script>
    
     <script runat="server">
         public string substr(string st)
         {
             string str = st;
             if (str.Length < 9)
             {
                 str = str.Substring(0, 8);
             }
             else
             {
                 str = str.Substring(0, 9);
             }
             return str;
         }
    </script>
</head>
<body>
   <div id="container">
   <table id="tbcal">
   <tr align="center"><td><u style="font-weight: bold;">Archive</u></td></tr>
   <!-- #include virtual="formcal.aspx" -->
   </table> 
     
   <table id="tblg">
   <!-- #include virtual="logo.html" -->
   </table>
   <table id="latlogin" width="180">
   <% 
       if (Request.Cookies["ut"] == null)
       {
       %>
   <tr><td><a href="login.aspx">Login</a></td></tr>
   <%
       }
       else
       {
            %>
            <tr><td>Welcome back <u><b><%= Request.Cookies["ut"].Value %></b></u> </td></tr>   
            <tr><td><a href="logout.aspx">logout</a> </td></tr>
            <%
       
       }
            %>
            
   </table>
   <table id="latsx" width="170">
    <!-- #include virtual="latsx.html" -->
   </table>
   <!-- #include virtual="config.inc" -->
   
      
  
       
       <table id="tbnews" width="660" cellpadding="15">
       <tr align="center"><td class="titart" colspan="3">Article</td></tr>
        <%
            try
            {
                string n = Request.QueryString["nck"];
                int idn = Convert.ToInt32(Request.QueryString["idn"]);
                Session["idn"] = idn;
                string q1 = "SELECT * FROM utenti WHERE nick='" + n + "'";
                mc.Open();
                MySqlCommand mcomm = new MySqlCommand(q1, mc);
                MySqlDataReader mdr = mcomm.ExecuteReader();
                mdr.Read();
                int idu = Convert.ToInt32(mdr["idu"]);
                Session["idu"] = idu;
                mdr.Close();
                string qs = "SELECT * FROM news WHERE idn=" + idn;
                MySqlCommand mcomms = new MySqlCommand(qs, mc);
                MySqlDataReader mdrs = mcomms.ExecuteReader();
                mdrs.Read();
                string ss = Convert.ToString(mdrs["teston"]);
                ss = ss.Replace("[B]", "<b>");
                ss = ss.Replace("[/B]", "</b>");
                ss = ss.Replace("[U]", "<u>");
                ss = ss.Replace("[/U]", "</u>");
                ss = ss.Replace("[I]", "<i>");
                ss = ss.Replace("[/I]", "</i>");
                ss = ss.Replace("[URL=http://", "<a href=http://");
                ss = ss.Replace(" ]", ">");
                ss = ss.Replace("[/URL]", "</a>");
                ss = ss.Replace("[IMG SRC=", "<img src=");
                ss = ss.Replace(Environment.NewLine, "<br/>");
                
                string sst = substr(Convert.ToString(mdrs["datan"]));           
                %>
                
                <tr align="center"><td colspan="2" class="titn"><%= mdrs["titolon"]%></td></tr>
                <tr><td class="rn" colspan="2"><%= ss%></td></tr>
                <tr><td>&nbsp;</td></tr>
                <tr><td>Posted by <b><u><%= mdrs["autore"]%></u></b>&nbsp;<img src="./images/user-prof.png" /></td><td><%= sst%></td></tr>
                <tr><td colspan="3"><hr style="color: Green;border-width: medium;" /></td></tr>
                <tr><td><div id='basic-modal'><a href="#" class='basic'>Legend Code</a></div></td></tr>
                <tr><td><input class="btn" id="bf"  value="B" type="button" onclick="boldfin()" />
                <input class="btn" value="U" type="button" onclick="sottolinfin()" />
                <input class="btn" value="i" type="button" onclick="italicfin()" />
                <button class="btn" type="submit" onclick="imgfin()"><img src="./images/image.gif" /></button>
                <button class="btn" type="submit" onclick="httpfin()"><img src="./images/Earth-icon16.png" /></button>
                &nbsp;
                </td></tr>
                <form method="post" action="addcomm.aspx" name="fcomm" onsubmit="return valida()">
                <tr><td><textarea id="txtfc" rows="10" cols="40" name="txt"></textarea></td><td><!-- #include file="pagsmilie.aspx" --></td></tr>
                <tr><td><div id="attz"></div></td></tr>
                <tr><td><input class="btn" type="submit" value="send comment" /> 
                </form>
                <br /><br />
                </td></tr>
                
        </table>
       
        <%
            mdr.Close();
            mc.Close();
            }
            catch (Exception e)
            {
                Response.Redirect("Default.aspx");
            }
             %>
             </div>
             <div id="basic-modal-content">
            <font color="#FF0000"><u><b>Legend Code</b></u></font><br>
            <font color="#000080"><br></font><font color="#000080">Bold: [B] your text [/B]<br><br>
            Underline: [U] your text [/U]<br><br>
            Italic: [I] your text [/I]<br><br>
            Images: [IMG SRC=urltoimage ]<br /><br />
            Link: [URL=http://www.awebsite.com ] Website description [/URL]<br><br>
            all HTML tags are enabled <br><br><br>

            <a target="_blank" href="http://www.w3schools.com/tags/default.asp">HTML tag reference</a>
            
            </font>
		</div>
</body>
</html>
