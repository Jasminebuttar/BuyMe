<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>
<%@ page import="java.util.Date" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BuyMe</title>
</head>
<body>

<%@include file="header.jsp" %>

<div class="center">
<%
	String auctionId = request.getParameter("auctionid");

	session.setAttribute("auctionid", auctionId);
	
	String bidHistory = request.getParameter("bidhistory");
	
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
	
	Statement stmt = con.createStatement();	
	
	// get all information about this auction from the db
	String str = "SELECT * FROM Auction WHERE auctionid = " + auctionId;
	
	ResultSet result = stmt.executeQuery(str);
	
	result.next();
	
	// set the session attribute start price and increment
	// this will be used to check the user's bid is sufficient
	// if they decide to bid on the item
	String startPrice = result.getString("startprice");
	session.setAttribute("startprice", startPrice);
	
	String increment = result.getString("increment");
	session.setAttribute("increment", increment);
	
	Timestamp sqlDate = result.getTimestamp("enddate");
	
	TimeZone.setDefault(TimeZone.getTimeZone("America/New_York"));
	java.util.Date endDate = sqlDate;
	java.util.Date today = new Date();
	
	// get the current max bid for this auction
	String maxBid = "SELECT MAX(amount) as max FROM Bid WHERE auctionid = '" + auctionId +"'";
	String max = "0";
			
	Statement maxStmt = con.createStatement();
	ResultSet maxResult = maxStmt.executeQuery(maxBid);
	
	if(maxResult.next())
	{
		if (maxResult.getString("max") != null)
			max = maxResult.getString("max");
	}
	
	session.setAttribute("max", max);
%>
<table>
<tr>
<td><h1><%=result.getString("title")%></h1></td>
</tr>
<tr class="nohover">
	<td>
		<img src="<%out.print(result.getString("image"));%>" alt=phonepic><br><br>
		<a href="reportauction.jsp?auctionid=<%=auctionId%>">Report Auction</a><br>
		<a href="viewsimilarauctions.jsp?auctionid=<%=auctionId%>">View Similar Auctions</a>
	</td>
	<td>
<%
		if (endDate.before(today))
		{
			out.print("<label>This auction has ended</label>");
		}
		else
		{
	
%>
				<form method="post" action="enterbid.jsp">
					<label>Enter Bid Amount:</label>
					<input type="text" name="amount">
					<input type="submit" value="Submit Bid">
				</form>
				<br><br>
				<form method="post" action="autobid.jsp">
					<label>Set Up AutoBid. Enter highest amount:</label>
					<input type="text" name="amount">
					<input type="submit" value="Submit Bid">
				</form>
	</td>	
<%
		}
		//check if bid history needs to be expanded or not
		if (bidHistory == null)
		{
%>
			<td>Bid History<a href="viewAuction.jsp?auctionid=<%=auctionId %>&bidhistory=yes"><img src="images/plus.bmp" height="22" width="22"></a></td>	
<%
		}
		else
		{
%>
			<td>Bid History<a href="viewAuction.jsp?auctionid=<%=auctionId %>"><img src="images/minus.bmp" height="22" width="22"></a><br>
<%
			Statement historyStmt = con.createStatement();	
			
			// get all bid for this auction
			String historySelect = "SELECT * FROM Bid WHERE auctionid = " + auctionId + " ORDER BY date_time DESC";
			
			ResultSet historyResult = historyStmt.executeQuery(historySelect);
					
			// check if there are no bids		
			if(!historyResult.next())
				out.print("There are no bid on this auction so far. Be the first one!");
			else
			{
				
%>
				<table style="display:block;">
				<tr>
					<td>Bid</td>
					<td>Date/Time</td>
				</tr>
<%
				do
				{
					String bidAmount = historyResult.getString("amount");
					String dateTime = historyResult.getString("date_time");
					
					String bid = String.format("<tr><td>%s</td><td>%s</td></tr>", bidAmount, dateTime);
					out.print(bid);					
					
				} while (historyResult.next());
%>
				</table>
<%

			}
%>
			</td>
<%
			
			
		}
%>
</tr>	
<tr >
	<th><label>Seller</label></th>	
	<td><a href="viewUser.jsp?username=<%=result.getString("seller")%>"><%=result.getString("seller")%>  <i class="fas fa-info-circle"></i></a></td>
</tr>
<tr>
	<th><label>Start Date</label></th>
	<td><%out.print(result.getString("startdate"));%></td>
</tr>
<tr>	
	<th><label>End Date</label></th>
	<td><%out.print(result.getString("enddate"));%></td>
</tr>
<tr>	
	<th><label>Start Price</label></th>
	<td>$<%out.print(result.getString("startprice"));%></td>
</tr>
<tr>	
	<th><label>Current Winning Bid</label></th>
	<td>$<%=max%></td>
</tr>
<tr>
	<th><label>Title</label></th>
	<td><%out.print(result.getString("title"));%></td>
</tr>
<tr>
	<th><label>Description</label></th>
	<td><%out.print(result.getString("description"));%></td>
</tr>
<tr>
	<th><label>Screen Size</label></th>
	<td><%out.print(result.getString("screensize"));%></td>
</tr>
<tr>
	<th><label>City</label></th>
	<td><%out.print(result.getString("city"));%></td>
</tr>
<tr>
	<th><label>State</label></th>
	<td><%out.print(result.getString("state"));%></td>
</tr>
<tr>
	<th><label>Zip</label></th>
	<td><%out.print(result.getString("zip"));%></td>
</tr>
<tr>
	<th><label>County</label></th>
	<td><%out.print(result.getString("county"));%></td>
</tr>
<tr>
	<th><label>Brand</label></th>
	<td><%out.print(result.getString("brand"));%></td>
</tr>
<tr>
	<th><label>Model</label></th>
	<td><%out.print(result.getString("model"));%></td>
</tr>
<tr>
	<th><label>Condition</label></th>
	<td><%out.print(result.getString("cond"));%></td>
</tr>
<tr>
	<th><label>Pickup</label></th>
	<td><%=(result.getString("pickup").equals("0")) ? "NO" : "YES"%></td>
</tr>
<tr>
	<th><label>Shipping</label></th>
	<td><%out.print(result.getString("shipping"));%></td>
</tr>
<tr>
	<th><label>Color</label></th>
	<td><%out.print(result.getString("color"));%></td>
</tr>
<tr>
	<th><label>Megapixels</label></th>
	<td><%out.print(result.getString("megapixels"));%></td>
</tr>
<tr>
	<th><label>Carrier</label></th>
	<td><%out.print(result.getString("carrier"));%></td>
</tr>
<tr>
	<th><label>RAM</label></th>
	<td><%out.print(result.getString("ram"));%></td>
</tr>
<tr>
	<th><label>Storage Space</label></th>
	<td><%out.print(result.getString("storagespace"));%></td>
</tr>
<tr>
	<th><label>Expandable</label></th>	
	<td><%=(result.getString("expandable").equals("0")) ? "NO" : "YES"%></td>
</tr>	
</table>
<%

con.close();

}catch(Exception e){	
	out.println(e.getMessage());	
	}
%>

</div>
</body>
</html>