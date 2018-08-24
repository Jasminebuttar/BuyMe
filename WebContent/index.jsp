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
	
	String sortBy = (request.getParameter("sortby") == null) ? "enddate" : request.getParameter("sortby");
	Integer orderValue = (request.getParameter("order") == null) ? 1 : (request.getParameter("order").equals("0") ? 0 : 1);
	String order = (orderValue == 0) ? "DESC" : "ASC";
	
	
	
	
	
	// get all the auctions that have not ended yet
	String select = "SELECT title, auctionid, image, enddate, amount, brand, model FROM "+
					"(SELECT title, a.auctionid, image, enddate, MAX(amount) as amount, brand, model FROM "+
					"Auction a LEFT JOIN Bid b ON a.auctionid = b.auctionid" +
					" WHERE a.enddate >= NOW() GROUP BY a.auctionid) as bids " +
					"ORDER BY " + sortBy + " " + order;
	
	ResultSet result = stmt.executeQuery(select);
	
%>
	<h2 class="center">Auctions still in progess</h2>
	<h4 class="center">Click the columns to change the order of the auctions</h4>
	<br>
	<table>	
	<tr>	
	<th class="nohover"> </th>	
	<th><a href="index.jsp?sortby=title&order=<%out.print((!(sortBy.equals("title"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
		Title  <%out.print((!(sortBy.equals("title"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>
	<th><a href="index.jsp?sortby=brand&order=<%out.print((!(sortBy.equals("brand"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
		Brand  <%out.print((!(sortBy.equals("brand"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>
	<th><a href="index.jsp?sortby=model&order=<%out.print((!(sortBy.equals("model"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
		Model  <%out.print((!(sortBy.equals("model"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>
	<th><a href="index.jsp?sortby=amount&order=<%out.print((!(sortBy.equals("amount"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
		Max Bid  <%out.print((!(sortBy.equals("amount"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>	
	<th><a href="index.jsp?sortby=enddate&order=<%out.print((!(sortBy.equals("enddate"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
		End Date  <%out.print((!(sortBy.equals("enddate"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>		
	</tr>	
<%	
	while(result.next())
	{
		// get all the needed variable from the current auction being proccessd
		String auctionId = result.getString("auctionid");
		String image = result.getString("image");
		String endDate = result.getString("enddate");
		String title = result.getString("title");
		String brand = result.getString("brand").toUpperCase();
		String model = result.getString("model");
		Double amount = (result.getString("amount") != null) ? Double.parseDouble(result.getString("amount")) : 0.00;
		String winningBid = String.format("%.2f",amount);
		String auctionLink = "viewAuction.jsp?auctionid=" + auctionId;

		// display all the information
		%>
		<tr>	
			<td><a href="<%=auctionLink%>"><img src="<%=image%>" alt="auctpic" width="70" height="70"></a></td>
			<td><a href="<%=auctionLink%>"><%=title%></a></td>
			<td><a href="<%=auctionLink%>"><%=brand %></a></td>
			<td><a href="<%=auctionLink%>"><%=model %></a></td>
			<td><a href="<%=auctionLink%>">$<%=winningBid %></a></td>
			<td><a href="<%=auctionLink%>"><%=endDate%></a></td>
		</tr>		
<%
	}

//get all the auctions that have ended
	select = "SELECT title, auctionid, image, enddate, amount, brand, model FROM "+
					"(SELECT title, a.auctionid, image, enddate, MAX(amount) as amount, brand, model FROM "+
					"Auction a LEFT JOIN Bid b ON a.auctionid = b.auctionid" +
					" WHERE a.enddate < NOW() GROUP BY a.auctionid) as bids " +
					"ORDER BY " + sortBy + " " + order;
	
	result = stmt.executeQuery(select);
%>
</table>
	
	<br><br>
	<h2 class="center">Finished Auctions</h2>
	<h4 class="center">Click the columns to change the order of the auctions</h4>
	<br>
	<table>	
	<tr>
	<tr>	
	<th class="nohover"> </th>	
	<th><a href="index.jsp?sortby=title&order=<%out.print((!(sortBy.equals("title"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
		Title  <%out.print((!(sortBy.equals("title"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>
		
	<th><a href="index.jsp?sortby=brand&order=<%out.print((!(sortBy.equals("brand"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
		Brand  <%out.print((!(sortBy.equals("brand"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>
		
	<th><a href="index.jsp?sortby=model&order=<%out.print((!(sortBy.equals("model"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
		Model  <%out.print((!(sortBy.equals("model"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>
		
	<th><a href="index.jsp?sortby=amount&order=<%out.print((!(sortBy.equals("amount"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
		Max Bid  <%out.print((!(sortBy.equals("amount"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>
			
	<th><a href="index.jsp?sortby=enddate&order=<%out.print((!(sortBy.equals("enddate"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
		End Date  <%out.print((!(sortBy.equals("enddate"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>		
	</tr>	
<%	

	while(result.next())
	{
		// get all the needed variable from the current auction being proccessd
		String auctionId = result.getString("auctionid");
		String image = result.getString("image");
		String endDate = result.getString("enddate");
		String title = result.getString("title");
		String brand = result.getString("brand").toUpperCase();
		String model = result.getString("model");
		Double amount = (result.getString("amount") != null) ? Double.parseDouble(result.getString("amount")) : 0.00;
		String winningBid = String.format("%.2f",amount);
		
		String auctionLink = "viewAuction.jsp?auctionid=" + auctionId;

		// display all the information
		%>
		<tr>		
			<td><a href="<%=auctionLink%>"><img src="<%=image%>" alt="auctpic" width="70" height="70"></a></td>
			<td><a href="<%=auctionLink%>"><%=title%></a></td>
			<td><a href="<%=auctionLink%>"><%=brand %></a></td>
			<td><a href="<%=auctionLink%>"><%=model %></a></td>
			<td><a href="<%=auctionLink%>">$<%=winningBid %></a></td>
			<td><a href="<%=auctionLink%>"><%=endDate%></a></td>
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