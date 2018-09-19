package com.avic.market.controllers.help;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.avic.market.models.CodeList;
import com.avic.market.models.HelpInfo;
import com.avic.market.services.CodeListService;
import com.avic.market.services.HelpInfoService;

@Controller
@RequestMapping("/help")
public class HelpController {
	
    @Autowired
    HelpInfoService helpInfoService;
    
    @Autowired
    CodeListService codeListService;
	
	@RequestMapping("/indexHelpInfo")
    public String indexHelpInfo(HttpServletRequest req, 
    		@ModelAttribute("HelpInfo") HelpInfo helpInfo,
    		Map<String, Object> map) throws UnsupportedEncodingException {
		
		List<HelpInfo> helpList = helpInfoService.queryHelpInfoList(helpInfo);
		
		String page = String.valueOf(helpInfo.getPage());
		
        int total = helpInfoService.queryHelpInfoCount(helpInfo);

        int pages = (int) Math.ceil((double) total / helpInfo.getPageSize());
        
        map.put("pageAction","market/help/indexHelpInfo?"
        		+ "&title="+URLEncoder.encode((helpInfo.getTitle() == null ? "":helpInfo.getTitle()),"GBK")
        		+ "&type=" + helpInfo.getType()
        		+ "&helpTypeBuyer=" + helpInfo.getHelpTypeBuyer()
        		+ "&helpTypeSup=" + helpInfo.getHelpTypeSup()
                + "&page=%PAGE%");
        String CodeListType = "";
        if ("0".equals( helpInfo.getType())) {
        	CodeListType = "HELP_TYPE_BUYER";
		}else {
			CodeListType = "HELP_TYPE_SUP";
		}
        List<CodeList> codeList = codeListService.getCodeListByType(CodeListType);
        map.put("helpTypeList", codeList);
        map.put("page", page);
        map.put("total", total);
        map.put("pages", pages);
        map.put("helpInfo", helpInfo);
		map.put("helpList", helpList);
		map.put("type", helpInfo.getType());
		return "help/bid_help";
	}
	@RequestMapping("/helpInfoDetails")
    public String helpInfoDetails(HttpServletRequest req, 
    		@ModelAttribute("HelpInfo") HelpInfo helpInfo,
    		Map<String, Object> map) throws UnsupportedEncodingException {
		//設置查詢供應商
		
		List<HelpInfo> helpList = helpInfoService.queryHelpInfoList(helpInfo);
		String CodeListType = "";
        if ("0".equals( helpInfo.getType())) {
        	CodeListType = "HELP_TYPE_BUYER";
		}else {
			CodeListType = "HELP_TYPE_SUP";
		}
        List<CodeList> codeList = codeListService.getCodeListByType(CodeListType);
        map.put("helpTypeList", codeList);
		map.put("helpInfo", helpList.get(0));
		map.put("type", helpInfo.getType());
		return "help/bid_help_details";
	}
	@RequestMapping("/indexHelpInfoDownload")
    public String indexHelpInfoDownload(HttpServletRequest req, 
    		@ModelAttribute("HelpInfo") HelpInfo helpInfo,
    		Map<String, Object> map) throws UnsupportedEncodingException {
		
		List<HelpInfo> helpList = helpInfoService.queryHelpInfoList(helpInfo);
		
		String page = String.valueOf(helpInfo.getPage());
		
        int total = helpInfoService.queryHelpInfoCount(helpInfo);

        int pages = (int) Math.ceil((double) total / helpInfo.getPageSize());
        
        map.put("pageAction","market/help/indexHelpInfo?"
        		+ "&title="+URLEncoder.encode((helpInfo.getTitle() == null ? "":helpInfo.getTitle()),"GBK")
        		+ "&type=" + helpInfo.getType()
                + "&page=%PAGE%");
        map.put("page", page);
        map.put("total", total);
        map.put("pages", pages);
        map.put("helpInfo", helpInfo);
		map.put("helpList", helpList);
		map.put("type", helpInfo.getType());
		return "help/bid_help_download";
	}
	/**
	 * 帮助下载
	 * @param reqeust
	 * @param response
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("/downloadHelp")  
    public void downloadFile(HttpServletRequest reqeust,HttpServletResponse response) throws UnsupportedEncodingException{  
        response.setCharacterEncoding("utf-8");  
        response.setContentType("multipart/form-data");  
        String fileName = reqeust.getParameter("downFile");
        String downloadFileName = reqeust.getParameter("fileName");
        System.err.println(fileName);
        String filePath = reqeust.getSession().getServletContext().getRealPath(fileName);
//        fileName = fileName.substring(fileName.lastIndexOf("/")+1,fileName.length());
        response.setHeader("Content-Disposition", "attachment;fileName="+java.net.URLEncoder.encode(downloadFileName, "UTF-8"));  
        try {
            File file=new File(filePath);  
//            System.out.println(file.getAbsolutePath());
            InputStream inputStream=new FileInputStream(file);  
            OutputStream os=response.getOutputStream();  
            byte[] b=new byte[1024];  
            int length;  
            while((length=inputStream.read(b))>0){  
                os.write(b,0,length);  
            }  
            inputStream.close();  
        } catch (FileNotFoundException e) {  
            e.printStackTrace();  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
    }
}
