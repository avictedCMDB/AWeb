package com.avic.market.controllers.bid;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.avic.market.models.BidProject;
import com.avic.market.services.BidProjectService;
import com.avic.market.services.UserService;

@Controller
@RequestMapping("/bid/result")
public class ResultController {
    protected static final Log logger = LogFactory.getLog(ResultController.class);

    @Autowired
    BidProjectService bidProjectService;
    
    @Autowired
    UserService userService;


    @RequestMapping("/{func:[a-z-]+}")
    public String index(@PathVariable("func") String func, @RequestParam("projId") String projId, HttpSession sess, Map<String, Object> map) {
        logger.info("中标通知书页面");

        BidProject proj = bidProjectService.getProjectById(projId);
        if (proj == null || proj.getProjStatus() != 7) {
            map.put("success", false);
            map.put("msg", "非法操作");
            return "bid/join_result";
        }
        
        map.put("proj", proj);
        map.put("subs", bidProjectService.getSubjects(projId));
        map.put("sup", bidProjectService.getAwardSupplier(projId));
        map.put("user", userService.getUserAndCompanyById(proj.getUserId()));
        map.put("now", new Date());
        
        if ("print".equals(func)) {
            return "bid/result_print";
        }
        return "bid/result_show";
    }
    //临时处理经贸的需求
    @RequestMapping("downloadSpecialFile")    
    public ResponseEntity<byte[]> download(@RequestParam("specialAttachmentPath")String specialAttachmentPath,HttpServletRequest request) throws IOException {    
        String filePath = "/upload/bid/20170802/中航泰德（深圳）海洋工程有限公司通风等生产设备及办公设备成交公告.docx";
    	String path = request.getSession().getServletContext().getRealPath("/")+filePath;  
        String downLoadFileName = filePath.substring(filePath.lastIndexOf("/")+1);
        File file=new File(path);  
        HttpHeaders headers = new HttpHeaders();    
        String fileName=new String(downLoadFileName.getBytes("UTF-8"),"iso-8859-1");//为了解决中文名称乱码问题  
        headers.setContentDispositionFormData("attachment", fileName);   
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);   
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers, HttpStatus.OK);    
    }
}
