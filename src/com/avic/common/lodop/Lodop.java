package com.avic.common.lodop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import com.avic.common.utils.CommonFileUtils;

@Controller
@RequestMapping("/lodop")
public class Lodop {
    protected static final Log logger = LogFactory.getLog(Lodop.class);
    static final String LODOP32_NAME = "install_lodop32.exe"; 
    static final String LODOP64_NAME = "install_lodop64.exe";
    static final String LODOPUP32_NAME = "install_lodopup32.exe"; 
    static final String LODOPUP64_NAME = "install_lodopup64.exe";
    
    @RequestMapping("/downloadLodop32/{type}")
    public String downloadLodop32(@PathVariable("type")String type,HttpServletResponse response,HttpServletRequest request) {
    	String storeName = "";  
        String realName = "";
    	if("1".equals(type)){
    		storeName = LODOP32_NAME;  
            realName = LODOP32_NAME;  
    	}else if("2".equals(type)){
    		storeName = LODOPUP32_NAME;  
            realName = LODOPUP32_NAME;  
    	}else if("3".equals(type)){
    		storeName = LODOP64_NAME;  
            realName = LODOP64_NAME;  
    	}else{
    		storeName = LODOP64_NAME;  
            realName = LODOP64_NAME;  
    	}
    	
    	
        String contentType = "application/octet-stream";  
  
        try {
			CommonFileUtils.download(request, response, storeName, contentType,realName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/management/compare/detail";
    }
    
}
