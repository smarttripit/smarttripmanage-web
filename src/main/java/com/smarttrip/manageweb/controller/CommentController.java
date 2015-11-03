package com.smarttrip.manageweb.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.smarttrip.manageweb.common.Result;

import com.smarttrip.service.ICommentService;
import com.smarttrip.service.IVisitorService;

@Controller
@RequestMapping("/comment")
public class CommentController {
	@Autowired
	private IVisitorService visitorService;
	private ICommentService commentService;
	
	@RequestMapping("/commentPage")
	public String visitorPage(HttpServletRequest request,Model model){
		return "comment/commentPage";
	}

	@RequestMapping("/batchDeleteComments")
	@ResponseBody
	public Result batchDeleteVisitorComments(HttpServletRequest request,Model model){
		String commentIds = request.getParameter("commentIds");
		Result result = new Result();
		if(commentIds==null||commentIds.equals("")){
			result.setStatus("fail");
			result.setTipMsg("visitId或status为空");
			return result;
		}
		String[] commentId = commentIds.split(",");
		for(String id : commentId){
			this.commentService.deleteByPrimaryKey(id);
		}
		result.setStatus("success");
		return result;	
	}
}
