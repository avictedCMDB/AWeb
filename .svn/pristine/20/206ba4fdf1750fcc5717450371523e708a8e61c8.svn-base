package com.avic.common.tlds;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

/**
 * 图片上传Tag
 */
public class ImgUploadTag implements Tag {
	//接收传递进来的PageContext对象 
	private PageContext pageContext;
//	用户标志（与userId文件夹路径有关、配置文件的路径）
	private String mark;
	
	public int doStartTag() throws JspException {
		HttpServletRequest request = (HttpServletRequest)this.pageContext.getRequest();
		StringBuffer html = new StringBuffer();
		try{
			html.append("<iframe id='target_upload' name='target_upload' src='' style='display: none;'></iframe>");
			html.append("<form id='fileUploadForm' name='fileUploadForm' action='"+request.getContextPath()+"/UploadServlet' ");
						html.append("enctype='multipart/form-data' method='post' onsubmit=\"return startUpload('"+request.getContextPath()+"',this);\" target='target_upload'>");
				html.append("<input id='mark' name='mark' type='hidden' value='"+this.getMark()+"'>");
				html.append("<input id='file' name='file' type='file' style='display:none'>");
				html.append("<div class='input-append'>");
					html.append("<input id='photoCover' class='input-large form-control' type='text' style='height:30px;'>"); 
					html.append("<a class='btn btn-default red' onclick=\"$('input[id=file]').click();\">浏览文件</a>");
					html.append("<button type='submit' name='uploadButton' id='uploadButton' class='btn btn-default red' >开始上传</button><span class='blue-text'>支持的图片格式为jpg/jpeg/png/gif/bmp，单个图片需小于2M</span>");
					html.append("<input type='button' name='cancelUploadButton' id='cancelUploadButton' value='取消上传' onclick=\"return cancelUpload('"+request.getContextPath()+"');\" style='display: none;'/>");
				html.append("</div>");
				html.append("<span id='img_check' style='color: red;display: none;'></span></br>");
			
				html.append("<div id='progressBar'></div>");
				html.append("<div class='up_img_list'>");
					html.append("<input id='imgCount' name='imgCount' type='hidden' value='0'/>");
					html.append("<input id='realCount' name='realCount' type='hidden' value='0'/>");
					html.append("<input id='delImgName' name='delImgName' type='hidden' value=''/>");
					html.append("<ul id='imgUl' class='clearfix'>");
					html.append("</ul>");
				html.append("</div>");
			html.append("</form>");
			
			this.pageContext.getOut().print(html.toString());
		}catch(Exception e){
			throw new JspException(e);
		}
		
		return EVAL_PAGE;
	}

	public int doEndTag() throws JspException {
		return EVAL_PAGE;
	}

	public Tag getParent() {
		return null;
	}

	public void release() {
		// TODO Auto-generated method stub
	}

	public void setPageContext(PageContext pageContext) {
		this.pageContext = pageContext;
	}

	public void setParent(Tag arg0) {
		// TODO Auto-generated method stub
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}
}