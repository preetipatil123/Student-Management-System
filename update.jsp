<%@ page import="java.sql.*" %>
<html>
<head>
    <Title>Student Management System</Title>
    <link rel="stylesheet" href="mystyle.css">
<script>
    function validateForm() {
        var name = document.forms["recordForm"]["name"].value;

        if (!name.match(/^[A-Za-z]+$/)) {
            alert("Name should contain only alphabets.");
            document.forms["recordForm"]["name"].focus();
            document.forms["recordForm"]["name"].value = "";
            return false;
        }

        if (name.trim() === "") {
            alert("Name should not be empty or contain only spaces.");
            document.forms["recordForm"]["name"].focus();
            return false;
    }
    }
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
    </div>
    <h1> UPDATE RECORD</h1>
    
    <form name="recordForm" method="post" onsubmit="return validateForm()">
        <input type="number" name="rno" placeholder="enter the rno" required min="1"><br><br>
        <input type="text" name="name" placeholder="enter the name" required><br><br>
        <input type="number" name="marks" placeholder="enter the marks" required min="0" max="100"><br><br>
        <input type="Submit" value="Update" name="btn">
	  <br><br>
      <input type="button" value="Back" onclick="goBack()">
    </form>
    <%
        if (request.getParameter("btn") != null) {
            int rno = Integer.parseInt(request.getParameter("rno"));
            String name = request.getParameter("name");
            int marks = Integer.parseInt(request.getParameter("marks"));
	String action = request.getParameter("action");
            try {
                DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                String url = "jdbc:mysql://localhost:3306/st_aug4";
                Connection con = DriverManager.getConnection(url, "root", "abc123");
                String checkSql = "SELECT * FROM student WHERE rno=?";
                PreparedStatement checkPst = con.prepareStatement(checkSql);
                checkPst.setInt(1, rno);
                ResultSet resultSet = checkPst.executeQuery();
                
                if (!resultSet.next()) {
                    out.println("Roll number " + rno + " does not exist.");
                } else if (action != null && action.equals("back")) {
                response.sendRedirect("Main.jsp"); // Redirect to Main.jsp
           	 } else {
                    String sql = "UPDATE student SET name=?, marks=? WHERE rno=?";
                    PreparedStatement pst = con.prepareStatement(sql);
                    pst.setString(1, name);
                    pst.setInt(2, marks);
                    pst.setInt(3, rno);
                    pst.executeUpdate();
                    out.println("Record updated successfully");
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
