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
			url:'/route/getByPage',
			fitColumns:true,
			singleSelect:true,
			toolbar:'#toolbar',
			fit:true,
			rownumbers:true,
			pagination:true">
	<thead>
		<tr>
			<th field="name" width="50">名称</th>
			<th field="feature" width="100">特色</th>
			<th field="theme" width="50">主题</th>
			<th field="region" width="50">地区</th>
			<th field="period" width="50">天数</th>
			<th field="commentCount" width="50">评论数</th>
			<th field="commetRatio" width="50">好评率</th>
			<th field="purchaseCount" width="50">购买数</th>
			<th field="displayOrder" width="50">显示顺序</th>
			<th field="status" width="50">状态</th>
		</tr>
	</thead>
</table>
<div id="toolbar">
	<div>
		Date From: <input class="easyui-datebox" style="width:80px">
		To: <input class="easyui-datebox" style="width:80px">
		Language: 
		<input class="easyui-combobox" style="width:100px"
				url="data/combobox_data.json"
				valueField="id" textField="text">
		<a href="#" class="easyui-linkbutton" iconCls="icon-search">Search</a>
	</div>
	<div>
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newRoute()">新建线路</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editRoute()">修改线路</a>
	</div>
	<B>筛选条件：</B><br>
	<span style="font-weight:bold;">地区：</span>
		<select id="firstRegion">
			<option value="">请选择</option>
			<option value="北京">北京</option>
		</select>
		<select id="secondRegion">
			<option value="">请选择</option>
			<option value="怀柔">怀柔</option>
		</select>
	&nbsp&nbsp<span style="font-weight:bold;">线路名称：</span>
		<input id="name" style="border:1px solid #ccc">
	&nbsp&nbsp<span style="font-weight:bold;">线路主题：</span>
		<select id="theme">
			<option value="">请选择</option>
			<option value="烧烤">烧烤</option>
			<option value="露营">露营</option>
		</select>
	&nbsp&nbsp<span style="font-weight:bold;">线路天数：</span>
		<input id="periodStart" type="text" maxlength="2" style="width:26px;border:1px solid #ccc">
		-
		<input id="periodEnd" type="text" maxlength="2" style="width:26px;border:1px solid #ccc">
	&nbsp&nbsp<span style="font-weight:bold;">线路状态:</span>
		<select id="status">
			<option value="">全部</option>
			<option value="有效">有效</option>
			<option value="无效">无效</option>
		</select>
	&nbsp&nbsp<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="doSearch()">查询</a>
</div>
<script type="text/javascript">
	function doSearch(){
		$('#tt').datagrid('load',{
			
		});
	}
</script>
</body>
</html>
