<%@ Page Language="vb" Debug=true %>
<%@ import Namespace="System.Data.OLEDB" %>
<!-- #INCLUDE FILE="include.aspx" -->       
<script runat="server" language="vb">
	dim mydata as string

    Sub Page_Load(sender As Object, e As EventArgs)
	Dim queryvalue = Request.QueryString("id")
If (IsNumeric(queryvalue)) then
        Dim query As String = "Select pagedata FROM tblpages WHERE id = " & queryvalue & ";"
        Dim myConn As New OleDbConnection("PROVIDER=Microsoft.Jet.OLEDB.4.0;DATA SOURCE="Server=e0bed636-e6cb-4e30-af20-a39f00344be0.sqlserver.sequelizer.com;Database=dbe0bed636e6cb4e30af20a39f00344be0;User ID=jesiauovhkmgskon;Password=sZ5ebqHqSyDKmR2LfsExoGNm3snC65B5WqVqUCchHBJJs7MHE2iA2jrSmRjRdetV;"")
        Dim myCmd As OleDbCommand = New OleDbCommand(query, myConn)
        myConn.Open()
        Dim myReader As OleDbDataReader = myCmd.ExecuteReader()
		
        While myReader.Read()
        	mydata = (myReader("pagedata").tostring)
		End While

        'close connections'
        myReader.Close()
        myConn.Close()
        MyConn = Nothing
Else
        Dim query As String = "Select pagedata FROM tblpages WHERE homepage = 1;"
        Dim myConn As New OleDbConnection("PROVIDER=Microsoft.Jet.OLEDB.4.0;DATA SOURCE="Server=e0bed636-e6cb-4e30-af20-a39f00344be0.sqlserver.sequelizer.com;Database=dbe0bed636e6cb4e30af20a39f00344be0;User ID=jesiauovhkmgskon;Password=sZ5ebqHqSyDKmR2LfsExoGNm3snC65B5WqVqUCchHBJJs7MHE2iA2jrSmRjRdetV;"")
        Dim myCmd As OleDbCommand = New OleDbCommand(query, myConn)
        myConn.Open()
        Dim myReader As OleDbDataReader = myCmd.ExecuteReader()
		
        While myReader.Read()
	        mydata = (myReader("pagedata").tostring)
		End While

        'close connections'
        myReader.Close()
        myConn.Close()
        MyConn = Nothing
End if
		
	End Sub
</script>
<%=mydata%>
