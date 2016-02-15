<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>User Management</title>
</head>
	<SCRIPT>
		//function to move to add new user
		function moveToRegister()
		{window.location = "AdminRegister.jsp"}
		
		//function to move to delete user
		function moveToRemove()
		{
			alert("Reminder: deleting an account (including transactions by that account) is a permanent action.");
			window.location = "AdminRemove.jsp"
		}
		
		//function to change user credentials
		function moveToAlter()
		{}
		
		//function to go back to main admin menu
		function backButton()
		{}
	</SCRIPT>
<body>
	<input type="button" id="btn_register" value="Register New User" onclick="moveToRegister()"/><br><br>
	<input type="button" id="btn_remove" value="Delete Existing User" onclick="moveToRemove()"/><br><br>
	<input type="button" id="btn_alter" value="Change User Credentials" onclick="moveToAlter()"/><br><br>
	<input type="button" id="btn_cancel" value="Cancel" onclick="backButton()"/>
</body>
</html>