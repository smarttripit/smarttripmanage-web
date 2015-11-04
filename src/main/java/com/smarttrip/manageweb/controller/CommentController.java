package com.smarttrip.manageweb.controller;

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
import com.smarttrip.domain.Comment;
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
	
	@RequestMapping("/getCommentByPage")
	@ResponseBody
	public Map<String, Object> getCommentByPage(@RequestParam(value="page",required=false) int page,
			 @RequestParam(value="rows",required=false) int rows,
			 @RequestParam(value="visitorName",required=false) String visitorName,
			 @RequestParam(value="content",required=false) String content,
			 @RequestParam(value="productType",required=false) String productType,
			 @RequestParam(value="commentBeginTime",required=false) String commentBeginTime,
			 @RequestParam(value="commentEndTime",required=false) String commentEndTime ){
		Map<String, Object> map = new HashMap<String, Object>();
		if(!(commentBeginTime == null || commentBeginTime.equals("")||commentEndTime == null || commentEndTime.equals(""))){
		commentBeginTime = commentBeginTime.replace("-", ":");
		commentEndTime = commentEndTime.replace("-", ":");
		}
		String visitorId =null;
		if(!(visitorName == null|| visitorName.equals(""))){
			visitorId = this.visitorService.selectByName(visitorName).getVisitorId();
		}
		PageInfo<Comment> pageInfo = this.commentService.selectCommentByPage(page,rows,visitorId,content,productType,commentBeginTime,commentEndTime);
		map.put("total", pageInfo.getTotal());
		List<Comment> commentInfos = pageInfo.getList();
		map.put("rows", commentInfos);
		return map;
	}
	
}
