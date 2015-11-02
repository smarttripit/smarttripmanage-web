package com.smarttrip.manageweb.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.smarttrip.domain.Comment;
import com.smarttrip.domain.Visitor;
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

//	@RequestMapping("/getCommentByPage")
//	@ResponseBody
//	public Map<String, Object> getVisitorByPage(@RequestParam(value="page",required=false) int page,
//			 @RequestParam(value="rows",required=false) int rows,
//			 @RequestParam(value="userName",required=false) String userName,
//			 @RequestParam(value="content",required=false) String content,
//			 @RequestParam(value="commentTime",required=false) String commentTime){
//		Map<String, Object> map = new HashMap<String, Object>();
//		Pattern patternPhone = Pattern.compile("^1[34589]\\d{9}$");
//		Matcher matcherPhone = patternPhone.matcher(userName);
//		Pattern patternEmail = Pattern.compile("^[0-9a-zA-Z_]+@[0-9a-zA-Z]+\\.[a-zA-Z]+$");
//		Matcher matcherEmail = patternEmail.matcher(userName);
//		Visitor visitor = new Visitor();
//		if(matcherPhone.matches()){
//			visitor = this.visitorService.selectByMobileNo(userName);	
//		}else if(matcherEmail.matches()){
//			visitor = this.visitorService.selectByEmail(userName);
//		}else{
//			visitor = this.visitorService.selectByName(userName);
//		}
//		String visitorId = visitor.getVisitorId();
//		PageInfo<Comment> pageInfo = this.commentService.selectCommentByPage(page,rows,visitorId,content,commentTime);
//		map.put("total", pageInfo.getTotal());
//		List<Comment> commentInfos = pageInfo.getList();
//		map.put("rows", commentInfos);
//		return map;	
//	}
}
