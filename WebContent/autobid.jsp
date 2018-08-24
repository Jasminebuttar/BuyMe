<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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

	// get the User object for the currently logged in user
	User current = (User) session.getAttribute("currentUser");
			
	if (current == null)
	{
		out.print("<p>Must be logged in to perform this action. Please create an account or log in</p>");
		
		return;
	}

	// get the auctionid, amount for the autobid, and the user sumbmitting the autobid
	String auctionId = (String) session.getAttribute("auctionid");
	Double amount = Double.parseDouble((String) request.getParameter("amount"));
	Double startPrice = Double.parseDouble((String)  session.getAttribute("startprice"));
	String username = current.getUsername();
	
	// get the seller of the auction to make sure the user is not trying to bid on his/her
	// own auction
	String seller = "";
	String sellerQuery = "SELECT seller FROM Auction where auctionid = " + auctionId;
	Statement sellerStmt = con.createStatement();
	ResultSet sellerResult = sellerStmt.executeQuery(sellerQuery);
	
	if(sellerResult.next())
		seller = sellerResult.getString("seller");
	
	if(seller.equals(username))
	{
		out.print("<p>Nice try. You cannot bid on your own auction.</p>");
		return;
	}

	//Make select statement for the AutoBid table:
	String select = "SELECT COUNT(*) as count FROM AutoBid WHERE username = '" + username +"' AND auctionid = '" + auctionId +"'";
	
	Statement stmt = con.createStatement();
	
	// run the query
	ResultSet result = stmt.executeQuery(select);
	result.next();
	
	//get the count
	int count = result.getInt("count");
	
	// check if the user has already set up an autobid for this auction
	if (count > 0)
	{
		// if so then we will ask them if they want to update the autobid amount
		
		//get the old autobid amount
		String str = "SELECT maxPrice FROM AutoBid WHERE username = '" + username +"' AND auctionid = '" + auctionId +"'";
		
		// run the query
		ResultSet result2 = stmt.executeQuery(str);
		result2.next();
%>
		<p> You already set up an autobid for this auction for the amount of $<%out.print(result2.getString("maxPrice"));%></p>
		
		<p>Would you like to update the autobid to a new amount?
			<form method="post" action="updateautobid.jsp">
			<input type="text" name="amount">
			<input type="submit" value="Submit AutoBid">
			</form>
<%
	}
	else
	{
		// otherwise we can just add the user's autobid to the table
		
		String insert = "INSERT INTO AutoBid VALUES (?, ?, ?)";
		
		//Create a Prepared SQL statement
		// all the question marks will be replaced with the values from the form and session
		PreparedStatement ps = con.prepareStatement(insert);
		
		//Add the parameters
		ps.setString(1, username);
		ps.setString(2, auctionId);
		ps.setString(3, amount.toString());
		
		ps.executeUpdate();
		
		out.print("<p>Autobid for the amount of "+ amount +" was set up</p>");
		
	}
	
	con.close();
	
} 

catch (Exception ex) 
{
	if(con != null)
		con.close();
	out.print(ex);

}

%>

</body>
</html>