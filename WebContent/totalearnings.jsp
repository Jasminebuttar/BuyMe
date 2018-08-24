<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Generate Reports</title>
</head>
<body>
<h1><center>Report as per total Earnings</center></h1>
<% 
	

try{
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
    
	Statement stmt = con.createStatement();	
	
	String maxBid = "SELECT MAX(amount) as max FROM Bid GROUP BY auctionid"; 
	ResultSet result = stmt.executeQuery(maxBid);
	
	double total = 0.0;
	while(result.next())
	{
		total += result.getDouble("max");
	}
	out.print("The total earnings are: $" + total);
	con.close();

}   catch(Exception e){	
	out.println(e.getMessage());	
	}
	
%></body>
</html>

