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

<p><%@include file="header.jsp" %></p>

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

	// get the User object for the currently logged in user
	User current = (User) session.getAttribute("currentUser");
	String userName = current.getUsername();
			
	if (current == null)
	{
		out.print("<p>Must be logged in to perform this action. Please create an account or log in</p>");
		
		return;
	}	

	// get the auctionid, amount, startprice, increment, highest bid, and the user sumbmitting the bid
	String auctionId = (String) session.getAttribute("auctionid");
	Double amount = Double.parseDouble((String) request.getParameter("amount"));
	Double startPrice = Double.parseDouble((String)  session.getAttribute("startprice"));	
	Double increment = Double.parseDouble((String) session.getAttribute("increment"));
	Double highestBid = Double.parseDouble((String) session.getAttribute("max"));
	//Make an insert statement for the User table:
	String insert = "INSERT INTO Bid" +
			 " VALUES (?, ?, NOW(), ?)";

	// get the seller of the auction to make sure the user is not trying to bid on his/her
	// own auction
	String seller = "";
	String sellerQuery = "SELECT seller FROM Auction where auctionid = " + auctionId;
	Statement sellerStmt = con.createStatement();
	ResultSet sellerResult = sellerStmt.executeQuery(sellerQuery);
	
	if(sellerResult.next())
		seller = sellerResult.getString("seller");
	
	if(seller.equals(userName))
	{
		out.print("<p>Nice try. You cannot bid on your own auction.</p>");
		return;
	}
	
	//Create a Prepared SQL statement
	// all the question marks will be replaced with the values from the forms
	PreparedStatement ps = con.prepareStatement(insert);
	
	//Add the parameters
	ps.setString(1, auctionId);
	ps.setString(2, userName);
	ps.setString(3, amount.toString());

	// check if there any other bids that were put in for this auction already
	Statement stmt = con.createStatement();	
	String str = "SELECT COUNT(*) as count FROM Bid WHERE auctionid = \"" + auctionId + "\"";
	
	// run the query
	ResultSet result = stmt.executeQuery(str);
	result.next();

	//get the bid count
	int bidCount = result.getInt("count");
	
	// if the bid count is 0 then check to making the bid equal to or higher than the start price
	if (bidCount < 1)
	{
		// if it is place bid
		if(amount >= startPrice)
		{
			//Run the INSERT
			ps.executeUpdate();
			out.print("<p>Bid amount of " + amount + " was entered</p>");
		
		}
		// otherwise tell the user the bid is not sufficient
		else
		{
			out.print("<p>Bid amount of " + amount + " was too low. Has to be at least " + startPrice + "</p>");
			con.close();
			return;
		}
	}
	// if there is at least one bid check that the users bid is higher
	else
	{	

		// check to make sure the user's bid is higher
		if (amount > highestBid)
		{
			if (amount >= increment+highestBid)
			{
				//Run the INSERT
				ps.executeUpdate();
				
				out.print("<p>Bid amount of " + amount + " was entered</p>");
			}
			else
			{
				out.print("<p>Bid amount of " + amount + " was too low. Has to be at least " + (highestBid+increment) + "</p>");
				con.close();
				return;
			}
		}
		else
		{
			out.print("<p>Bid amount of " + amount + " was too low. Has to be more than " + highestBid + "</p>");
			con.close();
			return;
		}
	}
	
	// check if there is an AutoBid for this auction and enter a bid for the increment+last bid
	String getAutoBid = "SELECT MAX(maxPrice) as amount, username FROM AutoBid WHERE auctionid='" + auctionId + "'";
	result = stmt.executeQuery(getAutoBid);
			
	if(result.next())
	{
		String autoBidder = result.getString("username");
		Double autoAmount = result.getDouble("amount");
		
		// check if the auto amount is less than or equal to the new bid plus the incrementd
		// if so we enter a new bid
		if (autoAmount >= amount+increment)
		{
			Double autoBid = amount+increment;
			String insertAuto = "INSERT INTO Bid VALUES (?, ?, NOW(), ?)";
			
			ps = con.prepareStatement(insertAuto);
			ps.setString(1, auctionId);
			ps.setString(2, autoBidder);
			ps.setString(3, autoBid.toString());
			
			ps.executeUpdate();
		}
	}
	
	con.close();
	
}

catch(Exception e)
{	
	if (con != null)
		con.close();
	
	out.println("Error: " + e.getMessage());
}
%>


</body>
</html>