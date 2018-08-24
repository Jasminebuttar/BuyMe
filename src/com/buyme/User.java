package com.buyme;

public class User {

	String username;
	String firstName;
	String lastName;
	String email;
	String street;
	String city;
	String county;
	String zip;
	String state;
	Boolean isAdmin;
	Boolean isCustRep;
	String dob;
	String password;
	
	public User(String inUN, String inFN, String inLN, String inEmail, String inStreet, String inCity,
				String inCounty, String inZip, String inState, Boolean inIsAdmin, Boolean inIsCustRep, String inDob,
				String inPassword)
	{	
		username = inUN;
		firstName = inFN;
		lastName = inLN;
		email = inEmail;
		street = inStreet;
		city = inCity;
		county = inCounty;
		zip = inZip;
		state = inState;
		isAdmin = inIsAdmin;
		isCustRep = inIsCustRep;
		dob = inDob;
		password = inPassword;
		
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCounty() {
		return county;
	}

	public void setCounty(String county) {
		this.county = county;
	}

	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Boolean getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(Boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

	public Boolean getIsCustRep() {
		return isCustRep;
	}

	public void setIsCustRep(Boolean isCustRep) {
		this.isCustRep = isCustRep;
	}
	
	public String getDob() {
		return dob;
	}

	public void setDob(String dob) {
		this.dob = dob;
	}
	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
