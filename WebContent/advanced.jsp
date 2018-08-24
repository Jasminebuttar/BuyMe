<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>

<%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader ("Expires", -1);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="main.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%@include file="header.jsp" %>

<%
	if (session.getAttribute("where") != null)
	{
		String site = "advanced.jsp";
        response.setHeader("Location", site); 
        
    	return;
	}

	User current = (User) session.getAttribute("currentUser");	

	// check to make sure the user is logged in
	// they need to be logged in to use this function (we need the location for some of the variables)
	if (current == null)
	{
		out.println("<p>You need to be logged in to used this function. Please log in and try again.</p>");
		return;
	}

	// clears out an old WHERE clause
	// need this just in case an advanced search was run before 
	// and the WHERE clause was saved to change the ORDER BY
	session.setAttribute("where", null);
%>

	<h1><center>Advanced Search</center></h1>
	<p>
		<form method = "post" action= "advancedsubmit.jsp">

			<label> Brand:</label><br>
			<input type = "checkbox" name="brand" value="apple"> Apple 
			<input type = "checkbox" name="brand" value="samsung"> Samsung 
			<input type = "checkbox" name="brand" value="lg"> LG <br>
			<input type = "checkbox" name="brand" value="oneplus"> One Plus 
			<input type = "checkbox" name="brand" value="google"> Google 
			<input type = "checkbox" name="brand" value="sony"> Sony <br>
			<input type = "checkbox" name="brand" value="htc"> HTC 
			<input type = "checkbox" name="brand" value="motorola"> Motorola 
			<input type = "checkbox" name="brand" value="nokia"> Nokia <br><br>

			<label> Model:</label><br>
			<input type = "text" name = "model"/><br><br><br>
			
			<label> Color:</label><br>
			<input type = "checkbox" name="color" value="black"> Black <input type = "checkbox" name="color" value="blue"> Blue <br>
			<input type = "checkbox" name="color" value="white"> White <input type = "checkbox" name="color" value="gray"> Gray <br>
			<input type = "checkbox" name="color" value="silver"> Silver <input type = "checkbox" name="color" value="gold"> Gold <br>
			<input type = "checkbox" name="color" value="red"> Red <input type = "checkbox" name="color" value="purple"> Purple <br><br>

			<label> Screensize(inches):</label><br>
			lowest:
			<select name = "screensizelow">
  				<option value="4" selected>4</option>
  				<option value="4.2">4.2</option>
  				<option value="4.4">4.4</option>
  				<option value="4.6">4.6</option>
  				<option value="4.8">4.8</option>
  				<option value="5.0">5.0</option>
  				<option value="5.2">5.2</option>
  				<option value="5.4">5.4</option>
  				<option value="5.6">5.6</option>
  				<option value="5.8">5.8</option>
  				<option value="6.0">6.0</option>
  				<option value="6.2">6.2</option>
			</select>

			-

			highest:
			<select name = "screensizehigh">
  				<option value="4">4</option>
  				<option value="4.2">4.2</option>
  				<option value="4.4">4.4</option>
  				<option value="4.6">4.6</option>
  				<option value="4.8">4.8</option>
  				<option value="5.0">5.0</option>
  				<option value="5.2">5.2</option>
  				<option value="5.4">5.4</option>
  				<option value="5.6">5.6</option>
  				<option value="5.8">5.8</option>
  				<option value="6.0">6.0</option>
  				<option value="6.2" selected>6.2</option>
			</select> <br> <br>

			<label> Carrier:</label><br>
			<input type = "checkbox" name="carrier" value="tmobile"> T-Mobile <br>
			<input type = "checkbox" name="carrier" value="sprint"> Sprint <br>
			<input type = "checkbox" name="carrier" value="verizon"> Verizon <br>
			<input type = "checkbox" name="carrier" value="atnt"> ATT <br>
			<input type = "checkbox" name="carrier" value="unlocked"> Unlocked <br><br>

			<label> Camera(megapixels):</label><br>
			<input type = "text" name = "mplow"/><br><br><br>
			to
			<input type = "text" name = "mphigh"/><br><br><br>

			<label> Storage(GB):</label><br>
			lowest:
			<select name = "storagelow">
				<option value="2" selected>2</option>
  				<option value="4">4</option>
  				<option value="8">8</option>
  				<option value="12">12</option>
  				<option value="16">16</option>
  				<option value="24">24</option>
  				<option value="32">32</option>
  				<option value="64">64</option>
  				<option value="128">128</option>
  				<option value="256">256</option>
			</select>

			-

			highest:
			<select name = "storagehigh">
				<option value="2">2</option>
  				<option value="4">4</option>
  				<option value="8">8</option>
  				<option value="12">12</option>
  				<option value="16">16</option>
  				<option value="24">24</option>
  				<option value="32">32</option>
  				<option value="64">64</option>
  				<option value="128">128</option>
  				<option value="256" selected>256</option>
			</select> <br> <br>


			<label> RAM:</label><br>
			lowest:
			<select name = "ramlow">
  				<option value="0.5" selected>512MB</option>
  				<option value="1">1GB</option>
  				<option value="2">2GB</option>
  				<option value="3">3GB</option>
  				<option value="4">4GB</option>
  				<option value="6">6GB</option>
  				<option value="8">8GB</option>
  				<option value="10">10GB</option>
			</select>

			-

			highest:
			<select name = "ramhigh">
  				<option value="0.5">512MB</option>
  				<option value="1">1GB</option>
  				<option value="2">2GB</option>
  				<option value="3">3GB</option>
  				<option value="4">4GB</option>
  				<option value="6">6GB</option>
  				<option value="8">8GB</option>
  				<option value="10" selected>10GB</option>
			</select> <br> <br>
 
			<label> Condition:</label><br>
			<input type = "checkbox" name="condition" value="New"> New <br>
			<input type = "checkbox" name="condition" value="Used - New"> Used - New <br>
			<input type = "checkbox" name="condition" value="Used - Fair"> Used - Fair <br>
			<input type = "checkbox" name="condition" value="Used - Poor"> Used - Poor <br><br>

			<label> Location:</label><br>
			<input type = "checkbox" name="location" value="inzip"> In Zip <br>
			<input type = "checkbox" name="location" value="incity"> In Town/City <br>
			<input type = "checkbox" name="location" value="incounty"> In County <br>
			<input type = "checkbox" name="location" value="instate"> In State <br><br>

			<label> Price($):</label><br>
			low:<input type = "text" name = "lowprice"/><br> to high:<input type = "text" name = "highprice"/><br><br><br>

			<label> Shipping Method:</label><br>
			<input type = "checkbox" name="shipping" value="free"> Free <br>
			<input type = "checkbox" name="shipping" value="pickup"> Pick Up <br>
			<input type = "checkbox" name="shipping" value="standard"> Standard/Fast <br><br>

			<input type = "checkbox" name = "expandable"> Expandable Storage <br><br>

			<input type = "submit" value = "Submit">

		</form>
	</p>

</body>
</html>