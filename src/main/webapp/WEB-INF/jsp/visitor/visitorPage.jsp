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
			url:'/visitor/getVisitorByPage',
			fitColumns:true,
			singleSelect:true,
			toolbar:'#toolbar',
			fit:true,
			rownumbers:true,
			pagination:true">
	<thead>
		<tr>
			<th field="name" width="50">用户名</th>
			<th field="realName" width="50">真实姓名</th>
			<th field="email" width="50">邮箱</th>
			<th field="mobileNo" width="50">手机号</th>	
		</tr>
	</thead>
</table>
<div id="toolbar">
	<div id="tb" style="padding:3px">
	<span>用户名:</span>
	<input id="name" style="line-height:26px;border:1px solid #ccc">
	<span>手机号:</span>
	<input id="mobileNo" style="line-height:26px;border:1px solid #ccc">
	<span>邮箱:</span>
	<input id="email" style="line-height:26px;border:1px solid #ccc">
	<a href="#" class="easyui-linkbutton" plain="true" onclick="doSearch()">查找</a>
	</div>
	<a href="#" class="easyui-linkbutton"  plain="true" onclick="newUser()">锁定</a>
	<a href="#" class="easyui-linkbutton"  plain="true" onclick="editUser()">解锁</a>
</div>

<script type="text/javascript">
function doSearch(){
	$('#tt').datagrid('load',{
		name: $('#name').val(),
		mobileNo: $('#mobileNo').val(),
		email: $('#email').val()
	});
}
function changeStatus(){
	var row = $('#dg').datagrid('getSelected');
	if (row){
		
	}
}
</script>
</body>
</html>