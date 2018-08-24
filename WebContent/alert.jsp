<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="main.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%@include file="header.jsp" %>


	<h1><center>Set up an alert</center></h1>
	<p class="center">Set up an alert for newly created auction. You will be alerted when new auctions are posted that match your criteria</p>
	<p>
		<form method = "post" action= "alertsubmit.jsp">

			<label>Brand:</label>
	    	<input type="radio" name="brand" value="apple" checked>
	    	Apple
	    	<input type="radio" name="brand" value="htc">
	    	HTC<br>
	    	<input type="radio" name="brand" value="lg">
	    	LG
	    	<input type="radio" name="brand" value="oneplus">
	    	One Plus<br>
	    	<input type="radio" name="brand" value="samsung">
	    	Samsung<br>

			<label> Model:</label><br>
			<input type = "text" name = "model"/><br><br><br>
			
			<label>Color:</label>
	  	   <input type="radio" name="color" value="black">
	    	Black
	    	<input type="radio" name="color" value="blue">
	    	Blue<br>
	    	<input type="radio" name="color" value="white">
	    	White
	    	<input type="radio" name="color" value="gray">
	    	Gray<br>
	    	<input type="radio" name="color" value="gold">
	    	Gold
	    	<input type="radio" name="color" value="silver">
	    	Silver<br>
	    	<input type="radio" name="color" value="red">
	    	Red
	    	<input type="radio" name="color" value="purple">
	    	Purple<br>

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

			<label>Carrier:</label>
	        <input type="radio" name="carrier" value="tmobile" checked>
	    	T-Mobile<br>
	    	<input type="radio" name="carrier" value="sprint">
	    	Sprint<br>
	    	<input type="radio" name="carrier" value="verizon">
	    	Verizon<br>
	    	<input type="radio" name="carrier" value="att">
	    	ATT<br>
	    	<input type="radio" name="carrier" value="unlocked">
	    	Unlocked<br>

			<label> Camera(megapixels):</label><br>
			<input type = "text" name = "mplow"/ value="0"><br><br><br>
			to
			<input type = "text" name = "mphigh"/ value="40"><br><br><br>

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
			<input type = "checkbox" name="isnew" value="isnew"> New <br>
			<input type = "checkbox" name="usedlikenew" value="usedlikenew"> Used-New <br>
			<input type = "checkbox" name="usedfair" value="usedlikefair"> Used-Fair <br>
			<input type = "checkbox" name="usedpoor" value="usedlikepoor"> Used-Poor <br><br>

			<label> Location:</label><br>
			<input type = "checkbox" name="inzip" value="inzip"> In Zip <br>
			<input type = "checkbox" name="incity" value="incity"> In Town/City <br>
			<input type = "checkbox" name="incounty" value="incounty"> In County <br>
			<input type = "checkbox" name="instate" value="instate"> In State <br><br>

			<label> Payment:</label><br>
			<input type = "checkbox" name="payment" value="paypal"> PaPal <br>
			<input type = "checkbox" name="payment" value="credit"> Credit Card <br>
			<input type = "checkbox" name="payment" value="visa"> Visa <br>
			<input type = "checkbox" name="payment" value="mastercard"> Master Card <br>
			<input type = "checkbox" name="payment" value="applepay"> Apple Pay <br><br>

			<input type = "checkbox" name="freeshipping" value="free"> Free Shipping? <br>
			<input type = "checkbox" name="pickup" value="pickup"> Pick Up?<br>

			<input type = "checkbox" name = "expandable"> Expandable Storage?<br><br>

			<input type = "submit" value = "Submit">

		</form>
	</p>

</body>
</html>