<%@ page import="java.sql.*"%>
<html>
<head>
<title>Student Management System</title>
<head>
	<title> Logout</title>
	<link rel="stylesheet" href="mystyle.css">
<div class="topnav">
<a class="active"
</div>

</head>
<body>
<center>

<form>
<input type="submit" value="Logout" name="btn" onclick="return confirmLogout()" class="button" onclick="msg()"/>

</form>
<%
response.sendRedirect("index.jsp");

%>
</center>
</body>
</html>


