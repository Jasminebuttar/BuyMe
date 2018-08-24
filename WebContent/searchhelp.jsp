<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>
<%@ page import="java.lang.StringBuilder.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BuyMe</title>
</head>
<body>

<%@include file="header.jsp" %>

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
	
	// get the search term the user submitted
	String search = request.getParameter("search");
	// split the search term entered by the user into tokens. each token will seperated by a space " "
	String[] searchTerms = search.toLowerCase().split(" ");
	
	// we need to save the search just in case the user decides to reorder the results
	// once they do this getParmeter() will not work
	if(search == null)
	{
		search = (String) session.getAttribute("search");
	}
	else
	{
		session.setAttribute("search", search);
	}
	
	Statement stmt = con.createStatement();
	
	// query the DB to get all the help requests
	String allHelp = "SELECT * FROM HelpRequest";
	ResultSet helpResult = stmt.executeQuery(allHelp);
	
	if(!helpResult.next())
		out.println("<h2>There are no help requests to search</h2>");
	else
	{
%>
	<table>	
	<tr>	
		<th class="nohover">Question</th>
		<th class="nohover">Category</th>
		<th class="nohover">Answer</th>
	</tr>	
<%
		do
		{
			// get the question and the answer and then concat them together
			// this is what we will use to search in
			String question = (helpResult.getString("question") != null) ? helpResult.getString("question").toLowerCase() : "";
			String answer =  (helpResult.getString("answer") != null) ? helpResult.getString("answer").toLowerCase() : "";
			String category =  (helpResult.getString("category") != null) ? helpResult.getString("category").toLowerCase() : "";
			String searchThis = question + " " + answer + " " + category;
			
			// this Boolean will hold the result of the search on this auction
			boolean foundAllTerms = true;
			
			// look through each term from the search and see if it is in the auction string
			// we will set a flag to false if a term was not in the auction
			for(String term:searchTerms)
			{
				if(!searchThis.contains(term))
				{
					// if we dont find the current term in the auction string
					// we set the boolean test to false and break out of the loop
					foundAllTerms = false;
					break;
				}
			}
			
			// if we have found all the terms, display the auction
			if (foundAllTerms)
			{		
				// display all the information
%>
				<tr  class="nohover">
					<td width="33%"><%=question %></td>
					<td width="33%"><%=category %></td>
					<td width="33%"><%=answer %></td>
				</tr>
				<tr></tr>	
<%
			}
			
		} while(helpResult.next());
		
	}

	con.close();

}
catch(Exception e){	
	out.println(e.getMessage());	
	}

%>


</body>
</html>