package com.avic.market.controllers.bid;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.avic.market.models.BidProjMateriel;
import com.avic.market.models.BidProjSubject;
import com.avic.market.models.BidProject;
import com.avic.market.services.BidProjectService;
import com.avic.market.services.CodeListService;
import com.avic.market.services.UserService;
import com.avic.supervise.models.Order;
import com.avic.supplier.utils.NewExcel;

@Controller
@RequestMapping("/bid/notice")
public class NoticeController {
    protected static final Log logger = LogFactory.getLog(IndexController.class);

    @Autowired
    BidProjectService bidProjectService;

    @Autowired
    CodeListService codeListService;

    @Autowired
    UserService userService;

    @RequestMapping("")
    public String index(@RequestParam("projId") String projId, Map<String, Object> map) {
        logger.info("电子竞价-公告");

        BidProject proj = bidProjectService.getProjectById(projId);

        if (proj == null || proj.getNoticeStatus() != 2) {
            throw new IllegalArgumentException("没有该公告");
        }

        proj.setBidCatName(codeListService.getCodeText("BID_CAT", proj.getBidCat()));
        proj.setCurrencyName(codeListService.getCodeText("CURRENCY", proj.getCurrency()));

        Calendar c = Calendar.getInstance();
        c.setTime(proj.getBidStartTime());
        c.add(Calendar.HOUR, -1);

        proj.setClarifyEndTime(c.getTime());

        map.put("proj", proj);
        map.put("subjects", bidProjectService.getSubjects(projId));
        map.put("user", userService.getUserById(proj.getUserId()));

        return "bid/notice";
    }

    @RequestMapping("/export/subject")
    public void exportSubject(@RequestParam("projId") String projId, HttpServletResponse resp) throws IOException {

        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/x-download");

        String filedisplay = "标的" + projId + ".xls";
        filedisplay = URLEncoder.encode(filedisplay, "UTF-8");
        resp.addHeader("Content-Disposition", "attachment;filename=" + filedisplay);

        List<BidProjSubject> subjects = bidProjectService.getSubjects(projId);
        
        if (subjects != null) {

            List<String> columnName = Arrays.asList(new String[] { "序号", "标的编号", "标的名称", "计量单位", "竞价数量", "说明" });

            List<List<String>> values = new ArrayList<List<String>>();
            int idx = 1;
            for (BidProjSubject i : subjects) {
                List<String> item = new ArrayList<String>();
                item.add(String.valueOf(idx++));
                item.add(i.getSubjectId());
                item.add(i.getSubjectName());
                item.add(i.getSubjectUnit());
                item.add(String.valueOf(i.getSubjectNum()));
                item.add(i.getIntro());
                
                values.add(item);
            }
            
            
            NewExcel.createExcel(resp, columnName, values);
        }

    }


    @RequestMapping("/export/mtr")
    public void exportMtr(@RequestParam("projId") String projId, @RequestParam("subjectId") String subjectId, HttpServletResponse resp) throws IOException {

        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/x-download");
        	 String filedisplay = "标的商品.xls";
             filedisplay = URLEncoder.encode(filedisplay, "UTF-8");
             resp.addHeader("Content-Disposition", "attachment;filename=" + filedisplay);

             List<BidProjMateriel> mtrs = bidProjectService.getSubjectMtr(projId, subjectId);
             
             if (mtrs != null) {

                 List<String> columnName = Arrays.asList(new String[] { "物料名称", "数量", "单位", "品牌", "型号", "是否标配", "售后服务", "规格配置" });

                 List<List<String>> values = new ArrayList<List<String>>();
                 int idx = 1;
                 for (BidProjMateriel i : mtrs) {
                     List<String> item = new ArrayList<String>();
                     item.add(i.getMaterName());
                     item.add(String.valueOf(i.getMaterNum()));
                     item.add(i.getMaterUnit());
                     item.add(i.getMaterBrand());
                     item.add(i.getMaterModel());
                     item.add(i.getIfStandard());
                     item.add(i.getSaleService());
                     item.add(i.getSpecConf());
                     
                     values.add(item);
                 }
                 
                 
                 NewExcel.createExcel(resp, columnName, values);
             }
    }
    //临时处理经贸的需求
    @RequestMapping("downloadSpecialFile")    
    public ResponseEntity<byte[]> download(@RequestParam("specialAttachmentPath")String specialAttachmentPath,HttpServletRequest request) throws IOException {    
        String filePath = "/upload/bid/20170802/中航泰德（深圳）海洋工程有限公司通风等生产设备及办公设备竞买公告.docx";
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
