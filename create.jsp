<%@ page import="java.sql.*"%>
<html>
<head>
  <title>Student Management System</title>
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
    <div class="nav">
      <div class="topnav">
        <a href="create.jsp" class="active">Create</a>
        <a href="view.jsp">View</a>
        <a href="update.jsp">Update</a>
        <a href="delete.jsp">Delete</a>
      </div>
    </div>
    <h1>CREATE RECORD</h1>

    <form name="recordForm" method="post" onsubmit="return validateForm()">
      <input type="number" name="rno" placeholder="Enter the roll number" required min="1" max="100"><br><br>
      <input type="text" name="name" placeholder="Enter the name" required><br><br>
      <input type="number" name="marks" placeholder="Enter the marks" required min="0" max="100"><br><br>
      <input type="submit" value="Save" name="btn">
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

    String checkSql = "SELECT * FROM student WHERE rno = ?";
    PreparedStatement checkStmt = con.prepareStatement(checkSql);
    checkStmt.setInt(1, rno);
    ResultSet resultSet = checkStmt.executeQuery();

    if (resultSet.next()) {
      out.println("Roll number already exists. Please choose a different roll number.");
    } else if (rno < 1 || rno > 100) {
      out.println("Roll number should be between 1 and 100.");
    } else if (marks < 0 || marks > 100) {
      out.println("Marks should be between 0 and 100.");
    } else if (action != null && action.equals("back")) {
       response.sendRedirect("Main.jsp");
    } else {
      String sql = "INSERT INTO student VALUES (?, ?, ?)";
      PreparedStatement pst = con.prepareStatement(sql);
      pst.setInt(1, rno);
      pst.setString(2, name);
      pst.setInt(3, marks);
      pst.executeUpdate();
      out.println("Record created.");
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
