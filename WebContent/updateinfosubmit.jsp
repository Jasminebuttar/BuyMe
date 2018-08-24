<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*, java.lang.Boolean ,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update Your Account</title>
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
	
	
	User current = (User) session.getAttribute("currentUser");
	String userName = current.getUsername();
	
	// get all the information about the current user
	// this will be checked against the update info form that was submitted
	String currentFirstName = current.getFirstName();
	String currentLastName = current.getLastName();
	String currentEmail = current.getEmail();
	String currentDob = current.getDob();
	String currentStreet = current.getStreet();
	String currentCity = current.getCity();
	String currentCounty = current.getCounty();
	String currentZip = current.getZip();
	String currentState = current.getState();
	String dobParts[] = currentDob.split("-");
	String currentYear = dobParts[0];
	String currentYonth = dobParts[1];
	String currentDay = dobParts[2];
	
	// get all the information from the update info form		
	String firstName = request.getParameter("firstname");
	String lastName = request.getParameter("lastname");
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	String newpassword = request.getParameter("newpassword");
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	String dob = year + "-" + month + "-" + day;
	String streetAddress = request.getParameter("streetaddress");
	String city = request.getParameter("city");
	String zip = request.getParameter("zipcode");
	String county = request.getParameter("county");
	String state = request.getParameter("state");
	boolean success = true;
	
	// check all the form information against the current user
	// update the database and the current User object if there are any changes
	if(!firstName.equals(currentFirstName))
	{
		Statement stmt1 = con.createStatement();
		String str = "UPDATE User SET firstname = \"" + firstName + "\" WHERE username = \"" + userName + "\"";
		stmt1.executeUpdate(str);
		
		current.setFirstName(firstName);
	}

	if(!lastName.equals(lastName))
	{
		Statement stmt1 = con.createStatement();
		String str = "UPDATE User SET lastname = \"" + lastName + "\" WHERE username = \"" + userName + "\"";
		stmt1.executeUpdate(str);
		
		current.setLastName(lastName);
	}
	
	if(!email.equals(email))
	{
		Statement stmt1 = con.createStatement();
		String str = "UPDATE User SET email = \"" + email + "\" WHERE username = \"" + userName + "\"";
		stmt1.executeUpdate(str);
		
		current.setEmail(email);
	}
	
	
	
	if(!password.equals(""))
	{

		if(!newpassword.equals(""))
		{	
			Statement stmt = con.createStatement();
			String str = "SELECT password FROM User WHERE username =  \"" + userName + "\"";
			
			ResultSet result = stmt.executeQuery(str);
			result.next();
			String str1 = result.getString("password");
			
			if(password.equals(str1))
			{
			
			Statement stmt1 = con.createStatement();
			
			String str2 = "UPDATE User SET password = \"" + newpassword + "\" WHERE username = \"" + userName + "\"";	
			
			stmt1.executeUpdate(str2);

			current.setPassword(newpassword);
			}
			else
			{
				success = false;
				out.print("<p><b>Your old password is incorrect. Please try again!</b></p>");
			
			}
		}	
	}
	
	if(!dob.equals(currentDob))
	{
		Statement stmt1 = con.createStatement();
		String str = "UPDATE User SET dob = \"" + dob + "\" WHERE username = \"" + userName + "\"";
		stmt1.executeUpdate(str);
		
		current.setDob(dob);
	}
	
	
	if(!streetAddress.equals(currentStreet))
	{
		Statement stmt1 = con.createStatement();
		String str = "UPDATE User SET street = \"" + streetAddress + "\" WHERE username = \"" + userName + "\"";
		stmt1.executeUpdate(str);
		
		current.setStreet(streetAddress);
	}

	
	if(!city.equals(currentCity))
	{
		Statement stmt1 = con.createStatement();
		String str = "UPDATE User SET city = \"" + city + "\" WHERE username = \"" + userName + "\"";
		stmt1.executeUpdate(str);
		
		current.setCity(city);
	}

	
	if(!zip.equals(currentZip))
	{
		Statement stmt1 = con.createStatement();
		String str = "UPDATE User SET zipcode = \"" + zip + "\" WHERE username = \"" + userName + "\"";
		stmt1.executeUpdate(str);
		
		current.setZip(zip);
	}
	
	
	if(!county.equals(currentCounty))
	{
		Statement stmt1 = con.createStatement();
		String str = "UPDATE User SET county = \"" + county + "\" WHERE username = \"" + userName + "\"";
		stmt1.executeUpdate(str);
		
		current.setCounty(county);
	}
	
	
	if(!state.equals(currentState))
	{
		Statement stmt1 = con.createStatement();
		String str = "UPDATE User SET state = \"" + state + "\" WHERE username = \"" + userName + "\"";
		stmt1.executeUpdate(str);
		
		current.setState(state);
	}
	
	
	
	// close out the connection to the database
	con.close();
	
	if(success == true)
	{
		out.print("<p><b>Successfully Updated!</b></p>");
	}
	
}

catch (Exception ex) {
out.print(ex);}
%>
</body>
</html>