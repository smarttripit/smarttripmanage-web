package com.smarttrip.manageweb.controller.base;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * session相关. <br/>
 * date: 2015年11月2日 下午5:05:49 <br/>
 *
 * @author songjiesdnu@163.com
 */
@Controller
@RequestMapping("/session")
public class SessionController {
	private Logger logger = LoggerFactory.getLogger(SessionController.class);

	/**
	 * 保持session不失效
	 * @author songjiesdnu@163.com
	 * @return
	 */
	@RequestMapping(value = "/keepSessionAlive")
	@ResponseBody
	public boolean keepSessionAlive(HttpSession session){
		logger.debug("进入keepSessionAlive方法");
		session.setAttribute("keepSessionAlive", "");
		logger.debug("退出keepSessionAlive方法");
		return true;
	}
	
}
