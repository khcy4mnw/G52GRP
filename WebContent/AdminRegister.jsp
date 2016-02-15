<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!-- import java sql syntax in WEB-INF -->
<%@ page import="java.sql.*,java.util.*,java.io.*" %>
<!-- import tag library in WEB-INF -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" 		%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" 		%>

<!-- setup sql connection -->
<sql:setDataSource var="dsrc" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost/bnk_frauddetection"
	user="root"  password="${null}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- this page uses pure scriptlet and html only to connect with sql. -->

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add a new user</title>
</head>

<SCRIPT>
	function addintosql()
	{
		<%
			//only if two convert values are NOT NULL will these run- explanation below
			if(request.getParameter("txt_age") != null && request.getParameter("txt_balance") != null)
			{
				//get values from parameter
				String acID 	= request.getParameter("txt_accountID");
				String Fname 	= request.getParameter("txt_firstname");
				String Lname	= request.getParameter("txt_lastname");
				String PinN		= request.getParameter("txt_pin");
				int AgeN 		= Integer.parseInt(request.getParameter("txt_age"));
				double Blnc 	= Double.parseDouble(request.getParameter("txt_balance"));
				boolean Prvlg = true;
				boolean Grpd = true;
				
				//translate string values from form to boolean values
				if(request.getParameter("chkbx_privilege") == null)
				{Prvlg 	= false;}
				
				if(request.getParameter("chkbx_group") == null)
				{Grpd = false;}

				//make the connection to database
				Connection mainconn = null;
				//user credentials
				String user = "root";
				String pass = null;
				//url of the database- format is jdbc:mysql://hostname/databaseName
				String dataurl = "jdbc:mysql://localhost/bnk_frauddetection";
				//make the connection
				try
				{
					//the driver's id name
					String driver = "com.mysql.jdbc.Driver";
					//use a type 4 database (pure java) : only use mysql-type
					//register driver
					Class.forName(driver);
					
					//actually make the connection
					mainconn = DriverManager.getConnection(dataurl, user, pass);
				}
				catch(Exception e)
				{System.out.println("Problems in connection: "+e);}
				//end of open connection
				
				//build sql syntax
				//make a prepared statement
				PreparedStatement insertion = null;
				//actual statement
				String sqlcommand = "REPLACE INTO bnk_users VALUES (?,?,?,?,?,?,?,?)";
				insertion = mainconn.prepareStatement(sqlcommand);
				insertion.setString(1,acID);
				insertion.setString(2,Fname);
				insertion.setString(3,Lname);
				insertion.setString(4,PinN);
				insertion.setInt(5,AgeN);
				insertion.setBoolean(6,Grpd);
				insertion.setDouble(7,Blnc);
				insertion.setBoolean(8,Prvlg);
				
				//System.out.println(insertion);
				//execute sql command
				insertion.executeUpdate();
				
				//close connection
				mainconn.close();
			}
		%>
		alert("User has been added/changed.");
	}
	
	//function to move into user management
	function moveToManagement()
	{window.location = "AdminUserManagement.jsp"}
</SCRIPT>

<body>
	<h1>Insert a new User:</h1>
	<br>
	<form action="Register.jsp" method="POST">
	<table style="width:80px">
		<tr>
			<td><label for="txt_accountID">Account ID :</label></td>
			<td><input type="text" id="txt_accountID" name="txt_accountID" required value =""/></td>
		</tr>
		<tr>
			<td><label for="txt_firstname">First name :</label></td>
			<td><input type="text" id="txt_firstname" name="txt_firstname" required value =""/></td>
		</tr>
		<tr>
			<td><label for="txt_lastname">Last name :</label></td>
			<td><input type="text" id="txt_lastname" name="txt_lastname" required value =""/></td>
		</tr>
		<tr>
			<td><label for="txt_pin">Pin no. :</label></td>
			<td><input type="text" id="txt_pin" name="txt_pin" required value =""/></td>
		</tr>
		<tr>
			<td><label for="txt_age">Age :</label></td>
			<td><input type="text" id="txt_age" name="txt_age" required value =""/></td>
		</tr>
		<tr>
			<td><label for="chkbx_group">Organisation :</label></td>
			<td><input type="checkbox" id="chkbx_group" name="chkbx_group" />group</td>
		</tr>
		<tr>
			<td><label for="txt_balance">Balance :</label></td>
			<td><input type="text" id="txt_balance" name="txt_balance" required value =""/></td>
		</tr>
		<tr>
			<td colspan=2><input type="checkbox" id="chkbx_privilege" name="chkbx_privilege" value="privileged"/>Admin Privilege</td>
		</tr>
		</table>
		<br><input type="submit" value="Accept">
	</form> 
	<br><br>
	<input type="button" id="btn_confirm" value="Confirm" onclick="addintosql()"/><br>
	<input type="button" id="btn_cancel" value="Cancel" onclick="moveToManagement()"/>
	
</body>

</html>


<!--
			Why is the function wrapped in that if statement?

  			This is because the two variables need to be converted from string. Parameters are parts of url, so they are strings.
  			therefore, for those values to be inserted into the sql table, they need to be converted into the appropriate datatype.
  			This conversion method will cause errors if it tries to convert NULL values. This normally would not be a problem,
  			but html runs itself through the code at startup, so this condition must be handled.
  			
  			Radiobutton was attempted to be used, unfortunately scriptlet cannot comprehend logic gates that is needed to implement
  			radio buttons. Thus group was changed from radio to checkbox. Functions properly now.
  			
  			Needs to be able to handle zero entry or null values in inputs- will cause error if one of them is blanked. Solution
  			is to use 'required' attribute tag. Unfortunately eclipse doesn't get html5- checked with external resource instead.
-->
