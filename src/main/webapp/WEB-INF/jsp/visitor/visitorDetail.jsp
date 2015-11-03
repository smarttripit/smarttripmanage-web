<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="../common/header.jsp" %>
<meta charset="UTF-8">
<title>游客信息详情页</title>
<style type="text/css">
</style>
</head>
<body>
	<div>
		<span>性别：</span><span>${visitor.gender}</span>
	</div>
	<div>
		<span>注册时间：</span><span>${visitor.registerTime}</span>
	</div>
</body>
</html>