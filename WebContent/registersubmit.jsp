<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create your account</title>
</head>
<body>

<%@include file="header.jsp" %>

<%

try
{
	//Get the database connection
	//URL of DB
	String connectionUrl = "jdbc:mysql://mydb.c1trsunp1o0n.us-east-2.rds.amazonaws.com:3306/BuyMe";
	Connection con = null;
	
	User current = (User) session.getAttribute("currentUser");
	
	if(current != null && current.getIsCustRep())
		return;
	
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

	// get the rest of the values from the form that the user submitted
	String firstName = request.getParameter("firstname");
	String lastName = request.getParameter("lastname");
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	String dob = year + "-" + month + "-" + day;
	String email = request.getParameter("email");
	String streetAddress = request.getParameter("streetaddress");
	String city = request.getParameter("city");
	String zip = request.getParameter("zipcode");
	String county = request.getParameter("county");
	String state = request.getParameter("state");
	String userName = request.getParameter("username");
	String password = request.getParameter("password");
	String retypepassword = request.getParameter("retypepassword");
	
	String alert = "";
	
	boolean bool = false;
	
	if(firstName.equals(""))
	{
		bool = true;
		alert += "<p><b>You must enter the First Name!</b></p>";
	}
	
	if(lastName.equals(""))
	{
		bool = true;
		alert += "<p><b>You must enter the Last Name!</b></p>";
	}
	
	if(email.equals(""))
	{
		bool = true;
		alert += "<p><b>You must enter the Email!</b></p>";
	}
	
	if(streetAddress.equals(""))
	{
		bool = true;
		alert += "<p><b>You must enter the streetAddress!</b></p>";
	}
	
	if(city.equals(""))
	{
		bool = true;
		alert += "<p><b>You must enter the City!</b></p>";
	}
	
	if(zip.equals(""))
	{
		bool = true;
		alert += "<p><b>You must enter the Zipcode!</b></p>";
	}
	
	if(county.equals(""))
	{
		bool = true;
		alert += "<p><b>You must enter the County!</b></p>";
	}
	
	if(userName.equals(""))
	{
		bool = true;
		alert += "<p><b>You must enter the Username!</b></p>";
	}
	
	if(password.equals(""))
	{
		bool = true;
		alert += "<p><b>You must enter the Password!</b></p>";
	}
	
	if(retypepassword.equals(""))
	{
		bool = true;
		alert += "<p><b>You must enter the Retype the Password!</b></p>";
	}
	
	if(!password.equals(retypepassword))
	{
		bool = true;
		alert += "<p><b>Your passwords do not match!!</b></p>";
	}

	if(bool == true)
	{
		out.print(alert);
	}

	else
	{
		

		//Create a SQL statement
		Statement stmt = con.createStatement();	
		
		// this query will get the number of users with the login that user wants to use as their own
		// we want to make sure the user picked a unique login
		String str = "SELECT COUNT(*) as count FROM User WHERE username = \"" + userName + "\"";
		
		// run the query
		ResultSet result = stmt.executeQuery(str);

		//Start parsing out the result of the query. Don't forget this statement. It opens up the result set.
		result.next();
		//Parse out the result of the query
		int userCount = result.getInt("count");
		
		// if that username already exists tell the user to try another one
		if (userCount >= 1)
		{	
			out.print("<p><b>A user with that same username already exists. Click back and please choose another username.</b><br>");
			return;
		}
		
		// if the current user logged in is an admin then they are creating
		// a customer rep account. This will set isCustRep to 1 if this is the case
		String createCustRep = (current != null && current.getIsAdmin()) ? "1" : "0";
		
		//Make an insert statement for the User table:
		String insert = "INSERT INTO User"
				+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, " + createCustRep + ")";
		
		//Create a Prepared SQL statement
		// all the question marks will be replaced with the values from the forms
		PreparedStatement ps = con.prepareStatement(insert);

		//Add username and password
		ps.setString(1, userName);
		ps.setString(2, password);
		ps.setString(3, firstName);
		ps.setString(4, lastName);
		ps.setString(5, email);
		ps.setString(6, streetAddress);
		ps.setString(7, city);
		ps.setString(8, county);
		ps.setString(9, zip);
		ps.setString(10, state);
		ps.setString(11, dob);
		
		//Run the query against the DB
		ps.executeUpdate();
		
		str = "SELECT COUNT(*) as count FROM User WHERE username = \"" + userName + "\"";
		result = stmt.executeQuery(str);
		result.next();
		userCount = result.getInt("count");
		
		// if that username already exists tell the user to try another one
		if (userCount >= 1)
		{
			
			if(current == null)
				out.print("<p> Successfuly created your new user account. </p>");
			else
				out.print("<p> Successfuly created customer rep account.</p>");
		}
		else
			out.print("<p> Failed to create account. Click back and try again </p>");

	} // end else that inserts the new User into the table

con.close();
	
} catch (Exception ex) {
	out.print(ex);
	out.print("<p> Failed to create your new user account. Click back and try again </p>");
}
	
%>
</body>
</html>