<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="UTF-8">
<%@include file="../common/header.jsp" %>
<title>新建经典线路</title>
<style type="text/css">
	form div{
		margin:10px 0;
	}
	form div label{
		font-weight: bold;
	}
</style>
</head>
<body>
	<form id="createRouteForm" method="post">
        <div>
            <label>名称：</label>
            <input class="easyui-validatebox" type="text" id="name" name="name" data-options="required:true" />
        </div>
        <div>
            <label>特色：</label>
            <input class="easyui-validatebox" type="text" id="feature" name="feature" data-options="required:true" />
        </div>
        <div>
            <label>天数：</label>
            <input class="easyui-validatebox" type="text" id="period" name="period" data-options="required:true" />
        </div>
        <div>
            <label>简短推荐理由：</label>
            <input class="easyui-validatebox" type="text" id="briefRecommendation" name="briefRecommendation" data-options="required:true" />
        </div>
        <div>
            <label>费用说明：</label>
            <textarea rows="30" cols="50" id="feeDescription" name="feeDescription"></textarea>
        </div>
        <div>
            <label>预定须知：</label>
            <textarea rows="30" cols="50" id="bookingNotice" name="bookingNotice"></textarea>
        </div>
        <div>
            <label>线路详情：</label>
            <textarea rows="30" cols="50" id="detail" name="detail"></textarea>
        </div>
        
		<div>
			<a href="#" class="easyui-linkbutton" id="btnCreate">提交</a>
		</div>
    </form>
    
    <script type="text/javascript">
 	// 页面加载完毕执行
	$(document).ready(function() {
		//初始化ckeditor
		CKEDITOR.replace( 'detail',
				{
			        customConfig : ckeditorConfigFile
			    });
		CKEDITOR.replace( 'feeDescription',
				{
			        customConfig : ckeditorConfigFile
			    });
		CKEDITOR.replace( 'bookingNotice',
				{
			        customConfig : ckeditorConfigFile
			    });
		// 绑定“创建”按钮的click事件
		$("#btnCreate").bind("click", function(){
			createRoute();
		});
		//定期和后台服务器交互，从而防止session失效
		keepSessionAlive();
	});
 	
 	//创建一条经典线路
 	function createRoute(){
 		$('#createRouteForm').form({
 		    url:"/route/newRoute",
 		    onSubmit: function(){
 		        //进行表单验证，如果返回false阻止提交
 		    	var data01 = CKEDITOR.instances.detail.getData();
 		   		alert(data01);
 		   		var data02 = CKEDITOR.instances.feeDescription.getData();
 		   		alert(data02);
 		   		var data03 = CKEDITOR.instances.bookingNotice.getData();
 		   		alert(data03);
 		    },
 		    success:function(data){
 		        alert(data)
 		    }
 		});
 		//提交表单
 		$('#createRouteForm').submit();
 	}
    </script>
</body>
</html>