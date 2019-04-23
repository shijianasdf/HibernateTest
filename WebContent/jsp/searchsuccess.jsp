<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>  
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	var json = "<s:property value='#asjson'/>";
	json = json.replace(/&quot;/g,'"');
	json = JSON.parse(json);
	alert(json);
	alert(json[0].name);
	alert(json[0].score);
</script>
</head>
<body>
<s:iterator value="#as" id="id" status="st">
	<s:property value="#id.getScore()"/>
	<a href="student!delete?name=<s:property value="#id.getName()"/>"><s:property value="#id.getName()"/></a>
</s:iterator>



<script type="text/javascript" src="js/jquery.min.js"></script>
</body>
</html>