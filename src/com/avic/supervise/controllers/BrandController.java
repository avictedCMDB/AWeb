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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.avic.common.utils.ConfigHolder;
import com.avic.passport.models.User;
import com.avic.supervise.models.Brand;
import com.avic.supervise.services.BrandService;

@Controller
@RequestMapping("/brand")
public class BrandController {
    protected static final Log logger = LogFactory.getLog(BrandController.class);
    
    static final int PAGE_SIZE = 10; //ÿҳ��ʾ������
    @Autowired
    BrandService brandService;
    
    @SuppressWarnings("unused")
	@RequestMapping("")
    public String index(@ModelAttribute("brand") Brand brand,
    		HttpServletRequest req,Map<String, Object> map,HttpSession httpSession) {
        logger.info("Ʒ���Ƽ�");
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
        //��ѯ����
        int total = brandService.queryBrandCount(brand);

        int pages = (int) Math.ceil((double) total / PAGE_SIZE);
        
        if (pageNum > pages) {
            pageNum = pages;
        }
        List<Brand> brandList = new ArrayList<Brand>();
        brand.setPage(pageNum);
        brand.setPageSize(PAGE_SIZE);
        brandList = brandService.queryBrand(brand);
        
        map.put("brands", brandList);
        map.put("searchBrand", brand);
        map.put("page", pageNum);
        map.put("total", total);
        map.put("pages", pages);
        map.put("pageAction","supervise/brand?page=%PAGE%");
        return "/business/brand/brand_recommend";
    }
    
    /**
     * ȡ���Ƽ�Ʒ�� 
     */
    @RequestMapping("/cancleBrand/{bid}")
    public String cancleBrand(@PathVariable("bid") String bid,
    		HttpServletRequest req,Map<String, Object> map,HttpSession httpSession) {
        logger.info("ȡ��Ʒ���Ƽ�");
        Brand bd = new Brand();
        bd.setBid(bid);
        brandService.setIfRecommend(bd);
        return "redirect:/supervise/brand";
    }
    
    /**
     * ��ת����Ʒ���Ƽ�ҳ��
     */
    @RequestMapping("/setBrandPage")
    public String setBrandPage(HttpServletRequest req,Map<String, Object> map,HttpSession httpSession) {
        logger.info("����Ʒ���Ƽ�");
        Brand bd = new Brand();
        bd.setBrand_name(req.getParameter("brand_name"));
        Brand brand = new Brand();
        brand = brandService.getBrandInfoByBid(bd);
        if(brand==null){
        	brand = new Brand();
        	brand.setBrand_name(req.getParameter("brand_name"));
        }
        map.put("brand", brand);
        return "/business/brand/brand_recommend_form";
    }
    
    /**
     * �����Ƽ�Ʒ�� 
     */
    @RequestMapping("/setBrand")
    @ResponseBody
    public String setRecommend(@ModelAttribute("brand")Brand brand,
    		HttpServletRequest req,Map<String, Object> map,HttpSession httpSession) {
        logger.info("����Ʒ���Ƽ�");
		//�޸�Ʒ���Ƽ�ʱ����Ϣ
        brandService.updateBrandInfoDate(brand);
        int count = brandService.getBrandInfoExtByBid(brand);
		//�ж��Ƿ���Ʒ����չ��Ϣ
        if(count>0){
        	//�� ɾ��֮ǰͼƬ  �޸���չͼƬ��Ϣ
        	String sPath = brandService.getBrandInfoExtImgPath(brand);
        	deleteFile(sPath);
        	brandService.updateBrandExtPic(brand);
        }else{
        	//û�� ����Ʒ����չ��Ϣ
        	brandService.addBrandInfoExt(brand);
        }
		        	
		        	
        return "success";
    }
    
    
    @RequestMapping("/uploadPic")
    @ResponseBody  
    public Object uploadPic(@RequestParam(value = "file", required = false) MultipartFile file,
    		HttpServletRequest request,HttpSession httpSession) throws Exception {
    	String path = request.getSession().getServletContext().getRealPath(ConfigHolder.getInstance().getConfig("brand_url"));  
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
        
        return ConfigHolder.getInstance().getConfig("brand_url") + "/" +fileNameStr;  
    }  

    @RequestMapping("/deletePic")  
    @ResponseBody  
    public Object uploadPic(@RequestParam("fileName")String fileName,
    		HttpServletRequest request,HttpSession httpSession) throws Exception {  
    	Map<String, String> result = new HashMap<String, String>();
    	result.put("status", "success");
    	String path = request.getSession().getServletContext().getRealPath(ConfigHolder.getInstance().getConfig("brand_url"));  
        String sPath = path+ File.separator + fileName;
        try{
        	this.deleteFile(sPath);
        }catch (Exception e) {
        	result.put("status", "fail");
		}
        return result;
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