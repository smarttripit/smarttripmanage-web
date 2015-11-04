package com.smarttrip.manageweb.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.smarttrip.manageweb.common.Result;

/**
 * 
 * 登录. <br/>
 * date: 2015年11月4日 下午3:28:06 <br/>
 *
 * @author songjiesdnu@163.com
 */
@Controller
@RequestMapping("/login")
public class LoginController {
	private Logger logger = LoggerFactory.getLogger(LoginController.class);
	/**
	 * 跳转到登录页面
	 * @author songjiesdnu@163.com
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String login(HttpServletRequest request,Model model){
		logger.debug("进入login方法");
		String contextPath = request.getContextPath();
		model.addAttribute("contextPath", contextPath);
		logger.debug("退出login方法");
		return "login";
	}
	
	/**
	 * 使用户登录
	 * @author songjiesdnu@163.com
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("loginSave")
	@ResponseBody
	public Result loginSave(HttpServletRequest request,Model model,HttpSession session,
							@RequestParam(value="username") String username, 
							@RequestParam(value="password") String password){
		logger.debug("进入loginSave方法");
		Result result = new Result();
		logger.debug("username={};password={}", username, password);
		if(username == null || username.equals("") || password == null || password.equals("")){
			result.setStatus(Result.FAILED);
			result.setTipCode("empty");
			result.setTipMsg("用户名或密码为空");
		}else{
			//tdb:检查用户名和密码是否匹配
		}
		
		logger.debug("退出loginSave方法");
		return result;
	}
}
