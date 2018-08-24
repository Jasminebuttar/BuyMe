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

//get the User object for the currently logged in user
User current = (User) session.getAttribute("currentUser");

//get the rep's username, his/her answer, and id of the request the answer belongs to, and the user who asked for help
String repUsername = current.getUsername();
String answer = request.getParameter("answer");
String requestId = request.getParameter("requestid");
String userUsername = request.getParameter("user");

// first we need to check to make sure the request was not answered already

// this will get the information about the help request that will be answered
String select = "SELECT * FROM HelpRequest WHERE requestid = '" + request.getParameter("requestid") + "'";

Statement stmt = con.createStatement();

// run the query
ResultSet result = stmt.executeQuery(select);
result.next();

String answered = result.getString("answered");

// check to make that help requested was not answered already
// this could happen between the rep clicking to answer this one and when they actually submit the answer
if (answered.equals("1"))
{
	out.print("<div class=\"center\">That question was answered already. <a href=\"viewhelp.jsp\">Please try another one</a></div>");
			
	return;
}

// check to make sure a user is logged in
if (current == null)
{
	out.print("<p>Must be logged in to perform this action. Please create an account or log in</p>");
	return;
}

// check to make sure the currrently logged in user is a customer rep
if (!current.getIsCustRep())
{
	out.print("<p>Only a customer rep can perform this action.</p>");
	return;
}

// this will UPDATE the help request with who answered it, the date/time, the answer, and changing to answer
String update = "UPDATE HelpRequest SET rep_username = ?, answer = ?, responsedatetime = NOW(), answered = '1' "+
				" WHERE requestid = ?";

PreparedStatement ps = con.prepareStatement(update);

// insert the parameters
ps.setString(1, repUsername);
ps.setString(2, answer);
ps.setString(3, requestId);

// execute it
ps.executeUpdate();

// this send an email to the user that asked the question with the content being the answer from the rep
// we will do this by inserting to the email table

String insert = "INSERT INTO Messege VALUES(?, ?, 'Answer to your help request', NOW(), ?)";

ps = con.prepareStatement(insert);

ps.setString(1, repUsername);
ps.setString(2, userUsername);
ps.setString(3, answer);

ps.executeUpdate();

con.close();

%>
	<div class="center">
	Your response was submitted. <a href="viewhelp.jsp">Answer more questions</a>
	</div>
<%
}

catch(Exception e)
{	
	if(con != null)
		con.close();
	out.println(e.getMessage());	
}

%>

</body>
</html>