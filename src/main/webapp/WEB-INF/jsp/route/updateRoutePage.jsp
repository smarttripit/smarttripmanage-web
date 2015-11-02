<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="UTF-8">
<title>修改经典线路</title>
<style type="text/css">
</style>
	<link rel="stylesheet" type="text/css" href="/static/framework/jeasyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/static/framework/jeasyui/themes/icon.css">
	<script type="text/javascript" src="/static/framework/jeasyui/jquery.min.js"></script>
	<script type="text/javascript" src="/static/framework/jeasyui/jquery.easyui.min.js"></script>
	<script src="/static/framework/ckeditor/ckeditor.js"></script>
</head>
<body>
	    <form id="ff" method="post">
        <div>
            <label for="name">Name:</label>
            <input class="easyui-validatebox" type="text" name="name" data-options="required:true" />
        </div>
        <div>
            <label for="email">Email:</label>
            <input class="easyui-validatebox" type="text" name="email" data-options="validType:'email'" />
        </div>
        <textarea rows="30" cols="50" name="editor01">请输入.</textarea>
		<script type="text/javascript">
			CKEDITOR.replace( 'editor01',
					{
				        customConfig : '/static/framework/custom/ckeditor_config.js'
				    });
		</script>
		
		
		
		<textarea rows="30" cols="50" name="editor02">请输入.</textarea>
		<script type="text/javascript">
			CKEDITOR.replace( 'editor02',
					{
				        customConfig : '/static/framework/custom/ckeditor_config.js'
				    });
		</script>
		
		
		
		
		<textarea rows="30" cols="50" name="editor03">请输入.</textarea>
		<script type="text/javascript">
			CKEDITOR.replace( 'editor03',
					{
				        customConfig : '/static/framework/custom/ckeditor_config.js'
				    });
		</script>
    </form>
</body>
</html>