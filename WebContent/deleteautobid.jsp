<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete Autobid</title>
</head>
<body>
<%@include file="header.jsp" %>
<%@include file="subheader.jsp" %>

<% 

Connection con = null;

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
		String userName = current.getUsername();
		
		Statement stmt = con.createStatement();	

		String str = "SELECT ab.auctionid as auctionid FROM AutoBid ab INNER JOIN " + 
				      "Auction a ON a.auctionid=ab.auctionid " +
				      "WHERE a.enddate > NOW() AND ab.username = \"" + userName + "\"";
		
		ResultSet result = stmt.executeQuery(str);
		String id;
		%>
		
		<table>
		<tr>
			<th>Auction Id</th>
			<th> DELETE?</th>
	    </tr>
		
		<% 
		while(result.next())
		{
			id = result.getString("auctionid");
			  %>

			  <tr>	
			  <td><a href=viewAuction.jsp?auctionid=<%=id%>><%=id%></a></td>	
			  <td><a href=deleteautobidsubmit.jsp?auctionid=<%=id%>>YES</a></td>
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

	
     
