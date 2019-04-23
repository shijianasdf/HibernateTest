<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>

</head>
<body>
<form action="student!add" method="post">
	name:<input type="text" name="name"/><br/>
	sex:<input type="text" name="sex"/><br/>
	score:<input type="text" name="score"/><br/>
	university:<input type="text" name="university"/><br/>
	<input type="submit" name="提交"/>
</form>
<hr/>
<form action="student!searchdetail" method="post">
	name:<input type="text" name="name"/><br/>
		<input type="submit" name="提交"/>
</form>
<hr/>
<form action="student!update" method="post">
	oldscore:<input type="text" name="score"/><br/>
	newscore:<input type="text" name="newscore"/>
	<input type="submit" value="提交"/>
</form>

</body>
</html>