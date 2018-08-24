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

	// get the User object for the currently logged in user
	User current = (User) session.getAttribute("currentUser");
			
	if (current == null)
	{
		out.print("<p>Must be logged in to perform this action. Please create an account or log in</p>");
		
		return;
	}

	// get the auctionid, amount for the autobid, and the user sumbmitting the autobid
	String auctionId = (String) session.getAttribute("auctionid");
	Double amount = Double.parseDouble((String) request.getParameter("amount"));
	Double startPrice = Double.parseDouble((String)  session.getAttribute("startprice"));
	String username = current.getUsername();
		
	String insert = "UPDATE AutoBid SET maxPrice = ? WHERE username = ? AND auctionId = ?";
	
	//Create a Prepared SQL statement
	// all the question marks will be replaced with the values from the form and session
	PreparedStatement ps = con.prepareStatement(insert);
	
	//Add the parameters
	ps.setString(1, amount.toString());
	ps.setString(2, username);
	ps.setString(3, auctionId);
	
	ps.executeUpdate();
	
	out.print("<p>Autobid for the amount of "+ amount +" was set up</p>");
		
} catch (Exception ex) {
	out.print(ex);
}

%>

</body>
</html>