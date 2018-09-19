package com.avic.management.controllers;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.avic.common.constants.UserRole;
import com.avic.common.exceptions.NoPermissionException;
import com.avic.common.exceptions.UserNotLoginException;
import com.avic.common.utils.ConfigHolder;
import com.avic.common.utils.Permission;
import com.avic.management.models.AuditImageInfo;
import com.avic.management.models.CodeList;
import com.avic.management.models.CompanyMyInfo;
import com.avic.management.models.SupArea;
import com.avic.management.models.VatSpecial;
import com.avic.management.services.CodeListService;
import com.avic.management.services.CommonService;
import com.avic.management.services.CompanyMyInfoService;
import com.avic.management.services.ImageInfoService;
import com.avic.management.services.SupAreaService;
import com.avic.management.services.VatSpecialService;
import com.avic.market.cpi.exceptions.NoSuchSupplierException;
import com.avic.market.cpi.exceptions.ServiceExecutionFailedException;
import com.avic.passport.models.User;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Controller
@RequestMapping("/companyMyInfo")
@Transactional
public class CompanyMyInfoController {
    protected static final Log logger = LogFactory.getLog(CompanyMyInfoController.class);
    
    @Autowired
    CompanyMyInfoService companyMyInfoService;
    @Autowired
    CodeListService codeListService;
    
    @Autowired
    SupAreaService areaService;
    
    //�����ϴ����ļ�����
    String fileType = ".gif,.png,.bmp,.jpeg,.jpg";
    //�����ϴ����ļ�����С(100M,��λΪbyte)
    int maxSize = 1024*1024*5;
    
    @RequestMapping("")
    public String index(@Param("witchPage")String witchPage,HttpServletRequest req,Map<String, Object> map,HttpSession httpSession) {
        logger.info("���ع�˾���Ϲ�����Ϣ");
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
		CompanyMyInfo companyMyInfos = new CompanyMyInfo();
		boolean error = false;
		try {
			CompanyMyInfo companyMyInfo = new CompanyMyInfo();
			companyMyInfo.setCreateUser(user.getUserId());
			
			companyMyInfos = companyMyInfoService.queryCompanyMyInfo(companyMyInfo);
			List<CodeList> companyCodes = new ArrayList<CodeList>();
			List<CodeList> userTypeCodes = new ArrayList<CodeList>();
			List<CodeList> managementTypeCodes = new ArrayList<CodeList>();
			CodeList code = new CodeList();
			code.setCodeListType("company_model");
			companyCodes = codeListService.queryCodes(code);
			code.setCodeListType("user_type");
			userTypeCodes = codeListService.queryCodes(code);
			code.setCodeListType("management_type");
			managementTypeCodes = codeListService.queryCodes(code);
			//���ص���
			SupArea supArea = new SupArea();
			List<SupArea> areas = new ArrayList<SupArea>();
			supArea.setSupID("1");
			areas = areaService.queryAreas(supArea);
			
			
	        map.put("companyMyInfo", companyMyInfos);
	        map.put("companyCodes", companyCodes);
	        map.put("userTypeCodes", userTypeCodes);
	        map.put("managementTypeCodes", managementTypeCodes);
	        map.put("areas", areas);
	        map.put("witchPage", witchPage);
		} catch (Exception e) {
			error = true;
			e.printStackTrace();
		}
		
        if("1".equals(witchPage)||"".equals(witchPage)||witchPage == null){
        	return "company/management_myinfo";
        }else if("3".equals(witchPage)){
        	if(error){
        		return "company/management_myinfo03_1";
        	}else{
        		if("1".equals(companyMyInfos.getIfCheck())){
        			
        			map.put("status", "1");
        			map.put("message", "��ҵ��Ϣ�����ͨ�������Խ���ҵ�������");
        		}else if("2".equals(companyMyInfos.getIfCheck())){
        			map.put("status", "2");
        			map.put("message", "��ҵ��Ϣ���δͨ�����ܾ����ɣ�"+companyMyInfos.getCheckInfo()+",������������д��ҵ��Ϣ��");
        		}else{
        			map.put("status", "3");
        			map.put("message", "������ҵ�����ѱ���ɹ��������ĵȴ���ˣ�");
        		}
        		return "company/management_myinfo03";
        	}
        	
        }else{
        	return "company/management_myinfo02";
        }
        
    }
    
    @RequestMapping("/update")
    public String updateCompanyMyInfo(@ModelAttribute("companyMyInfo")CompanyMyInfo companyMyInfo,HttpSession httpSession,RedirectAttributes attr) {
        logger.info("�޸�������Ϣ");
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
		if("".equals(companyMyInfo.getWitchPage())||"2".equals(companyMyInfo.getWitchPage())||companyMyInfo.getWitchPage()==null){
			companyMyInfoService.updateCompanyMyInfo(companyMyInfo);
		}else{
			companyMyInfoService.updateCompanyMyInfo2(companyMyInfo);
		}
		
		attr.addAttribute("witchPage", companyMyInfo.getWitchPage());
        return "redirect:/management/companyMyInfo";
    }
    
    
    
    @RequestMapping("/uploadPic")  
    @ResponseBody  
    public Object uploadPic(@RequestParam(value = "file", required = false) MultipartFile file,HttpServletRequest request,HttpSession httpSession) throws Exception {  
        User user = new User();
    	try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
    	String path = request.getSession().getServletContext().getRealPath(ConfigHolder.getInstance().getConfig("companyMyInfo_url"))+ File.separator + user.getUserId();  
        String fileName = file.getOriginalFilename();
        String suffix = "";
        int dot = fileName.lastIndexOf('.'); 
        if ((dot >-1) && (dot < (fileName.length()))) { 
        	suffix = fileName.substring(dot); 
        }
        if ( !Arrays.<String> asList(fileType.split(",")).contains(suffix.toLowerCase()))
        {
            return "fileNameError";
        }
        
      //�ж��ļ���С�Ƿ���
        if (file.getSize() > maxSize)
        {
            return "fileSizeError";
        }
//        String fileNameStr = (new Date().getTime())+fileName;  
        String fileNameStr = new Date().getTime()+suffix;
        File targetFile = new File(path, fileNameStr);  
        if(!targetFile.exists()){  
            targetFile.mkdirs();  
        }  
        //����  
        try {  
            file.transferTo(targetFile);  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        
        return ConfigHolder.getInstance().getConfig("companyMyInfo_url") + "/" + user.getUserId()+"/"+fileNameStr;  
    }  

    @RequestMapping("/deletePic")  
    @ResponseBody  
    public Object deletePic(@RequestParam("fileName")String fileName,HttpServletRequest request,HttpSession httpSession) throws Exception {  
    	Map<String, String> result = new HashMap<String, String>();
    	result.put("status", "success");
        User user = new User();
    	try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
    	String path = request.getSession().getServletContext().getRealPath(ConfigHolder.getInstance().getConfig("companyMyInfo_url"))+ File.separator + user.getUserId();  
        String sPath = path+ File.separator + fileName;
        try{
        	this.deleteFile(sPath);
        }catch (Exception e) {
        	result.put("status", "fail");
		}
        return result;
    }  
    
    @RequestMapping("/loadSubArea")
    @ResponseBody
    public Object loadAreaLebelTwo(@RequestParam("parentId")String parentId,@RequestParam("supID")String supID) throws NoSuchSupplierException, ServiceExecutionFailedException {
    	SupArea supArea = new SupArea();
    	supArea.setSupParentArea(parentId);
    	if("3".equals(supID)){
    		supArea.setSupID("1");
    	}else{
    		supArea.setSupID(supID);
    	}
    	
        //���ص�����Ϣ
        List<SupArea> areas = new ArrayList<SupArea>();
        areas = areaService.querySubAreas(supArea);
    	return areas;
    }
    
    /**
     * ɾ�������ļ�
     * 
     * @param sPath
     *            ��ɾ���ļ���·��+�ļ���
     * @return �����ļ�ɾ���ɹ�����true�����򷵻�false
     */
    public boolean deleteFile(String sPath) {
        Boolean flag = false;
        File file = new File(sPath);
        // ·��Ϊ�ļ��Ҳ�Ϊ�������ɾ��
        if (file.isFile() && file.exists()) {
            file.delete();
            flag = true;
        }
        return flag;
    }

 }