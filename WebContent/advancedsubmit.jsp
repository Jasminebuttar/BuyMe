<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="main.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%@include file="header.jsp" %>
<%@include file="subheader.jsp" %>

<%

Connection con = null;

try
{
	//get the logged in user
	User current = (User) session.getAttribute("currentUser");
	
	// get all the parameters values the user submitted
	String[] brand = request.getParameterValues("brand");
	String model = request.getParameter("model");
	String[] color = request.getParameterValues("color");
	String screensizelow = request.getParameter("screensizelow");
	String screensizehigh = request.getParameter("screensizehigh");
	String[] carrier = request.getParameterValues("carrier");
	String mplow = request.getParameter("mplow");
	String mphigh = request.getParameter("mphigh");
	String storagelow = request.getParameter("storagelow");
	String storagehigh = request.getParameter("storagehigh");
	String ramlow = request.getParameter("ramlow");
	String ramhigh = request.getParameter("ramhigh");
	String[] condition = request.getParameterValues("condition");
	String[] location = request.getParameterValues("location");
	String pricelow = request.getParameter("pricelow");
	String pricehigh = request.getParameter("pricehigh");
	String[] payment = request.getParameterValues("payment");
	String[] shipping = request.getParameterValues("shipping");
	String expandable = request.getParameter("expandable");
	
	// use the values of the parameters to build the WHERE statement that we will query
	// the database with. 
	// we will AND together the different categories (brand, model, color, etc)
	// for each category that can have multiple values (the ones with check boxes
	// we will OR together the different values checked
	
	String whereClause = "WHERE ";
	
	// check if this is just a call to reorder an already run advanced search
	// if it is the "where" session attribute has been set and we retreive it
	// otherwise we get the parameters from the form
	if (session.getAttribute("where") != null)
	{
		whereClause = (String) session.getAttribute("where");
	}
	else
	{
		if (brand != null)
		{
			whereClause += "(";
			for(int i=0; i<brand.length; i++)
			{
				whereClause += "brand = '" + brand[i] + "'";
				
				// if we are at the last entry in the array add an OR to the WHERE clause
				if(i < brand.length - 1)
					whereClause += " OR ";
			}
			
			whereClause += ")";
		}
		
		if (model != null && !model.equals(""))
		{
			// check to see if the WHERE clause was added to and we need to add an AND
			if (!whereClause.equals("WHERE "))
				whereClause += " AND ";
			
			whereClause += "(model = '" + model + "')"; 
		}
		
		if (color != null)
		{
			// check to see if the WHERE clause was added to and we need to add an AND
			if (!whereClause.equals("WHERE "))
				whereClause += " AND ";
			
			whereClause += "(";
			for(int i=0; i< color.length; i++)
			{
				whereClause += "color = '" + color[i] + "'";;
				
				// if we are at the last entry in the array add an OR to the WHERE clause
				if(i < color.length - 1)
					whereClause += " OR ";
			}
			whereClause += ")";
		}
		
		if (!whereClause.equals("WHERE "))
			whereClause += " AND ";
		
		whereClause += "(screensize >= '" + screensizelow + "' AND screensize <= '" + screensizehigh + "')";
		
		if (carrier != null)
		{
			// check to see if the WHERE clause was added to and we need to add an AND
			if (!whereClause.equals("WHERE "))
				whereClause += " AND ";
			
			whereClause += "(";
			for(int i=0; i< carrier.length; i++)
			{
				whereClause += "carrier = '" + carrier[i] + "'";
				
				// if we are at the last entry in the array add an OR to the WHERE clause
				if(i < carrier.length - 1)
					whereClause += " OR ";
			}
			whereClause += ")";
		}
		
		if ( (mplow != null && !mplow.equals("")) && (mphigh != null && !mphigh.equals("")))
		{
			if (!whereClause.equals("WHERE "))
				whereClause += " AND ";
			
			whereClause += "(megapixels >= '" + mplow + "' AND megapixels <= '" + mphigh + "')";
		}
		
		if (!whereClause.equals("WHERE "))
			whereClause += " AND ";
		
		whereClause += "(storagespace >= '" + storagelow + "' AND storagespace <= '" + storagehigh + "')";
		
		if (!whereClause.equals("WHERE "))
			whereClause += " AND ";
		
		whereClause += "(ram >= '" + ramlow + "' AND ram <= '" + ramhigh + "')";
		
		if (condition != null)
		{
			// check to see if the WHERE clause was added to and we need to add an AND
			if (!whereClause.equals("WHERE "))
				whereClause += " AND ";
			
			whereClause += "(";
			for(int i=0; i< condition.length; i++)
			{
				whereClause += "cond = '" + condition[i] + "'";
				
				// if we are at the last entry in the array add an OR to the WHERE clause
				if(i < condition.length - 1)
					whereClause += " OR ";
			}
			whereClause += ")";
		}
		
		if (location != null)
		{
			// check to see if the WHERE clause was added to and we need to add an AND
			if (!whereClause.equals("WHERE "))
				whereClause += " AND ";
			
			whereClause += "(";
			for(int i=0; i< location.length; i++)
			{
				
				if(location[i].equals("inzip"))
					whereClause += "zip='" + current.getZip() + "'";
		
				else if(location[i].equals("incity"))
					whereClause += "city='" + current.getCity() + "'";
	
				else if(location[i].equals("instate"))
					whereClause += "state='" + current.getState() + "'";
				
				else if(location[i].equals("incounty"))
					whereClause += "county='" + current.getCounty() + "'";

					
				if(i < location.length - 1)
					whereClause += " OR ";
			}
			whereClause += ")";
		}
		
		if ( (pricelow != null) && (pricehigh != null))
		{
			if (!whereClause.equals("WHERE "))
				whereClause += " AND ";
			
			whereClause += "(startprice >= '" + pricelow + "' AND startprice <= '" + pricehigh + "')";
		}
		
		if (payment != null)
		{
			// check to see if the WHERE clause was added to and we need to add an AND
			if (!whereClause.equals("WHERE "))
				whereClause += " AND ";
			
			whereClause += "(";
			for(int i=0; i< payment.length; i++)
			{
				whereClause += "payment = '" + payment[i] + "'";
				
				// if we are at the last entry in the array add an OR to the WHERE clause
				if(i < payment.length - 1)
					whereClause += " OR ";
			}
			whereClause += ")";
		}
		
		if (shipping != null)
		{
			// check to see if the WHERE clause was added to and we need to add an AND
			if (!whereClause.equals("WHERE "))
				whereClause += " AND ";
			
			whereClause += "(";
			for(int i=0; i< shipping.length; i++)
			{
				whereClause += "shipping = '" + shipping[i] + "'";
				
				// if we are at the last entry in the array add an OR to the WHERE clause
				if(i < shipping.length - 1)
					whereClause += " OR ";
			}
			whereClause += ")";
		}
		
		if(expandable != null)
		{
			// check to see if the WHERE clause was added to and we need to add an AND
			if (!whereClause.equals("WHERE "))
				whereClause += " AND ";
			
			whereClause += "(expandable = '1')";
		}
	}
	
	// save the WHERE clause jsut in case the user wants to reorder the results
	// this way we dont have to rebuild it
	session.setAttribute("where", whereClause);
	
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
	
	String sortBy = (request.getParameter("sortby") == null) ? "enddate" : request.getParameter("sortby");
	Integer orderValue = (request.getParameter("order") == null) ? 1 : (request.getParameter("order").equals("0") ? 0 : 1);
	String order = (orderValue == 0) ? "DESC" : "ASC";
	
	Statement stmt = con.createStatement();	
	
	String str = "SELECT * FROM "+
				"(SELECT a.*, MAX(amount) as amount FROM "+
				"Auction a LEFT JOIN Bid b ON a.auctionid = b.auctionid" +
				" WHERE a.enddate >= CURDATE() GROUP BY a.auctionid) as bids ";
	
	if (!whereClause.equals("WHERE "))
		str += whereClause;
	
	str += " ORDER BY " + sortBy + " " + order;
	
	//out.print("<p>"+str+"</p>");
	
	ResultSet result = stmt.executeQuery(str);
	
	if (!result.next())
	{
		out.print("<p>There are no auctions that match your criteria. Try searching different ones.</p>");
		con.close();
		return;
	}
	
	%>
<table>	
<tr>	
	<th class="nohover"> </th>	
	<th><a href="advancedsubmit.jsp?sortby=title&order=<%out.print((!(sortBy.equals("title"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
		Title  <%out.print((!(sortBy.equals("title"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>
		
	<th><a href="advancedsubmit.jsp?sortby=brand&order=<%out.print((!(sortBy.equals("brand"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
		Brand  <%out.print((!(sortBy.equals("brand"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>
		
	<th><a href="advancedsubmit.jsp?sortby=model&order=<%out.print((!(sortBy.equals("model"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
		Model  <%out.print((!(sortBy.equals("model"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>
		
	<th><a href="advancedsubmit.jsp?sortby=amount&order=<%out.print((!(sortBy.equals("amount"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
		Max Bid  <%out.print((!(sortBy.equals("amount"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>
			
	<th><a href="advancedsubmit.jsp?sortby=enddate&order=<%out.print((!(sortBy.equals("enddate"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
		End Date  <%out.print((!(sortBy.equals("enddate"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>		
</tr>		
	<%	
	
	//Iterate over	the	ResultSet
	do
	{	
	// get all the needed variable from the current auction being proccessd
		String auctionId = result.getString("auctionid");
		String image = result.getString("image");
		String endDate = result.getString("enddate");
		String title = result.getString("title");
		String brandFound = result.getString("brand").toUpperCase();
		String modelFound = result.getString("model");
		Double amount = (result.getString("amount") != null) ? Double.parseDouble(result.getString("amount")) : 0.00;
		String winningBid = String.format("%.2f",amount);
		
		String auctionLink = "viewAuction.jsp?auctionid=" + auctionId;

		// display all the information
		%>
		<tr>	
			<td><a href="<%=auctionLink%>"><img src="<%=image%>" alt="auctpic" width="70" height="70"></a></td>
				<td><a href="<%=auctionLink%>"><%=title%></a></td>
				<td><a href="<%=auctionLink%>"><%=brandFound %></a></td>
				<td><a href="<%=auctionLink%>"><%=modelFound %></a></td>
				<td><a href="<%=auctionLink%>">$<%=winningBid %></a></td>
				<td><a href="<%=auctionLink%>"><%=endDate%></a></td>
		</tr>			
<%
	}while(result.next());
%>	
</table>
<%

con.close();

}
catch(Exception e)
{	
	if (con != null)
		con.close();
	out.println(e.getMessage());
	
	}

%>

</body>
</html>