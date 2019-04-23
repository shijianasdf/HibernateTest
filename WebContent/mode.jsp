<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
    <link rel="stylesheet" href="css/reset.css"/>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <script type="text/javascript">
    
    $.ajax //在这里调用ipRecorder.action,记录ip，count(访问次数),country(国家)，lastTime(最后一次访问时间)
    ({
    	type: "POST",
    	url: "ipRecorder.action",
    	dataType:"text",
    	success: function(){
    	}
    });
   
    </script>
</head>
<body>
    <a href="test?rid=student000001">student000001</a>
    <s:iterator value="#rs" id="id">
       
    </s:iterator>
    <s:property value="#rs.get(0).getName()"/>
	<script src="js/jquery-1.12.1.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/jquery-ui.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/d3.min.js"></script>
	<script>

	</script>
</body>
</html>