package com.avic.supervise.controllers;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.avic.common.constants.UserRole;
import com.avic.common.exceptions.NoPermissionException;
import com.avic.common.exceptions.UserNotLoginException;
import com.avic.common.utils.ConfigHolder;
import com.avic.common.utils.Permission;
import com.avic.management.models.Audit;
import com.avic.management.services.CommonService;
import com.avic.passport.models.User;
import com.avic.supervise.models.SupplierRecommend;
import com.avic.supervise.services.SupplierRecommendService;

@Controller
@RequestMapping("/supplierReommend")
@Transactional
public class SupplierRecommendController {
    protected static final Log logger = LogFactory.getLog(SupplierRecommendController.class);
    static final int PAGE_SIZE = 10; //每页显示多少条
    @Autowired
    SupplierRecommendService supplierRecommendService;
    
    @SuppressWarnings("unused")
	@RequestMapping("")
    public String index(@ModelAttribute("supplierRecommend") SupplierRecommend supplierRecommend,HttpServletRequest req,Map<String, Object> map,HttpSession httpSession) {
        logger.info("供应商推荐");
        User user = new User();
        /*try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}*/
		String page = req.getParameter("page");
		
		int pageNum = 1;
		 
        if (StringUtils.isNumeric(page)) {
            pageNum = Integer.parseInt(page);
        }
        //查询数量
        int total = supplierRecommendService.querySupplierRecommendsCount(supplierRecommend);

        int pages = (int) Math.ceil((double) total / PAGE_SIZE);
        
        if (pageNum > pages) {
            pageNum = pages;
        }
        List<SupplierRecommend> supplierRecommends = new ArrayList<SupplierRecommend>();
        supplierRecommend.setPage(pageNum);
        supplierRecommend.setPageSize(PAGE_SIZE);
        supplierRecommends = supplierRecommendService.querySupplierRecommends(supplierRecommend);
        
        map.put("supplierRecommends", supplierRecommends);
        map.put("searchSupplierRecommend", supplierRecommend);
        map.put("page", pageNum);
        map.put("total", total);
        map.put("pages", pages);
        map.put("pageAction","supervise/supplierReommend?page=%PAGE%");
        return "business/suppliser/supplier_recommend";
    }
    
    /**
     * 取消推荐供应商 
     */
    @RequestMapping("/cancleRecommend/{supID}")
    public String cancleRecommend(@PathVariable("supID") String supID,HttpServletRequest req,Map<String, Object> map,HttpSession httpSession) {
        logger.info("取消供应商推荐");
        SupplierRecommend sr = new SupplierRecommend();
        sr.setSupID(supID);
        supplierRecommendService.setIfRecommend(sr);
        return "redirect:/supervise/supplierReommend";
    }
    
    /**
     * 跳转设置供应商推荐页面
     */
    @RequestMapping("/setRecommendPage/{supID}")
    public String setRecommendPage(@PathVariable("supID") String supID,HttpServletRequest req,Map<String, Object> map,HttpSession httpSession) {
        logger.info("设置供应商推荐");
        SupplierRecommend sr = new SupplierRecommend();
        sr.setSupID(supID);
        SupplierRecommend supplierRecommend = new SupplierRecommend();
        supplierRecommend = supplierRecommendService.getSupInfoBySupID(sr);
        map.put("supplierRecommend", supplierRecommend);
        return "business/suppliser/supplier_recommend_form";
    }
    
    /**
     * 设置推荐供应商 
     */
    @RequestMapping("/setRecommend")
    @ResponseBody
    public String setRecommend(@ModelAttribute("supplierRecommend")SupplierRecommend supplierRecommend,HttpServletRequest req,Map<String, Object> map,HttpSession httpSession) {
        logger.info("设置供应商推荐");
		//修改供应商推荐时间信息
        supplierRecommendService.updateSupInfoDate(supplierRecommend);       
        int count = supplierRecommendService.getSupInfoExtBySupID(supplierRecommend);
		//判断是否有供应商扩展信息
        if(count>0){
        	//有 删除之前图片  修改扩展图片信息
        	String sPath = supplierRecommendService.getSupInfoExtImgPath(supplierRecommend);
        	deleteFile(sPath);
        	supplierRecommendService.updateSuperviseRecommendExtPic(supplierRecommend);
        }else{
        	//没有 添加供应商扩展信息
        	supplierRecommendService.addSupInfoExt(supplierRecommend);
        }
		        	
		        	
        return "success";
    }
    
    
    @RequestMapping("/uploadPic")  
    @ResponseBody  
    public Object uploadPic(@RequestParam(value = "file", required = false) MultipartFile file,HttpServletRequest request,HttpSession httpSession) throws Exception {  
    	String path = request.getSession().getServletContext().getRealPath(ConfigHolder.getInstance().getConfig("supplier_recommend_url"));  
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
        
        return ConfigHolder.getInstance().getConfig("supplier_recommend_url") + "/" +fileNameStr;  
    }  

    @RequestMapping("/deletePic")  
    @ResponseBody  
    public Object uploadPic(@RequestParam("fileName")String fileName,HttpServletRequest request,HttpSession httpSession) throws Exception {  
    	Map<String, String> result = new HashMap<String, String>();
    	result.put("status", "success");
    	String path = request.getSession().getServletContext().getRealPath(ConfigHolder.getInstance().getConfig("supplier_recommend_url"));  
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
}
