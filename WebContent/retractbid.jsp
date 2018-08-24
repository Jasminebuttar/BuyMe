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
	
	// query the database to make sure the bid is there
	String bidQuery = "SELECT * FROM Bid WHERE bidder = '" +  userName + "' AND auctionid='" + auctionId + "'";
	Statement stmt = con.createStatement();
	ResultSet result = stmt.executeQuery(bidQuery);
	
	if(!result.next())
	{
		out.println("<p>Sorry the bid information is wrong. Please try again or contact a customer rep</p>");
		return;
	}
	
	// check to see if the user already tried to retract this bid
	// inform them they can not request to do this twice
	String getRetract = "SELECT * FROM RetractBid WHERE username='" + userName + "' AND auctionid='" + auctionId + "' AND " +
			"amount='" + amount +  "'";
				
	result = stmt.executeQuery(getRetract);
	
	if (result.next())
	{
		out.println("<p>You cannot request to remove the same bid twice</p>");
		
		con.close();
		return;
	}
		
%>
	<p>Please enter a reason for the retract bid and the your request will be reviewed by a cust rep. Thank you. </p>
	<div>
	<form method="post" action="retractbidsubmit.jsp" style="display: inline;">
		<input type="hidden" name="auctionid" value="<%=auctionId %>">
		<input type="hidden" name="amount" value="<%=amount %>">
		<textarea rows="10" cols="45" name="reason"></textarea>
		<input type="submit" value="Submit">
	</form>
	</div><br><br>
	
<%

con.close();

}

catch(Exception e){	
	out.println(e.getMessage());	
	}


%>

</body>
</html>