<%@ Import Namespace="System.Data.OleDb" %>

<script runat="server">
sub Page_Load
dim dbconn
dbconn=New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;
data source=" & server.mappath("acm2000.mdb"))
dbconn.Open()
end sub
dim user as string = "admin"
dim pass as string = "1234"
dim uploadpath as string = server.MapPath("images\") '"
</script>


