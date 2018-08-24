<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete Account</title>
</head>
<body>

<%@include file="header.jsp" %>
<%@include file="subheader.jsp" %>

<% 
	String delete = request.getParameter("delete");
	String userName = request.getParameter("username");

	if (delete==null)
	{
%>

<h1><center>Are you sure you want to delete this account?</center></h1>
<center><a href="deletecusrepsubmit.jsp?delete=yes&username=<%=userName%>">YES</a></center><br>
<center><a href="deletecusrepsubmit.jsp?delete=no">NO</a></center>

<%

	}

	else if (delete.equals("yes"))
	{
	
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
		
		
		
        Statement stmt = con.createStatement();	
		
		String str = "DELETE FROM User WHERE `username` = \"" + userName + "\"";
		
		stmt.executeUpdate(str);
		session.setAttribute("user", null);%>
		<p>The Customer Rep account was successfully deleted.</p>
<%
	
	con.close();
		
	}

   else if(delete.equals("no"))
   {
%>
   <jsp:forward page="account.jsp"/>
   
<% 
	}  
%>
    
</body>
</html>
     
