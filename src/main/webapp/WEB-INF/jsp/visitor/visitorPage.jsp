<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="../common/header.jsp" %>
<meta charset="UTF-8">
<title>游客信息列表页</title>
<style type="text/css">
</style>
</head>
<body>
	<div class="easyui-layout" data-options="fit:true,selected:true">
		<div class="datagrid-toolbar" data-options="region:'north',split:true,title:'查询'" style="height: 130px; padding: 20px 0px 10px 30px">
			<form id="queryForm" method="post" novalidate>
				<table class="datagrid-toolbar" style="width: 100%; height: 70%; border: 0px; font-size: 12px">
					<tr class="itemMagin">
						<!-- 查询条件：用户名 -->
						<td>
							<label for="qyVisitorName">用户名:</label>
						</td>
						<td>
							<input id="qyVisitorName" name="qyVisitorName" class="easyui-validatebox" data-option="required:true" />
						</td>
						<!-- 查询条件：手机号 -->
						<td>
							<label for="qyVisitorMobileNo">手机号:</label>
						</td>
						<td>
							<input id="qyVisitorMobileNo" name="qyVisitorMobileNo" class="easyui-validatebox" data-option="required:true" />
						</td>
						<!-- 查询条件：邮箱 -->
						<td>
							<label for="qyVisitorEmail">邮箱:</label>
						</td>
						<td>
							<input id="qyVisitorEmail" name="qyVisitorEmail" class="easyui-validatebox" data-option="required:true" />
						</td>
						<td><a href="#" class="easyui-linkbutton" iconCls="icon-search" id="btnQuery">查询</a> 
							<a href="#"	class="easyui-linkbutton" iconCls="icon-undo" id="btnCancel">清空</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:true,title:'列表'">
			<table id="visitorList">
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
		initVisitorGrid();
	});

	// 查询
	function queryInfo(){
		// 按照查询条件重新加载列表数据
		$('#visitorList').datagrid('load',{
		name: $('#qyVisitorName').val(),
		mobileNo: $('#qyVisitorMobileNo').val(),
		email: $('#qyVisitorEmail').val()
	});
	}
	
	// 取消查询
	function queryCancel(){
		$('#queryForm').form('clear');
	}
	
	// 分页显示经典线路信息
	function initVisitorGrid(){
		$("#visitorList").datagrid({
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
			url: '/visitor/getVisitorByPage',
			onDblClickRow:function(rowIndex, rowData){

			},
			columns:[[
					  {title:'主键',field:'visitorId',width:100,checkbox:true},
					  {title:'用户名',field:'name',width:100},
					  {title:'真实姓名',field:'realName',width:25},
					  {title:'真实姓名保密否',field:'realNameSecret',width:25,hidden:true},
					  {title:'昵称',field:'nickName',width:25},
			          {title:'邮箱',field:'email',width:25,hidden:true},
			          {title:'邮箱是否激活',field:'emailActivated',width:25},
			          {title:'手机',field:'mobileNo',width:60},
			          {title:'状态',field:'status',width:60},
			          {title:'操作',field:'operation',width:25,align:'center',
			  			formatter : function(value, row, index) {
			  				console.log(row);
			  				var opt='';
			  				opt += '<a href="javascript:void(0);" val="'+value+'" onclick="showVisitorDetails(\''+ row.visitorId +'\')" class="easyui-linkbutton">详情</a>';
			  				opt += '';
			  				return opt;
			  			} 
			          }
			      ]],
			toolbar:[
			        {
					    text:'锁定',
			            iconCls:'icon-cancel',
			            handler:function(){
			            	changeVisitorStatus('0');//停用一条经典线路
				        }
					}
					,
			        {
					    text:'解锁',
			            iconCls:'icon-ok',
			            handler:function(){
			            	changeVisitorStatus('1');//启用一条经典线路
				        }
					}
			]
		});
	}
	
	
	// 锁定/解锁一名游客
	function changeVisitorStatus(status){
		var rows = $('#visitorList').datagrid('getSelections');
		if(rows.length == 0){
			showSlideMessage("请选择至少一名游客！");
			return;
		}
		
		var visitorIds = [];
		for(var i = 0;i<rows.length;i++){
			visitorIds.push(rows[i].visitorId);
		}
		// 拼接需要发布
		var visitorIds = visitorIds.join(',');
		
		$.messager.confirm('确认','你确定要执行该操作吗?',function(r){
	        if (r){
	        	jQuery.ajax({
	    			type : "POST",
	    	        async: false,
	    	        url : "/visitor/reviseVisitorStatus",
	    	        data : {
	    	        	visitorIds:visitorIds,
	    	        	status:status
	    	        },
	    	        success : function(result) {
	    	          if(result.status=='success'){
	    	        	  if(status == '0'){
	    	        		  showSlideMessage("游客已被锁定");
	    	        	  }else if(status == '1'){
	    	        		  showSlideMessage("游客已被解锁");
	    	        	  }
	    	        	  // 重新加载
	    	        	  $('#visitorList').datagrid('reload');
	    	           }else{
	    	        	   showSlideMessage("操作失败！");
	    	           }
	    	        },
	    	        error : function(result) {
	    	        	showSlideMessage("出现错误，请确认！");
	    	        },
	    	        datatype : "json"
	        	});
	        }
	    });
	}
	
	// 显示一条经典线路的详细信息
	function showVisitorDetails(visitorId){
		self.parent.addTab("详情：游客信息详情", "/visitor/visitorDetail?visitorId=" + visitorId);
	}
</script>
</body>
</html>
