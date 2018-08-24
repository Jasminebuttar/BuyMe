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

try
{
	
//Get the database connection
//URL of DB
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

//get the User object for the currently logged in user
User current = (User) session.getAttribute("currentUser");
		
if (current == null)
{
	out.print("<p>Must be logged in to perform this action. Please create an account or log in</p>");
	return;
}

if (!current.getIsCustRep())
{
	out.print("<p>Only a customer rep can perform this action.</p>");
	return;
}

String select = "SELECT * FROM HelpRequest WHERE answered = '0'";

Statement stmt = con.createStatement();

// run the query
ResultSet result = stmt.executeQuery(select);

%>
<table>	
<tr>	
<th>User</th>	
<th>Question</th>	
<th>Category</th>
<th>Date/Time Submitted</th>
<th></th>	
</tr>	
<%	
//Iterate over	the	ResultSet
while(result.next()){	
%>
<tr>	
<td><%=	result.getString("user_username")%></td>	
<td><%=	result.getString("question")%></td>	
<td><%=	result.getString("sentdatetime")%></td>
<td><%=	result.getString("category")%></td>
<td><a href="answerhelp.jsp?requestid=<%= result.getString("requestid")%>">Answer this question</a></td>
</tr>	
<%
}

}

catch(Exception e)
{	
	out.println(e.getMessage());	
}

%>
</table>
</body>
</html>