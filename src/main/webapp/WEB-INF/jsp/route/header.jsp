<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<link rel="shortcut icon" href="${ctx}/static/images/favicon.ico" />
<link rel="stylesheet" type="text/css" href="${ctx}/static/js/pub/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${ctx}/static/js/pub/jquery-easyui/themes/icon.css">
<link href="${ctx}/static/styles/reset.css" rel="stylesheet" type="text/css">
<%-- <link href="${ctx}/static/styles/global.css" rel="stylesheet" type="text/css"> --%>
<%-- <link href="${ctx}/static/styles/common.css" rel="stylesheet" type="text/css"> --%>
<script type="text/javascript" src="${ctx}/static/js/pub/jquery-easyui/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/pub/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/pub/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
  var ctx = '${ctx}';

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
</script>
<script type="text/javascript" src="${ctx}/static/js/pub/common.js"></script>