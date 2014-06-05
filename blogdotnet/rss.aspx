<%@ Page Language="C#" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<%@ Import Namespace="System.Text" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
   <!-- #include virtual="config.inc" -->
    <%
       
       Response.Clear();

        Response.ContentType = "text/xml";

        XmlTextWriter xtwFeed = new XmlTextWriter(Response.OutputStream, Encoding.UTF8);

        xtwFeed.WriteStartDocument();

        // The mandatory rss tag

        xtwFeed.WriteStartElement("rss");

        xtwFeed.WriteAttributeString("version", "2.0");

        // The channel tag contains RSS feed details

        xtwFeed.WriteStartElement("channel");
        

        xtwFeed.WriteElementString("title", Convert.ToString(Session["titoloblog"]));

        xtwFeed.WriteElementString("link", "http://" + Request.ServerVariables["SERVER_NAME"]);

        xtwFeed.WriteElementString("description", "The latest news");

        xtwFeed.WriteElementString("copyright", "");

        // Objects needed for connecting to the SQL database

        MySqlConnection SqlCon;

        MySqlCommand SqlCom;

        MySqlDataReader SqlDR;

        // Edit to match your connection string
        //string sconn = "Data Source=localhost;User Id=root;Password=alex;Database=blogdn;";

        //SqlCon = new MySqlConnection(sconn);
        
        SqlCon = mc; 
        
        // Edit to match your stored procedure or SQL command

        SqlCom = new MySqlCommand("SELECT * FROM news  WHERE idn> ALL (SELECT MAX(idn) - 10  FROM news) ORDER BY idn DESC", SqlCon);


        SqlCom.CommandType = CommandType.Text;


        if (SqlCon.State == ConnectionState.Closed)
        {

            SqlCon.Open();

        }

        SqlDR = SqlCom.ExecuteReader();

        // Loop through the content of the database and add them to the RSS feed

        while (SqlDR.Read())
        {

            xtwFeed.WriteStartElement("item");

            xtwFeed.WriteElementString("title", SqlDR["titolon"].ToString());

            xtwFeed.WriteElementString("description", SqlDR["autore"].ToString());

            xtwFeed.WriteElementString("link", "http://"+Request.ServerVariables["SERVER_NAME"] +"/blogdotnet/displaycomm.aspx?idn=" + SqlDR["idn"]);

            xtwFeed.WriteElementString("pubDate", SqlDR["datan"].ToString());

            xtwFeed.WriteEndElement();

        }

        SqlDR.Close();

        SqlCon.Close();

        // Close all tags

        xtwFeed.WriteEndElement();

        xtwFeed.WriteEndElement();

        xtwFeed.WriteEndDocument();

        xtwFeed.Flush();

        xtwFeed.Close();

        Response.End();
     
        
         %>
</body>
</html>
