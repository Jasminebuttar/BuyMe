<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<p><%@include file="header.jsp" %></p>
<br>
<div class="center">
	<h1><center>Create Account</center></h1>
	<p>
		<form method="post" action="registersubmit.jsp">
			<label>User name:</label>
			<input type = "text" name = "username"><br><br>
			<label>First name:</label>
			<input type = "text" name = "firstname"><br><br>
			<label>Last name:</label>
			<input type = "text" name = "lastname"><br><br>

			<label>Date of Birth:</label>
			<label style="display:inline;">Month:</label>
			<select name = "month">
  				<option value="01">January</option>
  				<option value="02">February</option>
  				<option value="03">March</option>
  				<option value="04">April</option>
  				<option value="05">May</option>
  				<option value="06">June</option>
  				<option value="07">July</option>
  				<option value="08">August</option>
  				<option value="09">September</option>
  				<option value="10">October</option>
  				<option value="11">November</option>
  				<option value="12">December</option>
			</select>

			<label style="display:inline;">Day:</label>
			<select name = "day">
  				<option value="01">1</option>
  				<option value="02">2</option>
  				<option value="03">3</option>
  				<option value="04">4</option>
  				<option value="05">5</option>
  				<option value="06">6</option>
  				<option value="07">7</option>
  				<option value="08">8</option>
  				<option value="09">9</option>
  				<option value="10">10</option>
  				<option value="11">11</option>
  				<option value="12">12</option>
  				<option value="13">13</option>
  				<option value="14">14</option>
  				<option value="15">15</option>
  				<option value="16">16</option>
  				<option value="17">17</option>
  				<option value="18">18</option>
  				<option value="19">19</option>
  				<option value="20">20</option>
  				<option value="21">21</option>
  				<option value="22">22</option>
  				<option value="23">23</option>
  				<option value="24">24</option>
  				<option value="25">25</option>
  				<option value="26">26</option>
  				<option value="27">27</option>
  				<option value="28">28</option>
  				<option value="29">29</option>
  				<option value="30">30</option>
  				<option value="31">31</option>
			</select>

			<label style="display:inline;">Year:</label>
			<select name = "year">
				<option value='1960'>1960</option>
				<option value='1961'>1961</option>
				<option value='1962'>1962</option>
				<option value='1963'>1963</option>
				<option value='1964'>1964</option>
				<option value='1965'>1965</option>
				<option value='1966'>1966</option>
				<option value='1967'>1967</option>
				<option value='1968'>1968</option>
				<option value='1969'>1969</option>
				<option value='1970'>1970</option>
				<option value='1971'>1971</option>
				<option value='1972'>1972</option>
				<option value='1973'>1973</option>
				<option value='1974'>1974</option>
				<option value='1975'>1975</option>
				<option value='1976'>1976</option>
				<option value='1977'>1977</option>
				<option value='1978'>1978</option>
				<option value='1979'>1979</option>
				<option value='1980'>1980</option>
				<option value='1981'>1981</option>
				<option value='1982'>1982</option>
				<option value='1983'>1983</option>
				<option value='1984'>1984</option>
				<option value='1985'>1985</option>
				<option value='1986'>1986</option>
				<option value='1987'>1987</option>
				<option value='1988'>1988</option>
				<option value='1989'>1989</option>
				<option value='1990'>1990</option>
				<option value='1991'>1991</option>
				<option value='1992'>1992</option>
				<option value='1993'>1993</option>
				<option value='1994'>1994</option>
				<option value='1995'>1995</option>
				<option value='1996'>1996</option>
				<option value='1997'>1997</option>
				<option value='1998'>1998</option>
				<option value='1999'>1999</option>
				<option value='2000'>2000</option>
			</select> <br> <br>

			<label>Email:</label>
			<input type = "text" name = "email"><br><br>

			<label>Password:</label>
			<input type = "text" name = "password"><br><br>

			<label>Retype Password:</label>
			<input type = "text" name = "retypepassword"><br><br>

			<label>Street Address:</label>
			<input style="width:500px;" type = "text" name = "streetaddress"><br><br>

			<label>City/Town:</label>
			<input type = "text" name = "city"><br><br>

			<label>Zipcode:</label>
			<input type = "text" name = "zipcode"><br><br>

			<label>County:</label>
			<input type = "text" name = "county"><br><br>

			<label>State:</label>
			<select name = "state">
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



			<input type = "submit" value = "Submit">

		</form>
		
</div>

</body>
</html>