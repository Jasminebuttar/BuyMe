<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*, java.lang.Boolean ,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update Your Account</title>
</head>
<body>

<%@include file="header.jsp" %>
<%@include file="subheader.jsp" %>

<%
	User current = (User) session.getAttribute("currentUser");

	//if so then they have successully logged in
	String username = current.getUsername();
	String firstName = current.getFirstName();
	String lastName = current.getLastName();
	String email = current.getEmail();
	String street = current.getStreet();
	String city = current.getCity();
	String county = current.getCounty();
	String zip = current.getZip();
	String state = current.getState();
	String dob = current.getDob();
	String dobParts[] = dob.split("-");
	String year = dobParts[0];
	String month = dobParts[1];
	String day = dobParts[2];
	
%>

<br>
<div class="center">

	<p>

		<form method="post" action="updateinfosubmit.jsp">
			<label>First name:</label>
			<input type = "text" name = "firstname" value="<%=firstName %>"><br><br>
			<label>Last name:</label>
			<input type = "text" name = "lastname" value="<%=lastName %>"><br><br>

			<label>Date of Birth:</label>
			<label style="display:inline;">Month:</label>
			<select name = "month">
  				<option value="01" <%=(month.equals("01")) ? "selected=selected" : ""%>>January</option>
  				<option value="02" <%=(month.equals("02")) ? "selected=selected" : ""%>>February</option>
  				<option value="03" <%=(month.equals("03")) ? "selected=selected" : ""%>>March</option>
  				<option value="04" <%=(month.equals("04")) ? "selected=selected" : ""%>>April</option>
  				<option value="05" <%=(month.equals("05")) ? "selected=selected" : ""%>>May</option>
  				<option value="06" <%=(month.equals("06")) ? "selected=selected" : ""%>>June</option>
  				<option value="07" <%=(month.equals("07")) ? "selected=selected" : ""%>>July</option>
  				<option value="08" <%=(month.equals("08")) ? "selected=selected" : ""%>>August</option>
  				<option value="09" <%=(month.equals("09")) ? "selected=selected" : ""%>>September</option>
  				<option value="10" <%=(month.equals("10")) ? "selected=selected" : ""%>>October</option>
  				<option value="11" <%=(month.equals("11")) ? "selected=selected" : ""%>>November</option>
  				<option value="12" <%=(month.equals("12")) ? "selected=selected" : ""%>>December</option>
			</select>

			<label style="display:inline;">Day:</label>
			<select name = "day">
  				<option value="01" <%=(day.equals("01")) ? "selected=selected" : ""%>>1</option>
  				<option value="02" <%=(day.equals("02")) ? "selected=selected" : ""%>>2</option>
  				<option value="03" <%=(day.equals("03")) ? "selected=selected" : ""%>>3</option>
  				<option value="04" <%=(day.equals("04")) ? "selected=selected" : ""%>>4</option>
  				<option value="05" <%=(day.equals("05")) ? "selected=selected" : ""%>>5</option>
  				<option value="06" <%=(day.equals("06")) ? "selected=selected" : ""%>>6</option>
  				<option value="07" <%=(day.equals("07")) ? "selected=selected" : ""%>>7</option>
  				<option value="08" <%=(day.equals("08")) ? "selected=selected" : ""%>>8</option>
  				<option value="09" <%=(day.equals("09")) ? "selected=selected" : ""%>>9</option>
  				<option value="10" <%=(day.equals("10")) ? "selected=selected" : ""%>>10</option>
  				<option value="11" <%=(day.equals("11")) ? "selected=selected" : ""%>>11</option>
  				<option value="12" <%=(day.equals("12")) ? "selected=selected" : ""%>>12</option>
  				<option value="13" <%=(day.equals("13")) ? "selected=selected" : ""%>>13</option>
  				<option value="14" <%=(day.equals("14")) ? "selected=selected" : ""%>>14</option>
  				<option value="15" <%=(day.equals("15")) ? "selected=selected" : ""%>>15</option>
  				<option value="16" <%=(day.equals("16")) ? "selected=selected" : ""%>>16</option>
  				<option value="17" <%=(day.equals("17")) ? "selected=selected" : ""%>>17</option>
  				<option value="18" <%=(day.equals("18")) ? "selected=selected" : ""%>>18</option>
  				<option value="19" <%=(day.equals("19")) ? "selected=selected" : ""%>>19</option>
  				<option value="20" <%=(day.equals("20")) ? "selected=selected" : ""%>>20</option>
  				<option value="21" <%=(day.equals("21")) ? "selected=selected" : ""%>>21</option>
  				<option value="22" <%=(day.equals("22")) ? "selected=selected" : ""%>>22</option>
  				<option value="23" <%=(day.equals("23")) ? "selected=selected" : ""%>>23</option>
  				<option value="24" <%=(day.equals("24")) ? "selected=selected" : ""%>>24</option>
  				<option value="25" <%=(day.equals("25")) ? "selected=selected" : ""%>>25</option>
  				<option value="26" <%=(day.equals("26")) ? "selected=selected" : ""%>>26</option>
  				<option value="27" <%=(day.equals("27")) ? "selected=selected" : ""%>>27</option>
  				<option value="28" <%=(day.equals("28")) ? "selected=selected" : ""%>>28</option>
  				<option value="29" <%=(day.equals("29")) ? "selected=selected" : ""%>>29</option>
  				<option value="30" <%=(day.equals("30")) ? "selected=selected" : ""%>>30</option>
  				<option value="31" <%=(day.equals("31")) ? "selected=selected" : ""%>>31</option>
			</select>

			<label style="display:inline;">Year:</label>
			<select name = "year">
				<option value='1960' <%=(year.equals("1960")) ? "selected=selected" : ""%>>1960</option>
				<option value='1961' <%=(year.equals("1961")) ? "selected=selected" : ""%>>1961</option>
				<option value='1962' <%=(year.equals("1962")) ? "selected=selected" : ""%>>1962</option>
				<option value='1963' <%=(year.equals("1963")) ? "selected=selected" : ""%>>1963</option>
				<option value='1964' <%=(year.equals("1964")) ? "selected=selected" : ""%>>1964</option>
				<option value='1965' <%=(year.equals("1965")) ? "selected=selected" : ""%>>1965</option>
				<option value='1966' <%=(year.equals("1966")) ? "selected=selected" : ""%>>1966</option>
				<option value='1967' <%=(year.equals("1967")) ? "selected=selected" : ""%>>1967</option>
				<option value='1968' <%=(year.equals("1968")) ? "selected=selected" : ""%>>1968</option>
				<option value='1969' <%=(year.equals("1969")) ? "selected=selected" : ""%>>1969</option>
				<option value='1970' <%=(year.equals("1970")) ? "selected=selected" : ""%>>1970</option>
				<option value='1971' <%=(year.equals("1971")) ? "selected=selected" : ""%>>1971</option>
				<option value='1972' <%=(year.equals("1972")) ? "selected=selected" : ""%>>1972</option>
				<option value='1973' <%=(year.equals("1973")) ? "selected=selected" : ""%>>1973</option>
				<option value='1974' <%=(year.equals("1974")) ? "selected=selected" : ""%>>1974</option>
				<option value='1975' <%=(year.equals("1975")) ? "selected=selected" : ""%>>1975</option>
				<option value='1976' <%=(year.equals("1976")) ? "selected=selected" : ""%>>1976</option>
				<option value='1977' <%=(year.equals("1977")) ? "selected=selected" : ""%>>1977</option>
				<option value='1978' <%=(year.equals("1978")) ? "selected=selected" : ""%>>1978</option>
				<option value='1979' <%=(year.equals("1979")) ? "selected=selected" : ""%>>1979</option>
				<option value='1980' <%=(year.equals("1980")) ? "selected=selected" : ""%>>1980</option>
				<option value='1981' <%=(year.equals("1981")) ? "selected=selected" : ""%>>1981</option>
				<option value='1982' <%=(year.equals("1982")) ? "selected=selected" : ""%>>1982</option>
				<option value='1983' <%=(year.equals("1983")) ? "selected=selected" : ""%>>1983</option>
				<option value='1984' <%=(year.equals("1984")) ? "selected=selected" : ""%>>1984</option>
				<option value='1985' <%=(year.equals("1985")) ? "selected=selected" : ""%>>1985</option>
				<option value='1986' <%=(year.equals("1986")) ? "selected=selected" : ""%>>1986</option>
				<option value='1987' <%=(year.equals("1987")) ? "selected=selected" : ""%>>1987</option>
				<option value='1988' <%=(year.equals("1988")) ? "selected=selected" : ""%>>1988</option>
				<option value='1989' <%=(year.equals("1989")) ? "selected=selected" : ""%>>1989</option>
				<option value='1990' <%=(year.equals("1990")) ? "selected=selected" : ""%>>1990</option>
				<option value='1991' <%=(year.equals("1991")) ? "selected=selected" : ""%>>1991</option>
				<option value='1992' <%=(year.equals("1992")) ? "selected=selected" : ""%>>1992</option>
				<option value='1993' <%=(year.equals("1993")) ? "selected=selected" : ""%>>1993</option>
				<option value='1994' <%=(year.equals("1994")) ? "selected=selected" : ""%>>1994</option>
				<option value='1995' <%=(year.equals("1995")) ? "selected=selected" : ""%>>1995</option>
				<option value='1996' <%=(year.equals("1996")) ? "selected=selected" : ""%>>1996</option>
				<option value='1997' <%=(year.equals("1997")) ? "selected=selected" : ""%>>1997</option>
				<option value='1998' <%=(year.equals("1998")) ? "selected=selected" : ""%>>1998</option>
				<option value='1999' <%=(year.equals("1999")) ? "selected=selected" : ""%>>1999</option>
				<option value='2000' <%=(year.equals("2000")) ? "selected=selected" : ""%>>2000</option>
			</select> <br> <br>

			<label>Email:</label>
			<input type = "text" name = "email" value="<%=email %>"><br><br>

			Reset Password?
			<label>Old Password:</label>
			<input type = "password" name = "password"><br><br>

			<label>New Password:</label>
			<input type = "password" name = "newpassword"><br><br>

			<label>Street Address:</label>
			<input style="width:500px;" type = "text" name = "streetaddress" value="<%=street %>"><br><br>

			<label>City/Town:</label>
			<input type = "text" name = "city" value="<%=city %>"><br><br>

			<label>Zipcode:</label>
			<input type = "text" name = "zipcode" value="<%=zip %>"><br><br>

			<label>County:</label>
			<input type = "text" name = "county" value="<%=county %>"><br><br>

			<label>State:</label>
			<select name = "state">
				<option value="AL" <%=(state.equals("AL")) ? "selected=selected" : ""%>>Alabama</option>
				<option value="AK" <%=(state.equals("AK")) ? "selected=selected" : ""%>>Alaska</option>
				<option value="AZ" <%=(state.equals("AZ")) ? "selected=selected" : ""%>>Arizona</option>
				<option value="AR" <%=(state.equals("AR")) ? "selected=selected" : ""%>>Arkansas</option>
				<option value="CA" <%=(state.equals("CA")) ? "selected=selected" : ""%>>California</option>
				<option value="CO" <%=(state.equals("CO")) ? "selected=selected" : ""%>>Colorado</option>
				<option value="CT" <%=(state.equals("CT")) ? "selected=selected" : ""%>>Connecticut</option>
				<option value="DE" <%=(state.equals("DE")) ? "selected=selected" : ""%>>Delaware</option>
				<option value="DC" <%=(state.equals("DC")) ? "selected=selected" : ""%>>District Of Columbia</option>
				<option value="FL" <%=(state.equals("FL")) ? "selected=selected" : ""%>>Florida</option>
				<option value="GA" <%=(state.equals("GA")) ? "selected=selected" : ""%>>Georgia</option>
				<option value="HI" <%=(state.equals("HI")) ? "selected=selected" : ""%>>Hawaii</option>
				<option value="ID" <%=(state.equals("ID")) ? "selected=selected" : ""%>>Idaho</option>
				<option value="IL" <%=(state.equals("IL")) ? "selected=selected" : ""%>>Illinois</option>
				<option value="IN" <%=(state.equals("IN")) ? "selected=selected" : ""%>>Indiana</option>
				<option value="IA" <%=(state.equals("IA")) ? "selected=selected" : ""%>>Iowa</option>
				<option value="KS" <%=(state.equals("KS")) ? "selected=selected" : ""%>>Kansas</option>
				<option value="KY" <%=(state.equals("KY")) ? "selected=selected" : ""%>>Kentucky</option>
				<option value="LA" <%=(state.equals("LA")) ? "selected=selected" : ""%>>Louisiana</option>
				<option value="ME" <%=(state.equals("ME")) ? "selected=selected" : ""%>>Maine</option>
				<option value="MD" <%=(state.equals("MD")) ? "selected=selected" : ""%>>Maryland</option>
				<option value="MA" <%=(state.equals("MA")) ? "selected=selected" : ""%>>Massachusetts</option>
				<option value="MI" <%=(state.equals("MI")) ? "selected=selected" : ""%>>Michigan</option>
				<option value="MN" <%=(state.equals("MN")) ? "selected=selected" : ""%>>Minnesota</option>
				<option value="MS" <%=(state.equals("MS")) ? "selected=selected" : ""%>>Mississippi</option>
				<option value="MO" <%=(state.equals("MO")) ? "selected=selected" : ""%>>Missouri</option>
				<option value="MT" <%=(state.equals("MT")) ? "selected=selected" : ""%>>Montana</option>
				<option value="NE" <%=(state.equals("NE")) ? "selected=selected" : ""%>>Nebraska</option>
				<option value="NV" <%=(state.equals("NV")) ? "selected=selected" : ""%>>Nevada</option>
				<option value="NH" <%=(state.equals("NH")) ? "selected=selected" : ""%>>New Hampshire</option>
				<option value="NJ" <%=(state.equals("NJ")) ? "selected=selected" : ""%>>New Jersey</option>
				<option value="NM" <%=(state.equals("NM")) ? "selected=selected" : ""%>>New Mexico</option>
				<option value="NY" <%=(state.equals("NY")) ? "selected=selected" : ""%>>New York</option>
				<option value="NC" <%=(state.equals("NC")) ? "selected=selected" : ""%>>North Carolina</option>
				<option value="ND" <%=(state.equals("ND")) ? "selected=selected" : ""%>>North Dakota</option>
				<option value="OH" <%=(state.equals("OH")) ? "selected=selected" : ""%>>Ohio</option>
				<option value="OK" <%=(state.equals("OK")) ? "selected=selected" : ""%>>Oklahoma</option>
				<option value="OR" <%=(state.equals("OR")) ? "selected=selected" : ""%>>Oregon</option>
				<option value="PA" <%=(state.equals("PA")) ? "selected=selected" : ""%>>Pennsylvania</option>
				<option value="RI" <%=(state.equals("RI")) ? "selected=selected" : ""%>>Rhode Island</option>
				<option value="SC" <%=(state.equals("SC")) ? "selected=selected" : ""%>>South Carolina</option>
				<option value="SD" <%=(state.equals("SD")) ? "selected=selected" : ""%>>South Dakota</option>
				<option value="TN" <%=(state.equals("TN")) ? "selected=selected" : ""%>>Tennessee</option>
				<option value="TX" <%=(state.equals("TX")) ? "selected=selected" : ""%>>Texas</option>
				<option value="UT" <%=(state.equals("UT")) ? "selected=selected" : ""%>>Utah</option>
				<option value="VT" <%=(state.equals("VT")) ? "selected=selected" : ""%>>Vermont</option>
				<option value="VA" <%=(state.equals("VA")) ? "selected=selected" : ""%>>Virginia</option>
				<option value="WA" <%=(state.equals("WA")) ? "selected=selected" : ""%>>Washington</option>
				<option value="WV" <%=(state.equals("WV")) ? "selected=selected" : ""%>>West Virginia</option>
				<option value="WI" <%=(state.equals("WI")) ? "selected=selected" : ""%>>Wisconsin</option>
				<option value="WY" <%=(state.equals("WY")) ? "selected=selected" : ""%>>Wyoming</option>
			</select><br>



			<input type = "submit" value = "Submit">

		</form>
		
</div>

</body>
</html>