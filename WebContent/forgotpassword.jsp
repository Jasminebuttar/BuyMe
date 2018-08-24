<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Forgot Password</title>
</head>
<body>

<%@include file="header.jsp" %>	

<h1><center>A New Password Will Be Sent To Your Email</center></h1>
<div class="center">

	<p> Input your username. </p>
	
		<form method="post" action="forgotpasswordsubmit.jsp"> 
		<label>Username:</label>
		<input type="text" name="username"><br>
		<input type="submit" value="submit">
		</form>
		
</div>

</body>
</html>