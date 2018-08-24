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

	// get all username, auctionid, and amount for this removal request
	String userName = request.getParameter("username");
	String auctionId = request.getParameter("auctionid");
	String amount = request.getParameter("amount");
	
	// query the database to get the reason the user gave for this request
	String reasonQuery = "SELECT reason FROM RetractBid WHERE username = '" + userName + "' AND auctionid = '" +
						auctionId + "' AND amount = '" + amount + "'";
	Statement stmt = con.createStatement();
	ResultSet result = stmt.executeQuery(reasonQuery);
	result.next();
	
	String reason = result.getString("reason");
	
	String removeUrl = "removebid.jsp?username=" + userName + "&auctionid=" + auctionId + "&amount=" + amount;
	
%>
	<table>
		<tr>
			<th>Username</th>
			<th>Auction ID</th>
			<th>Reason</th>
			<th>Delete?</th>
		</tr>
		<tr>
			<td><%=userName %></td>
			<td><a href="viewauction.jsp?auctionid=<%= auctionId%>"><%=auctionId %></a></td>
			<td><%=reason %></td>
			<td><a href="<%=removeUrl + "&remove=yes" %>">YES</a> or <a href="<%=removeUrl + "&remove=no" %>">NO</a></td>
		</tr>
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