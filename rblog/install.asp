<!--#include file="./rss/incinstall.asp"-->
<%
Dim dirz
'  Installation Program

' Step 1: Get you bearings
' Step 2: Make sure you have two key directories:
'	- www/rss
'   - www/data
' Step 3: Make sure you can write to:
'	- www/rss
'   - www/data
' Step 4: Make sure you have a useable database
' Step 5: Build an Admin ID
' Step 6: Check for capabilities and record them.

Steps = Request.Form("Step")
If Len(Request.QueryString("Step")) > Request.Form("Step") Then
	Steps = Request.QueryString("Step")
End If

Select Case Steps
Case "1"
' Step 1: Get your bearings

' mask out the script name
wya = Request.ServerVariables("APPL_PHYSICAL_PATH")
Session("wya") = wya
%>
<% Call Heading() %>
From the looks of it. Your main web directory is located at:
<nobr><% =wya %></nobr>
<br>
<form action="install.asp" method=post>
<%
Session("rootpath") = wya
'dirz = split(Session("wya"),"\")
'rootpath = dirz(0) & "\"
'For x = 1 to UBound(dirz) - 1
'	rootpath = rootpath  & "\" & dirz(x)
'Next
%>
<input type=hidden name="rootpath" value="<%=rootpath %>">
<input type=hidden name="Step" value="2">
<input type="submit" value="YES. On to Step Two">
</form>

<form action="install.asp" method=post>
<input type=hidden name="Step" value="1.1">
<input type="submit" value="No. Manually enter the path">
</form>
<% Call Footing() 

Case "1.1"
%>
<% Call Heading() %>
The system thinks that the right directory is :
<nobr><% =Session("wya") %></nobr>
<br>
<form action="install.asp" method=post>
Put in the web directory that you think it is:
<input type=text name="path" size=50 value="<%=Session("wya") %>"><br>
Put in the root directory that you think it is:
<%
rootpath = Session("wya")
%>
<input type=text name="rootpath" size=50 value="<%=rootpath %>">
<input type=hidden name="Step" value="1.2">
<input type="submit" value="Proceed to Step Two">
</form>
<% Call Footing() %>
<%
Case "1.2"
	Session("wya") = Request.Form("Path")
	Session("rootpath") = Request.Form("rootpath")
	Response.Redirect("install.asp?Step=2")
Case "2"
	If Len(Session("rootpath")) < Len(Request.Form("rootpath")) Then
		Session("rootpath") = Request.Form("rootpath")
	End If
%>
<% Call Heading() %>
<%
' Step 2: Make sure you have three key directories:
'	- www/rss
'   - www/data

	If CheckDir(".\rss") = FALSE Then
	%>&middot; You need a subdirectory called "rss". It needs to be writable by the server so that you can store graphics and documents<br><%
		busted = 1
	End If

	FirstPass = "."
	AllBad = 0

	If CheckDir("data") = TRUE Then
			Session("DataDir") = "\data"
			AllBad = 1
	End If
	If CheckDir("database") = TRUE Then
			Session("DataDir") = "\database"
			AllBad = 1
	End If
	If CheckDir("db") = TRUE Then
			Session("DataDir") = "\db"
			AllBad = 1
	End If
	If CheckDir("..\data") = TRUE Then
			Session("DataDir") = "..\data"
			AllBad = 1
	End If
	If CheckDir(".\data") = TRUE Then
			Session("DataDir") = "\data"
			AllBad = 1
	End If
	If CheckDir(".\database") = TRUE Then
			Session("DataDir") = "\database"
			AllBad = 1
	End If
	If CheckDir(".\db") = TRUE Then
			Session("DataDir") = "\db"
			AllBad = 1
	End If
	If CheckDir("..\data") = TRUE Then
			Session("DataDir") = "..\data"
			AllBad = 1
	End If
	If CheckDir("..\database") = TRUE Then
			Session("DataDir") = "..\database"
			AllBad = 1
	End If
	If CheckDir("..\db") = TRUE Then
			Session("DataDir") = "..\db"
			AllBad = 1
	End If
	If CheckDir("www\data") = TRUE Then
			Session("DataDir") = "www\data"
			AllBad = 1
	End If
	If CheckDir("www\database") = TRUE Then
			Session("DataDir") = "www\database"
			AllBad = 1
	End If
	If CheckDir("www\db") = TRUE Then
			Session("DataDir") = "www\db"
			AllBad = 1
	End If
	If AllBad = 0 Then
		%>&middot; You need a directory called "data" or one called "database" or even "db". This is where you store your databases. Also, it should exist in the level ABOVE the web directory so that it is more secure.<br><%
			busted = 1
	End If
	If busted = 1 Then
	%>
	Stop, fix this problem with the use of an FTP program, or the the assistance of your sysadmin.
	<br>
	When you feel you are ready then:
	<form action="install.asp" method=post>
	<input type=hidden name="Step" value="2">
	<input type="submit" value="Try Step Two Again">
	</form>
	<% Else %>
	The critical directories appear to be in place. 
	<form action="install.asp" method=post>
	<input type=hidden name="Step" value="3">
	<input type="submit" value="Proceed to Step Three">
	</form>
	<% End If %>
<% Call Footing() %>
<%
Case "3"
' Step 3: Make sure you can write to:
'	- www/includes
'	- www/graphics
'   - data/
%>
<% Call Heading() %>
<font color=#0000AA><%
	If CheckWritable(".\rss") = FALSE Then
	%>&middot; The subdirectory called "rss" needs to be writable by the server so that you can store system files<br><%
			busted = 1
	End If
	If CheckWritable(Session("DataDir")) = FALSE Then
	%>&middot; The directory called <% =Session("DataDir") %> needs to be writable by the server so that you can store data<br><%
			busted = 1
	End If
	If busted = 1 Then
	%>
	Stop, fix this problem with the assistance of your sysadmin.
	<br>
	When you feel you are ready then:
	</font>
	<% Else %>
	</font>
	The critical directories appear to be functioning. 
	<% End If %>

<form action="install.asp" method=post>
<input type=hidden name="rootpath" value="<%=Session("rootpath") %>">
<input type=hidden name="path" value="<%=Session("wya") %>">
<input type=hidden name="DataDir" value="<%=Session("DataDir") %>">
<input type=hidden name="WebDir" value="<%=Session("WebDir") %>">
<input type=hidden name="Provider" value="<%=Session("Provider") %>">
<input type=hidden name="Step" value="4">
<input type="submit" value="Proceed to Step Four">
</form>
<% Call Footing() %>
<%
Case "4"
' Step 4: Make sure you have a useable database
' cycle through the different connection strings until you find something that works.
If Len(Session("wya")) < Len(Request.Form("path")) Then
	Session("wya") = Request.Form("path")
End If
If Len(Session("rootpath")) < Len(Request.Form("rootpath")) Then
	Session("rootpath") = Request.Form("rootpath")
End If
If Len(Session("DataDir")) < Len(Request.Form("DataDir")) Then
	Session("DataDir") = Request.Form("DataDir")
End If
If Len(Session("WebDir")) < Len(Request.Form("WebDir")) Then
	Session("WebDir") = Request.Form("WebDir")
End If

thePath = Session("DataDir")
Set objFS = Server.CreateObject("Scripting.FileSystemObject")
Set objFolder = objFS.GetFolder(Server.MapPath(thePath))

k = 0
Dim databases(30)
For Each objItem In objFolder.Files
	specimen = LCase(objItem.Name)
	extn = right(specimen,4)
	If extn = ".mdb" Then
		databases(k) = specimen
		k = k + 1
	End If
Next
%><font color=#22AA00><%

For j = 0 to k
	If adminmdb <> 1 And databases(j) = "admin.mdb" Then
		adminmdb = 1
		%>&middot; The Admin Database is available<br><%
	End If 
	If rblogmdb <> 1 And databases(j) = "rblog.mdb" Then
		rblogmdb = 1
		%>&middot; The RBlog Database is available<br><%
	End If 
Next

%></font><%
	If adminmdb <> 1 Or rblogmdb <> 1 Then
		If adminmdb <> 1 Then
		%><font color=#22AA00>&middot; You need the Admin Database. <br>
		Stop, fix this problem with the use of an FTP program, or the the assistance of your sysadmin. Find the file and post it to the website. <br>
		The admin database should be in the /data directory and it should be named "admin.mdb" <br>
		Without it, you cannot control your web site data.</font><%
		End If
		If rblogmdb <> 1 Then
		%><br><font color=#22AA00>&middot; You need an RBlog Database. <br>
		Stop, fix this problem with the use of an FTP program, or the the assistance of your sysadmin. Find the file and post it to the website. <br>
		The admin database should be in the /data directory and it should be named "rblog.mdb" <br>
		Without it, you cannot control your web site features and add new features as they become available.</font><%
		End If
	End If 

' what sort of database access query will we need?

Set ObjConn = Server.CreateObject("ADODB.Connection")
On Error Resume Next
Provision = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="
DataSource = Provision & Session("rootpath") & Session("DataDir") & "\rblog.mdb"
ObjConn.Open DataSource

If Err.Number <> 0 Then
	ObjConn.Close
	Set ObjConn = Server.CreateObject("ADODB.Connection")
	Provision = "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="
	DataSource = Provision & Session("rootpath") & Session("DataDir") & "\rblog.mdb"
	secondtest = " "
	ObjConn.Open DataSource
	Set RS = ObjConn.Execute("SELECT ID From Users")
	If Not(RS.EOF) Then
		RS.MoveFirst
		secondtest = RS("Title")
		RS.Close	
	End If

	Response.Write("<br>" & Err.Description &  "<br>" & DataSource)

	If secondtest = " " Then
		ObjConn.Close
		%><font color=#22AA00>&middot; Your server needs to be able to use OLE Automation and the Jet 4.0 database engine OR an ODBC File DSN access. Make the fix and hit "REFRESH" <br></font><%
	Else
		ObjConn.Close
		Session("Provider") = Provision
		%>
		<form action="install.asp" method=post>
		<input type=hidden name="Step" value="5">
		<input type="submit" value="Proceed to Step Five">
		</form>
		<%		
	End If
Else
	ObjConn.Close
	Session("Provider") = Provision
	%>
	<form action="install.asp" method=post>
	<input type=hidden name="Step" value="5">
	<input type="submit" value="Proceed to Step Five">
	</form>
	<%
End If

Case "5"
' Step 5: Build an Admin ID

' check to see if there's any updated news...
If Len(Session("wya")) < Len(Request.Form("path")) Then
	Session("wya") = Request.Form("path")
End If
If Len(Session("rootpath")) < Len(Request.Form("rootpath")) Then
	Session("rootpath") = Request.Form("rootpath")
End If
If Len(Session("DataDir")) < Len(Request.Form("DataDir")) Then
	Session("DataDir") = Request.Form("DataDir")
End If

Call Heading()
Set ObjConn = Server.CreateObject("ADODB.Connection")
DataSource = Session("Provider") & Session("rootpath") & Session("DataDir") & "\admin.mdb"
ObjConn.Open DataSource

Set RS = ObjConn.Execute("SELECT ID From Admin WHERE UserName = 'Admin'")
If Not(RS.EOF) Then
	RS.Close
	ObjConn.Close
	%><h2 style="font-color : #880000;">Setup cannot continue</h2>
	There is alway an active administrator account in the database.
<%
Else
%>
<form action="install.asp" method=post>
Input an admin password: <br>
Username : Admin<br>
Password : <input type=text name="Password"><br>
Email : <input type=text name="EmailAddress"><br>
<input type=hidden name="Step" value="5.1">
<input type="submit" value="Proceed to Step Six">
</form>
<% End If 
Call Footing()
Case "5.1"
' Save that password

If checkValid(Request.Form("Password")) = FALSE Then
	Response.Redirect("install.asp?Step=5")
End If

DataSource = Session("Provider") & Session("rootpath") & Session("DataDir") & "\admin.mdb"

Set ObjConn = Server.CreateObject("ADODB.Connection")
ObjConn.Open DataSource

Set RS = ObjConn.Execute("SELECT ID From Admin WHERE UserName = 'Admin'")
Session("EmailAddress") = Request.Form("EmailAddress")
	If RS.EOF Then
	RS.Close
	ObjConn.Close

	Set InsConn = Server.CreateObject("ADODB.Connection")
	InsConn.Open DataSource

	InsStatement = "INSERT Into Admin ([UserName],[Password],[Level]) VALUES ('Admin','" & Request.Form("Password") & "','system')"
	' Response.Write(InsStatement)
	Set qryInsert = InsConn.Execute(InsStatement)

	InsConn.Close 
	Set InsConn=Nothing	

	Response.Redirect("install.asp?Step=6")
Else
	Call Heading()
	%><h2 style="font-color : #880000;">Setup cannot continue</h2>
	There is alway an active administrator account in the database.
	<%
	Call Footing()
End If
Case "6"
' Step 6: Check for capabilities and options; and record them.

	Call Heading()
	%>
	<form action="install.asp" method=post>
	<input type=hidden name="rootpath" value="<%=Session("rootpath") %>">
	<input type=hidden name="path" value="<%=Session("wya") %>">
	<input type=hidden name="DataDir" value="<%=Session("DataDir") %>">
	<input type=hidden name="WebDir" value="<%=Session("WebDir") %>">
	<input type=hidden name="EmailAddress" value="<%=Session("EmailAddress") %>">
	<input type=hidden name="Step" value="7">
	<input type="submit" value="Finish">
	</form>	
	<%
	Call Footing()
Case "7"
' Step 7: Done! Write this information to a file: locales.asp

If Right(Session("rootpath"),1) = "\" Then
	Session("rootpath") = Left(Session("rootpath"),Len(Session("rootpath"))-1)
End If
TheFile = Replace(Session("rootpath") & Session("DataDir") & "\locales.asp","\\","\")

Response.Write(TheFile)

Set FileStreamObject = Server.CreateObject("Scripting.FileSystemObject")
Set WriteStream = FileStreamObject.CreateTextFile(TheFile,True)

WriteStream.WriteLine("<" & "%")
WriteStream.WriteLine("' Data Access Style")
WriteStream.WriteLine("Dim DataProvider")
WriteStream.WriteLine("DataProvider = " & Chr(34) & Session("Provider") & Chr(34))

WriteStream.WriteLine(" ")
WriteStream.WriteLine("' File Locations")
WriteStream.WriteLine("Dim LocalGroup")
WriteStream.WriteLine("Dim DataDir")
WriteStream.WriteLine("Dim WebDir")
WriteStream.WriteLine("Dim TheEmailAddress")

WriteStream.WriteLine("LocalGroup = " & Chr(34) & Session("rootpath") & Chr(34))
WriteStream.WriteLine("DataDir = " & Chr(34) & Session("DataDir") & Chr(34))
WriteStream.WriteLine("WebDir = " & Chr(34) & Session("WebDir") & Chr(34))
WriteStream.WriteLine("TheEmailAddress = " & Chr(34) & Session("EmailAddress") & Chr(34))
WriteStream.WriteLine("%" & ">")
WriteStream.Close


Set FileStreamObject = Server.CreateObject("Scripting.FileSystemObject")
Set WriteStream = FileStreamObject.CreateTextFile(Server.MapPath ("./") & "\rss\" & "incinstall.asp",True)

WriteStream.WriteLine("<" & "%")
WriteStream.WriteLine("Response.Redirect(""/"")")
WriteStream.WriteLine("%" & ">")
WriteStream.Close

	%><h2>Complete</h2>
	<h4 style="font weight=normal;">Congratulations! The set-up is complete. You can now <a href="/admin/">login</a> and administer your website.</h4>
	<%
	Call Footing()

Case Else
	Call Heading()
' Step 0
' Welcome!
	%><h2>Welcome</h2>
	<h4 style="font weight=normal;">Over the next few minutes we will go through a number of steps. They will establish where your data is going, if it is properly formatted and if you can add new material. You will also be prompted to create and administrative account so that you log in and make changes to your copy of RBlog. 
	
	A quick rundown:
	<dl>
	<dt>You need to have the following directories:
	<dt>
	<ul>
		<li>data/ (or database/)
		<li>www/ (or web/)
		<li>www/rss
	</ul>
	<dt>You need the following directories to be "writable":
	<dt>
	<ul>
		<li>www/rss
		<li>data/ (or database/)
	</ul>	
	<dt>
	<dt>Plan your admin password. Write it down somewhere or otherwise keep it safe. 
	</dl>

	<font color=red><b>
	You will only be able to go through the installation procedure ONCE. If you do not 
	complete the procedure, you may start again. If have to repeat the process, <a href="mailto:mike@dewolfe.bc.ca?subject=installation help!">contact us</a> for information or refer to your HELP files.
	</b></font>

	<form action="install.asp" method=post>
	<input type=hidden name="Step" value="1">
	Time to : <input type="submit" value="Begin">
	</form>

	</h4>
	<%
	Call Footing()
End Select

Sub Heading() %>
<html>
<title>RBlog Installation <% If Len(Request.Form("Step")) > 0 Then %>Step <% Else %>Let's Begin<% End If %> <% =Request.Form("Step") %></title>
<body>
<% End Sub %>
<% Sub Footing() %>
</body>
</html>
<% End Sub %>
<%
Function CheckObject(objet)
	On Error Resume Next
	Set LookSee = Server.CreateObject(objet)
	If Err.Number <> 0 Then
		Set LookSee = Nothing
		CheckObject = FALSE
	Else
		Set LookSee = Nothing
		CheckObject = TRUE
	End If
End Function

Function CheckDir(thePath)
	On Error Resume Next
	Set objFS = Server.CreateObject("Scripting.FileSystemObject")
	Set objFolder = objFS.GetFolder(Server.MapPath(thePath))
	
	Set objFolder=Nothing
	Set objFS = Nothing

	If Err.Number = 0 Then
		CheckDir = TRUE
	Else
		CheckDir = FALSE
	End If
End Function

Function CheckWritable(thePath)
	On Error Resume Next
	Set FileStreamObject = Server.CreateObject("Scripting.FileSystemObject")
	Set WriteStream = FileStreamObject.CreateTextFile(Server.MapPath (thePath) & "\" & "text.txt")
	If Err.Number = 0 Then
		WriteStream.Close
		FileStreamObject = Nothing
		CheckWritable = TRUE
	Else
		WriteStream.Close
		FileStreamObject = Nothing
		CheckWritable = FALSE
	End If
End Function

Function checkValid(arg)
	If Len(arg) > 1 Then 
		Dim funcObjRegExp
		Set funcObjRegExp = New Regexp
		funcObjRegExp.IgnoreCase = True
		funcObjRegExp.Global = True
		funcObjRegExp.Pattern = "[a-zA-Z_\-0-9]*"
		If IsEmpty(arg) OR IsNull(arg) Then
			checkValid = FALSE
		End If
		If (funcObjRegExp.Test(arg)) Then
			checkValid = TRUE
		Else
			checkValid = FALSE
		End If
	Else
		checkValid = FALSE
	End If
End Function

Function ModuleOrg(ThisDB)
	DataSource = Session("Provider") & Session("rootpath") & Session("DataDir") & "\" & ThisDB

	Set InsConn = Server.CreateObject("ADODB.Connection")
	InsConn.Open DataSource

	On Error Resume Next
	Set RS = InsConn.Execute("SELECT * FROM Version ORDER BY ID DESC")
	RS.MoveFirst
	If Err.Number <> 0 Then
		Response.Write("<font color=red><!--" & Err.Number & "-->You have a problem with the registration of the '" & ThisDB & "' database for a RBlog modules</font><br>")
	Else
		ModuleName = RS("ModuleName")
		ModuleDescrip = RS("ModuleDescrip")
		Version = RS("Version")
		Author = RS("Author")
		ContactInfo = RS("ContactInfo")

		RS.Close
		InsConn.Close
		InsConn=Nothing

		DataSource = Session("Provider") & Session("rootpath") & Session("DataDir") & "\modules.mdb"

		Set InsConn = Server.CreateObject("ADODB.Connection")
		InsConn.Open DataSource

		InsStatement = "INSERT Into Modules (ModuleName,ModuleDescrip,Version,Author,ContactInfo) VALUES (" & CheckString(ModuleName) & "," & CheckString(ModuleDescrip) & "," & CheckString(Version) & "," & CheckString(Author) & "," & CheckString(ContactInfo) & ")"

		Set qryInsert = InsConn.Execute(InsStatement)

		InsConn.Close
		InsConn=Nothing
	End If
End Function

Function CheckString (s)
pos = InStr(s, "'")
While pos > 0
	s = Mid(s, 1, pos) & "'" & Mid(s, pos + 1)
	pos = InStr(pos + 2, s, "'")
	Wend
	If Len(s) < 1 Then
		s = " "
	End If
	If Request.Form("verbatim") <> "yes" Then
		s = Replace("" & s,vbCRLF,"<br>")
	End If
	s = Replace("" & s,"<br><br><br>","<br>")
	CheckString="'" & s & "'"
End Function
%>