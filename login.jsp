<%@ page import="java.sql.*" %>

<html>
<head>
	<title>Student Management System - Admin Login</title>
	<link rel="stylesheet" href="mystyle.css">
</head>
<body>
<center>
<div class="container">
	<div class="topnav">
		<a href="index.jsp">Home</a>
	</div>
	
	<h1>Admin Login Page</h1>
	<form method="post">
		<input type="text" name="un" placeholder="Enter your name" required pattern="[A-Za-z]+" title="Only letters are allowed"><br><br>
		<input type="password" name="pw" placeholder="Enter password" required><br><br>
		<input type="submit" value="Login" name="btn"><br><br>
		<a href="Signup.jsp" style="color: #000080;">SignUp</a>
	</form>

	<%
	if (request.getParameter("btn") != null) {
		String un = request.getParameter("un");
		String pw = request.getParameter("pw");

		if (un.trim().isEmpty()) {
			out.println("Username cannot be empty.");
		} else if (pw.trim().isEmpty()) {
			out.println("Password cannot be empty.");
		} else {
		try {
		DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
		String url = "jdbc:mysql://localhost:3306/st_aug4";
		Connection con = DriverManager.getConnection(url, "root", "abc123");
		String sql = "select * from login where un=? and pw=?";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setString(1, un);
		pst.setString(2, pw);
		ResultSet rs = pst.executeQuery();
				
				if (rs.next()) {
					session.setAttribute("un", un);
					response.sendRedirect("Main.jsp");
				} else {
					out.println("Invalid login.");
				}

				con.close();
			} catch (SQLException e) {
				out.println("SQL issue: " + e);
			}
		}
	}
	%>
</div>
</center>
</body>
</html>
