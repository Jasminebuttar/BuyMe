<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>
<%@ page import="java.text.SimpleDateFormat" %>

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
	//Get the database connection
	//URL of DB
try{
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

	User current = (User)session.getAttribute("currentUser");
	
	String auctionId = request.getParameter("auctionid");
	String modify = request.getParameter("modify");
	String userName = request.getParameter("username");
	
	// the update that will UPDATE the ModiyAuction table
	String modifyUpdateString = "UPDATE ModifyAuction SET modified=? , custrep=? WHERE username=? and auctionid = ?";
	PreparedStatement modifyUpdate = con.prepareStatement(modifyUpdateString);
	modifyUpdate.setString(2, current.getUsername());
	modifyUpdate.setString(3, userName);
	modifyUpdate.setString(4, auctionId);
	
	// this will send the user a message telling them the outcome of the reps decisions
	String message = "INSERT INTO Messege VALUES('BuyMeSystem', ?, 'Request for Auction Modification', NOW(), ?)";
	PreparedStatement sendMessage = con.prepareStatement(message);
	sendMessage.setString(1, userName);
			
	// check to see if the cust rep decided not to modify the auction
	// if not then send a message and return
	// otherwise send a message saying it will be modified and continue to modification part
	if (!modify.equals("yes"))
	{
		out.println("<p>Auction will not be modified. A message has been sent to the user regarding the manner</p>");
		
		// send the user a message telling them that their request for modification has been denied
		String content = "Your request to modify <a href=\"viewAuction.jsp?auctionid=" + auctionId + "\">this auction</a>" +
						" has been denied";
				
		sendMessage.setString(2, content);
		sendMessage.executeUpdate();
				
		modifyUpdate.setString(1, "0");
		modifyUpdate.executeUpdate();
		
		con.close();
		return;
	}
	else
	{
		out.println("<p class=\"center\">Proceed with the auction modification. A message has been sent to the user regarding the manner</p>");
		
		// send the user a message telling them that their request for modification has been denied
		String content = "Your request to modify <a href=\"viewAuction.jsp?auctionid=" + auctionId + "\">this auction</a>" +
						" has been approved";
				
		sendMessage.setString(2, content);
		sendMessage.executeUpdate();
				
		modifyUpdate.setString(1, "1");
		modifyUpdate.executeUpdate();
	}
	
	Statement stmt = con.createStatement();	
	
	String str = "SELECT * FROM Auction WHERE auctionid = \"" + auctionId + "\"";
	
	ResultSet result = stmt.executeQuery(str);
	result.next();
	
	String title = result.getString("title");
	String description = result.getString("description");
	String reserve = result.getString("reserve");
	String increment = result.getString("increment");
	String pickup = (result.getString("pickup") != null) ? "1" : "0";
	String shipping = result.getString("shipping");
%>
<div class="center">
		<h1><center>MODIFY AUCTION</center></h1>
  		<form method="POST" action="modifyauctionsubmit.jsp">
  		
  		<input type = "hidden" name = "auctionid" value="<%=auctionId %>"><br><br>
  		
		<label>Title:</label>
			<input type = "text" name = "title" value="<%=title %>"><br><br>	
				
		<label>Description:</label>
			<textarea rows="7" cols="45" name="description" ><%=description %></textarea><br>
		
		<label>Reserve Price:</label>
			<input type="text" name="reserve" value="<%=reserve %>"><br>
		
		<label>Bid Increments:</label>
			<input type="text" name="increment" value="<%=increment %>"><br>
		
	
		<label>Pick Up?</label>
	    <input type="checkbox" name="pickup" <%=(pickup.equals("1")) ? "checked" : "" %>><br>
	  	
	  	<label>Shipping Method:</label>
	  	<input type="radio" name="shipping" value="free" checked>
	  	Free
	  	<input type="radio" name="shipping" value="standard">
	  	Standard
	  	
	  	<br>
	  	<input type="submit" value="Submit">
	</form>
	
</div>


<%
}

catch (Exception ex) {
out.print(ex);}
%>

</body>
</html>
