<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Generate Reports</title>
</head>
<body>

<%@include file="header.jsp" %>
<%@include file="subheader.jsp" %>

<h1><center>Earning Report as per Brand</center></h1>
<% //Get the database connection
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
	
	String sortBy = (request.getParameter("sortby") == null) ? "sum" : request.getParameter("sortby");
	Integer orderValue = (request.getParameter("order") == null) ? 0 : (request.getParameter("order").equals("0") ? 0 : 1);
	String order = (orderValue == 0) ? "DESC" : "ASC";
    
	Statement stmt = con.createStatement();	
	String str = "SELECT SUM(max) as sum, brand "+ 
				 "FROM (SELECT MAX(b.amount) as max, b.auctionid, a.brand "+ 
				 "FROM Bid b INNER JOIN Auction a ON b.auctionid = a.auctionid "+
				 "WHERE a.enddate <= NOW() GROUP BY auctionid) as sales "+
		         "GROUP BY brand ORDER BY " + sortBy + " " + order;
	
	ResultSet result = stmt.executeQuery(str);
	String brand;
	double total;%>
	
	<table>	
	<tr>	
	<th>BRAND</th>	
	<th>EARNINGS</th>	
	</tr>	
	
	<%while(result.next())
	{
		brand = result.getString("brand");
	    total = result.getDouble("sum");
	    %>

<tr>	
<td><%=	brand%></td>	
<td><%= total %></td>
</tr>	
<%
	}con.close();
	%>
	</table>
	</body>
	</html>
	
	              
	
	
	
	
	
	
	
