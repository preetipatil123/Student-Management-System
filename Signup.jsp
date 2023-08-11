<%@ page import="java.sql.*"%>
<html>
<head>
    <title> Student management system </title>
    <link rel="stylesheet" href="mystyle.css">
    <script>
        function validateForm() {
            var un = document.forms["signupForm"]["un"].value;
            var pw1 = document.forms["signupForm"]["pw1"].value;
            var pw2 = document.forms["signupForm"]["pw2"].value;

            if (un.includes(" ")) {
                alert("Spaces are not allowed in username.");
                return false;
            }

            if (pw1.includes(" ")) {
                alert("Spaces are not allowed in password.");
                return false;
            }

            if (pw2.includes(" ")) {
                alert("Spaces are not allowed in confirm password.");
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
<center>
    <h1> Signup Page </h1>
    <form name="signupForm" onsubmit="return validateForm()" method="post">

        <input type="text" name="un" placeholder="enter username" required>
        <br><br>
        <input type="password" name="pw1" placeholder="enter password" required>
        <br><br>
        <input type="password" name="pw2" placeholder="confirm password" required>
        <br><br>
        <input type="submit" value="Sign Up" name="btn">
        <br><br>
    </form>
 
    <%
        if (request.getParameter("btn") != null) {
            String un = request.getParameter("un");
            String pw1 = request.getParameter("pw1");
            String pw2 = request.getParameter("pw2");

            if (!pw1.equals(pw2)) {
                out.println("Passwords did not match");
            } else {
                try {
                    DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                    String url = "jdbc:mysql://localhost:3306/st_aug4";
                    Connection con = DriverManager.getConnection(url, "root", "abc123");
                    String sql = "insert into login values(?, ?)";
                    PreparedStatement pst = con.prepareStatement(sql);
                    pst.setString(1, un);
                    pst.setString(2, pw1);
                    pst.executeUpdate();
                    out.println("Sign Up successfully");
                    response.sendRedirect("login.jsp");
                    con.close();
                } catch (SQLException e) {
                    out.println("SQL issue: " + e);
                }
            }
        }
    %>
</center>
</body>
</html>
