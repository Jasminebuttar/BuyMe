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

Connection con = null; 

try
{ 
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
		
		Statement stmt = con.createStatement();	
		
		String str = "SELECT username as cusrep FROM User WHERE `isCustRep` = \"" + 1 + "\"";
		
		ResultSet result = stmt.executeQuery(str);
		String userName;
		%>
		<table>
		<tr>
		<th>Customer Rep</th>
		<th>Action</th>
	    </tr>
		
		<% 
		while(result.next())
		{
			userName = result.getString("cusrep");
			  %>

			  <tr>	
			  <td><%=userName%></td>	
			  <td><a href=deletecusrepsubmit.jsp?username=<%=userName%>>Delete Account</a></td>
			  </tr>	
			  <%
	    }
		
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

	
     
