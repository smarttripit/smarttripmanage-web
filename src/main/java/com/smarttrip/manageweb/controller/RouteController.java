package com.smarttrip.manageweb.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.smarttrip.domain.User;
import com.smarttrip.manageweb.common.Result;
import com.smarttrip.service.IRouteService;
import com.smarttrip.service.IUserService;


@Controller
@RequestMapping("/route")
public class RouteController {
	private Logger logger = LoggerFactory.getLogger(RouteController.class);
	@Autowired
	private IUserService userService;
	@Autowired
	private IRouteService routeService;
	
	
	/**
	 * 显示经典线路列表
	 * @author songjiesdnu@163.com
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/listPage")
	public String listPage(HttpServletRequest request,Model model){
		return "route/listPage";
	}
	
	@RequestMapping("/getByPage")
	@ResponseBody
	public Map<String, Object> getByPage(@RequestParam(value="page",required=false) int page,
										 @RequestParam(value="rows",required=false) int rows){
		logger.debug("进入getByPage方法");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", 201);
		
		List rowData = new ArrayList();
		for(int i=0; i<rows; i++){
			Map<String, String> oneRow = new HashMap<String, String>();
			oneRow.put("name", "爨底下黄岭西");
			oneRow.put("feature", "农村特色农村特色农村特色农村特色农村特色农村特色");
			oneRow.put("theme", "农村-亲子");
			oneRow.put("region", "北京-门头沟");
			oneRow.put("period", "2");
			oneRow.put("commentCount", "134");
			oneRow.put("commetRatio", "99%");
			oneRow.put("purchaseCount", "344");
			oneRow.put("displayOrder", "99");
			oneRow.put("status", "正常");
			rowData.add(oneRow);
			
		}
		 map.put("rows", rowData);
		
		logger.debug("退出getByPage方法");
		return map;
		/*Result rtn = new Result();
		rtn.setStatus("success");
		Map<String, String> data = new HashMap<String, String>();
		data.put("","");
		return rtn;*/
	}
	
	/**
	 * 根据线路的id将一条线路停用/启用
	 * @author gaoweibupt@gmail.com
	 * 
	 * */
	@RequestMapping("/reviseStatus")
	@ResponseBody
	public Result deleteRouteById(HttpServletRequest request,Model model){
		Result result = new Result();
		String routeId = request.getParameter("routeId");
		String statusString = request.getParameter("status");
		char status = statusString.charAt(0);
		if (routeService.updateStatusByRouteId(routeId, status) == 1){
			return result;
		}
		else{
			result.setStatus("failed");
			return result;
		}
	}
	
	/**
	 * 新建一个经典路线，但是不包含其行程信息
	 * 
	 * @author gaoweibupt@gmail.com
	 * */
//	@RequestMapping("/newRoute")
//	@ResponseBody
//	public Result newRoute(HttpServletRequest request,Model model){
//		
//	}
	
}
