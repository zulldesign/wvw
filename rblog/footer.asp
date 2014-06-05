<br>
<center>
<nobr><span class="ftr">
<a href="/default.asp">Home Page</a> - 
<a href="/searchfeeds.asp">Search</a> - 
<a href="/add.asp">Add</a> - 
<a href="/add.asp?edit">Edit</a> - 
<a href="/add.asp?delete">Delete</a> - 
<% If Len(Session("UserName")) > 2 Then %>
<a href="/rss/<% =Replace(Session("UserName")," ","_") %>.xml">See your RSS file</a> - 
<% End If %>
<a href="/users.asp"><% If Len(Session("UserName")) > 2 Then %>Edit Your<% Else %>Add A<% End If %> Profile</a>
<% If Len(Session("UserName")) > 2 Then %> - 
<a href="/logit.asp?out">Log out</a>
<% End If %>
</span>
</nobr>
</center>
