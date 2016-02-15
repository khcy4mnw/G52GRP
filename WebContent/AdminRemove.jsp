<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- import java sql syntax in WEB-INF -->
<%@ page import="java.sql.*,java.util.*" %>
<!-- import tag library in WEB-INF -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" 		%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" 		%>


<!-- setup sql connection -->
<sql:setDataSource var="dsrc" driver="com.mysql.jdbc.Driver"
url="jdbc:mysql://localhost/bnk_frauddetection"
user="root"  password="${null}"/>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete User</title>
</head>

<SCRIPT>
	//function to delete account
	function deleteacc()
	{
		<c:set var="account" value="${param.accounts}"/>
		//sql to delete account from users
		<sql:update dataSource="${dsrc}" var="deletefromusers">
			DELETE FROM bnk_users where accountID="${param.accounts}"
		</sql:update>
		//sql to delete account transactions
		<sql:update dataSource="${dsrc}" var="deletefromtrans" >
			DELETE FROM bnk_transactions where accountID="${param.accounts}" 
		</sql:update>
		
		alert("Account Removed.");
	}

	//function to move into user management
	function moveToManagement()
	{window.location = "AdminUserManagement.jsp"}
</SCRIPT>

<body>
	<form method="GET" id="removalform">
		<table>
		<tr>
			<td>Account to delete :</td>
			<td>
				<select name="accounts" id="accounts">
					<!-- implement JSTL to add options from sql database -->
					<sql:query dataSource="${dsrc}" var="availableaccounts">SELECT accountID FROM bnk_users</sql:query>
						<c:forEach var="acc" items="${availableaccounts.rows}">
							<option value="${acc.accountID}"><c:out value="${acc.accountID}"/></option>
						</c:forEach>
				</select>
			</td>
		</tr>
		<tr> 
			<td><input type="submit" value="Accept"></td>
		</tr>
		</table>
	</form>
	<br>
	<br><br>
	<!-- button to return -->
	<input type="button" id="btn_cancel" value="Cancel" onclick="moveToManagement()"/>
</body>
</html>