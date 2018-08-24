<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Alert List</title>
</head>
<body>

<%@include file="header.jsp" %>
<%@include file="subheader.jsp" %>

<h1><center>ALERTS!!!</center></h1>
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

	User current = (User)session.getAttribute("currentUser");
	String userName = current.getUsername();
	int i = 1;
    Statement stm = con.createStatement();	
	
	String str = "SELECT * FROM Alert WHERE username = \"" + userName + "\"";
	ResultSet result = stm.executeQuery(str);

%>
	<table>
	
<% 	
	while(result.next())
	{ 
	    String alertId =result.getString("alertid");
%>
		<tr>
		<td><a href="viewalert.jsp?alertid=<%=alertId%>">Alert <%=i %></a></td>
		</tr>
		
	    <% 

	    i++;
	}
	
	
    // close out the connection to the database
	con.close();
	
} 
catch (Exception ex) 
{
	if (con != null)
		con.close();
	out.print(ex);

}
	
%>

</table>
</body>
</html>