<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="common/header.jsp" %>
<title>周游趣后台管理系统登录</title>

<style type="text/css">
.login_inpt li{position:relative;}
.placeholder{position:absolute;text-align:left;padding-left:35px;font-size:14px;color:#B3B3B3;display:block;height:40px;line-height:52px;*top:-8px;*left:5px;}
#appNo{width:200px; height:31px; line-height:31px;}
.combo{ height:31px!important; line-height:31px; width:200px!important; border:1px solid #d8d8d8; border-radius:3px;position:relative;}
.login_inpt li#appLi{line-height:normal;margin-top:9px;}
li#appLi label{text-align:left;font-size:14px;color:#B3B3B3;*top:-8px;*left:5px;}
.combo .combo-text{font-size:14px;color:#B3B3B3; padding-left:10px;position:absolute;top:0;left:0;width:188px!important;}
::-ms-clear { display: none; }
 ::-ms-reveal { display: none; }
.combo-arrow{background-color:#fff; padding:0 10px; position:absolute;right:0;top:0;opacity:1;}.combo-arrow-hover{background:#transparent;}
.classHide{display:none;}
.validatebox-invalid{background-color:#fff}
</style>
</head>
<body onkeydown="bindingEnterKey(event)">
	<div id="loginPage" style="display: none">
		<!-- 头部 开始 -->
		<div split="true" border="false">
			<div style="height:70px;background:#2D3E50;color:white;padding:0 0 0 20px;line-height:65px;font-size:25px;font-family:微软雅黑;">
				<span>周游趣后台管理系统</span>
			</div>
		</div>
		<!-- 头部 结束 -->
		<!-- 内容 开始 -->
		<div class="login_box">
			<div class="logbox_con">
				<p class="login_tit">周游趣</p>
				<p class="login_manage fz-16 text_center">周游趣管理后台</p>
				<form id="loginForm" action="/login/loginSave" method="post" class="form-horizontal">
					<ul class="login_inpt text_center">
						<li>
							<label class="placeholder" for="username">身份证号</label>
							<input class="inp inp_user placeholderInput easyui-validatebox" type="text" value="" id="username" name="username" data-options="required:true,validType:'username'">
						</li>
						<li>
							<label class="placeholder" for="password">密码</label>
							<input class="inp inp_pwd placeholderInput easyui-validatebox" type="password" value="" id="password" name="password" data-options="required:true,validType:'password'">
						</li>
						
					</ul>
					<p class="text_center mt20 mb30">
						<input id="submit_btn" class="btn btn-primary" type="submit" value="登录" />
					</p>
				</form>
			</div>
		</div>
		<!-- 内容 结束 -->
		<!-- 底部 开始 -->
		<div class="footer footer_bor_top">
			<p>周游趣版权所有  | 京ICP备88888888号-8</p>
		</div>
		<!-- 底部 结束 -->
	</div>
	<div id="redirectPage" style="display: none"></div>
	<script>
		$.extend($.fn.validatebox.defaults.rules, {
			username : {
				validator : function(value) {
					var p = new RegExp('[^a-zA-Z0-9]');
					return (value.length >= 1 && value.length <= 20 && !p
							.test(value));
				},
				message : '用户名错误'
			},
			password : {
				validator : function(value) {
					return true;//(value.length>=6 && value.length<=20);
				},
				message : '密码长度错误'
			}
		});

		$(document).ready(function() {
			var p = self.parent;
			while (p.parent && p.parent != p) {
				p = p.parent;
			}
			if (p.closeCurrentTab) {//父页面存在
				$('#redirectPage').removeAttr('style');
				$.messager.alert('错误', '登录超时，请重新登录！', 'error',
						redirect);
			} else {
				$('#loginPage').removeAttr('style');
			}

			$('#loginForm').submit(function(event) {
				if (!$("#loginForm").form("validate")) {
					event.preventDefault();
				}
			});
			
			switchPlaceholder();//清除输入框里的提示信息
		});

		function redirect() {
			var p = self.parent;
			while (p.parent && p.parent != p) {
				p = p.parent;
			}
			p.window.location.href = "${ctx}/home/index";
		};

		 //绑定 按钮 按回车 激发按钮单击事件
		function bindingEnterKey(event) {
			// 保存按钮OJBJECT
			var btnOjb = $("#submit_btn");
			// 点击 Enter按钮
			if (event.keyCode == 13) {
				btnOjb.click();
				event.returnValue = false;
			}
			prevent(event); //文本框、下拉框readonly、disabled时禁用退格键 
		}
		
		//清除输入框里的提示信息
		function switchPlaceholder() {
			$(".placeholderInput").each(function(){
				$(this).focus(function() {
					$(this).prev().css("display", "none");
				});
				$(this).blur(function() {
					if ($(this).val() == "") {
						$(this).prev().css("display", "block");
					}
				});
			});
		}
	</script>
</body>
</html>
