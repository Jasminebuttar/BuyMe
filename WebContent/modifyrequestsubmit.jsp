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

	User current = (User) session.getAttribute("currentUser");
	String userName = current.getUsername();
	String auctionId = request.getParameter("auctionid");
	String reason = request.getParameter("reason");
	
	// check to make sure the user isnt trying to modify the auction again
	String str = "SELECT * FROM ModifyAuction WHERE username='" + userName + "' AND auctionid='" + auctionId + "'";
	Statement stmt = con.createStatement();
	ResultSet result = stmt.executeQuery(str);
	
	if(result.next())
	{
		out.println("<p class=\"center\">You cannot modify the same auction twice</p");
		
		con.close();
		return;
	}
	
	// mkae the INSERT for the modify auction request
	String insert = "INSERT INTO ModifyAuction (username, auctionid, reason) VALUES (?, ?, ?)";
	PreparedStatement insertPs = con.prepareStatement(insert);
	
	insertPs.setString(1, userName);
	insertPs.setString(2, auctionId);
	insertPs.setString(3, reason);
	insertPs.executeUpdate();
	
	out.println("<p>Your modify auction request has been submitted. Watch your messages for a decision</p>");
}

catch (Exception ex) 
{
	if (con != null)
		con.close();
	
	out.print(ex);
}
%>
</body>
</html>