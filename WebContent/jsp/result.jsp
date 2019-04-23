<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>  
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
	<thead>
		<tr>
			<td>id</td>
			<td>name</td>
			<td>sex</td>
			<td>score</td>
			<td>university</td>
		</tr>
	</thead>
	<tbody>
		
			<s:iterator value="#resultTable" id="id" status="st">
				<tr>	
					<td><s:property value="#id.getId()"/></td>
					<td><s:property value="#id.getName()"/></td>
					<td><s:property value="#id.getSex()"/></td>
					<td><s:property value="#id.getScore()"/></td>
					<td><a href="student!search?university=<s:property value="#id.getUniversity()"/>"><s:property value="#id.getUniversity()"/></a></td>
				</tr>
			</s:iterator>
		
	</tbody>
	
</table>

</body>
</html>