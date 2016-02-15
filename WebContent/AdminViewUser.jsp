<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AdminViewUser</title>
</head>
<body>
	<sql:setDataSource
	var="dsrc"
	driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost/bnk_frauddetection"
	user="root"  password="${null}"/>
	
	<sql:query var="ListUsers" dataSource="${dsrc}">
	SELECT * FROM bnk_users;
	</sql:query>
	
	<div align="center">
		<table border="1" cellpadding="5">
			<caption><h2>Users lists</h2></caption>
			<tr>
				<th>accountID</th>
				<th>Firstname</th>
				<th>Lastname</th>
				<th>Pin</th>
				<th>Age</th>
				<th>Collective</th>
				<th>Balance</th>
				<th>Admin</th>
			</tr>
			<c:forEach var="user" items="${ListUsers.rows}">
				<tr>
					<td><c:out value="${user.accountID}"/></td>
					<td><c:out value="${user.Firstname}"/></td>
					<td><c:out value="${user.Lastname}"/></td>
					<td><c:out value="${user.Pin}"/></td>
					<td><c:out value="${user.Age}"/></td>
					<td><c:out value="${user.collective}"/></td>
					<td><c:out value="${user.balance}"/></td>
					<td><c:out value="${user.Admin}"/></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>