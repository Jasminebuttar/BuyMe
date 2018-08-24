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
	Connection con = null;
	
	//Get the database connection
	//URL of DB
try{
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
	
	// get all the unprocessed modified auction 
	String str = "SELECT * FROM ModifyAuction WHERE modified IS NULL";
	Statement stmt = con.createStatement();
	
	ResultSet result = stmt.executeQuery(str);

	if (!result.next())
	{
		out.println("<p>There are no modify auction requests to process</p>");
		
		con.close();
		return;
	}
%>
	<table>
		<tr>
			<th>Username</th>
			<th>AuctionId</th>
			<th>Reason</th>
			<th>Modify?</th>
		</tr>

<%	
	do
	{
		String userName = result.getString("username");
		String auctionId = result.getString("auctionid");
		String reason = result.getString("reason");
%>
	<tr>
			<td><%=userName %></td>
			<td><a href="viewAuction.jsp?aucitonid=<%=auctionId %>"><%=auctionId %></a></td>
			<td><%=reason %></td>
			<td><a href="modifyauction.jsp?username=<%=userName %>&auctionid=<%=auctionId %>&modify=yes">Yes</a> or 
				<a href="modifyauction.jsp?username=<%=userName %>&auctionid=<%=auctionId %>&modify=no">No</a></td>
	</tr>
		
<%
		
		
	} while(result.next());
%>
</table>


<%
con.close();

}

catch (Exception ex) 
{
	if (con != null)
		con.close();
	
	out.print(ex);
}
	
%>

</body>
</html>
