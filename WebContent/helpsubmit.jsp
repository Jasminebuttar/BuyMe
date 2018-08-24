<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%@include file="header.jsp" %>

<%

Connection con = null;

try
{
		
	//Get the database connection
	//URL of DB
	String connectionUrl = "jdbc:mysql://mydb.c1trsunp1o0n.us-east-2.rds.amazonaws.com:3306/BuyMe";
	
	
	try {
		//Load JDBC driver
		Class.forName("com.mysql.jdbc.Driver").newInstance();
	} catch (InstantiationException e) {
		e.printStackTrace();
	} catch (IllegalAccessException e) {
		e.printStackTrace();
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	}
	
	try {
		//connect to DB
		con = DriverManager.getConnection(connectionUrl,"louielou", "louielou");
	} catch (SQLException e) {
		e.printStackTrace();
	}

	// get the User object for the currently logged in user
	User current = (User) session.getAttribute("currentUser");
			
	if (current == null)
	{
		out.print("<p>Must be logged in to perform this action. Please create an account or log in</p>");
		
		return;
	}
	
	String username = current.getUsername();
	String question = request.getParameter("question");
	String category = request.getParameter("category");
	
	String insert = "INSERT INTO HelpRequest(user_username, question, sentdatetime, answered, category) VALUES(?, ?, NOW(), 0, ?)";
	
	Statement stmt = con.createStatement();
	
	//Create a Prepared SQL statement
	// all the question marks will be replaced with the values from the form and session
	PreparedStatement ps = con.prepareStatement(insert);
	
	//Add the parameters
	ps.setString(1, username);
	ps.setString(2, question);
	ps.setString(3, category);
	
	String whereClause = "WHERE ";
	
	if (session.getAttribute("where") != null)
	{
		whereClause = (String) session.getAttribute("where");
		whereClause = "category " + category;
		
	}
	
		// check to see if the WHERE clause was added to and we need to add an AND
		//if (!whereClause.equals("WHERE "))
	
	
	ps.executeUpdate();
	
	out.print("<p>Your help request was submitted. A response will be emailed to you.</p>");
	
	con.close();
	
} catch (Exception ex) {
	
	if (con != null)
		con.close();
	
	out.print(ex);
}

%>

</body>
</html>