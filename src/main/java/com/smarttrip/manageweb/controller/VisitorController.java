package com.smarttrip.manageweb.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
}