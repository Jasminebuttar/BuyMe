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

	// this will set the default enddate to one day from now
	java.util.Date now = new java.util.Date();
	Calendar cal = Calendar.getInstance();
	cal.setTime(now); 
	cal.add(Calendar.DATE, 1);
	java.util.Date plusOneDay = cal.getTime(); 
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm");
	String dateString = dateFormat.format(plusOneDay);

%>
<div class="center">

	<h1><center>CREATE AUCTION</center></h1>
    <form method="POST" action="createauctionsubmit.jsp">
		<label>Title:</label>
			<input type="text" name="title" value="Title"><br>
		
		<label>Description:</label>
			<textarea rows="7" cols="45" name="description" value="Description"></textarea><br>
		
		<label>Start Price:</label>
			<input type="text" name="startprice" value="0"><br>
		
		<label>Reserve Price:</label>
			<input type="text" name="reserve" value="0"><br>
		
		<label>Bid Increments:</label>
			<input type="text" name="increment" value="0.01"><br>
		
<%	/*
		End of Auction:
		<label style="display:inline;">Year:</label>
			<select name = "year">
				<option value='2018'>2018</option>
				<option value='2019'>2019</option>
				<option value='2020'>2020</option>
				<option value='2021'>2021</option>
				<option value='2022'>2022</option>
				<option value='2023'>2023</option>
				<option value='2024'>2024</option>
				<option value='2025'>2025</option>
				<option value='2026'>2026</option>
				<option value='2027'>2027</option>
				<option value='2028'>2028</option>
				<option value='2029'>2029</option>
				<option value='2030'>2030</option>
			</select> <br> <br>
	
			<label style="display:inline;">Month:</label>
			<select name = "month">
  				<option value="01">01</option>
  				<option value="02">02</option>
  				<option value="03">03</option>
  				<option value="04">04</option>
  				<option value="05">05</option>
  				<option value="06">06</option>
  				<option value="07">07</option>
  				<option value="08">08</option>
  				<option value="09">09</option>
  				<option value="10">10</option>
  				<option value="11">11</option>
  				<option value="12">12</option>
			</select>	
			*/
	%>		
			
		<label>End of Auction:</label>
  			<input type="datetime-local" name="enddate" value=<%=dateString %>>	
		<br>	
		<label>Insert Picture:</label>
			<input type="file" name="insertpicture" accept="image/*"><br>
       	
       	<label style="display:inline;">Location:</label>
			<input type="checkbox" name="location" checked>Use Current Address<br>
		
		<label>Street Address:</label>
			<input type="text" name="street"><br>
		
		<label>Town/City:</label>
			<input type="text" name="city"><br>
		
		<label>Zip Code:</label>
			<input type="text" name="zip"><br>
		
		<label>County:</label>
			<input type="text" name="county"><br>
		
		<label>State:</label>
			<select name="state">
		    <option value="AL">Alabama</option>
		    <option value="AK">Alaska</option>
			<option value="AZ">Arizona</option>
			<option value="AR">Arkansas</option>
			<option value="CA">California</option>
			<option value="CO">Colorado</option>
			<option value="CT">Connecticut</option>
			<option value="DE">Delaware</option>
			<option value="DC">District Of Columbia</option>
			<option value="FL">Florida</option>
			<option value="GA">Georgia</option>
			<option value="HI">Hawaii</option>
			<option value="ID">Idaho</option>
			<option value="IL">Illinois</option>
			<option value="IN">Indiana</option>
			<option value="IA">Iowa</option>
			<option value="KS">Kansas</option>
			<option value="KY">Kentucky</option>
			<option value="LA">Louisiana</option>
			<option value="ME">Maine</option>
			<option value="MD">Maryland</option>
			<option value="MA">Massachusetts</option>
			<option value="MI">Michigan</option>
			<option value="MN">Minnesota</option>
			<option value="MS">Mississippi</option>
			<option value="MO">Missouri</option>
			<option value="MT">Montana</option>
			<option value="NE">Nebraska</option>
			<option value="NV">Nevada</option>
			<option value="NH">New Hampshire</option>
			<option value="NJ">New Jersey</option>
			<option value="NM">New Mexico</option>
			<option value="NY">New York</option>
			<option value="NC">North Carolina</option>
			<option value="ND">North Dakota</option>
			<option value="OH">Ohio</option>
			<option value="OK">Oklahoma</option>
			<option value="OR">Oregon</option>
			<option value="PA">Pennsylvania</option>
			<option value="RI">Rhode Island</option>
			<option value="SC">South Carolina</option>
			<option value="SD">South Dakota</option>
			<option value="TN">Tennessee</option>
			<option value="TX">Texas</option>
			<option value="UT">Utah</option>
			<option value="VT">Vermont</option>
			<option value="VA">Virginia</option>
			<option value="WA">Washington</option>
			<option value="WV">West Virginia</option>
			<option value="WI">Wisconsin</option>
			<option value="WY">Wyoming</option>
		    </select><br>
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
	    	
	  	<label>Model:</label>
	  	<input type="text" name="model"><br>
	  	
	  	<label>Condition:</label>
	    	<input type="radio" name="condition" value="New" checked>
	    	New<br>
	    	<input type="radio" name="condition" value="Used - Like New">
	    	Used-Like New<br>
	    	<input type="radio" name="condition" value="Used - Fair">
	    	Used-Fair<br>
	    	<input type="radio" name="condition" value="Used - Bad">
	    	Used-Bad<br>
	  	
	  	<label>Color:</label>
	  	   <input type="radio" name="color" value="black" checked>
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
	    
	    <label>Camera(Megapixels):</label>
	    <input type="text" name="megapixels" value="8"><br>
	    
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
	    	
	    <label>RAM:</label>
	    <input type="text" name="ram" value="8"><br>
	    
	    <label>Screen Size:</label>
		<input type="text" name="screensize" value="5"><br>
		
		<label>Storage:</label>
		<input type="text" name="storage" value="8"><br>
		
		<label>Expandable Storage?</label>
	    <input type="checkbox" name="expandablestorage"><br>
		
		<label>Pick Up?</label>
	    <input type="checkbox" name="pickup"><br>
	  	
	  	<label>Shipping Method:</label>
	  	<input type="radio" name="shipping" value="free" checked>
	  	Free
	  	<input type="radio" name="shipping" value="standard">
	  	Standard
	  	
	  	<br>
	  	<input type="submit" value="Submit">
	</form>
	
</div>

</body>
</html>