<%@ page import="java.sql.*"%>
<html>
<head>
	<Title>Student Management System</Title>
	<link rel="stylesheet" href="mystyle.css">
</head>
<body>
<center>

	<div class="nav">
	<div class="topnav">
  	<a class="active"

	<a href ="create.jsp"> Create</a>
	<a href ="view.jsp"> View</a>
	<a href ="update.jsp"> Update</a>
	<a href ="delete.jsp"> Delete</a>
	</div>
	

</div>
	<h1> VIEW RECORD</h1>

	<table border="5" style="width:80%">
	<tr>
	<th>Rno</th>
	<th>Name</th>
	<th>Marks</th>
	</tr>

<%
try
{
    DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
    String url="jdbc:mysql://localhost:3306/st_aug4";
    Connection con=DriverManager.getConnection(url,"root","abc123");
    String sql="select * from Student";
    PreparedStatement pst=con.prepareStatement(sql);
    ResultSet rs=pst.executeQuery();
    while(rs.next())
    {
        %>
        <tr>
            <td><%= rs.getInt("Rno") %></td>
            <td><%= rs.getString("Name") %></td>
            <td><%= rs.getInt("Marks") %></td>
        </tr>
	
        <%
    }
    con.close();
}
catch(SQLException e)
{
    out.println("sql issue"+e);
}
%>


</table>
</center>
</body>
</html>
