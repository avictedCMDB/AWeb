package com.avic.supervise.controllers;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.avic.common.constants.SessionKeys;
import com.avic.common.constants.UserRole;
import com.avic.common.exceptions.NoPermissionException;
import com.avic.common.exceptions.UserNotLoginException;
import com.avic.common.utils.ConfigHolder;
import com.avic.common.utils.Permission;
import com.avic.management.models.OffStandardRequire;
import com.avic.supervise.models.CodeList;
import com.avic.supervise.models.Help;
import com.avic.supervise.models.User;
import com.avic.supervise.services.CodeListService;
import com.avic.supervise.services.HelpService;

@Controller
@RequestMapping("/help")
public class HelpController {
    protected static final Log logger = LogFactory.getLog(HelpController.class);

    static final int PAGE_SIZE = 10;

    @Autowired
    HelpService helpService;
    
    @Autowired
    CodeListService codeListService;

    /**
     * 帮助中心列表页面
     */
    @RequestMapping("")
    public String helpList(HttpServletRequest req,Map<String, Object> map, @ModelAttribute("help") Help help, HttpSession httpSession)
            throws UnsupportedEncodingException {
    	logger.info("帮助中心列表");
    	String page = req.getParameter("page");
		
		int pageNum = 1;
		 
        if (StringUtils.isNumeric(page)) {
            pageNum = Integer.parseInt(page);
        }
        
        //查询数量
        int total = helpService.queryHelpCount(help);

        int pages = (int) Math.ceil((double) total / PAGE_SIZE);
        
        if (pageNum > pages) {
            pageNum = pages;
        }
        
        List<Help> helps = new ArrayList<Help>();
       
        help.setPage(pageNum);
        help.setPageSize(PAGE_SIZE);
        helps = helpService.queryHelps(help);
        
        List<CodeList> buyerCodes = new ArrayList<CodeList>();
        buyerCodes = codeListService.getCodeList("HELP_TYPE_BUYER");	
        
        List<CodeList> supCodes = new ArrayList<CodeList>();
        supCodes = codeListService.getCodeList("HELP_TYPE_SUP");	
        
        map.put("buyerCodes", buyerCodes);
        map.put("supCodes", supCodes);
        map.put("helps", helps);
        map.put("help", help);
        map.put("page", pageNum);
        map.put("total", total);
        map.put("pages", pages);
        try {
			map.put("pageAction","supervise/help?title=" + URLEncoder.encode(help.getTitle()==null?"":help.getTitle(), "GBK") 
								+ "&context=" + URLEncoder.encode(help.getContext()==null?"":help.getContext(), "GBK")
								+ "&status=" + URLEncoder.encode(help.getStatus()==null?"":help.getStatus(), "GBK")+ "&page=%PAGE%");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
        return "help/supervise_help";
    }
    
    @RequestMapping("/getHelp")
    @ResponseBody
    public Object getHelp(HttpServletRequest request,@ModelAttribute("help") Help help,HttpSession httpSession) {
        logger.info("查询帮助中心信息");
        Help h = new Help();
        if(!"".equals(help.getId())&&help.getId()!=null){
        	h = helpService.queryHelpById(help);
        }
        return h;
    }
    
    @RequestMapping("/updateStatus")
    public String updateStatus(HttpServletRequest request,@ModelAttribute("help") Help help,RedirectAttributes attr,HttpSession httpSession) {
        logger.info("帮助信息启用或停用");
        helpService.updateHelpStatus(help);
//        attr.addAttribute("searchTitle", help.getSearchTitle());
//        attr.addAttribute("searchContext", help.getSearchContext());
//        attr.addAttribute("searceType", help.getSearceType());
        return "redirect:/supervise/help";
    }
    
    @RequestMapping("/del")
    @ResponseBody
    public Object del(HttpServletRequest request,@ModelAttribute("help") Help help,RedirectAttributes attr,HttpSession httpSession) {
        logger.info("删除帮助");
        helpService.deleteHelp(help);
        Map<String, String> map = new HashMap<String, String>();
        map.put("result", "success");
        return map;
    }
    
    @RequestMapping("/editHelp")
    public String editHelp(HttpServletRequest request,@ModelAttribute("help") Help help,RedirectAttributes attr,HttpSession httpSession) {
        logger.info("编辑帮助中心信息");
        String addOrUpdate = request.getParameter("addOrUpdate");
        if("1".equals(addOrUpdate)){
        	helpService.addHelp(help);
        }else{
        	helpService.updateHelp(help);
        }
//        attr.addAttribute("searchTitle", help.getSearchTitle());
//        attr.addAttribute("searchContext", help.getSearchContext());
//        attr.addAttribute("searceType", help.getSearceType());
        return "redirect:/supervise/help";
    }
    
    @RequestMapping("/uploadFile")  
    @ResponseBody  
    public Object uploadPic(@RequestParam(value = "file", required = false) MultipartFile file,HttpServletRequest request,HttpSession httpSession) throws Exception {  
    	User user = new User();
    	user = (User) request.getSession().getAttribute(SessionKeys.LOGIN_SUPERVISE);
    	String path = request.getSession().getServletContext().getRealPath(ConfigHolder.getInstance().getConfig("help_url"))+ File.separator + user.getUserId();  
        String fileName = file.getOriginalFilename();
        String suffix = "";
        int dot = fileName.lastIndexOf('.'); 
        if ((dot >-1) && (dot < (fileName.length()))) { 
        	suffix = fileName.substring(dot); 
        }
//        String fileNameStr = (new Date().getTime())+fileName;  
        String fileNameStr = new Date().getTime()+suffix;
        File targetFile = new File(path, fileNameStr);  
        if(!targetFile.exists()){  
            targetFile.mkdirs();  
        }  
        //保存  
        try {  
            file.transferTo(targetFile);  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        
        return ConfigHolder.getInstance().getConfig("help_url") + "/" + user.getUserId()+"/"+fileNameStr;  
    }  

    @RequestMapping("/deleteFile")  
    @ResponseBody  
    public Object uploadPic(@RequestParam("fileName")String fileName,HttpServletRequest request,HttpSession httpSession) throws Exception {  
    	Map<String, String> result = new HashMap<String, String>();
    	result.put("status", "success");
    	User user = new User();
    	user = (User) request.getSession().getAttribute(SessionKeys.LOGIN_SUPERVISE);
    	String path = request.getSession().getServletContext().getRealPath(ConfigHolder.getInstance().getConfig("help_url"))+ File.separator + user.getUserId();  
        String sPath = path+ File.separator + fileName;
        try{
        	this.deleteFile(sPath);
        }catch (Exception e) {
        	result.put("status", "fail");
		}
        return result;
    }  
    

    /**
     * 删除单个文件
     * 
     * @param sPath
     *            被删除文件的路径+文件名
     * @return 单个文件删除成功返回true，否则返回false
     */
    public boolean deleteFile(String sPath) {
        Boolean flag = false;
        File file = new File(sPath);
        // 路径为文件且不为空则进行删除
        if (file.isFile() && file.exists()) {
            file.delete();
            flag = true;
        }
        return flag;
    }
    
  //下载
    @RequestMapping("downloadHelp")    
    public ResponseEntity<byte[]> download(@RequestParam("filePath")String filePath,HttpServletRequest request,HttpSession httpSession) throws IOException {    
    	User user = new User();
        user =  (User) request.getSession().getAttribute(SessionKeys.LOGIN_SUPERVISE);
		//添加验证是否存在文件
		Help help = new Help();
		help.setHelpPath(filePath);
		int count = helpService.queryFileEx(help);
		if(count<=0){
			//防止恶意攻击
			return null;
		}
		
    	String path = request.getSession().getServletContext().getRealPath("/")+filePath;  
        String downLoadFileName = filePath.substring(filePath.lastIndexOf("/")+1);
        File file=new File(path);  
        HttpHeaders headers = new HttpHeaders();    
        String fileName=new String(downLoadFileName.getBytes("UTF-8"),"iso-8859-1");//为了解决中文名称乱码问题  
        headers.setContentDispositionFormData("attachment", fileName);   
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);   
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers,  HttpStatus.OK);    
    }
}
