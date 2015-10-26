<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="UTF-8">
<title>后台管理系统-香油网络</title>
<style type="text/css">
	body{
		
	}
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
	<div class="easyui-layout" style="width: 100%; height:100%;">
		<div region="north" split="true" class="easyui-accordion" border="false">
			<div style="height:70px;background:#2D3E50;color:white;padding:0 0 0 20px;line-height:65px;font-size:25px;font-family:微软雅黑;">
				<span>周游趣后台管理系统</span>
			</div>
		</div>
		<!-- west region 开始 -->
		<div region="west" split="true" title="菜单导航" class="easyui-accordion" style="width:250px;">
			<div title="经典线路管理" selected="true" style="width:250px;">
				<ul id="tt1" class="easyui-tree">
					<li><div onclick="addTab('线路列表', '/route/listPage')">经典线路列表</div></li>
				</ul>
			</div>
			<div title="游客管理" style="width:250px;">
			</div>
			<div title="评论管理" style="width:250px;">
			</div>
		</div>
		<!-- west region 结束 -->

		<!-- center region 开始 -->
		<div id="content" region="center" style="padding: 5px;">
			<div id="content-tab" class="easyui-tabs" style="width:100%; height:100%;">
				<div title="欢迎使用" style="padding: 10px;">
					<div>欢迎使用周游趣后台管理系统！</div>
				</div>
			</div>
		</div>
		<!-- center region 结束 -->
	</div>
	<script type="text/javascript">
    function addTab(title, url){
    	if ($('#content-tab').tabs('exists', title)){
    		$('#content-tab').tabs('select', title);
    	} else {
    		var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
    		$('#content-tab').tabs('add',{
    			title:title,
    			content:content,
    			closable:true
    		});
    	}
    }
	</script>
</body>
</html>