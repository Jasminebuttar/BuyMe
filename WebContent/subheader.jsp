<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.buyme.User" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BuyMe</title>
</head>
<body>

<div id="subheader">

<%
	User user = (User) session.getAttribute("currentUser");
	
	if (user != null)
	{
	
		if (user.getIsAdmin())
		{
%>
			<div id="top_nav" class="center">
				<table class="account">
					<tr>
						<th><a href="email.jsp">View Messages</a></th>
						<th><a href="createemail.jsp">Send Message</a></th>
						<th><a href="register.jsp">Create Customer Rep Account</a></th>
						<th><a href="deleterepaccount.jsp">Delete Customer Rep Account</a></th>
						<th><a href="createreport.jsp">Create Report</a></th>
					</tr>
				</table>
			</div>
<%	
		}
		else if (user.getIsCustRep())
		{
%>
			<div id="top_nav" class="center">
				<table class="account">
					<tr>
						<th><a href="email.jsp">View Messages</a></th>
						<th><a href="createemail.jsp">Send Message</a></th>
						<th><a href="viewhelp.jsp">View Help Requests</a></th>
						<th><a href="viewreported.jsp">View Reported Auctions</a></th>
						<th><a href="viewretractreqs.jsp">Remove Bid</a></th>
						<th><a href="viewallmodifyauction.jsp">Modify Auction Reqs.</a></th>
					</tr>
				</table>
			</div>
<%
		}
		else
		{
%>
			<div id="top_nav" class="center">
				<table class="account">
					<tr>
						<th><a href="email.jsp">View Messages</a></th>
						<th><a href="createemail.jsp">Send Message</a></th>
						<th><a href="createauction.jsp">Create an Auction</a></th>
						<th><a href="buying.jsp">Auctions (Buying)</a></th>
						<th><a href="selling.jsp">Auctions (Selling)</a></th><br>
						<th><a href="alert.jsp">Set Up Auction Alerts</a></th>
						<th><a href="listalert.jsp">Your Alerts</a></th>
						<th><a href="deleteautobid.jsp">Delete Autobid</a></th>
						<th><a href="updateinfo.jsp">Update Info</a></th>
						<th><a href="deleteaccount.jsp">Delete Account</a></th>
					</tr>
				</table>
			</div><br><br>
<%		
		}
	}
%>

</div>

</body>
</html>