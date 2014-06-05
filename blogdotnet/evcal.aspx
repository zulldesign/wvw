<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    protected void cal_SelectionChanged(object sender, EventArgs e)
    {
        string g = Convert.ToString(cal.SelectedDate.Day);
        string m = Convert.ToString(cal.SelectedDate.Month);
        string a = Convert.ToString(cal.SelectedDate.Year);
        string dt = a + "-" + m + "-" + g;
        Session["data"] = dt;
        Response.Redirect("datanews.aspx");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body alink="White">
    <form id="form1" runat="server">
    <asp:Calendar ID="cal" runat="server" Height="20px" 
        style="margin-top: 61px" Width="25px" Font-Size="Small" 
        BorderColor="#FFFFCC" BorderStyle="Solid" 
        onselectionchanged="cal_SelectionChanged" BackColor="#009933" 
        Font-Bold="True" ForeColor="White" SelectedDate="05/05/2010 17:10:10">
        <SelectedDayStyle BackColor="#FF0066" />
        <SelectorStyle BackColor="White" />
        <NextPrevStyle BackColor="#FF9900" />
        <TitleStyle BackColor="Blue" />
        <DayHeaderStyle BackColor="#FF9900" />
    </asp:Calendar>
    </form>
</body>
</html>
