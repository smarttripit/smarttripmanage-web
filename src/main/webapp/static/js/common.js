//自定义的ckeditor配置文件路径
var ckeditorConfigFile = "/static/framework/custom/ckeditor_config.js";

// 设置默认ajax请求失败处理方法
$.ajaxSetup({
	error: function(data, status, exception){
		var errorMsg = '';
		if(data && data.responseText){
			errorMsg = (eval('('+data.responseText+')')).string;
			$.messager.alert('错误信息', errorMsg, 'error');
		}
	}
});

// 保持session不失效
function keepSessionAlive(){
	window.setInterval(function(){
		jQuery.ajax({
			type : "POST",
	        async: false,
	        url : "/session/keepSessionAlive",
	        success : function(data) {
	        	alert("success");
	        },
	        error : function(data) {
	        	alert("error");
	        },
	        datatype : "json"
    	});
	},600*1000);
}

//在页面的右下侧显示提示消息
function showSlideMessage(msg){
    $.messager.show({
        title:'提示',
        msg:msg,
        timeout:4000,
        showType:'slide'
    });
}
