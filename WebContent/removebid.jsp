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
	
	// get the usernae of the current customer rep
	String custrep = current.getUsername();

	// get all username, auctionid, and amount for this removal request
	String userName = request.getParameter("username");
	String auctionId = request.getParameter("auctionid");
	String amount = request.getParameter("amount");
	String delete = request.getParameter("remove");
	String retracted = (delete.equals("yes")) ? "1" : "0";
	
	// this will UPDATE the database to show that this request removal was processed
	String update = "UPDATE RetractBid SET custrep = ?, retracted = ? WHERE username = ? AND auctionid = ? AND amount = ?";
	PreparedStatement ps = con.prepareStatement(update);
	
	// this will be a prepared statement that will notify the user of the cust reps decision
	String sendMessage = "INSERT INTO Messege VALUES('BuyMeSystem', ?, 'Request for bid removal', NOW(), ?)";
	
	ps.setString(1, custrep);
	ps.setString(2, retracted);
	ps.setString(3, userName);
	ps.setString(4, auctionId);
	ps.setString(5, amount);
	
	ps.executeUpdate();
	
	if (delete.equals("yes"))
	{
		out.println("<p>The bid has been removed.</p>");
		
		// remove the bid from the bid table
		String remove = "DELETE FROM Bid WHERE bidder = ? AND auctionid = ? AND amount = ?";
		ps = con.prepareStatement(remove);
		
		ps.setString(1, userName);
		ps.setString(2, auctionId);
		ps.setString(3, amount);
		
		ps.executeUpdate();
		
		// notify the user the bid has been removed
		String content = "Your bid for <a href=\"viewAuction?auctionid=" + auctionId + "\">this auction</a> has been removed";
				
		ps = con.prepareStatement(sendMessage);
				
		ps.setString(1, userName);
		ps.setString(2, content);
		
		ps.executeUpdate();
	}
	else
	{
		out.println("<p>The bid has NOT been removed.</p>");
		
		// notify the user the bid has been removed
		String content = "Your bid for <a href=\"viewAuction?auctionid=" + auctionId + "\">this auction</a> has NOT been removed";
				
		ps = con.prepareStatement(sendMessage);
				
		ps.setString(1, userName);
		ps.setString(2, content);
		
		ps.executeUpdate();
	}

con.close();	

}

catch(Exception e)
{	
	if(con != null)
		con.close();
	
	out.println(e.getMessage());	
}

%>


</body>
</html>