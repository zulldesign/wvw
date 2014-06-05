<%@ Page Language="C#" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <script language="javascript" type="text/javascript">
        var largh = screen.width;
        var alt = screen.height;
        if((largh>1550))
        {
        document.write(' <link rel="Stylesheet" href="./styles/style.css" type="text/css" media="all" />');
        }
        else if((largh>1250)&&(largh<1550))
        {
        document.write('<link rel="Stylesheet" href="./styles/style1280.css" type="text/css" media="all" /> ');
    }
    else {
        document.write('<link rel="Stylesheet" href="./styles/style1280.css" type="text/css" media="all" /> ');
    }
        
    </script>
    <script language="javascript" type="text/javascript">
        function validareg() {
            var a = document.freg.email.value;
            var b = document.freg.nick.value;
            var c = document.freg.pwd.value;
            
            if (a.indexOf('@', 0) == -1) {
                document.getElementById("em").innerHTML = "<b style='color: red'>Email must be valid</b>";
                return false;
            }
            if (b.length < 4) {
                document.getElementById("nc").innerHTML = "<b style='color: red'>nick must have at least 4 char</b>";
                return false;
            }
            if (c.length < 4) {
                document.getElementById("pw").innerHTML = "<b style='color: red'>password must have at least 4 char</b>";
                return false;
            }
            
            
            return true;
        }
    
    </script>
</head>
<body>
<div id="container">

  <table id="tblg">
   <!-- #include virtual="logo.html" -->
   </table>
     <form name="freg" method="post" action="insreg.aspx" onsubmit="return validareg()">
     <table id="tbreg" width="500px">
    <tr align="center"><td colspan="3" class="tit"><b>Register</b></td></tr>
    <tr><td>Nick *</td><td><input type="text" name="nick" /></td><td><div id="nc"</td></tr>
    <tr><td>Password *</td><td><input type="password" name="pwd" maxlength="10" /><td><div id="pw"</td></td></tr>
    <tr><td>Email *</td><td><input type="text" name="email" /></td><td><div id="em"></div> </td></tr>
    <tr><td>Location</td><td><input type="text" name="loc" /></td></tr>
    <tr><td><b id="txtcod">Insert the code</b></td><td><img alt="captcha" src="imgcaptcha.aspx" /></td></tr>
    <tr><td>&nbsp;</td><td><input class="caselle" type="text" name="cod" /></td></tr>
    <tr><td></td><td colspan="2"><input id="btnreg" type="submit" value="Register" /></td></tr>
   </table>
      </form>
      </div> 
       
</body>
</html>
