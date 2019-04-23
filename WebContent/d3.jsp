<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>d3编写基因组浏览器</title>
    <link rel="stylesheet" href="css/reset.css"/>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
</head>
<body>
<div class="container" style="min-width:400px;height:400px">
	<svg width="50" height="50">  <!-- 使用D3.js画一个SVG 的 圆 circle -->
    	<circle cx="25" cy="25" r="25" fill="purple" />
	</svg>
	<svg width="50" height="50">  <!-- 使用D3.js画一个SVG 的 长方形 -->
		<rect x="0" y="0" width="50" height="50" fill="green"/>
	</svg>
	<svg width="50" height="50">
    	<line x1="5" y1="5" x2="40" y2="40" stroke="grey" stroke-width="5" />
	</svg>
</div>
<div>
	<p>
		
	</p>
 </div>
 <div id="barplot">
 	
 </div>
<script src="js/jquery-1.12.1.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="js/jquery-ui.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/d3.min.js"></script>
<script>
var width = 300;
var height = 300;
var svg_new = d3.select("#barplot").append("svg");
svg_new.attr("width",width).attr("height",height);
d3.select("#barplot").select("svg").append("rect");
var dataset = [250 , 210 , 170 , 130 , 90]; //数据（表示矩形的宽度）
var rectHeight = 25;   //每个矩形所占的像素高度(包括空白)
svg_new.selectAll("rect")
    .data(dataset)
    .enter()
    .append("rect")
    .attr("x",20)
    .attr("y",function(d,i){
         return i * rectHeight;
    })
    .attr("width",function(d){
         return d;
    })
    .attr("height",rectHeight-2)
    .attr("fill","steelblue");


d3.select("p").text("lala");
d3.select("p").data("haha").text(function(d,i){
	return i + d;    //0h 
});
//json数据格式  数组里装对象 这里一般从后台拿回数据，然后用JSON.parse(json)变成js对象
var jsonCircles = [                                              
	{"x_axis":30,"y_axis":30,"radius":20,"color":"greeen"},
	{"x_axis":70,"y_axis":70,"radius":20,"color":"purple"},
	{"x_axis":110,"y_axis":100,"radius":20,"color":"red"}   
];
 
var svgContainer = d3.select("body").append("svg")
.attr("width",200)
.attr("height",200);
 
var circles =svgContainer.selectAll("circle")
.data(jsonCircles)
.enter()
.append("circle");
 
var circleAttributes = circles
.attr("cx",function(d){return d.x_axis;})
.attr("cy",function(d){return d.y_axis;})
.attr("r",function(d){return d.radius;})
.style("fill",function(d){return d.color;});

//创建一个SVG容器
var svgContainer = d3.select("body").append("svg")
.attr("width",200)
.attr("height",200);
 
//画圆形
var circle = svgContainer.append("circle")
.attr("cx",30)
.attr("cy",30)
.attr("r",20);

//创建一个SVG容器
var svgContainer = d3.select("body").append("svg")
.attr("width",200)
.attr("height",200);
 
//画长方形
var rectangle = svgContainer.append("rect")
.attr("x",10)
.attr("y",10)
.attr("width",50)
.attr("height",100);

//创建SVG容器
var svgContainer = d3.select("body").append("svg")
.attr("width",200)
.attr("height",200);
 
//画直线
var line = svgContainer.append("line")
.attr("x1",5)
.attr("y1",5)
.attr("x2",50)
.attr("y2",50)
</script>
</body>
</html>


