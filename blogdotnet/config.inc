<%
string ServerIP="localhost";
string userid="root";
string password="alex";
string db="blogdotnet";
string sm ="Data Source="+ServerIP+";User Id="+userid+";Password="+password+";Database="+db+";Max Pool Size=150;";
 MySqlConnection mc = new MySqlConnection(sm);
%>