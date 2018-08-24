<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="main.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%@include file="header.jsp" %>

<%

try
{
	String userName = ((User) session.getAttribute("currentUser")).getUsername();

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
	
	String insert = "INSERT INTO Alert (username, brand, model, color, screensizelow, screensizehigh, carrier, megapixelslow, megapixelshigh, "+
					"storagespacelow, storagespacehigh, ramlow, ramhigh, isnew, usedlikenew, usedfair, usedpoor, inzip, incity, incounty, instate, "+
					"freeshipping, expandable, pickup) VALUES (";
	
	// add in the values to be inserted	
	insert += "'" + userName + "', ";
	insert += (request.getParameter("brand") == null ? "NULL" : "'" + request.getParameter("brand")+"'") + ", ";
	insert += (request.getParameter("model").equals("") ? "NULL" : "'" + request.getParameter("model")+"'") + ", ";
	insert += (request.getParameter("color") == null ? "NULL" : "'" + request.getParameter("color")+"'") + ", ";
	insert += (request.getParameter("screensizelow") == null?  "NULL" : "'" + request.getParameter("screensizelow")+"'") + ", ";
	insert += (request.getParameter("screensizehigh") == null ? "NULL" : "'" + request.getParameter("screensizehigh")+"'") + ", ";
	insert += (request.getParameter("carrier") == null ? "NULL" : "'" + request.getParameter("carrier")+"'") + ", ";
	insert += (request.getParameter("mplow").equals("") ? "NULL" : "'" + request.getParameter("mplow")+"'") + ", ";
	insert += (request.getParameter("mphigh").equals("") ? "NULL" : "'" + request.getParameter("mphigh")+"'") + ", ";
	insert += (request.getParameter("storagelow") == null ? "NULL" : "'" + request.getParameter("storagelow")+"'") + ", ";
	insert += (request.getParameter("storagehigh") == null ? "NULL" : "'" + request.getParameter("storagehigh")+"'") + ", ";
	insert += (request.getParameter("ramlow") == null ? "NULL" : "'" + request.getParameter("ramlow")+"'") + ", ";
	insert += (request.getParameter("ramhigh") == null ? "NULL" : "'" + request.getParameter("ramhigh")+"'") + ", ";
	insert += (request.getParameter("isnew") == null ? "0" : "1") + ", ";
	insert += (request.getParameter("usedlikenew") == null ? "0" : "1") + ", ";
	insert += (request.getParameter("usedfair") == null ? "0" : "1") + ", ";
	insert += (request.getParameter("usedpoor") == null ? "0" : "1") + ", ";
	insert += (request.getParameter("inzip") == null ? "0" : "1") + ", ";
	insert += (request.getParameter("incity") == null ? "0" : "1") + ", ";
	insert += (request.getParameter("incounty") == null ? "0" : "1") + ", ";
	insert += (request.getParameter("instate") == null ? "0" : "1") + ", ";
	insert += (request.getParameter("freeshipping") == null ? "0" : "1") + ", ";
	insert += (request.getParameter("expandable") == null ? "0" : "1") + ",";
	insert += (request.getParameter("pickup") == null ? "0" : "1") + ")";
	
	Statement stmt = con.createStatement();	
	stmt.executeUpdate(insert);
	
	con.close();

	out.print("<p>Your alert has been set. You will be notified if an auction matching your criteria is created</p>");
	
}
	
catch(Exception e)
{	
	out.println(e.getMessage());	
}

%>

</body>
</html>