using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data;
using MySql.Data.MySqlClient;
using System.Data;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public string substr(string st)
    {   string str = st;
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
    protected void cal_SelectionChanged(object sender, EventArgs e)
    {
        string g = Convert.ToString(cal.SelectedDate.Day);
        string m = Convert.ToString(cal.SelectedDate.Month);
        string a = Convert.ToString(cal.SelectedDate.Year);
        string dt = a + "-" + m + "-" + g;
        Session["data"] = dt;
        Response.Redirect("dispdatanews.aspx");
    }
   
    
}
