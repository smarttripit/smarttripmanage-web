package com.smarttrip.manageweb.controller.base;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.smarttrip.platform.file.AliyunFileManager;

/**
 * 文件上传和下载
 * 
 * @author songjie
 *
 */
@Controller
@RequestMapping("/file")
public class FileController {
	private Logger logger = LoggerFactory.getLogger(FileController.class);

	@Autowired
	AliyunFileManager aliyunFileManager;

	/**
	 * ckeditor中的图片上传
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/ckeditorUpload")
	public Map<String, String> ckeditorUpload(HttpServletRequest request, Model model,
			@RequestParam(value = "upload") MultipartFile fileUpload,
			HttpServletResponse response)throws IOException {
		logger.debug("进入ckeditorUpload方法");
		response.setContentType("text/html; charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		String[] allowedFileType = new String[]{"jpg", "jpeg", "png", "gif"};//允许上传的文件类型
		PrintWriter out = response.getWriter();
		Map<String, String> rtn = new HashMap<String, String>();
		rtn.put("status", "success");
		rtn.put("tips", "文件上传成功");
		String fileValidateResult = validateUploadFile(fileUpload, allowedFileType);
		if (!fileValidateResult.equals("ok")) {
			out.println("<script type=\"text/javascript\">");
			out.println("window.alert('"+fileValidateResult+"');");
			out.println("</script>");
		}else{
			String fileId = saveFile(fileUpload);
			//将上传的图片的url返回给ckeditor
			String fileUrl = getOSSBucketUrl() + "/" + fileId;
			String callback = request.getParameter("CKEditorFuncNum");//CKEditorFuncNum是回调时显示的位置，这个参数必须有
			out.println("<script type=\"text/javascript\">");
			out.println("window.parent.CKEDITOR.tools.callFunction(" + callback + ",'" + fileUrl + "',''" + ")");
			out.println("</script>");
		}
		out.flush();
		out.close();
		logger.debug("退出ckeditorUpload方法");
		return rtn;
	}

	/**
	 * 校验文件
	 * @author songjiesdnu@163.com
	 * @param fileUpload
	 * @param allowedFileTypes
	 * @return ok：文件通过校验；否则，返回错误提示信息
	 */
	private String validateUploadFile(MultipartFile fileUpload, String[] allowedFileTypes) {
		if (fileUpload.isEmpty()) {
			logger.info("上传的文件内容为空");
			return "上传的文件内容为空";
		}
		String originalFileName = fileUpload.getOriginalFilename();
		String fileType = originalFileName.substring(originalFileName.lastIndexOf(".") + 1).toLowerCase();
		for(String allowFileType: allowedFileTypes){
			if(fileType.equals(allowFileType)){
				return "ok";
			}
		}
		String allowedFileTypeStr = "";
		for(String allowFileType: allowedFileTypes){
			allowedFileTypeStr += allowFileType + "、";
		}
		allowedFileTypeStr = allowedFileTypeStr.substring(0, allowedFileTypeStr.length()-1).toString();
		return "只允许上传" + allowedFileTypeStr + "文件";
	}

	/**
	 * 保存用户上传的文件到阿里云OSS
	 * @param fileUpload
	 * @return fileId
	 * @throws IOException
	 */
	private String saveFile(MultipartFile fileUpload) throws IOException {
		logger.debug("进入saveFile方法");
		String fileName = fileUpload.getOriginalFilename();
		fileUpload.getContentType();
		String fileId = aliyunFileManager.upload(fileName,
				fileUpload.getBytes());
		logger.debug("退出saveFile方法");
		return fileId;
	}
	
	/**
	 * 获得bucket在阿里云OSS上的域名地址
	 * @author songjiesdnu@163.com
	 * @return 类似于：http://bucket-songjie.oss-cn-beijing.aliyuncs.com
	 */
	private String getOSSBucketUrl(){
		String bucketName = aliyunFileManager.getBucketName();
		String endPoint = aliyunFileManager.getEndpoint();
		return endPoint.substring(0, endPoint.indexOf("//") + 2) + bucketName + "." + endPoint.substring(endPoint.indexOf("//") + 2);
	}
}
