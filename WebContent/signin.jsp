<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login into your account</title>
</head>
<body>

<p><%@include file="header.jsp" %></p>	

<div class="center">

	<p> Input your username and password. Then submit to login. </p>
	
		<form method="post" action="signinsubmit.jsp"> 
		<label>Username:</label>
		<input type="text" name="username">
		<label>Password:</label>
		<input type="password" name="password">
		<br>
		<input type="submit" value="submit">
		</form>
		
		<p><a href="forgotpassword.jsp">Forgot your password?</a></p>
		
</div>

</body>
</html>