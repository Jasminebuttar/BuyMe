<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Log into your account</title>
</head>
<body>

<%@include file="header.jsp" %>
<%@include file="subheader.jsp" %>

<%

try
{
	//Get the database connection
	//URL of DB
	String connectionUrl = "jdbc:mysql://mydb.c1trsunp1o0n.us-east-2.rds.amazonaws.com:3306/BuyMe";
	Connection con = null;
		
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

	// get the username and password the user typed into the input boxes
	String userName = request.getParameter("username");
	String password = request.getParameter("password");

	//Create a SQL statement
	Statement stmt = con.createStatement();	
	
	// this query will get the number of users with the username that the user wants to log in with
	String str = "SELECT COUNT(*) as count FROM User WHERE username = \"" + userName + "\"";
	
	// execute the query
	ResultSet result = stmt.executeQuery(str);
	result.next();
	
	//get the count
	int userCount = result.getInt("count");
	
	// if that username already exists then we need to make sure the password matches
	if (userCount >= 1)
	{
		str = "SELECT * FROM User WHERE username = \"" + userName + "\"";
		
		//execute the query
		result = stmt.executeQuery(str);
		result.next();

		// get the password returned from the database
		String db_password = result.getString("password");
		
		// check if the password given by the user matches the password in the database
		if (password.equals(db_password))
		{
			// if so then they have successully logged in
			String username = result.getString("username");
			String firstName = result.getString("firstName");
			String lastName = result.getString("lastName");
			String email = result.getString("email");
			String street = result.getString("street");
			String city = result.getString("city");
			String county = result.getString("county");
			String zip = result.getString("zip");
			String state = result.getString("state");
			Boolean isAdmin = result.getBoolean("isAdmin");
			Boolean isCustRep = result.getBoolean("isCustRep");
			String dob = result.getString("dob");
			
			User thisUser = new User(username, firstName, lastName, email, street, city, county, zip, 
										state, isAdmin, isCustRep, dob, password);
			
			session.setAttribute("currentUser", thisUser);
			
%>
			 <jsp:forward page="index.jsp"/>
<%
		}
		// otherwise the password was wrong and they need to try again
		else
		{
%>			
			<div class="center">
				<p><b>Wrong password! Please try again.</b></p>
						
				<form method="post" action="signinsubmit.jsp"> 
				<label>Username:</label>
				<input type="text" name="username">
				<label>Password:</label>
				<input type="password" name="password">
				<br>
				<input type="submit" value="submit">
				</form>
				
				<p><a href="forgotpassword.jsp">Forgot your password?</a></p>
				
			</div>
<%			
		}
	}
	// the username the user tried to use does not exist
	else
	{	
		// create HTML to tell the user that the username does not exist
%>

	<p><b>That user name does not exist.<br>
		  Either try another one or create an account using that user name</b></p>
				
	<br><p><a href="register.jsp">Create Account</a>				
<%
	}
	
	// close out the connection to the database
	con.close();
	
} catch (Exception ex) {
	out.print(ex);
	out.print("<p> Failed to log in to your account. Click back and try again </p>");
}

%>

</body>
</html>