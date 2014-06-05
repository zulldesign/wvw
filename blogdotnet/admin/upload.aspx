<%@ Page Language="C#" AutoEventWireup="true" CodeFile="upload.aspx.cs" Inherits="upload" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
    <style type="text/css">
     body
     {
     background-color: White;
     }
    a
    {
   color: Blue;    
   font-size: small;
    }       
   a:hover
   {
  color: #FF7000;
  font-size: small;   
    } 
    
    .btn
{
background-color: #181818;
color: White;
font-size: small;
font-weight: bolder;    
    } 
      
    </style>
    <script language="javascript" type="text/javascript">
        function insertupl(val1, val2) {
            window.opener.document.fin.txtnews.value += "<a href='./admin/"+val1+"'>"+val2+"</a>";
            window.close();
        }
    
    </script>
</head>
<body>
    <%
         
      if (Request.Cookies["adm"]!=null)
      {
          string uu = Request.Cookies["adm"].Value;  
      %>
         
   <form id="Form1" method="post" runat="server" enctype="multipart/form-data">
    Upload a file <br /><br />
   
    <input id="filMyFile" type="file" runat="server" NAME="filMyFile" size="30">
    <br /><br />
    <asp:Button class="btn" id="Button1" runat="server" Text="Upload »"></asp:Button>
    <br /><br />
    <asp:Label ID="lbResult" Runat="server"></asp:Label>
    <div id="divlink" runat="server"></div>
  </form><br />
 <%
     }
      else
      {
          Response.Redirect("errcp.html");
      }   
           %>
</body>
</html>
