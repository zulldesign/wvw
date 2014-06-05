<%
for each item in request.servervariables
%>
<% =item %> is <% =request.servervariables(item) %><br>
<%
next
%>