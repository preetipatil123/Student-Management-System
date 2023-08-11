<%@ page import="java.sql.*" %>
<html>
<head>
    <title> Student Management System </title>
    <link rel="stylesheet" href="mystyle.css">

<script>

function goBack() {
        window.location.href = "Main.jsp"; 
    }
</script>
</head>
<body>
<center>
    <div class="topnav">
        <a class="active">
            <div class="nav">
                <a href="create.jsp"> Create</a>
                <a href="view.jsp"> View</a>
                <a href="update.jsp"> Update</a>
                <a href="delete.jsp"> Delete</a>
            </div>
        </a>
    </div>
    <h1> DELETE RECORD </h1>
    <form>
        <input type="number" name="rno" placeholder="enter the rno" required min="1">
        <br><br>
        <input type="Submit" value="Delete" name="btn">
	<br><br>
	 <input type="button" value="Back" onclick="goBack()">
	
    </form>
    <%
        if (request.getParameter("btn") != null) {
            int rno = Integer.parseInt(request.getParameter("rno"));

            try {
                DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                String url = "jdbc:mysql://localhost:3306/st_aug4";
                Connection con = DriverManager.getConnection(url, "root", "abc123");
                
                // Check if the roll number exists before deleting
                String checkSql = "SELECT * FROM student WHERE rno=?";
                PreparedStatement checkPst = con.prepareStatement(checkSql);
                checkPst.setInt(1, rno);
                ResultSet resultSet = checkPst.executeQuery();
                
                if (!resultSet.next()) {
                    out.println("Roll number " + rno + " does not exist.");
                } else 
		{
                    String deleteSql = "DELETE FROM student WHERE rno=?";
                    PreparedStatement pst = con.prepareStatement(deleteSql);
                    pst.setInt(1, rno);
                    int rowsDeleted = pst.executeUpdate();
                    out.println(rowsDeleted + " record(s) deleted");
                }
                
                con.close();
            } catch (SQLException e) {
                out.println("SQL issue: " + e);
            }
        }
    %>
</center>
</body>
</html>
