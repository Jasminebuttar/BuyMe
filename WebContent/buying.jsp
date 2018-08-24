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
	
	User current = (User)session.getAttribute("currentUser");
	String userName = current.getUsername();
	
	Statement stmt = con.createStatement();
	
	// get all the auctions where the user is a buyer and the auction have not ended yet
	String select = "SELECT title, auctionid, image, enddate, amount FROM "+
					"(SELECT title, a.auctionid, image, enddate, MAX(amount) as amount FROM "+
					"Auction a INNER JOIN Bid b ON a.auctionid = b.auctionid WHERE b.bidder = '" + userName +
					"' AND a.enddate >= NOW() GROUP BY a.auctionid) as bids ORDER BY enddate ASC";
	
	ResultSet result = stmt.executeQuery(select);
%>
	<h2 class="center">Auctions still in progess</h2>
	<table>	
	<tr>	
	<th>Auction</th>	
	<th>Title</th>
	<th>Your Bid</th>
	<th>Max Bid</th>	
	<th>EndDate</th>	
	<th>Retract Bid?</th>
		
	</tr>	
<%	
	while(result.next())
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
		<td><a href="viewAuction.jsp?auctionid=<%=auctionId%>"><img src="<%=image%>" alt="auctpic" width="70" height="70"></a></td>	
		<td><a href="viewAuction.jsp?auctionid=<%=auctionId%>"><%=title%></a></td>
		<td><a href="viewAuction.jsp?auctionid=<%=auctionId%>">$<%=usersBid %></a></td>
		<td><a href="viewAuction.jsp?auctionid=<%=auctionId%>">$<%=winningBid %></a></td>
		<td><a href="viewAuction.jsp?auctionid=<%=auctionId%>"><%=endDate%></a></td>
		<td>
<%
			// check if the user has the max bid
			// and if so, allow them the option to retract it
			if((max-amount) < 0.001)
			{
%>
				<a href="retractbid.jsp?auctionid=<%=auctionId %>&amount=<%=amount%>">Retract Bid</a>				
				
<%	
			}
		
%>
		</td>
		</tr>		
<%
	}

//get all the auctions where the user is a buyer and the auction have not ended yet
	select = "SELECT title, auctionid, image, enddate, amount, reserve FROM "+
					"(SELECT title, a.auctionid, image, enddate, MAX(amount) as amount, a.reserve FROM "+
					"Auction a INNER JOIN Bid b ON a.auctionid = b.auctionid WHERE b.bidder='" + userName +
					"' AND a.enddate < NOW() GROUP BY a.auctionid) as bids ";
	
	result = stmt.executeQuery(select);
%>
</table>

	<h2 class="center">Finished Auctions</h2>
	<table>	
	<tr>	
	<th>Auction</th>	
	<th>Title</th>
	<th>Your Bid</th>
	<th>Max Bid</th>	
	<th>EndDate</th>	
	<th>Won?</th>
		
	</tr>	
<%	
	while(result.next())
	{
		// get all the needed variable from the current auction being proccessd
		String auctionId = result.getString("auctionid");
		String image = result.getString("image");
		String endDate = result.getString("enddate");
		String title = result.getString("title");
		Double amount = Double.parseDouble(result.getString("amount"));
		Double reserve = result.getDouble("reserve");
		
		String usersBid = String.format("%.2f",amount);
		String winningBid = String.format("%.2f",amount);
		
		// get the max bid for this auction
		Statement maxStmt = con.createStatement();
		String getMax = "SELECT MAX(amount) as max FROM Bid WHERE auctionid = '" + auctionId + "'";
		ResultSet maxResult = maxStmt.executeQuery(getMax);
		maxResult.next();
		
		// get the result from the query
		Double max = Double.parseDouble(maxResult.getString("max"));
		
		// display all the information
		%>
		<tr>	
		<td><a href="viewAuction.jsp?auctionid=<%=auctionId%>"><img src="<%=image%>" alt="auctpic" width="70" height="70"></a></td>	
		<td><a href="viewAuction.jsp?auctionid=<%=auctionId%>"><%=title%></a></td>
		<td><a href="viewAuction.jsp?auctionid=<%=auctionId%>">$<%=usersBid %></a></td>
		<td><a href="viewAuction.jsp?auctionid=<%=auctionId%>">$<%=winningBid %></a></td>
		<td><a href="viewAuction.jsp?auctionid=<%=auctionId%>"><%=endDate%></a></td>
		<td>
<%
			// check if the user has the max bid
			// and if so, allow them the option to retract it
			if( ((max-amount) < 0.001) && (amount >= reserve))
				out.print("Yes");
			else
				out.print("No");
		
%>
		</td>
		</tr>		
<%
	}
	
	
con.close();

}

catch(Exception e)
{	
	if (con != null)
		con.close();
	
	out.println(e.getMessage());	
}
%>

</table>

</body>
</html>