
<%@ Page Language="C#" %>
<%@ Import Namespace="System.Drawing" %>
<%@ Import Namespace="System.Drawing.Imaging" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script language="C#" runat="server">

    void Page_load(object s, EventArgs e)
    {
        //Session.CodePage = 65001;
        Response.ContentType = "image/gif";
        Random r = new Random();
        // Create a new random number between the specified range 
        int num = r.Next(10000, 99999);
        Bitmap Bmp = new Bitmap(110, 70);
        for (int i = 0; i < 110; i++)
        {
            for (int j = 0; j < 70; j++)
            {
                Bmp.SetPixel(i, j, Color.Blue);
            }
        }
        Graphics gfx = Graphics.FromImage(Bmp);
        Font fnt = new Font("Verdana", 21, FontStyle.Bold);
        gfx.DrawString(num.ToString(), fnt, Brushes.OrangeRed, 2, 20);
        // Draw the random number 
        Pen p = new Pen(Color.OrangeRed, 2);
        int x11 = 0;
        int y11 = 30;
        int x22 = 110;
        int y22 = 30;
        gfx.DrawLine(p, x11, y11, x22, y22);
        int xx11 = 0;
        int yy11 = 45;
        int xx22 = 110;
        int yy22 = 45;
        gfx.DrawLine(p, xx11, yy11, xx22, yy22);
        Bmp.Save(Response.OutputStream, ImageFormat.Gif);
        Session["numr"] = num;
        gfx.Dispose();
        Bmp.Dispose();
        Response.End();
    
    }
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>
