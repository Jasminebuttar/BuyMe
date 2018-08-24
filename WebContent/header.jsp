<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="main.css">
<link rel="stylesheet" type="text/css" href="header.css">
<link rel="stylesheet" type="text/css" href="list.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.10/css/all.css" integrity="sha384-+d0P83n9kaQMCwj8F4RJB66tzIwOKmrdb46+porD/OvrJ+37WqIM7UoBtwHO6Nlg" crossorigin="anonymous">
<meta charset="ISO-8859-1">
<title>Welcome to Buy Me</title>
</head>
<body>

<div id="header">
	
	<div id = "options">
		<% 
			User loggedInUser = (User) session.getAttribute("currentUser");
			
			if (loggedInUser == null)
			{
		%>
				
				<a class="left" href="help.jsp">Help</a>
				<a class="right" href="signin.jsp">Sign In</a> 
				<a class="right" href="register.jsp">Create Account</a>
				
	<%	
			}
			else
			{
	%>
				<a class="left" href="help.jsp">Help</a>
				<a class="right" href="account.jsp">My Account (<%=loggedInUser.getUsername() %>)</a>
				<a class="right" href="logout.jsp">Logout</a>
	<%	
			}	
	%>
	</div>	
	
	<div id="logo">
		<a href="index.jsp"><img id="logo" src="images/logo.png" alt="logo" height="150" width="270"></a>
	</div>
	
	<div id="search">
	<form method="post" action="search.jsp" style="display: inline;">
		<input type="text" name="search" size="45">
		<input type="submit" value="search">
	</form>
	<a href="advanced.jsp">Advanced Search</a>
	</div>
	
</div>
<br><br>

</body>
</html>