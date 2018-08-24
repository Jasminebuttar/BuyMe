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
<title>Insert title here</title>
</head>
<body>

<%@include file="header.jsp" %>
<%@include file="subheader.jsp" %>

<%
Connection con = null;

try
{
	//Get the database connection
	//URL of DB
	String connectionUrl = "jdbc:mysql://mydb.c1trsunp1o0n.us-east-2.rds.amazonaws.com:3306/BuyMe";
		
	User currentUser = (User) session.getAttribute("currentUser");	

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

	// get the username and password from the form that was submitted
	String title = request.getParameter("title");
	String description = request.getParameter("description");
	String startPrice = request.getParameter("startprice");
	Boolean useLocation = request.getParameter("location") != null;
	String brand = request.getParameter("brand");
	String model = request.getParameter("model");
	String condition = request.getParameter("condition");
	String color = request.getParameter("color");
	String megapixels = request.getParameter("megapixels");
	String carrier = request.getParameter("carrier");
	String ram = request.getParameter("ram");
	String screenSize = request.getParameter("screensize");
	String storage = request.getParameter("storage");
	String expandable = (request.getParameter("expandablestorage") != null) ? "1" : "0";
	String pickup = (request.getParameter("pickup") != null) ? "1" : "0";
	String shipping = request.getParameter("shipping");
	String endDateHTML = request.getParameter("enddate");
	String reserve = request.getParameter("reserve");
	String increment = request.getParameter("increment");
	
	java.util.Date date = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm").parse(endDateHTML);
	java.sql.Timestamp sqlDate = new java.sql.Timestamp(date.getTime());
	
	
	String street, city, county, state, zip;
	
	if (!useLocation)
	{
		street = request.getParameter("street");
		city = request.getParameter("city");
		zip = request.getParameter("zip");
		county = request.getParameter("county");
		state = request.getParameter("state");
	}
	else
	{
		street = currentUser.getStreet();
		city = currentUser.getCity();
		zip = currentUser.getZip();
		county = currentUser.getCounty();
		state = currentUser.getState();
	}
	
	String alert = "";
	
	boolean bool = false;

	if(title.equals(""))
	{
		bool = true;
		alert += "<p><b>You must enter the Title!</b></p>";
	}

	if(description.equals(""))
	{
		bool = true;
		alert += "<p><b>You must enter the Description!</b></p>";
	}

	if(startPrice.equals(""))
	{
		bool = true;
		alert += "<p><b>You must enter the Start Price!</b></p>";
	}

	if(reserve.equals(""))
	{
		bool = true;
		alert += "<p><b>You must enter the Reseve Price!</b></p>";
	}

	if(increment.equals(""))
	{
		bool = true;
		alert += "<p><b>You must enter the Bid Increments!</b></p>";
	}
	
	if(model.equals(""))
	{
		bool = true;
		alert += "<p><b>You must enter the Model!</b></p>";
	}

	if(megapixels.equals(""))
	{
		bool = true;
		alert += "<p><b>You must enter the Megapixels!</b></p>";
	}

	if(ram.equals(""))
	{
		bool = true;
		alert += "<p><b>You must enter the Ram!</b></p>";
	}
	
	if(screenSize.equals(""))
	{
		bool = true;
		alert += "<p><b>You must enter the Screen Size!</b></p>";
	}
	
	if(storage.equals(""))
	{
		bool = true;
		alert += "<p><b>You must enter the Storage!</b></p>";
	}                                                                                                             
	
	if(!useLocation)
	{
		if(street.equals(""))
		{
			bool = true;
			alert += "<p><b>You must enter the Street Address!</b></p>";
		}
		
		if(city.equals(""))
		{
			bool = true;
			alert += "<p><b>You must enter the City!</b></p>";
		}
		
		if(zip.equals(""))
		{
			bool = true;
			alert += "<p><b>You must enter the Zipcode!</b></p>";
		}
		
		if(county.equals(""))
		{
			bool = true;
			alert += "<p><b>You must enter the County!</b></p>";
		}
	}

	if(bool == true)
	{
		out.print(alert);
	}

	else
	{
	//Make an insert statement for the User table:
			String insert = "INSERT INTO Auction"+
							"(seller, startdate, startprice, title, description, screensize, " +
							"streetaddress, city, zip, county, state, brand, cond, pickup, shipping, color," +
							"megapixels, carrier, ram, storagespace, expandable, model, reserve, increment, enddate, finished) " +
							" VALUES (?, NOW() , ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
	
	//Create a Prepared SQL statement
	// all the question marks will be replaced with the values from the forms
	PreparedStatement ps = con.prepareStatement(insert);
	
	ps.setString(1, currentUser.getUsername());
	ps.setString(2, startPrice);
	ps.setString(3, title);
	ps.setString(4, description);
	ps.setString(5, screenSize);
	ps.setString(6, street);
	ps.setString(7, city);
	ps.setString(8, zip);
	ps.setString(9, county);
	ps.setString(10, state);
	ps.setString(11, brand);
	ps.setString(12, condition);
	ps.setString(13, pickup);
	ps.setString(14, shipping);
	ps.setString(15, color);
	ps.setString(16, megapixels);
	ps.setString(17, carrier);
	ps.setString(18, ram);
	ps.setString(19, storage);
	ps.setString(20, expandable);
	ps.setString(21, model);
	ps.setString(22, reserve);
	ps.setString(23, increment);
	ps.setTimestamp(24, sqlDate);
	
	// run the INSERT
	ps.executeUpdate();
	
	
	out.print("<p>Your auction was sucessfully created</p>");
	}
	
	con.close();
	
} catch (Exception ex) 
{
	if (con != null)
		con.close();
	
	out.print(ex);
	out.print("<p> Failed to create your auction. Click back and try again </p>");
}
	
%>

</body>
</html>