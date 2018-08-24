<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Email</title>
</head>
<body>

<%@include file="header.jsp" %>
<%@include file="subheader.jsp" %>

<h1><center>E-mails</center></h1>

<%

Connection con = null;

try
{
	//Get the database connection
	//URL of DB
	String connectionUrl = "jdbc:mysql://mydb.c1trsunp1o0n.us-east-2.rds.amazonaws.com:3306/BuyMe";
		
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
	
	// sorting stuff
	String sortBy = (request.getParameter("sortby") == null) ? "date_time" : request.getParameter("sortby");
	Integer orderValue = (request.getParameter("order") == null) ? 0 : (request.getParameter("order").equals("0") ? 0 : 1);
	String order = (orderValue == 0) ? "DESC" : "ASC";
	
	User current = (User)session.getAttribute("currentUser");
	String userName = current.getUsername();
	String from, dateTime;
	
    Statement stmt = con.createStatement();	
	
	String str = "SELECT * FROM Messege WHERE `to` = '" + userName + "' ORDER BY `" + sortBy + "` " + order;
	
	ResultSet result = stmt.executeQuery(str);
	
%>
<table>	
<tr>	
<th><a href="email.jsp?sortby=from&order=<%out.print((!(sortBy.equals("from"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
	From  <%out.print((!(sortBy.equals("from"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>
<th><a href="email.jsp?sortby=subject&order=<%out.print((!(sortBy.equals("subject"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
	Subject  <%out.print((!(sortBy.equals("subject"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>
<th><a href="email.jsp?sortby=date_time&order=<%out.print((!(sortBy.equals("date_time"))) ? 1 : ((orderValue == 0) ? 1 : 0)); %>">
	Date/Time  <%out.print((!(sortBy.equals("date_time"))) ? "" : ((orderValue == 0) ? "<i class=\"fas fa-arrow-circle-down\"></i>" : "<i class=\"fas fa-arrow-circle-up\"></i>")); %></a></th>		
</tr>	
<%	
//Iterate over	the	ResultSet
while(result.next())
{
	
	from = result.getString("from");
	dateTime = result.getString("date_time");
	
%>

<tr>	
<td><%=	from%></td>	
<td><a href="viewemail.jsp?to=<%=userName%>&from=<%=from%>&date_time=<%=dateTime%>" > <%=result.getString("subject")%> </a></td>	
<td><%=	dateTime%></td>	
</tr>	
<%
}

con.close();

}

catch(Exception e){	
	
	if (con != null)
		con.close();
	
	out.println(e.getMessage());	
	}
%>
</table>	
</body>
</html>