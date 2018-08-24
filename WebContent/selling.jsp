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
	String select = "SELECT title, auctionid, image, enddate FROM Auction " +
					"WHERE seller = '" + userName +	"' AND enddate > NOW() ORDER BY enddate ASC";
	
	ResultSet result = stmt.executeQuery(select);
%>
	<h2 class="center">Auctions still in progess</h2>
	<table>	
	<tr>	
	<th>Auction</th>	
	<th>Title</th>	
	<th>Max Bid</th>
	<th>EndDate</th>
	<th>Delete Auction</th>
	<th>Modify Auction</th>		
	</tr>	
<%	
	while(result.next())
	{
		// get all the needed variable from the current auction being proccessd
		String auctionId = result.getString("auctionid");
		String image = result.getString("image");
		String endDate = result.getString("enddate");
		String title = result.getString("title");
		
		// get the max bid for this auction
		Statement maxStmt = con.createStatement();
		String getMax = "SELECT MAX(amount) as max FROM Bid WHERE auctionid = '" + auctionId + "'";
		ResultSet maxResult = maxStmt.executeQuery(getMax);
		maxResult.next();
		
		// get the result from the query
		Double max = 0.0;
		
		if (maxResult.getString("max") != null)
			max = Double.parseDouble(maxResult.getString("max"));
		
		String winningBid = String.format("%.2f",max);
		
		// display all the information
		%>
		<tr>	
			<td><img src="<%=image%>" alt="auctpic" width="70" height="70"></td>	
			<td><a href="viewAuction.jsp?auctionid=<%=auctionId%>"><%=title%></a></td>
			<td>$<%=winningBid %></td>
			<td><%=endDate%></td>
			<td><a href="deleteAuction.jsp?requestid=<%=auctionId%>&delete=no">Remove Auction</a></td>
			<td><a href="modifyrequest.jsp?auctionid=<%=auctionId%>">Modify</a></td>
		</tr>		
<%
	}
%>

</table>

<%
	//get all the auctions where the user is a buyer and the auction have not ended yet
	select = "SELECT title, auctionid, image, enddate, reserve FROM Auction " +
					"WHERE seller = '" + userName +	"' AND enddate < NOW() ORDER BY enddate DESC";
	
	result = stmt.executeQuery(select);
%>
	<h2 class="center">Finished Auctions</h2>
	<table>	
	<tr>	
	<th>Auction</th>	
	<th>Title</th>	
	<th>Max Bid</th>
	<th>EndDate</th>
	<th>Sold?</th>			
	</tr>	
<%	
	while(result.next())
	{
		// get all the needed variable from the current auction being proccessd
		String auctionId = result.getString("auctionid");
		String image = result.getString("image");
		String endDate = result.getString("enddate");
		String title = result.getString("title");
		Double reserve = result.getDouble("reserve");
		
		// get the max bid for this auction
		Statement maxStmt = con.createStatement();
		String getMax = "SELECT MAX(amount) as max FROM Bid WHERE auctionid = '" + auctionId + "'";
		ResultSet maxResult = maxStmt.executeQuery(getMax);
		maxResult.next();
		
		// get the result from the query
		Double max = 0.0;
		
		if (maxResult.getString("max") != null)
			max = Double.parseDouble(maxResult.getString("max"));
		
		String winningBid = String.format("%.2f",max);
		
		// display all the information
		%>
		<tr>	
		<td><img src="<%=image%>" alt="auctpic" width="70" height="70"></td>	
		<td><a href="viewAuction.jsp?auctionid=<%=auctionId%>"><%=title%></a></td>
		<td>$<%=winningBid %></td>
		<td><%=endDate%></td>
		<td><%=((max - reserve) > 0.001) ? "Yes" : "No"%></td>

		</tr>		
<%
	}
	
	
con.close();

}

catch(Exception e){	
	
	if(con != null)
		con.close();
	
	out.println(e.getMessage());	
	}
%>

</table>

</body>
</html>