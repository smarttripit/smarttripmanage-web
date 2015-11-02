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

