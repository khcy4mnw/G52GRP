<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AdminViewTransaction</title>
</head>
<body>
	<sql:setDataSource
	var="dsrc"
	driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost/bnk_frauddetection"
	user="root"  password="${null}"/>
	
	<sql:query var="ListTrans" dataSource="${dsrc}">
		SELECT * FROM bnk_transactions
	</sql:query>
	
	<div align="center">
		<table border="1" cellpadding="5">
		<caption><h2>List of Transactions</h2></caption>
		<tr>
			<th>TransactionID</th>
			<th>AccountID</th>
			<th>Amount</th>
			<th>Type</th>
			<th>Time</th>
			<th>Terminal</th>
		</tr>
		<c:forEach var="trans" items="${ListTrans.rows}">
			<tr>
				<td><c:out value="${trans.transactionID}"/></td>
				<td><c:out value="${trans.accountID}"/></td>
				<td><c:out value="${trans.amount}"/></td>
				<td><c:out value="${trans.type}"/></td>
				<td><c:out value="${trans.time}"/></td>
				<td><c:out value="${trans.terminal}"/></td>
			</tr>
		</c:forEach>
		</table>
	</div>
</body>
</html>