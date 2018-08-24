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
<h1><center>ALERTS!!!</center></h1>

<%@include file="header.jsp" %>
<%@include file="subheader.jsp" %>

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

	
	String alertId= request.getParameter("alertid");
    Statement stm = con.createStatement();	
	
	String str = "SELECT * FROM Alert WHERE alertid = \"" + alertId + "\"";
	ResultSet result = stm.executeQuery(str);
	result.next();
	
	String brand = result.getString("brand");
	String model = result.getString("model");
	String color = result.getString("color");
	String screenlow = result.getString("screensizelow");
	String screenhigh = result.getString("screensizehigh");
	String megalow = result.getString("megapixelslow");
	String megahigh = result.getString("megapixelshigh");
	String carrier = result.getString("carrier");
	String ramlow = result.getString("ramlow");
	String ramhigh = result.getString("ramhigh");
	String storagelow = result.getString("storagespacelow");
	String storagehigh = result.getString("storagespacehigh");
	String isnew = result.getString("isnew");
	String likenew = result.getString("usedlikenew");
	String fair = result.getString("usedfair");
	String poor = result.getString("usedpoor");
	String city = result.getString("incity");
	String zip = result.getString("inzip");
	String county = result.getString("incounty");
	String state = result.getString("instate");
	String pickup = result.getString("pickup");
	String freeshipping = result.getString("freeshipping");
	String expandable = result.getString("expandable");
%>

<td><a href="deletealert.jsp?alertid=<%=alertId%>">DELETE THIS ALERT</a><br><br></td>

	<table>
<%
	    if(brand!=null) 
	    {
%>
		<tr>
		<th width="33%"><label>Brand</label></td>
		<td><%out.print(brand);%></td>
		</tr>
<% 
		}
%>
		
		<%if(model!=null) {%>
		<tr>
		<th><label>Model</label></td>
		<td><%out.print(model);%></td>
		</tr><% }%>
		
		<%if(color!=null) {%>
		<tr>
		<th><label>Color</label></th>
		<td><%out.print(color);%></td>
		</tr><% }%>
		
		<%if(screenlow!=null) {%>
		<tr>
		<th><label>Screen Size Low</label></th>
		<td><%out.print(screenlow);%></td>
		</tr><% }%>
		
		<%if(screenhigh!=null) {%>
		<tr>
		<th><label>Screen Size High</label></th>
		<td><%out.print(screenhigh);%></td>
		</tr><% }%>
		
		<%if(megalow!=null) {%>
		<tr>
		<th><label>Megapixels Low</label></th>
		<td><%out.print(megalow);%></td>
		</tr><% }%>
		
		<%if(megahigh!=null) {%>
		<tr>
		<th><label>Megapixels High</label></th>
		<td><%out.print(megahigh);%></td>
		</tr><% }%>
		
		<%if(carrier!=null) {%>
		<tr>
		<th><label>Carrier</label></th>
		<td><%out.print(carrier);%></td>
		</tr><% }%>
		<%if(ramlow!=null) {%>
		<tr>
		<th><label>Ram Low</label></th>
		<td><%out.print(ramlow);%></td>
		</tr><% }%>
		
		<%if(ramhigh!=null) {%>
		<tr>
		<th><label>Ram High </label></th>
		<td><%out.print(ramhigh);%></td>
		</tr><% }%>
		
		<%if(storagelow!=null) {%>
		<tr>
		<th><label>Storage Space Low</label></th>
		<td><%out.print(storagelow);%></td>
		</tr><% }%>
		
		<%if(storagehigh!=null) {%>
		<tr>
		<th><label>Storage Space High</label></th>
		<td><%out.print(storagehigh);%></td>
		</tr> <%} %>
		
		<tr>
		<th><label>Is New?</label></th>
		<td><%= (isnew.equals("1")) ? "YES" : "NO"%></td>
		</tr>
		
		<tr>
		<th><label>Used-Like New</label></th>
		<td><%= (likenew.equals("1")) ? "YES" : "NO"%></td>
		</tr>
		
		<tr>
		<th><label>Used-Fair</label></th>
		<td><%= (fair.equals("1")) ? "YES" : "NO"%></td>
		</tr>
		
		<tr>
		<th><label>Used-Poor</label></th>
		<td><%= (poor.equals("1")) ? "YES" : "NO"%></td>
		</tr>
		
		<tr>
		<th><label>In City</label></th>
		<td><%= (city.equals("1")) ? "YES" : "NO"%></td>
		</tr>
		
		<tr>
		<th><label>In Zip</label></th>
		<td><%= (zip.equals("1")) ? "YES" : "NO"%></td>
		</tr>
		
		<tr>
		<th><label>In County</label></th>
		<<td><%= (county.equals("1")) ? "YES" : "NO"%></td>
		</tr>
		
		<tr>
		<th><label>In State</label></th>
		<td><%= (state.equals("1")) ? "YES" : "NO"%></td>
		</tr>
		
		<tr>
		<th><label>Pickup?</label></th>
		<td><%= (pickup.equals("1")) ? "YES" : "NO"%></td>
		</tr>
		
		<tr>
		<th><label>FreeShipping?</label></th>
		<td><%= (freeshipping.equals("1")) ? "YES" : "NO"%></td>
		</tr>
		
		<tr>
		<th><label>Expandable?</label></th>
		<td><%= (expandable.equals("1")) ? "YES" : "NO"%></td>
		</tr>
		</table>
		
<% 

 // close out the connection to the database
con.close();
} 
catch (Exception ex) 
{
	out.print(ex);
}
	
%>
</body>
</html>