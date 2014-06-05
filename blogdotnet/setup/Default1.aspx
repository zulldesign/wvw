<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Setup the Blog step 2</title>
    <script language="javascript" type="text/javascript">
        var largh = screen.width;
        var alt = screen.height;
        if((largh>1550))
        {
        document.write(' <link rel="Stylesheet" href="../styles/style.css" type="text/css" media="all" />');
        }
        else if((largh>1250)&&(largh<1550))
        {
        document.write('<link rel="Stylesheet" href="../styles/style1280.css" type="text/css" media="all" /> ');
    }
    else
    {
        document.write('<link rel="Stylesheet" href="../styles/style1280.css" type="text/css" media="all" /> ');
    }
        
    </script>
    <script language="javascript" type="text/javascript">
        function validareg() {
            var a = document.freg.auid.value;
            var b = document.freg.apwd.value;
            var c = document.freg.aemail.value;
            var d = document.freg.blogtit.value;
            var e = document.freg.ms.value;
            

            if (a.length < 4) {
                document.getElementById("nc").innerHTML = "<b style='color: red'>nick must have at least 4 char</b>";
                return false;
            }
            if (b.length < 4) {
                document.getElementById("pw").innerHTML = "<b style='color: red'>password must have at least 4 char</b>";
                return false;
            }
            if (c.indexOf('@', 0) == -1) {
                document.getElementById("em").innerHTML = "<b style='color: red'>Email must be valid</b>";
                return false;
            }

            if (d.length == 0) {
                document.getElementById("bt").innerHTML = "<b style='color: red'>Write Blog title</b>";
                return false;
            }
            if (e.length == 0 || e.indexOf('.', 0) == -1)  {
                document.getElementById("mms").innerHTML = "<b style='color: red'>Mail Server not valid</b>";
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
    <table id="tbreg" width="500">
    <tr align="center"><td>
    <h3 class="tit">2st step</h3>
    </td></tr>
    <tr align="center"><td>
    <h4>Enter Administrator data</h4><br />
     <form name="freg" method="post" action="setup.aspx" onsubmit="return validareg()">
     <table>
    <tr><td>Admin Nick *</td><td><input type="text" name="auid" /></td><td><div id="nc"></div></td></tr>
    <tr><td>Password *</td><td><input  type="password" name="apwd" /></td><td><div id="pw"></div></td></tr>
    <tr><td>Email *</td><td><input type="text" name="aemail" /></td><td><div id="em"></div> </td></tr>
    <tr><td>Blog Title *</td><td><input type="text" name="blogtit" /></td><td><div id="bt"></div> </td></tr>
    <tr><td>Location</td><td><input type="text" name="aloc" /></td></tr>
    <tr><td>Email Server *</td><td><input type="text" name="ms" /><div id="mms"></div></td></tr>
    <tr><td></td><td colspan="2"><input id="btnreg" type="submit" value="Setup the Blog" /></td></tr>
    <tr><td>&nbsp;</td></tr>
    <tr><td></td><td><a href="#" onClick="javascript:history.back()">Back</a></td></tr>
    </table>
    </form>
    </td></tr>
   </table>
    
    </div>
</body>
</html>
