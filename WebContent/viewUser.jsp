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
	
	// get the username whos info we are viewing
	String userName = request.getParameter("username");
	
	// display a title and give the user the option to message this user
	out.print("<h2 class=\"center\">Viewing information for user: " + userName + "</h2>"); 
	out.print("<label><a href=createemail.jsp?to=" + userName + 
			">Message This User  </a><i class=\"far fa-paper-plane\"></i></label></a><br><br>");
	
	Statement stmt = con.createStatement();
	
	// get all the auctions where the user is a buyer and the auction have not ended yet
	String select = "SELECT title, auctionid, image, enddate, amount FROM "+
					"(SELECT title, a.auctionid, image, enddate, MAX(amount) as amount FROM "+
					"Auction a INNER JOIN Bid b ON a.auctionid = b.auctionid WHERE b.bidder = '" + userName +
					"' AND a.enddate >= CURDATE() GROUP BY a.auctionid) as bids ";
	
	ResultSet result = stmt.executeQuery(select);
	
%>

<h2 style="text-decoration: underline;" class="center">Auctions the user is currently bidding on</h2>

<%
	if (!result.next())
	{
%>
	<h3 class="center">This user has not bid on any current auctions</h3>
<%
	}
	else
	{
%>
		<table>	
		<tr>	
			<th>Auction</th>	
			<th>Title</th>
			<th>Their Bid</th>
			<th>Max Bid</th>	
			<th>EndDate</th>		
		</tr>	
<%	
	
		do 
		{
			// get all the needed variable from the current auction being proccessd
			String auctionId = result.getString("auctionid");
			String image = result.getString("image");
			String endDate = result.getString("enddate");
			String title = result.getString("title");
			Double amount = Double.parseDouble(result.getString("amount"));
			
			// get the max bid for this auction
			Statement maxStmt = con.createStatement();
			String getMax = "SELECT MAX(amount) as max FROM Bid WHERE auctionid = '" + auctionId + "'";
			ResultSet maxResult = maxStmt.executeQuery(getMax);
			maxResult.next();
			
			// get the result from the query
			Double max = Double.parseDouble(maxResult.getString("max"));
			
			String usersBid = String.format("%.2f",amount);
			String winningBid = String.format("%.2f",max);
			
			// display all the information
			%>
			<tr>	
				<td><img src="<%=image%>" alt="auctpic" width="70" height="70"></td>	
				<td><a href="viewAuction.jsp?auctionid=<%=auctionId%>"><%=title%></a></td>
				<td>$<%=usersBid %></td>
				<td>$<%=winningBid %></td>
				<td><%=endDate%></td>
				<td>
			</tr>		
<%
		} while(result.next());
	}

//get all the auctions where the user is a buyer and the auction have
	select = "SELECT title, auctionid, image, enddate, amount FROM "+
					"(SELECT title, a.auctionid, image, enddate, MAX(amount) as amount FROM "+
					"Auction a INNER JOIN Bid b ON a.auctionid = b.auctionid WHERE b.bidder ='" + userName + "'" +
					" AND a.enddate < CURDATE() GROUP BY a.auctionid) as bids ";
	
	result = stmt.executeQuery(select);
%>
	</table><br><br>
	<h2 style="text-decoration: underline;" class="center">Auctions the user has bid on in the past</h2>
<%
	if (!result.next())
		out.print("<h3 class=\"center\">This user has not bid on any past auctions</h3>");
	else
	{
%>
</table>

	<table>	
	<tr>	
	<th>Auction</th>	
	<th>Title</th>
	<th>Their Bid</th>
	<th>Max Bid</th>	
	<th>EndDate</th>	
	<th>Won?</th>
		
	</tr>	
<%	
		do 
		{
			// get all the needed variable from the current auction being proccessd
			String auctionId = result.getString("auctionid");
			String image = result.getString("image");
			String endDate = result.getString("enddate");
			String title = result.getString("title");
			Double amount = Double.parseDouble(result.getString("amount"));
			
			String usersBid = String.format("%.2f",amount);
			
			// get the max bid for this auction
			Statement maxStmt = con.createStatement();
			String getMax = "SELECT MAX(amount) as max FROM Bid WHERE auctionid = '" + auctionId + "'";
			ResultSet maxResult = maxStmt.executeQuery(getMax);
			maxResult.next();
			
			// get the result from the query
			Double max = Double.parseDouble(maxResult.getString("max"));
			
			String winningBid = String.format("%.2f",amount);
			
			// display all the information
			%>
			<tr>	
				<td><img src="<%=image%>" alt="auctpic" width="70" height="70"></td>	
				<td><a href="viewAuction.jsp?auctionid=<%=auctionId%>"><%=title%></a></td>
				<td>$<%=usersBid %></td>
				<td>$<%=winningBid %></td>
				<td><%=endDate%></td>
			<td>
<%
				// check if the user has the max bid
				// and if so, allow them the option to retract it
				if((max-amount) < 0.001)
					out.print("Yes");
				else
					out.print("No");
			
%>
			</td>
			</tr>		
<%
		} while(result.next());
	}
%>
</table><br><br>
<h2 style="text-decoration: underline;" class="center">Auctions where the user has been the seller</h2>
<%	
	//get all the auctions where the user is the seller
	select = "SELECT title, auctionid, image, enddate, amount, reserve FROM "+
					"(SELECT title, a.auctionid, image, enddate, MAX(amount) as amount, reserve FROM "+
					"Auction a INNER JOIN Bid b ON a.auctionid = b.auctionid WHERE a.seller ='" + userName + "'" +
					"GROUP BY a.auctionid) as bids ";
	
	result = stmt.executeQuery(select);
	
	if (!result.next())
		out.print("<h3 class=\"center\">This user has not sold any items</h3>");
	else
	{
%>

	<table>	
	<tr>	
	<th>Auction</th>	
	<th>Title</th>
	<th>Max Bid</th>	
	<th>EndDate</th>	
	<th>Sold?</th>
		
	</tr>	
<%	
		do 
		{
			// get all the needed variable from the current auction being proccessd
			String auctionId = result.getString("auctionid");
			String image = result.getString("image");
			String endDate = result.getString("enddate");
			String title = result.getString("title");
			Double amount = Double.parseDouble(result.getString("amount"));
			Double reserve = Double.parseDouble(result.getString("reserve"));
			
			String usersBid = String.format("%.2f",amount);
			
			// display all the information
			%>
			<tr>	
				<td><img src="<%=image%>" alt="auctpic" width="70" height="70"></td>	
				<td><a href="viewAuction.jsp?auctionid=<%=auctionId%>"><%=title%></a></td>
				<td>$<%=usersBid %></td>
				<td><%=endDate%></td>
			<td>
<%
				// check if the user has the max bid
				// and if so, allow them the option to retract it
				if((reserve-amount) < 0.001)
					out.print("Yes");
				else
					out.print("No");
			
%>
			</td>
			</tr>		
<%
		} while(result.next());
	}
	
con.close();

}

catch(Exception e){	
	out.println(e.getMessage());	
	}
%>

</table>

</body>
</html>