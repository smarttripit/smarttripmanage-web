<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="../common/header.jsp" %>
<meta charset="UTF-8">
<title>游客评论表页</title>
<style type="text/css">
</style>
</head>
<body>
	<div class="easyui-layout" data-options="fit:true,selected:true">
		<div class="datagrid-toolbar" data-options="region:'north',split:true,title:'查询'" style="height: 130px; padding: 20px 0px 10px 30px">
			<form id="queryForm" method="post" novalidate>
				<table class="datagrid-toolbar" style="width: 100%; height: 70%; border: 0px; font-size: 12px">
					<tr class="itemMagin">
						<!-- 查询条件：游客名称 -->
						<td>
							<label for="qyVisitorName">游客名称:</label>
						</td>
						<td>
							<input id="qyVisitorName" name="qyVisitorName" class="easyui-validatebox" data-option="required:true" />
						</td>
						<!-- 查询条件：评论内容 -->
						<td>
							<label for="qyCommentContent">评论内容:</label>
						</td>
						<td>
							<input id="qyCommentContent" name="qyCommentContent" class="easyui-validatebox" data-option="required:true" />
						</td>
						<!-- 查询条件：评论产品 -->
						<td>
							<label for="qyCommentProduct">评论产品:</label>
						</td>
						<td>
							<input id="qyCommentProduct" name="qyCommentProduct" class="easyui-validatebox" data-option="required:true" />
						</td>
						<!-- 查询条件：评论时间 -->
						<td>
							<label for="qyCommentTime">评论时间:</label>
						</td>
						<td>
							从:<input id="qyCommentBeginTime" name="qyCommentBeginTime" class="easyui-datetimebox" data-option="required:true" />
							到:<input id="qyCommentEndTime" name="qyCommentEndTime" class="easyui-datetimebox" data-option="required:true" />
						</td>
						<td><a href="#" class="easyui-linkbutton" iconCls="icon-search" id="btnQuery">查询</a> 
							<a href="#"	class="easyui-linkbutton" iconCls="icon-undo" id="btnCancel">清空</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:true,title:'列表'">
			<table id="commentList">
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
		initCommentGrid();
	});

	// 查询
	function queryInfo(){
		// 按照查询条件重新加载列表数据
		$('#commentList').datagrid('load',{
			name: $('#qyVisitorName').val(),
			content: $('#qyCommentContent').val(),
			productType: $('#qyCommentProduct').val(),
			commentBeginTime: $('#qyCommentBeginTime').datetimebox('getValue'),
			commentEndTime: $('#qyCommentEndTime').datetimebox('getValue')
		});
	}
	
	// 取消查询
	function queryCancel(){
		$('#queryForm').form('clear');
		$('#qyCommentBeginTime').datatimebox('setValue','');
		$('#qyCommentEndTime').datatimebox('setValue','');
	}
	
	// 分页显示经典线路信息
	function initCommentGrid(){
		$("#commentList").datagrid({
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
			url: '/comment/getCommentByPage',
			onDblClickRow:function(rowIndex, rowData){

			},
			columns:[[
					  {title:'主键',field:'commentId',width:100,checkbox:true},
					  {title:'游客名称',field:'visitorId',width:100},
					  {title:'评论产品',field:'productType',width:100},
			          {title:'操作',field:'operation',width:25,align:'center',
			  			formatter : function(value, row, index) {
			  				console.log(row);
			  				var opt='';
			  				opt += '<a href="javascript:void(0);" val="'+value+'" onclick="showCommentDetails(\''+ row.commentId +'\')" class="easyui-linkbutton">详情</a>';
			  				opt += '';
			  				return opt;
			  			} 
			          }
			      ]],
			toolbar:[
			        {
					    text:'删除',
			            iconCls:'icon-cancel',
			            handler:function(){
			            	batchDeleteComments();//批量删除评论
				        }
					}
			]
		});
	}
	
	
	// 批量删除评论
	function batchDeleteComments(){
		var rows = $('#commentList').datagrid('getSelections');
		if(rows.length == 0){
			showSlideMessage("请选择至少一条评论！");
			return;
		}
		
		var commentIds = [];
		for(var i = 0;i<rows.length;i++){
			commentIds.push(rows[i].commentId);
		}
		// 拼接需要发布
		var commentIds = commentIds.join(',');
		
		$.messager.confirm('确认','你确定要执行该操作吗?',function(r){
	        if (r){
	        	jQuery.ajax({
	    			type : "POST",
	    	        async: false,
	    	        url : "/comment/batchDeleteComments",
	    	        data : {
	    	        	commentIds:commentIds,
	    	        },
	    	        success : function(result) {
	    	          if(result.status=='success'){
	    	        		showSlideMessage("评论已被删除");
	    	        	  // 重新加载
	    	        	  $('#commentList').datagrid('reload');
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
	function showCommentDetails(commentId){
		self.parent.addTab("详情：评论", "/comment/commentDetail?comemntId=" + comemntId);
	}
</script>
</body>
</html>
