
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
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
</head>
<body>
<div id="container">
   <table id="tblg">
   <!-- #include virtual="logo.html" -->
   </table>
    <table id="tbinst" width="500">
    <tr align="center"><td>
    <b>Done!</b><br />
    To go the admin section go <a href="../admin/default.aspx">here</a><br />
    Delete the entire setup folder first of all
    </td></tr>
    </table>
    
    </div>
</body>
</html>
