<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    public string indicipasswd(string pw)
    {
        string s = "abcdefghijklmnopqrstuvxyzABCDEFGHIJKLMNOPQRSTXYZ123456789";
        int lun = pw.Length;
        string si = "";
        for (int j = 0; j < lun; j++)
        {
            string sc = "";
            for (int k = 0; k < s.Length; k++)
            {

                if (pw[j].Equals(s[k]))
                {
                    int ic = k;
                    sc = Convert.ToString(ic);
                }
            }
            si = si + sc;
        }
        return si;
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <!-- #include virtual="config.inc" -->
    <%
        mc.Open();
        string nc = Request.Cookies["ut"].Value;
        string spwd = Request.Form["pwd"];
        string pwd = indicipasswd(spwd);
        string qu = "UPDATE utenti SET password=@pwd WHERE nick='" + nc + "'";

        MySqlCommand mcomm = new MySqlCommand(qu, mc);
        mcomm.Parameters.AddWithValue("@pwd", pwd);
        mcomm.ExecuteNonQuery();
        Response.Redirect("profuser.aspx?nick=" + nc);
        
            
         %>
</body>
</html>
