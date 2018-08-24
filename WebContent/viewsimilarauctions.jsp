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
	
	// we will compare this auction to each auction that occured last month
	// and assign a simlarity variable that is based on a weighted assesment of each field
	// if this simlarity variable exceeds a certain value we consider the auctions "similar"
	double similarity = 0;
	
	boolean foundSimilar = false;
	
	// get the auctionid of the auction we want to find similar auctions for
	String thisAuction = request.getParameter("auctionid");
	
	// get all the information for this auction
	String auctionSelect = "SELECT * from Auction WHERE auctionid = " + thisAuction;
	Statement stmt = con.createStatement();
	
	ResultSet result = stmt.executeQuery(auctionSelect);
	result.next();
				
	// get all the parameter for this auction
	String thisBrand = result.getString("brand");
	String thisModel = result.getString("model");
	String thisCondition = result.getString("cond");
	String thisColor = result.getString("color");
	Double thisMegapixels = result.getDouble("megapixels");
	String thisCarrier = result.getString("carrier");
	Double thisRam = result.getDouble("ram");
	Double thisScreenSize = result.getDouble("screensize");
	Double thisStorage = result.getDouble("storagespace");
	String thisExpandable = (result.getString("expandable") != null) ? "1" : "0";
	
	String sortBy = (request.getParameter("sortby") == null) ? "enddate" : request.getParameter("sortby");
	Integer orderValue = (request.getParameter("order") == null) ? 1 : (request.getParameter("order").equals("0") ? 0 : 1);
	String order = (orderValue == 0) ? "DESC" : "ASC";
	
	// get all the auctions that occured last month
	String select = "SELECT * FROM "+
					"(SELECT a.*, MAX(amount) as amount FROM "+
					"Auction a LEFT JOIN Bid b ON a.auctionid = b.auctionid" +
					" WHERE YEAR(a.enddate) = YEAR(CURDATE() - INTERVAL 1 MONTH) AND " + 
					" MONTH(a.enddate) = MONTH(CURDATE() - INTERVAL 1 MONTH) GROUP BY a.auctionid) as bids " +
					"ORDER BY " + sortBy + " " + order;
	
	result = stmt.executeQuery(select);
	
%>
	<h2 class="center">Similar Auctions From Last Month</h2>
	<h4 >*Click the columns to change the order of the auctions</h4>
	<br>
	<table>	
	<tr>	
	<th class="nohover"> </th>	
	<th><a href="viewsimilarauctions.jsp?auctionid=<%=thisAuction %>&sortby=title&order=<%out.print((!(sortBy.equals("title"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
		Title  <%out.print((!(sortBy.equals("title"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>
	<th><a href="viewsimilarauctions.jsp?auctionid=<%=thisAuction %>&sortby=brand&order=<%out.print((!(sortBy.equals("brand"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
		Brand  <%out.print((!(sortBy.equals("brand"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>
	<th><a href="viewsimilarauctions.jsp?auctionid=<%=thisAuction %>&sortby=model&order=<%out.print((!(sortBy.equals("model"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
		Model  <%out.print((!(sortBy.equals("model"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>
	<th><a href="viewsimilarauctions.jsp?auctionid=<%=thisAuction %>&sortby=amount&order=<%out.print((!(sortBy.equals("amount"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
		Max Bid  <%out.print((!(sortBy.equals("amount"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>	
	<th><a href="viewsimilarauctions.jsp?auctionid=<%=thisAuction %>&sortby=enddate&order=<%out.print((!(sortBy.equals("enddate"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
		End Date  <%out.print((!(sortBy.equals("enddate"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>		
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
		String brand = result.getString("brand").toUpperCase();
		String model = result.getString("model");
		String condition = result.getString("cond");
		String color = result.getString("color");
		Double megapixels = result.getDouble("megapixels");
		String carrier = result.getString("carrier");
		Double ram = result.getDouble("ram");
		Double screenSize = result.getDouble("screensize");
		Double storage = result.getDouble("storagespace");
		String expandable = (result.getString("expandable") != null) ? "1" : "0";
		Double reserve = result.getDouble("reserve");
		
		// get the max bid for this auction
		Statement maxStmt = con.createStatement();
		String getMax = "SELECT MAX(amount) as max FROM Bid WHERE auctionid = '" + auctionId + "'";
		ResultSet maxResult = maxStmt.executeQuery(getMax);
		maxResult.next();
		
		// get the result from the query
		Double maxBid = 0.0;
		
		if (maxResult.getString("max") != null)
			maxBid = Double.parseDouble(maxResult.getString("max"));
		
		String winningBid = String.format("%.2f",maxBid);
		
		// resert the similarity counter
		similarity = 0;
		
		// start comparing the values of the auctions to measure the similarity
		if (thisBrand.equals(brand))
			similarity += 2;
		
		if (thisModel.equals(model))
			similarity += 3;
		
		if (thisCondition.equals(condition))
			similarity += 1;
		
		if (thisColor.equals(color))
			similarity += 1;
		
		if (thisMegapixels == megapixels)
			similarity += 1;
		else if (Math.abs(thisMegapixels - megapixels) <= 2)
			similarity += 0.5;
		
		if (thisCarrier.equals(carrier))
			similarity += 1;
		
		if (thisRam == ram)
			similarity += 1;
		else if (Math.abs(thisRam - ram) <= 1)
			similarity += 0.5;
		
		if (thisScreenSize == screenSize)
			similarity += 1;
		else if (Math.abs(thisScreenSize - screenSize) <= 0.5)
			similarity += 0.5;
		
		if (thisStorage == storage)
			similarity += 1;
		else if (Math.abs(thisStorage - storage) <= 0.5)
			similarity += 0.5;

		if (thisExpandable.equals(expandable))
			similarity += 1;
		
		if (similarity >= 5)
		{
			foundSimilar = true;
		// display all the information
%>
			<tr>	
				<td><a href="viewAuction.jsp?auctionid=<%=auctionId%>"><img src="<%= image%>" alt="auctpic" width="70" height="70"></a></td>
				<td><a href="viewAuction.jsp?auctionid=<%=auctionId%>"><%= title%></a></td>
				<td><a href="viewAuction.jsp?auctionid=<%=auctionId%>"><%= brand %></a></td>
				<td><a href="viewAuction.jsp?auctionid=<%=auctionId%>"><%= model %></a></td>
				<td><a href="viewAuction.jsp?auctionid=<%=auctionId%>">$<%= winningBid %></a></td>
				<td><a href="viewAuction.jsp?auctionid=<%=auctionId%>"><%= endDate%></a></td>
				<td><%=((maxBid-reserve) > 0.001) ? "YES" : "NO"%></td>
			</tr>		
<%
		}	
	}

	//if we didnt find any similar auctions, alert the user
	if (!foundSimilar)	
		out.print("<tr><td>No similar auctions from last month were found</td></tr>");

%>
</table>
	
<%
	
	
con.close();

}

catch(Exception e){	
	out.println(e.getMessage());	
	}
%>


</body>
</html>