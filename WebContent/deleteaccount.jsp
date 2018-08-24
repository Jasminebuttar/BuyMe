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

<% 

String delete = request.getParameter("delete");
if (delete==null)
{%><h1><center>Are you sure you want to delete your BuyMe account?</center></h1>
<center><a href="deleteaccount.jsp?delete=yes">YES</a></center><br>
<center><a href="deleteaccount.jsp?delete=no">NO</a></center>
<%}
else if (delete.equals("yes"))
   {%><p>Your account was successfully deleted</p>
	   <%String connectionUrl = "jdbc:mysql://mydb.c1trsunp1o0n.us-east-2.rds.amazonaws.com:3306/BuyMe";
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
		String userName = current.getUsername();
		
	    Statement stmt = con.createStatement();	
		
		String str = "DELETE FROM User WHERE `username` = \"" + userName + "\"";
		
		stmt.executeUpdate(str);
		session.setAttribute("currentUser", null);
		con.close();
	}
   else if(delete.equals("no"))
   {%>
   <jsp:forward page="account.jsp"/>
	<% }
     %>
     </body>
     </html>
     
