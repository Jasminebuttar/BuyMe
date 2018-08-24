<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>

<!DOCTYPE html>
<html>
<head>
	<title>Help</title>
</head>
<body>

<%@include file="header.jsp" %>

<div class="center">
	<h1><center>NEED HELP?</center></h1><br>
	<form method="post" action="helpsubmit.jsp">
		Question:<br>
		<textarea rows="10" cols="45" name="question">Type your question here......</textarea><br>
		Category:<br>
			<select name = "category">
  				<option value="account">Account</option>
  				<option value="auction">Auction</option>
  				<option value="bid">Bid Insert/Delete</option>
  				<option value="shipping">Shipping</option>
  				<option value="tracking">Tracking</option>
  				<option value="buying">Buying</option>
  				<option value="selling">Selling</option>
  				<option value="returns">Returns</option>
  				<option value="refunds">Refunds</option>
  				<option value="other">Other</option>
			</select>
		<input type="submit" value="Submit">
	</form><br>
	<a href="viewallhelp.jsp?category=all">Click here to view all asked questions</a>

</div>

</body>
</html>