<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="../pub/header.jsp" %>
<meta charset="UTF-8">
<title>经典线路列表页</title>
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
	<div class="easyui-layout" data-options="fit:true,selected:true">
		<div class="datagrid-toolbar" data-options="region:'north',split:true,title:'查询'" style="height: 130px; padding: 20px 0px 10px 30px">
			<form id="queryForm" method="post" novalidate>
				<table class="datagrid-toolbar" style="width: 100%; height: 70%; border: 0px; font-size: 12px">
					<tr class="itemMagin">
						<!-- 查询条件：名称 -->
						<td>
							<label for="qyRouteName">名称:</label>
						</td>
						<td>
							<input id="qyRouteName" name="qyRouteName" class="easyui-validatebox" data-option="required:true" />
						</td>
						<!-- 查询条件：天数 -->
						<td>
							<label for="qyRoutePeriod">天数:</label>
						</td>
						<td>
							<input id="qyRoutePeriodStart" name="qyRoutePeriodStart" class="easyui-validatebox" data-option="required:true" />
							<label>-</label>
							<input id="qyRoutePeriodEnd" name="qyRoutePeriodEnd" class="easyui-validatebox" data-option="required:true" />
						</td>
						<!-- 查询条件：主题 -->
						<td><label for="qyRouteTheme">主题:</label></td>
						<td><select id="qyRouteTheme" class="easyui-combobox"
							name="qyRouteTheme" panelHeight="auto" style="width: 155px;"
							data-option="editable:false,required:true">
								<option value="">全部</option>
								<c:forEach items="${themes}" var="theme">
									<option value="${theme.themeId}">${theme.name}</option>
								</c:forEach>
						</select></td>
						<td><a href="#" class="easyui-linkbutton"
							iconCls="icon-search" id="btnQuery">查询</a> <a href="#"
							class="easyui-linkbutton" iconCls="icon-undo" id="btnCancel">清空</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:true,title:'列表'">
			<table id="routeList">
			</table>
		</div>
	</div>
	<script type="text/javascript">
	// 页面加载完毕执行
	$(document).ready(function() {
		// 绑定“查询”按钮的click事件
		$("#btnQuery").bind("click", function(){
			queryInfo();
		});
		// 绑定“清空”按钮的click事件
		$("#btnCancel").bind("click", function(){
			queryCancel();
		});

		// 初始化数据网格
		initRouteGrid();
	});

	// 查询
	function queryInfo(){
		// 按照查询条件重新加载列表数据
		$('#routeList').datagrid('load',{
			routeName: $('#qyRouteName').val(),
			routePeriodStart: $('#qyRoutePeriodStart').val(),
			routePeriodEnd: $('#qyRoutePeriodEnd').val(),
			routeTheme: $('#qyRouteTheme').combobox('getValue')
		});
	}
	
	// 取消查询
	function queryCancel(){
		$('#queryForm').form('clear');
		$('#qyRouteTheme').combobox('setValue','');
	}
	
	// 分页显示经典线路信息
	function initRouteGrid(){
		$("#routeList").datagrid({
			pagination:true,
			rownumbers:true,
			pageSize:10,
			pageList:[10,20,50],
			nowrap:false,
			autoRowHeight:false,
			striped:true,
			border:false,
			fitColumns:true,
			method:'post',
			singleSelect:false,
			fit:true,
			url: '/route/getByPage',
			onDblClickRow:function(rowIndex, rowData){

			},
			columns:[[
					  {title:'主键',field:'routeId',width:100,checkbox:true},
					  {title:'名称',field:'name',width:100},
					  {title:'特色',field:'feature',width:100},
					  {title:'主题',field:'theme',width:100},
					  {title:'天数',field:'period',width:25},
					  {title:'评论数',field:'commentCount',width:25,hidden:true},
					  {title:'好评率',field:'commetRatio',width:25},
			          {title:'购买数',field:'purchaseCount',width:25,hidden:true},
			          {title:'显示顺序',field:'displayOrder',width:25},
			          {title:'状态',field:'status',width:60,hidden:true},
			          {title:'操作',field:'id',width:25,align:'center',
			  			formatter : function(value, row, index) {
			  				var opt='';
			  				opt += '<a href="javascript:void(0);" val="'+value+'" onclick="showRouteDetails(\''+value +'\')" class="easyui-linkbutton">详情</a>';
			  				opt += '';
			  				return opt;
			  			} 
			          }
			      ]],
			toolbar:[
					{
					    text:'新建',
					    iconCls:'icon-add',
					    handler:function(){
					    	createOneRoute();//新建一条经典线路
					    }
					},
					{
					    text:'修改',
			            iconCls:'icon-edit',
			            handler:function(){
				        	modifyOneRoute();//修改一条经典线路
				        }
					},
			        {
					    text:'停用',
			            iconCls:'icon-cancel',
			            handler:function(){
			            	stopOrEnableOneRoute('2');//停用一条经典线路
				        }
					}
					,
			        {
					    text:'启用',
			            iconCls:'icon-ok',
			            handler:function(){
			            	stopOrEnableOneRoute('1');//启用一条经典线路
				        }
					}
			]
		});
	}
	
	// 新建一条经典线路
	function createOneRoute(){
		self.parent.addTab("新建：经典线路", "/route/newRoutePage");
	}
	
	// 修改一条经典线路
	function modifyOneRoute(){
		var rows = $('#routeList').datagrid('getSelections');
		if(rows.length == 0){
			showSlideMessage("请选择至少一条线路！");
			return;
		}
		if(rows.length > 1){
			showSlideMessage("只能选择一条线路！");
			return;
		}
		
		self.parent.addTab("修改：经典线路", "/route/updateRoutePage?routeId=" + rows[0].routeId);
	}
	
	// 停用/启用一条经典线路
	function stopOrEnableOneRoute(status){
		var rows = $('#routeList').datagrid('getSelections');
		if(rows.length == 0){
			showSlideMessage("请选择至少一条线路！");
			return;
		}
		
		var routeIds = [];
		for(var i = 0;i<rows.length;i++){
			routeIds.push(rows[i].routeId);
		}
		// 拼接需要发布
		var routeIds = routeIds.join(',');
		
		$.messager.confirm('确认','你确定要执行该操作吗?',function(r){
	        if (r){
	        	jQuery.ajax({
	    			type : "POST",
	    	        async: false,
	    	        url : "/route/reviseStatus",
	    	        data : {
	    	        	routeId:routeIds,
	    	        	status:status
	    	        },
	    	        success : function(data) {
	    	          if(data.message=='success'){
	    	        	  if(status == '1'){
	    	        		  showSlideMessage("线路已被启用");
	    	        	  }else if(status == '2'){
	    	        		  showSlideMessage("线路已被停用");
	    	        	  }
	    	        	  // 重新加载
	    	        	  $('#routeList').datagrid('reload');
	    	           }else{
	    	        	   showSlideMessage("操作失败！");
	    	           }
	    	        },
	    	        error : function(data) {
	    	        	showSlideMessage("出现错误，请确认！");
	    	        },
	    	        datatype : "json"
	        	});
	        }
	    });
	}
	
	// 显示一条经典线路的详细信息
	function showRouteDetails(routeId){
		self.parent.addTab("详情：经典线路", "/route/routeDetail?routeId=" + routeId);
	}
	
	// 消息提示框
	function showSlideMessage(msg){
	    $.messager.show({
	        title:'提示',
	        msg:msg,
	        timeout:4000,
	        showType:'slide'
	    });
	}
</script>
</body>
</html>
