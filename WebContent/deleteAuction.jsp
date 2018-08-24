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

	//get the User object for the currently logged in user and the auctionId
	User current = (User) session.getAttribute("currentUser");
	String userName = current.getUsername();
	String auctionId = request.getParameter("auctionid");
	String delete = request.getParameter("delete");
	String seller = "";
	
	// get the seller of the auction to be possibly deleted
	String sellerSelect = "SELECT seller FROM Auction WHERE auctionid = '" + auctionId + "'";
	Statement sellerStmt = con.createStatement();
	ResultSet sellerResult = sellerStmt.executeQuery(sellerSelect);
	
	if (sellerResult.next())
		seller = sellerResult.getString("seller");
	else
	{
		out.println("Auction does not exist");
		return;
	}
	
	if (current == null)
	{
		out.print("<p>Must be logged in to perform this action. Please create an account or log in</p>");
		return;
	}

	if (!current.getIsCustRep() && !seller.equals(userName))
	{
		out.print("<p>Only a customer rep or seller can perform this action.</p>");
		return;
	}
	
	// check if its the customer rep removing the auction
	if (current.getIsCustRep())
	{
		// update the table to show that the auction was checked
		// the removed option will be changed based on what the customer rep choose (the delete variable)
		String checked = "UPDATE RemoveAuction SET checked = '1', removed = ? WHERE auctionid = ?";
		
		PreparedStatement ps = con.prepareStatement(checked);
		
		ps.setString(2, auctionId);
		
		// the cust rep has determined that auction should NOT be removed
		if(delete.equals("false"))
		{
			// record the choice by setting the remove column to 0 (false)
			ps.setString(1, "0");
			ps.executeUpdate();		
	
			out.print("<div class=\"center\">The auction will not be removed. <a href=\"viewreported.jsp\">View more reported auctions to check</a></div>");
		}
		// the cust rep has determing that auction should be removed
		else
		{
			// record the choice by setting the remove column to 1 (true)
			ps.setString(1, "0");
			ps.executeUpdate();
			
			// remove the auction from the Auction table
			String del = "DELETE FROM Auction WHERE auctionid = ?";
			
			PreparedStatement psDel = con.prepareStatement(del);
			
			psDel.setString(1, auctionId);
			psDel.executeUpdate();
			
			out.print("<div class=\"center\">The auction was removed. <a href=\"viewreported.jsp\">View more reported auctions to check</a></div>");
			
		}
	}
	// if not than the seller wants to delete the auction
	else
	{
		// give the user a warning before the auction is deleted
		if (delete.equals("no"))
		{
%>

			<p class="center">Are you sure you want to remove this auction</p>
			<p class="center"><a href="deleteAuction.jsp?requestid=<%=auctionId%>&delete=yes">YES</a></p>
			<p class="center"><a href="selling.jsp">NO</a></p>
			
<%
		}
		else
		{
			// remove the auction from the Auction table
			String del = "DELETE FROM Auction WHERE auctionid = ?";
			
			PreparedStatement psDel = con.prepareStatement(del);
			
			psDel.setString(1, auctionId);
			psDel.executeUpdate();
			
			out.print("<div class=\"center\">The auction was removed.</div>");
		}
	}
	
	
	con.close();
}

catch(Exception e)
{	
	out.println(e.getMessage());	
}

%>

</body>
</html>