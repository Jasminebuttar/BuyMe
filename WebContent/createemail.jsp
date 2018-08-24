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

<%

try
{

	User current = (User)session.getAttribute("currentUser");
	String userName = current.getUsername();
	
	String to = (request.getParameter("to") != null) ? request.getParameter("to") : "";
	
%>

<form method="post" action="emailsubmit.jsp">
		<input type="hidden" name="from" value="<%=userName%>">
		To:<br>
		<input type="text" name="to" style="width:550px;" value="<%=to %>" >
		<br>Subject:<br>
		<input type="text" name="subject" style="width:550px;">
		<br>Content:<br>
		<textarea rows="40" cols="90" name="content">Type your response here......</textarea><br>
		<input type="submit" value="Submit">
	</form>
<%



}

catch(Exception e){	
	out.println(e.getMessage());	
	}
%>

</body>
</html>