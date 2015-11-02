<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="UTF-8">
<title>后台管理系统-香油网络</title>
<style type="text/css">
</style>
<link rel="stylesheet" type="text/css"
	href="${contextPath}/static/framework/jeasyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${contextPath}/static/framework/jeasyui/themes/icon.css">
<script type="text/javascript"
	src="${contextPath}/static/framework/jeasyui/jquery.min.js"></script>
<script type="text/javascript"
	src="${contextPath}/static/framework/jeasyui/jquery.easyui.min.js"></script>
</head>
<body>
	<table id="tt" class="easyui-datagrid" style="width:100%;height:auto;"
		data-options="
			url:'/comment/getCommentByPage',
			fitColumns:true,
			singleSelect:true,
			toolbar:'#toolbar',
			fit:true,
			rownumbers:true,
			pagination:true">
	<thead>
		<tr>
			<th field="commentId" width="50">评论Id</th>
			<th field="visitorId" width="50">游客Id</th>
			<th field="productId" width="50">产品Id</th>
			<th field="productType" width="50">产品类型</th>
			<th field="content" width="50">内容</th>
			<th field="score" width="50">评分</th>
			<th field="commentTime" width="50">评论时间</th>
		</tr>
	</thead>
</table>
<div id="toolbar">
	<div id="tb" style="padding:3px">
	<span>用户名:</span>
	<input id="name" style="line-height:26px;border:1px solid #ccc">
	<span>评论内容:</span>
	<input id="content" style="line-height:26px;border:1px solid #ccc">
	Date From: <input class="easyui-datebox" style="width:80px">
	To: <input class="easyui-datebox" style="width:80px">
	<a href="#" class="easyui-linkbutton" plain="true" onclick="doSearch()">查找</a>
	</div>
</div>	
</body>
</html>
