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
	String auctionId = request.getParameter("auctionid");
%>

<form method="post" action="modifyrequestsubmit.jsp">
		<input type="hidden" name="auctionid" value=<%=auctionId %>>
		Enter your reason and what you want modifed:<br>
		<textarea rows="20" cols="65" name="reason">......</textarea><br>
		<input type="submit" value="Submit">
	</form><br>

</body>
</html>
