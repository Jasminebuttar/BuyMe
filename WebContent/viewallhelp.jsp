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

<div>
	<form method="post" action="searchhelp.jsp" style="display: inline;">
		<input type="text" name="search" size="45">
		<input type="submit" value="search">
	</form>
</div><br><br>

<div class="center">
<form method="post" action="viewallhelp.jsp">
	Category:<br>
		<select name = "category">
 				<option value="account">Account</option>
 				<option value="all">All</option>
 				<option value="auction">Auction</option>
 				<option value="bid">Bid Insert/Delete</option>
 				<option value="buying">Buying</option>
 				<option value="refunds">Refunds</option>
 				<option value="returns">Returns</option>
 				<option value="shipping">Shipping</option>
 				<option value="tracking">Tracking</option>
 				<option value="selling">Selling</option>
 				<option value="other">Other</option>
		</select>
	<input type="submit" value="Submit">
</form><br>
</div>

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

	// check what category the user wants to view help questions from
	// if it is 'all' there will be no where clause
	String whereCategory = request.getParameter("category").equals("all") ? "" : "WHERE category = '" + request.getParameter("category") + "'";
	
	String str = "SELECT question, answer, category FROM HelpRequest " + whereCategory + " ORDER BY sentdatetime DESC";
    Statement stmt = con.createStatement();	
	ResultSet result = stmt.executeQuery(str);
	
%>
<table  >	
<tr>	
	<th class="nohover">Question</th>
	<th class="nohover">Category</th>
	<th class="nohover">Answer</th>
</tr>	

<%
	while(result.next())
	{
		String question = result.getString("question");
		String category = result.getString("category");
		String answer = (result.getString("answer") == null) ? "UNANSWERED" : result.getString("answer");
%>
		<tr  class="nohover">
			<td width="33%"><%=question %></td>
			<td width="33%"><%=category %></td>
			<td width="33%"><%=answer %></td>
		</tr>
		<tr></tr>
<%

	}
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