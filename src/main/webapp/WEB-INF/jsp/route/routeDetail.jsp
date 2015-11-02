<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="../common/header.jsp" %>
<meta charset="UTF-8">
<title>经典线路详情页</title>
<style type="text/css">
</style>
</head>
<body>
	<div>
		<span>名称：</span><span>${route.name}</span>
	</div>
	<div>
		<span>特色：</span><span>${route.feature}</span>
	</div>
</body>
</html>