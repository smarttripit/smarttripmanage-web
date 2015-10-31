package com.smarttrip.manageweb.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.smarttrip.domain.Visitor;
import com.smarttrip.manageweb.common.Result;
import com.smarttrip.service.ICommentService;
import com.smarttrip.service.IVisitorService;

@Controller
@RequestMapping("/visitor")
public class VisitorController {
	@Autowired
	private IVisitorService visitorService;
	private ICommentService commentService;
	
	@RequestMapping("/reviseVisitorStatus")
	@ResponseBody
	public Result reviseVisitorStatus(HttpServletRequest request,Model model){
		String visitorId = request.getParameter("visitorId");
		String status = request.getParameter("status");
		Result result = new Result();
		if(visitorId == null ||visitorId.equals("")||status==null||status.equals("")){
			result.setStatus("fail");
			result.setTipMsg("visitId或status为空");
			return result;
		}
		this.visitorService.updateStatusByVisitorId(visitorId,status);
		result.setStatus("success");
		return result;
	}
	
	@RequestMapping("/batchDeleteVisitorComment")
	@ResponseBody
	public Result batchDeleteVisitorComment(HttpServletRequest request,Model model){
		String visitorId = request.getParameter("visitorId");
		String commentId = request.getParameter("commentId");
		Result result = new Result();
		if(visitorId == null ||visitorId.equals("")||commentId==null||commentId.equals("")){
			result.setStatus("fail");
			result.setTipMsg("visitId或status为空");
			return result;
		}
		String[] commentIds = commentId.split(",");
		this.commentService.deleteCommentByVisitorId(visitorId,commentIds);
		result.setData("success");
		return result;	
	}
	
	@RequestMapping("/visitorPage")
	public String visitorPage(HttpServletRequest request,Model model){
		return "visitor/visitorPage";
	}
	@RequestMapping("/getVisitorByPage")
	@ResponseBody
	public Map<String, Object> getVisitorByPage(@RequestParam(value="page",required=false) int page,
			 @RequestParam(value="rows",required=false) int rows,
			 @RequestParam(value="name",required=false) String name,
			 @RequestParam(value="mobileNo",required=false) String mobileNo,
			 @RequestParam(value="email",required=false) String email){
		Map<String, Object> map = new HashMap<String, Object>();
		PageInfo<Visitor> pageInfo = this.visitorService.selectVisitorByPage(page,rows,name,mobileNo,email);
		map.put("total", pageInfo.getTotal());
		List<Visitor> visitorInfos = pageInfo.getList();
		List<Map<String, String>> rowData = new ArrayList<Map<String, String>>();
		for(Visitor visitorInfo : visitorInfos){
			Map<String, String> oneRow = new HashMap<String, String>();
			oneRow.put("name", visitorInfo.getName());
			oneRow.put("realName", visitorInfo.getRealName());
			oneRow.put("email", visitorInfo.getEmail());
			oneRow.put("mobileNo", visitorInfo.getMobileNo());
			rowData.add(oneRow);
		}
		map.put("rows", rowData);
		return map;	
	}


}