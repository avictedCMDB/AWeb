package com.avic.supplier.controllers;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.avic.common.constants.SessionKeys;

import com.avic.common.utils.ConfigHolder;

import com.avic.market.cpi.exceptions.NoSuchSupplierException;
import com.avic.market.cpi.exceptions.ServiceExecutionFailedException;
import com.avic.supplier.models.CodeList;
import com.avic.supplier.models.CompanyMyInfo;
import com.avic.supplier.models.SupArea;
import com.avic.supplier.services.CodeListService;
import com.avic.supplier.services.CompanyMyInfoService;
import com.avic.supplier.services.SupAreaService;

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
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        CompanyMyInfo companyMyInfos = new CompanyMyInfo();
		boolean error = false;
		try {
			CompanyMyInfo companyMyInfo = new CompanyMyInfo();
			companyMyInfo.setSupId(supId);
			
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
        	return "supplierMyinfo/supplier_myinfo";
        }else if("3".equals(witchPage)){
        	if(error){
        		return "supplierMyinfo/supplier_myinfo03_1";
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
        		return "supplierMyinfo/supplier_myinfo03";
        	}
        	
        }else{
        	return "supplierMyinfo/supplier_myinfo02";
        }
        
    }
    
    @RequestMapping("/update")
    public String updateCompanyMyInfo(@ModelAttribute("companyMyInfo")CompanyMyInfo companyMyInfo,HttpSession httpSession,RedirectAttributes attr) {
        logger.info("�޸�������Ϣ");
		if("".equals(companyMyInfo.getWitchPage())||"2".equals(companyMyInfo.getWitchPage())||companyMyInfo.getWitchPage()==null){
			companyMyInfoService.updateCompanyMyInfo(companyMyInfo);
		}else{
			companyMyInfoService.updateCompanyMyInfo2(companyMyInfo);
		}
		
		attr.addAttribute("witchPage", companyMyInfo.getWitchPage());
        return "redirect:/supplier/companyMyInfo";
    }
    
    
    
    @RequestMapping("/uploadPic")  
    @ResponseBody  
    public Object uploadPic(@RequestParam(value = "file", required = false) MultipartFile file,HttpServletRequest request,HttpSession httpSession) throws Exception {  
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
    	String path = request.getSession().getServletContext().getRealPath(ConfigHolder.getInstance().getConfig("companyMyInfo_url"))+ File.separator + supId;  
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
        
        return ConfigHolder.getInstance().getConfig("companyMyInfo_url") + "/" + supId+"/"+fileNameStr;  
    }  

    @RequestMapping("/deletePic")  
    @ResponseBody  
    public Object deletePic(@RequestParam("fileName")String fileName,HttpServletRequest request,HttpSession httpSession) throws Exception {  
    	Map<String, String> result = new HashMap<String, String>();
    	result.put("status", "success");
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
    	String path = request.getSession().getServletContext().getRealPath(ConfigHolder.getInstance().getConfig("companyMyInfo_url"))+ File.separator + supId;  
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