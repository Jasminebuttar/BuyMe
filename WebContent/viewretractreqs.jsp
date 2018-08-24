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
	
	// get the usernae of the current customer rep
	String custrep = current.getUsername();

	// query the database for all the unprocessed retract reqs
	String bidQuery = "SELECT * FROM RetractBid WHERE retracted IS null";
	Statement stmt = con.createStatement();
	ResultSet result = stmt.executeQuery(bidQuery);
	
	if(!result.next())
	{
		out.println("<p>There are no retract requests to process</p>");
		return;
	}
	
%>
	<table>
		<tr>
			<th>Username</th>
			<th>Auction ID</th>
		</tr>
<%
	// display a link to view each retract request
	do
	{
		String userName = result.getString("username");
		String auctionId = result.getString("auctionid");
		String amount = result.getString("amount");
		
%>
	<tr>
		<td><a href="viewretract.jsp?username=<%=userName %>&auctionid=<%= auctionId%>&amount=<%= amount%>"><%=userName %></a></td>
		<td><a href="viewretract.jsp?username=<%=userName %>&auctionid=<%= auctionId%>&amount=<%= amount%>"><%=auctionId %></a></td>
	</tr>
<%
		
	} while (result.next());
	
%>
	</table>
	
<%

	con.close();

}

catch(Exception e)
{	
	out.println(e.getMessage());	

}


%>

</body>
</html>