<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Best selling</title>
</head>
<body>

<%@include file="header.jsp" %>
<%@include file="subheader.jsp" %>

<h1><center></center></h1>
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
	
	Statement stmt = con.createStatement();	
	
	// these will be the select statements that get the various "best" information
	String bestBrandNumber = "SELECT MAX(count) as count, brand FROM " +
							"(SELECT brand, reserve, max, COUNT(*) as count FROM " +
							"(SELECT brand, reserve, MAX(amount) as max FROM Auction a " +
							"INNER JOIN Bid b ON a.auctionid = b.auctionid GROUP BY a.auctionid) AS MaxBid " +
							"WHERE max >= reserve GROUP BY brand) as counts";
	
	String bestBrandSales = "SELECT brand, MAX(total) as max FROM " +
							"(SELECT brand, SUM(max) as total FROM " + 
							"(SELECT brand, reserve, MAX(amount) as max FROM Auction a " +
							"INNER JOIN Bid b ON a.auctionid = b.auctionid GROUP BY a.auctionid) AS MaxBid " +
							"WHERE max >= reserve GROUP BY brand) as max"; 
							
	String bestBuyerSales = "SELECT username, MAX(total) as max FROM " +
							"(SELECT bidder as username, SUM(max) as total FROM " +
							"(SELECT brand, reserve, MAX(amount) as max, b.bidder FROM Auction a " +
							"INNER JOIN Bid b ON a.auctionid = b.auctionid GROUP BY a.auctionid) AS MaxBid " +
							"WHERE max >= reserve GROUP BY bidder) as max";
					
	String bestBuyerNumber = "SELECT username, MAX(count)  as count FROM " +
							"(SELECT bidder as username, COUNT(*) as count FROM " +
							"(SELECT brand, reserve, MAX(amount) as max, b.bidder FROM Auction a " +
							"INNER JOIN Bid b ON a.auctionid = b.auctionid GROUP BY a.auctionid) AS MaxBid " +
							"WHERE max >= reserve GROUP BY bidder) as counts";
	
	// query the database to get the "best" information
	// save all the info in strings that will be displayed
	ResultSet result = stmt.executeQuery(bestBrandNumber);
	result.next();
	String brandNumberBrand = result.getString("brand");
	String brandNumberCount = result.getString("count");
	
	result = stmt.executeQuery(bestBrandSales);
	result.next();
	String brandSalesBrand = result.getString("brand");
	String brandSalesTotal = result.getString("max");
	
	result = stmt.executeQuery(bestBuyerNumber);
	result.next();
	String buyerNumberName = result.getString("username");
	String buyerNumberCount = result.getString("count");
	
	result = stmt.executeQuery(bestBuyerSales);
	result.next();
	String buyerSalesName = result.getString("username");
	String buyerSalesTotal = result.getString("max"); 


%>
	
	<table>	
		<tr>	
			<th>Brand</th>
			<th>Buyer</th>	
		</tr>
		<tr>
				<tr>
					<td><b>By Number of Sales</b></td>
					<td><b>By Number of Sales</b></td>
				</tr>
				<tr>
					<td><%= brandNumberBrand%> : <%= brandNumberCount%></td>
					<td><%= buyerNumberName%> : <%= buyerNumberCount%></td>
				</tr>
		</tr>
		<tr>
				<tr>
					<td><b>By Totals Sales</b></td>
					<td><b>By Totals Sales</b></td>
				</tr>
				<tr>
					<td><%= brandSalesBrand%> : $<%= brandSalesTotal%></td>
					<td><%= buyerSalesName%> : $<%= buyerSalesTotal%></td>
				</tr>
		</tr>
	</table>
			
	
<%
	
	
} 
catch (Exception ex) 
{
	
	con.close();
	out.print(ex);

}
	
%>

</body>
</html>