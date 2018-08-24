<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
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
	
	User current = (User) session.getAttribute("currentUser");
	
	// get the user who wishes to retract the bid, the auctionid, and the amount the bid is for
	String userName = current.getUsername();
	String auctionId = request.getParameter("auctionid");
	String amount = request.getParameter("amount");
	String reason = request.getParameter("reason");
	
	// query the database to make sure the bid is there
	String retractInsert = "INSERT INTO RetractBid VALUES(?, ?, ?, ?, null, null)";
	PreparedStatement ps = con.prepareStatement(retractInsert);
	
	ps.setString(1, userName);
	ps.setString(2, auctionId);
	ps.setString(3, amount);
	ps.setString(4, reason);
	
	ps.executeUpdate();

	out.print("<p>Your request for bid removal was placed. A response will be sent to your messages once it has been processed</p>");

con.close();

}

catch(Exception e){	
	out.println(e.getMessage());	
	}


%>

</body>
</html>