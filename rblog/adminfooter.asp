<center>
<span class="ftr">
<nobr>
<% If (Session("Clearance") = "system") Then %>
<a href="/admin.asp">Add Administrators</a> 
<a href="/admin.asp?edit">Edit Administrators</a> + 
<a href="/adminusers.asp?add">Add Users</a> - 
<a href="/adminusers.asp?edit">Edit Users</a> - 
<a href="/adminusers.asp?delete">Delete Users</a> + 
</nobr>
<nobr>
<a href="/adminadd.asp">Add Item</a> - 
<a href="/adminadd.asp?edit">Edit Item</a> - 
<a href="/adminadd.asp?delete">Delete Item</a> + 
<% End If %>
<a href="adminlogit.asp?out">Admin Log out</a></nobr>
</span>
</center>