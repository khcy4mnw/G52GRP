<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!-- import java sql syntax in WEB-INF -->
<%@ page import="java.sql.*,java.util.*" %>
<!-- import tag library in WEB-INF -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" 		%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" 		%>


<!-- setup sql connection -->
<sql:setDataSource var="dsrc" driver="com.mysql.jdbc.Driver"
url="jdbc:mysql://localhost/bnk_frauddetection"
user="root"  password="${null}"/>

<HTML>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Login</title>
    
	</head>
	
	<SCRIPT>
		//function to login: connect with SQL database to get confirmation
		function attemptLogging()
		{
			//grab the neccessary variables
			<sql:query dataSource="${dsrc}" var="rs" sql="SELECT accountID,pin,admin from bnk_users" />
			
			// variables to be used: boolean for found and admin + input values of account and pin
			<c:set var="userfound" 	value="false"/>
			<c:set var="isadmin" 	value="false"/>
			<c:set var="acID" 		value="${param.acID}"/>
			<c:set var="pinN" 		value="${param.pin}"/>
	
			// search through the entire table
			<c:forEach var="user" items="${rs.rows}">
				// determine if there is a match: if true, change booleans 
				<c:if test="${acID == user.accountID && pinN == user.pin}">
					<c:set var="userfound" value="true"/>
						
					// determine if match is an admin
					<c:if test="${user.admin == 'true'}">
						<c:set var="isadmin" value="true"/>
					</c:if>
						
				</c:if>
			</c:forEach>
				
			// determine response depending on boolean values 
			// if user is found, pop an alert. if not, pop an alert 
			<c:choose>
				<c:when test="${userfound == 'true'}">
					alert("User is found");		
					
					//then select response depending on admin value -->
					<c:choose>
						<c:when test="${isadmin == 'true'}">
							alert("IS ADMIN go to admin");
						</c:when>
						<c:otherwise>
							alert("User is client go the clientpage");
						</c:otherwise>
					</c:choose>				
						
				</c:when>
				<c:otherwise>
					alert("USER IS NOT OFUND");
				</c:otherwise>
			</c:choose>
		}	

		//function to show or hide help table
		function showhideusers()
		{
			//button text switch script ok
			var btntext = document.getElementById("btn_utable").value
			document.getElementById("btn_utable").value = (btntext == "Show") ? "Hide" : "Show";

			//table show/hide switch
			document.getElementById("useravail").style.display = (document.getElementById("useravail").style.display == "none") ? "" : "none";
		}
	</SCRIPT>

	<BODY>
		<h1>Logging in-</h1> 
		<form method="POST" action="login.jsp">
		<table>
			<tr>
				<td>Account ID</td>
				<td><input type="text" name="acID" id="acID" size=5 value=""/></td>
	 		</tr>
	 		<tr>
	 			<td>PIN</td>
	 			<td><input type="text" name="pin" id="pin" size=6 value=""/></td>
	 		</tr>
	 		<tr>
				<!-- button posts parameters onto the url- if method is POST, it will be invisible. -->
				<td><input type="submit" value="accept"/></td>
				<!-- button to actually run login function -->
 				<td><button type="submit" onclick="attemptLogging()">submit</button></td>
		 	</tr>
 		</table>
 		</form>
 		<br><br>
 		
 		<!-- Button to show new users available logins -->
 		<input type="button" id="btn_utable" onclick="showhideusers()" value="Show"/> available user logins
 		
 		<!-- table that shows accountno, pin and privilege -->
 		<div id="useravail" style="display:none">
 		<table border="1">
 				<tr>
 					<td width="35%">AccountID</td>
 					<td width="33%">Pin No.</td>
 					<td width="32%">Admin</td>
 				</tr>
 			<!-- get into sql and print accountid,pin and admin -->
	 		<sql:query dataSource="${dsrc}" var="rs" sql="SELECT accountID,pin,admin from bnk_users" />
	 		<c:forEach var="allusers" items="${rs.rows}">
	 			<tr>
	 				<td><c:out value="${allusers.accountID}"/></td>
	 				<td><c:out value="${allusers.pin}"/></td>
	 				<td><c:out value="${allusers.admin}"/></td>
	 			</tr>
	 		</c:forEach>
	 		
 		</table>
 		</div>
 		
	</BODY>
</HTML>


<!--  
		BUG: the function applies the previous inputs when the button is pressed.
		This means when first pressed, it will always return negative. However, the next call will correctly
		apply the previous parameters into the function.
		To explain this:
		
			try      input    output
			1.       Client - Error
			2.		 Admin  - Client
			3.       Nothing- Admin
			4.       Admin  - Error
		
		Need to find solution ASAP.
		
	 	Problem source identified: the jstl gets inputs from the URL- known as parameters. These parameters are not set until
	 	after the function is run. Therefore, the submit button needs to be run, THEN the function.
	 	
	 	A workaround: make two buttons. One to post the parameters and one to fire the function.
-->