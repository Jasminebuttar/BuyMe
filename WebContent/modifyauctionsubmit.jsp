<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*, java.lang.Boolean ,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BuyMe</title>
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

	User current = (User)session.getAttribute("currentUser");
	String auctionId = request.getParameter("auctionid");

	String str = "SELECT * FROM Auction WHERE auctionid = \"" + auctionId + "\"";
	Statement stmt = con.createStatement();	
	ResultSet result = stmt.executeQuery(str);
	result.next();
	
	// get all the information about the current auction
	// this will be checked against the update info form that was submitted
	
	String title = result.getString("title");
	String description = result.getString("description");
	String reserve = result.getString("reserve");
	String increment = result.getString("increment");
	String pickup = (result.getString("pickup") == null) ? "0" : "1";
	String shipping = result.getString("shipping");
	
	// get all the information from the update info form		
	String updateTitle = request.getParameter("title");
	String updateDescription = request.getParameter("description");
	String updateReserve = request.getParameter("reserve");
	String updateIncrement = request.getParameter("increment");
	String updatePickup = (request.getParameter("pickup") == null) ? "0" : "1";
	String updateShipping = request.getParameter("shipping");
	
	
	boolean success = true;
	
	// check all the form information against the current user
	// update the database and the current User object if there are any changes
	if(!updateTitle.equals(title))
	{
		Statement stmt1 = con.createStatement();
		String str1 = "UPDATE Auction SET title = \"" + updateTitle + "\" WHERE auctionid = \"" + auctionId + "\"";
		stmt1.executeUpdate(str1);
		
	}

	if(!updateDescription.equals(description))
	{
		Statement stmt1 = con.createStatement();
		String str1 = "UPDATE Auction SET description = \"" + updateDescription + "\" WHERE auctionid = \"" + auctionId + "\"";
		stmt1.executeUpdate(str1);
		
	}
	
	if(!updateReserve.equals(reserve))
	{
		Statement stmt1 = con.createStatement();
		String str1 = "UPDATE Auction SET reserve = \"" + updateReserve + "\" WHERE auctionid = \"" + auctionId + "\"";
		stmt1.executeUpdate(str1);
		
	}
	
	if(!updateIncrement.equals(increment))
	{
		Statement stmt1 = con.createStatement();
		String str1 = "UPDATE Auction SET increment = \"" + updateIncrement + "\" WHERE auctionid = \"" + auctionId + "\"";
		stmt1.executeUpdate(str1);
		
	}
	
	if(!updatePickup.equals(pickup))
	{
		Statement stmt1 = con.createStatement();
		String str1 = "UPDATE Auction SET pickup = \"" + updatePickup + "\" WHERE auctionid = \"" + auctionId + "\"";
		stmt1.executeUpdate(str1);
		
	}
	
	if(!updateShipping.equals(pickup))
	{
		Statement stmt1 = con.createStatement();
		String str1 = "UPDATE Auction SET shipping = \"" + updateShipping + "\" WHERE auctionid = \"" + auctionId + "\"";
		stmt1.executeUpdate(str1);
		
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