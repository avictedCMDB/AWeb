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

import com.avic.common.constants.UserRole;
import com.avic.common.exceptions.NoPermissionException;
import com.avic.common.exceptions.UserNotLoginException;
import com.avic.common.utils.ConfigHolder;
import com.avic.common.utils.Permission;
import com.avic.management.models.AuditImageInfo;
import com.avic.management.models.VatSpecial;
import com.avic.management.services.CommonService;
import com.avic.management.services.ImageInfoService;
import com.avic.management.services.VatSpecialService;
import com.avic.passport.models.User;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Controller
@RequestMapping("/vat")
@Transactional
public class VatSpecialController {
    protected static final Log logger = LogFactory.getLog(VatSpecialController.class);
    private final String downLoadFileName = "��Ȩί����.doc";
    private final String DOWNLOADPATH = "download";
    @Autowired
    VatSpecialService vatSpecialService;
    @Autowired
    CommonService commonService;
    @Autowired
    ImageInfoService imageInfoService;
    
    private VatSpecial vatSpecial;
    
    @RequestMapping("")
    public String index(HttpServletRequest req,Map<String, Object> map,HttpSession httpSession) {
        logger.info("��Ʊ����");
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
		//��ȡ�ɹ�Ա��Ʊ��Ϣ
		vatSpecial = new VatSpecial();
		vatSpecial.setUserID(user.getUserId());
		vatSpecial = vatSpecialService.queryVatSpecial(vatSpecial);
		List<AuditImageInfo> imageInfo1 = new ArrayList<AuditImageInfo>();
		List<AuditImageInfo> imageInfo2 = new ArrayList<AuditImageInfo>();
		List<AuditImageInfo> imageInfo3 = new ArrayList<AuditImageInfo>();
		if(vatSpecial!=null){
			AuditImageInfo imageInfo = new AuditImageInfo();
			imageInfo.setBusinessID(vatSpecial.getId());
			
			imageInfo.setBusinessType("3");
			imageInfo1 = imageInfoService.queryImages(imageInfo);
			
			imageInfo.setBusinessType("4");
			imageInfo2 = imageInfoService.queryImages(imageInfo);
			
			imageInfo.setBusinessType("5");
			imageInfo3 = imageInfoService.queryImages(imageInfo);
		}
		
        map.put("vatSpecial", vatSpecial);
        map.put("imageInfo1", imageInfo1);
        map.put("imageInfo2", imageInfo2);
        map.put("imageInfo3", imageInfo3);
        return "vatSpecial/management_vat_special";
    }
    
    @RequestMapping("/add")
    public String addVat(@ModelAttribute("vatSpecial")VatSpecial vatSpecial,HttpSession httpSession) {
        logger.info("������Ʊ��Ϣ");
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
        String vatID = commonService.queryIndex();//��ȡ��Ʊid
        vatSpecial.setId(vatID);
        vatSpecial.setUserID(user.getUserId());
        vatSpecialService.addVat(vatSpecial);
        return "redirect:/management/vat";
    }
    
    @RequestMapping("/update")
    public String updateVat(@ModelAttribute("vatSpecial")VatSpecial vatSpecial,HttpSession httpSession) {
        logger.info("�޸���Ʊ��Ϣ");
        @SuppressWarnings("unused")
		User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
		String vatStatus = vatSpecialService.queryVatStatus(vatSpecial);
		if("1".equals(vatStatus)){
			vatSpecial.setAuditStatus("2");
		}
		vatSpecialService.updateVat(vatSpecial);
        return "redirect:/management/vat";
    }
    
    @RequestMapping("/del/{id}")
    public String deleteVat(Map<String, Object> map,@PathVariable("id")String id,HttpSession httpSession) {
        logger.info("ɾ����Ʊ��Ϣ");
        @SuppressWarnings("unused")
		User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
		VatSpecial vatSpecial = new VatSpecial();
		vatSpecial.setId(id);
		vatSpecialService.deleteVat(vatSpecial);
        return "redirect:/management/vat";
    }
    
    //�����ļ�
    @RequestMapping("download")    
    public ResponseEntity<byte[]> download(HttpServletRequest request) throws IOException {    
        String path = request.getSession().getServletContext().getRealPath("/")+DOWNLOADPATH+File.separator+downLoadFileName;  
        File file=new File(path);  
        HttpHeaders headers = new HttpHeaders();    
        String fileName=new String(downLoadFileName.getBytes("UTF-8"),"iso-8859-1");//Ϊ�˽������������������  
        headers.setContentDispositionFormData("attachment", fileName);   
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);   
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers, HttpStatus.OK);    
    }
    
    
    @RequestMapping("/uploadPic")  
    @ResponseBody  
    public Object uploadPic(@RequestParam(value = "file", required = false) MultipartFile file,HttpServletRequest request,HttpSession httpSession) throws Exception {  
    	User user = new User();
    	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
    	String path = request.getSession().getServletContext().getRealPath(ConfigHolder.getInstance().getConfig("vat_url"))+ File.separator + user.getUserId();  
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
        //����  
        try {  
            file.transferTo(targetFile);  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        
        return ConfigHolder.getInstance().getConfig("vat_url") + "/" + user.getUserId()+"/"+fileNameStr;  
    }  

    @RequestMapping("/deletePic")  
    @ResponseBody  
    public Object uploadPic(@RequestParam("fileName")String fileName,HttpServletRequest request,HttpSession httpSession) throws Exception {  
    	Map<String, String> result = new HashMap<String, String>();
    	result.put("status", "success");
    	User user = new User();
    	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
    	String path = request.getSession().getServletContext().getRealPath(ConfigHolder.getInstance().getConfig("vat_url"))+ File.separator + user.getUserId();  
        String sPath = path+ File.separator + fileName;
        try{
        	this.deleteFile(sPath);
        }catch (Exception e) {
        	result.put("status", "fail");
		}
        return result;
    }  
    
    @RequestMapping("/savePic")
    @ResponseBody
    public Object savePic(@RequestParam("businessID") String businessID,@RequestParam("picPath1") String[] picPath1,@RequestParam("picPath2") String[] picPath2,@RequestParam("picPath3") String[] picPath3,HttpSession httpSession) {
        logger.info("������ƱͼƬ��ַ");
        @SuppressWarnings("unused")
		User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
		
		AuditImageInfo imageInfo = new AuditImageInfo();
		imageInfo.setBusinessID(businessID);
		//ɾ����ƱͼƬ
		imageInfoService.deleteVatImage(imageInfo);
		//���ÿ��ͼƬ·��
		for (int i = 0; i < picPath1.length; i++) {
			imageInfo.setBusinessType("3");
			String fullPicPath = ConfigHolder.getInstance().getConfig("vat_url")+ "/" + user.getUserId()+ "/" + picPath1[i];
			imageInfo.setUrl(fullPicPath);
			imageInfoService.addVatImage(imageInfo);
		}
		for (int j = 0; j < picPath2.length; j++) {
			imageInfo.setBusinessType("4");
			String fullPicPath = ConfigHolder.getInstance().getConfig("vat_url")+ "/" + user.getUserId()+ "/" + picPath2[j];
			imageInfo.setUrl(fullPicPath);
			imageInfoService.addVatImage(imageInfo);
		}
		for (int k = 0; k < picPath3.length; k++) {
			imageInfo.setBusinessType("5");
			String fullPicPath = ConfigHolder.getInstance().getConfig("vat_url")+ "/" + user.getUserId()+ "/" + picPath3[k];
			imageInfo.setUrl(fullPicPath);
			imageInfoService.addVatImage(imageInfo);
		}
		vatSpecial = new VatSpecial();
		vatSpecial.setId(businessID);
		String vatStatus = vatSpecialService.queryVatStatus(vatSpecial);
		if("1".equals(vatStatus)){
			vatSpecial.setAuditStatus("2");
		}else{
			vatSpecial.setAuditStatus(vatStatus);
		}
		
		vatSpecialService.updateVatAuditStatus(vatSpecial);
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", "success");
        return map;
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