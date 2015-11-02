<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="UTF-8">
<title>经典线路详情页</title>
<style type="text/css">
</style>
	<link rel="stylesheet" type="text/css" href="/static/framework/jeasyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/static/framework/jeasyui/themes/icon.css">
	<script type="text/javascript" src="/static/framework/jeasyui/jquery.min.js"></script>
	<script type="text/javascript" src="/static/framework/jeasyui/jquery.easyui.min.js"></script>
	<script src="/static/framework/ckeditor/ckeditor.js"></script>
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