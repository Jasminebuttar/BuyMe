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

<div class="center">
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
	out.print("<p>That question was answered already. Please try another one<p>");
}
else
{
	String user = result.getString("user_username");
	String dateTime = result.getString("sentdatetime");
	String question = result.getString("question");
	
%>
	<table>	
	<tr>	
	<td>User:</td>
	<td><%=	user%></td>
	</tr>
	<tr>
	<td>Date/Time Submitted:</td>	
	<td><%=	dateTime%></td>
	</tr>
	<tr>
	<td>Question:</td>	
	<td><%=	question%></td>
	</tr>	
	</table>
	<br><br>
	<form class="center" method="post" action="answerhelpsubmit.jsp?requestid=<%=request.getParameter("requestid")%>&user=<%=user%>">
		Question:<br>
		<textarea rows="10" cols="45" name="answer">Type your response here......</textarea><br>
		<input type="submit" value="Submit">
	</form>
	
<%
	
}

con.close();

}

catch(Exception e)
{	
	out.println(e.getMessage());	
}

%>
</div>
</body>
</html>