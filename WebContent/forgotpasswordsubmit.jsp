<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Forgot Password</title>
</head>
<body>

<p><%@include file="header.jsp" %></p>

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

	// get the username typed into the input boxes
	String userName = request.getParameter("username");
	
	char[] chars = "abcdefghijklmnopqrstuvwxyz".toCharArray();
	StringBuilder sb = new StringBuilder(8);
	Random random = new Random();
	for (int i = 0; i < 8; i++) {
	    char c = chars[random.nextInt(chars.length)];
	    sb.append(c);
	}
	String atoz = sb.toString();
	
	
    //Create a SQL statement
	Statement stmt1 = con.createStatement();	
	
	String str1 = "UPDATE User SET password = \"" + atoz + "\" WHERE username = \"" + userName + "\"";
	
	// execute the query
    stmt1.executeUpdate(str1);
	
    Statement ch1 = con.createStatement();	
	
	String check = "SELECT username FROM User WHERE username = \"" + userName + "\"";
	ResultSet res= ch1.executeQuery(check);
	
	
	if(!res.next())
		{
		out.print("The username you typed does not exist.");
		}
	else
	{
	
	    Statement stmt2 = con.createStatement();
	    String str2= "SELECT u.email FROM User u WHERE u.username=" + "\"" + userName + "\"";
	    ResultSet result2 = stmt2.executeQuery(str2);
		result2.next();
		String email = result2.getString("email");
		String content = "Your new password is " + atoz;
		
		String str3 = "INSERT INTO EMAIL"
				+ " VALUES (?, ?,?, NOW(), ?)";
		PreparedStatement ps = con.prepareStatement(str3);
		ps.setString(1, "buymesystems@buyme.com");
		ps.setString(2, email);
		ps.setString(3, "Password Reset");
		ps.setString(4, content);
		ps.executeUpdate();
		out.print("An email has been sent to you with the new password.");
		
	}
	// close out the connection to the database
	con.close();
	
} catch (Exception ex) {
	
	if (con != null)
		con.close();
	
	out.print(ex);}

%>

</body>
</html>