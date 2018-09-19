package com.avic.supervise.controllers;

import java.io.OutputStream;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.xhtmlrenderer.pdf.ITextFontResolver;
import org.xhtmlrenderer.pdf.ITextRenderer;

import com.avic.common.beans.ResultObject;
import com.avic.common.constants.SessionKeys;
import com.avic.common.constants.UserRole;
import com.avic.common.exceptions.NoPermissionException;
import com.avic.common.exceptions.UserNotLoginException;
import com.avic.common.utils.Permission;
import com.avic.management.models.BidMessage;
import com.avic.management.models.BidProjSupplier;
import com.avic.management.models.BidProject;
import com.avic.management.models.BidSupplierQuota;
import com.avic.supervise.models.User;
import com.avic.management.services.SupInfoService;
import com.avic.supervise.services.CodeListService;
import com.avic.supervise.services.UserService;
import com.avic.supervise.services.bid.BidMessageService;
import com.avic.supervise.services.bid.BidProjectService;
import com.avic.supervise.services.bid.BidQuotaService;
import com.avic.supervise.services.bid.BidSupplierService;
import com.lowagie.text.pdf.BaseFont;

@Controller
@RequestMapping("/bid/project")
public class ProjectController {
    protected static final Log logger = LogFactory.getLog(ProjectController.class);
    

    @Autowired
    CodeListService codeListService;
    
    @Autowired
    BidProjectService bidProjectService;
    
    @Autowired
    BidSupplierService bidSupplierService;
    
    @Autowired
    BidQuotaService bidQuotaService;
    
    @Autowired
    UserService userService;
    
    @Autowired
    BidMessageService bidMessageService;
//    
//    @Autowired
//    SupInfoService supInfoService;
    

    @RequestMapping("")
    public String index(HttpSession sess, Map<String, Object> map) {
        logger.info("我的项目");
//        User user = null;
//        try {
//            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
//        } catch (UserNotLoginException e) {
//            return "redirect:/passport/login";
//        } catch (NoPermissionException e) {
//            return "redirect:/passport/login";
//        }
//        CodeList param = new CodeList();

        List<com.avic.supervise.models.CodeList> cats = codeListService.getCodeList("BID_CAT");

        map.put("cats", cats);

        return "bid/project";
    }
    

    static final int PAGE_SIZE = 10;


    @RequestMapping("/query")
    @ResponseBody
    public ResultObject query(@RequestParam(value="projId", defaultValue="") String projId,
            @RequestParam(value="projName", defaultValue="") String projName,
            @RequestParam(value="bidCat", defaultValue="") String bidCat,
            @RequestParam(value="createTime", defaultValue="") String createTime,
            @RequestParam(value="projStatus", defaultValue="") String projStatus,
            @RequestParam(value="page", defaultValue="1") int page,
            HttpSession sess) {
//        User user = null;
//        try {
//            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
//        } catch (Exception e) {
//            return new ResultObject(ResultObject.FAIL, "未登录或无权限");
//        }
		User user = (User) sess.getAttribute(SessionKeys.LOGIN_SUPERVISE);
    	String companyId = user.getCompanyId();
        List<String> status = new ArrayList<String>();
        int order = 0;
        
        if ("1".equals(projStatus)) {
            status.add("2");
            status.add("3");
        } else if ("2".equals(projStatus)) {
            status.add("1");
        } else {
            status.add("4");
            status.add("5");
            status.add("6");
            status.add("7");
            status.add("8");
            status.add("9");
            order = 1;
        }

        int total = bidProjectService.queryProjectCount("", projId, projName, bidCat, createTime, status,companyId);

        int pages = (int) Math.ceil((double) total / PAGE_SIZE);

        if (page > pages) {
            page = pages;
        }

        Map<String, Object> map = new HashMap<String, Object>();
        if (total > 0) {
            map.put("data", bidProjectService.queryProjectList("", projId, projName, bidCat, createTime, status, order, page, PAGE_SIZE,companyId));
        }
        map.put("pages", pages);
        return new ResultObject(ResultObject.OK, map);
    }


    @RequestMapping("/publish")
    @ResponseBody
    public ResultObject publish(@RequestParam("projId") String projId, HttpSession sess) {

//        User user = null;
//        try {
//            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
//        } catch (Exception e) {
//            return new ResultObject(ResultObject.FAIL, "未登录或无权限");
//        }
        
//        BidProject proj = bidProjectService.queryProjectById(projId);
        
//        if (proj == null || !proj.getUserId().equals(user.getUserId())) {
//            return new ResultObject(ResultObject.FAIL, "项目不存在");
//        }
        
        bidProjectService.updatePublish(projId);

        return new ResultObject(ResultObject.OK, "");
    }
    


    @RequestMapping("/del")
    @ResponseBody
    public ResultObject del(@RequestParam("projId") String projId, HttpSession sess) {

//        User user = null;
//        try {
//            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
//        } catch (Exception e) {
//            return new ResultObject(ResultObject.FAIL, "未登录或无权限");
//        }
        
        BidProject proj = bidProjectService.queryProjectById(projId);
        
//        if (proj == null || !proj.getUserId().equals(user.getUserId()) || proj.getProjStatus() != 1) {
//            return new ResultObject(ResultObject.FAIL, "项目不存在");
//        }
        
        bidProjectService.deleteProject(projId);

        return new ResultObject(ResultObject.OK, "");
    }
    
    @RequestMapping("/hall")
    public String hall(@RequestParam("projId") String projId, HttpSession sess, Map<String, Object> map) {
        logger.info("竞价大厅");
//        User user = null;
//        try {
//            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
//        } catch (UserNotLoginException e) {
//            return "redirect:/passport/login";
//        } catch (NoPermissionException e) {
//            return "redirect:/passport/login";
//        }

        BidProject proj = bidProjectService.queryProjectById(projId);
//        if (proj == null || !proj.getUserId().equals(user.getUserId())) {
//            throw new IllegalArgumentException();
//        }
        proj.setCurrencyName(codeListService.getCodeList("CURRENCY").get(0).getCodeValue());
        map.put("proj", proj);
        map.put("sups", bidSupplierService.queryAuditPassSupByProj(projId, null));
        
        if (proj.getProjStatus() != 2 && proj.getProjStatus() != 3) {
            map.put("disable", "disable");
            map.put("sta", "竞价已结束");
            map.put("time", "0");
            return "bid/project_hall";
        }
        
        Date now = new Date();
        
        // 试竞价
        if (now.getTime() <= proj.getTrialEndTime().getTime()) {
            
            map.put("sta", "试竞价");
            map.put("time", proj.getTrialEndTime().getTime() - now.getTime());
            
            return "bid/project_hall";
        }
        
        // 正式竞价
        if (now.getTime() <= proj.getTimeoutEndTime().getTime()) {
            
            if (now.getTime() >= proj.getBidStartTime().getTime() && now.getTime() <= proj.getBidEndTime().getTime()) {
                map.put("sta", "正式竞价");
                map.put("time", proj.getBidEndTime().getTime() - now.getTime());
            } else if (now.after(proj.getBidEndTime())) {
                map.put("sta", "超时竞价");
                map.put("time", proj.getTimeoutEndTime().getTime() - now.getTime());
            } else {
                map.put("sta", "等待竞价开始");
                map.put("disable", "disable");
                map.put("waiting", "waiting");
                map.put("time", proj.getBidStartTime().getTime() - now.getTime());
            }

            return "bid/project_hall";
        }
        map.put("disable", "disable");
        map.put("sta", "竞价已结束");
        map.put("time", "0");

        return "bid/project_hall";
    }


    @RequestMapping("/hall/msg/data")
    @ResponseBody
    public ResultObject hallMsgData(@RequestParam("projId") String projId, @RequestParam("msgId") int msgId, HttpSession sess, Map<String, Object> map) {
//        User user = null;
//        try {
//            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
//        } catch (UserNotLoginException e) {
//            return new ResultObject(ResultObject.FAIL, "未登录或无权限");
//        }

        BidProject proj = bidProjectService.queryProjectById(projId);
//        if (proj == null || !proj.getUserId().equals(user.getUserId())) {
//            throw new IllegalArgumentException();
//        }
        
        if (proj.getProjStatus() != 2 && proj.getProjStatus() != 3 && proj.getProjStatus() != 4) {
            return new ResultObject(ResultObject.FAIL, "竞价已结束");
        }
        

        
        Date now = new Date();
        
        int type = 0;

        // 试竞价
        if (now.getTime() <= proj.getTrialEndTime().getTime()) {
            type = 1;
        }
        
        // 正式竞价
        if (now.getTime() >= proj.getBidStartTime().getTime()) {
            type = 2;
        }
        return new ResultObject(ResultObject.OK, bidMessageService.queryMessageList(projId, type, msgId));
    }
    


    @RequestMapping("/hall/msg/send")
    @ResponseBody
    public ResultObject hallMsgSend(@RequestParam("projId") String projId, @RequestParam(value="supCode", defaultValue="0") String supCode, @RequestParam("msgContent") String msgContent, HttpSession sess, Map<String, Object> map) {
//        User user = null;
//        try {
//            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
//        } catch (UserNotLoginException e) {
//            return new ResultObject(ResultObject.FAIL, "未登录或无权限");
//        }

        BidProject proj = bidProjectService.queryProjectById(projId);
//        if (proj == null || !proj.getUserId().equals(user.getUserId())) {
//            throw new IllegalArgumentException();
//        }
        
        if (proj.getProjStatus() != 2 && proj.getProjStatus() != 3 && proj.getProjStatus() != 4) {
            return new ResultObject(ResultObject.FAIL, "竞价已结束");
        }

        Date now = new Date();

        BidMessage message = new BidMessage();
        message.setMsgContent(msgContent);
        message.setProjId(projId);
        message.setSupCode(supCode);
        message.setSendType(2);
        message.setSendTime(now);
        

        // 试竞价
        if (now.getTime() <= proj.getTrialEndTime().getTime()) {
            message.setMsgType(1);
        }
        
        // 正式竞价
        if (now.getTime() >= proj.getBidStartTime().getTime()) {
            message.setMsgType(2);
        }
        
        if (message.getMsgType() == 0) {
            return new ResultObject(ResultObject.FAIL, "非法操作");
        }
        
        bidMessageService.insertMessage(message);
        
        return new ResultObject(ResultObject.OK, message);
    }
    

    @RequestMapping("/hall/sup")
    @ResponseBody
    public ResultObject hallSup(@RequestParam("projId") String projId, @RequestParam("supName") String supName, HttpSession sess, Map<String, Object> map) {
//        User user = null;
//        try {
//            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
//        } catch (UserNotLoginException e) {
//            return new ResultObject(ResultObject.FAIL, "未登录或无权限");
//        }

        BidProject proj = bidProjectService.queryProjectById(projId);
//        if (proj == null || !proj.getUserId().equals(user.getUserId())) {
//            throw new IllegalArgumentException();
//        }
        
        if (proj.getProjStatus() != 2 && proj.getProjStatus() != 3) {
            return new ResultObject(ResultObject.FAIL, "竞价已结束");
        }
        
        Date now = new Date();
        int type = 0;
        // 试竞价
        if (now.getTime() <= proj.getTrialEndTime().getTime()) {
            type = 1;
        }
        
        // 正式竞价
        if (now.getTime() >= proj.getBidStartTime().getTime() && now.getTime() <= proj.getTimeoutEndTime().getTime()) {
            type = 2;
        }
        
        if (type == 0) {
            new ResultObject(ResultObject.OK, "");
        }
        
        List<BidProjSupplier> list = bidSupplierService.queryAuditPassSupByProj(projId, supName);
        
        if (list != null && list.size() > 0) {
            for (BidProjSupplier i : list) {
                i.setBan(type == 2 ? i.getRealBan() : i.getTrialBan());
            }
        }
        
        return new ResultObject(ResultObject.OK, list);
    }
    

    @RequestMapping("/hall/sup/on")
    @ResponseBody
    public ResultObject hallSupOn(@RequestParam("projId") String projId, @RequestParam("supCode") String supCode, HttpSession sess, Map<String, Object> map) {
//        User user = null;
//        try {
//            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
//        } catch (UserNotLoginException e) {
//            return new ResultObject(ResultObject.FAIL, "未登录或无权限");
//        }

        BidProject proj = bidProjectService.queryProjectById(projId);
//        if (proj == null || !proj.getUserId().equals(user.getUserId())) {
//            throw new IllegalArgumentException();
//        }
        
        if (proj.getProjStatus() != 2 && proj.getProjStatus() != 3) {
            return new ResultObject(ResultObject.FAIL, "竞价已结束");
        }
        
        Date now = new Date();

        // 试竞价
        if (now.getTime() <= proj.getTrialEndTime().getTime()) {
            bidSupplierService.updateSupplierTrialBan(projId, supCode, 0);
        }
        
        // 正式竞价
        if (now.getTime() >= proj.getBidStartTime().getTime() && now.getTime() <= proj.getTimeoutEndTime().getTime()) {
            bidSupplierService.updateSupplierRealBan(projId, supCode, 0);
        }
        
        return new ResultObject(ResultObject.OK, "");
    }


    @RequestMapping("/hall/sup/off")
    @ResponseBody
    public ResultObject hallSupOff(@RequestParam("projId") String projId, @RequestParam("supCode") String supCode, HttpSession sess, Map<String, Object> map) {
//        User user = null;
//        try {
//            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
//        } catch (UserNotLoginException e) {
//            return new ResultObject(ResultObject.FAIL, "未登录或无权限");
//        }

        BidProject proj = bidProjectService.queryProjectById(projId);
//        if (proj == null || !proj.getUserId().equals(user.getUserId())) {
//            throw new IllegalArgumentException();
//        }
        
        if (proj.getProjStatus() != 2 && proj.getProjStatus() != 3) {
            return new ResultObject(ResultObject.FAIL, "竞价已结束");
        }
        
        Date now = new Date();

        // 试竞价
        if (now.getTime() <= proj.getTrialEndTime().getTime()) {
            bidSupplierService.updateSupplierTrialBan(projId, supCode, 1);
        }
        
        // 正式竞价
        if (now.getTime() >= proj.getBidStartTime().getTime() && now.getTime() <= proj.getTimeoutEndTime().getTime()) {
            bidSupplierService.updateSupplierRealBan(projId, supCode, 1);
        }
        
        return new ResultObject(ResultObject.OK, "");
    }

    @RequestMapping("/hall/data")
    @ResponseBody
    public ResultObject hallData(@RequestParam("projId") String projId, HttpSession sess) {
//        User user = null;
//        try {
//            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
//        } catch (UserNotLoginException e) {
//            return new ResultObject(ResultObject.FAIL, "未登录或无权限");
//        }

        BidProject proj = bidProjectService.queryProjectById(projId);
//        if (proj == null || !proj.getUserId().equals(user.getUserId())) {
//            throw new IllegalArgumentException();
//        }
        
        Date now = new Date();
        
        int type = 0;

        // 试竞价
        if (now.getTime() <= proj.getTrialEndTime().getTime()) {
            type = 1;
        }
        
        // 正式竞价
        if (now.getTime() >= proj.getBidStartTime().getTime()) {
            type = 2;
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("quotas", bidQuotaService.queryQuotaListByProj(projId, type));
        map.put("sups", bidSupplierService.queryLoginSupplier(projId, type));
        
        return new ResultObject(ResultObject.OK, map);
    }
    
    @RequestMapping("/award")
    public String award(@RequestParam("projId") String projId, HttpSession sess, Map<String, Object> map) {
        logger.info("授标页面");
//        User user = null;
//        try {
//            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
//        } catch (UserNotLoginException e) {
//            return "redirect:/passport/login";
//        } catch (NoPermissionException e) {
//            return "redirect:/passport/login";
//        }

        BidProject proj = bidProjectService.queryProjectById(projId);
//        if (proj == null || !proj.getUserId().equals(user.getUserId()) || proj.getProjStatus() < 4) {
//            throw new IllegalArgumentException();
//        }
        
        map.put("proj", proj);
        map.put("sups", bidSupplierService.queryQuateSupplier(projId));
        map.put("title", "项目授标");
        map.put("action", "award");
        map.put("now", new Date());
        try {
            map.put("quotas", new ObjectMapper().writeValueAsString(bidQuotaService.queryQuotaListByProj(projId, 2)));
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return "bid/project_award";
    }
    
    


    @RequestMapping("/award/submit")
    @ResponseBody
    public ResultObject awardSubmit(@RequestParam("projId") String projId, @RequestParam("supCode") String supCode, HttpSession sess, Map<String, Object> map) {
//        User user = null;
//        try {
//            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
//        } catch (UserNotLoginException e) {
//            return new ResultObject(ResultObject.FAIL, "未登录或无权限");
//        }

        BidProject proj = bidProjectService.queryProjectById(projId);
//        if (proj == null || !proj.getUserId().equals(user.getUserId()) || (proj.getProjStatus() != 4 && proj.getProjStatus() != 8)) {
//            throw new IllegalArgumentException();
//        }

//        bidProjectService.updateProjectAward(projId, supCode, null);
        
        return new ResultObject(ResultObject.OK, "");
    }
    
    @RequestMapping("/view")
    public String view(@RequestParam("projId") String projId, HttpSession sess, Map<String, Object> map) {
        logger.info("授标查看页面");
//        User user = null;
//        try {
//            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
//        } catch (UserNotLoginException e) {
//            return "redirect:/passport/login";
//        } catch (NoPermissionException e) {
//            return "redirect:/passport/login";
//        }

        BidProject proj = bidProjectService.queryProjectById(projId);
//        if (proj == null || !proj.getUserId().equals(user.getUserId()) || proj.getProjStatus() < 4) {
//            throw new IllegalArgumentException();
//        }
        
        map.put("proj", proj);
        map.put("sups", bidSupplierService.queryQuateSupplier(projId));
        map.put("title", "项目查看");
        map.put("action", "view");
        try {
            map.put("quotas", new ObjectMapper().writeValueAsString(bidQuotaService.queryQuotaListByProj(projId, 2)));
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return "bid/project_award";
    }
    
    @RequestMapping("/obsolete")
    public String obsolete(@RequestParam("projId") String projId, HttpSession sess, Map<String, Object> map) {
        logger.info("终止页面");
//        User user = null;
//        try {
//            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
//        } catch (UserNotLoginException e) {
//            return "redirect:/passport/login";
//        } catch (NoPermissionException e) {
//            return "redirect:/passport/login";
//        }

        BidProject proj = bidProjectService.queryProjectById(projId);
//        if (proj == null || !proj.getUserId().equals(user.getUserId()) || proj.getProjStatus() < 4) {
//            throw new IllegalArgumentException();
//        }
        
        map.put("proj", proj);
        map.put("sups", bidSupplierService.queryQuateSupplier(projId));
        map.put("title", "项目终止");
        map.put("action", "obsolete");
        try {
            map.put("quotas", new ObjectMapper().writeValueAsString(bidQuotaService.queryQuotaListByProj(projId, 2)));
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return "bid/project_award";
    }


    @RequestMapping("/obsolete/submit")
    @ResponseBody
    public ResultObject obsoleteSubmit(@RequestParam("projId") String projId, @RequestParam("reason") String reason, HttpSession sess, Map<String, Object> map) {
        User user = null;
//        try {
//            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
//        } catch (UserNotLoginException e) {
//            return new ResultObject(ResultObject.FAIL, "未登录或无权限");
//        }

        BidProject proj = bidProjectService.queryProjectById(projId);
//        if (proj == null || !proj.getUserId().equals(user.getUserId()) || (proj.getProjStatus() != 4 && proj.getProjStatus() != 5 && proj.getProjStatus() != 8)) {
//            throw new IllegalArgumentException();
//        }

        bidProjectService.updateProjectObsolete(projId, reason);
        
        return new ResultObject(ResultObject.OK, "");
    }
    

    
    @RequestMapping("/notice")
    public String notice(@RequestParam("projId") String projId, HttpSession sess, Map<String, Object> map) {
        logger.info("中标通知书页面");
        User user = null;
//        try {
//            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
//        } catch (UserNotLoginException e) {
//            return "redirect:/passport/login";
//        } catch (NoPermissionException e) {
//            return "redirect:/passport/login";
//        }

        BidProject proj = bidProjectService.queryProjectById(projId);
//        if (proj == null || !proj.getUserId().equals(user.getUserId()) || proj.getProjStatus() < 5 || proj.getProjStatus() == 6) {
//            throw new IllegalArgumentException();
//        }
        
        map.put("proj", proj);
        map.put("subs", bidProjectService.querySubjectList(projId));
        map.put("sup", bidSupplierService.queryAwardSupplier(projId));
//        map.put("user", userService.queryUserById(user.getUserId()));
        map.put("now", new Date());
        
        return "bid/project_notice";
    }
    


    @RequestMapping("/notice/submit")
    @ResponseBody
    public ResultObject noticeSubmit(@RequestParam("projId") String projId, HttpSession sess, Map<String, Object> map) {
//        User user = null;
//        try {
//            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
//        } catch (UserNotLoginException e) {
//            return new ResultObject(ResultObject.FAIL, "未登录或无权限");
//        }

        BidProject proj = bidProjectService.queryProjectById(projId);
//        if (proj == null || !proj.getUserId().equals(user.getUserId()) || proj.getProjStatus() != 5) {
//            throw new IllegalArgumentException();
//        }

        bidProjectService.updateProjectNotice(projId);
        
        return new ResultObject(ResultObject.OK, "");
    }

//    @RequestMapping("/publicity")
//    public String publicity(@RequestParam("projId") String projId, 
//            @RequestParam("sup") String sup, 
//            @RequestParam("publicity_start") String publicityStart, 
//            @RequestParam("publicity_end") String publicityEnd, HttpSession sess, Map<String, Object> map)  {
//        logger.info("竞价公示页面");
//        User user = null;
////        try {
////            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
////        } catch (UserNotLoginException e) {
////            return "redirect:/passport/login";
////        } catch (NoPermissionException e) {
////            return "redirect:/passport/login";
////        }
//        
//        BidProject proj = bidProjectService.queryProjectById(projId);
////        if (proj == null || !proj.getUserId().equals(user.getUserId()) || proj.getProjStatus() != 4) {
////            throw new IllegalArgumentException();
////        }
//        
//        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
//        int day = 0;
//        try {
//            Date start = df.parse(publicityStart);
//            Date end = df.parse(publicityEnd);
//            
//            day = (int)((end.getTime() - start.getTime()) / 86400000);
//            
//        } catch (ParseException e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//        }
//        
//        map.put("proj", proj);
//        map.put("day", day);
//        map.put("publicityStart", publicityStart);
//        map.put("publicityEnd", publicityEnd);
//        map.put("subs", bidProjectService.querySubjectList(projId));
//        map.put("sup", supInfoService.querySupInfoByCode(sup));
//        map.put("psup", bidSupplierService.queryProjSupplier(projId, sup));
////        map.put("user", userService.queryUserById(user.getUserId()));
//        return "bid/project_publicity";
//    }
    

    @RequestMapping("/publicity/submit")
    @ResponseBody
    public ResultObject publicitySubmit(@RequestParam("proj_id") String projId, 
            @RequestParam("sup_id") String supCode, 
            @RequestParam("publicity_start") String publicityStart, 
            @RequestParam("publicity_end") String publicityEnd, 
            @RequestParam("purchaser_name") String purchaserName, 
            @RequestParam("purchaser_addr") String purchaserAddr, 
            @RequestParam("purchaser_contact") String purchaserContact, 
            HttpSession sess, Map<String, Object> map) {
//        User user = null;
//        try {
//            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
//        } catch (UserNotLoginException e) {
//            return new ResultObject(ResultObject.FAIL, "未登录或无权限");
//        }

//        BidProject proj = bidProjectService.queryProjectById(projId);
//        if (proj == null || !proj.getUserId().equals(user.getUserId()) || proj.getProjStatus() != 4) {
//            throw new IllegalArgumentException();
//        }

        bidProjectService.updateProjectPublicity(projId, supCode, publicityStart, publicityEnd, purchaserName, purchaserAddr, purchaserContact);
        
        return new ResultObject(ResultObject.OK, "");
    }
    @RequestMapping("/print")
    
    public String print(@RequestParam("projId") String projId, HttpSession sess, Map<String, Object> map) {
        logger.info("报价详情页面");
        User user = null;
//        try {
//            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
//        } catch (UserNotLoginException e) {
//            return "redirect:/passport/login";
//        } catch (NoPermissionException e) {
//            return "redirect:/passport/login";
//        }

        BidProject proj = bidProjectService.queryProjectById(projId);
        if (proj == null ) {
            throw new IllegalArgumentException();
        }
        
        map.put("proj", proj);
        map.put("sups", bidSupplierService.queryQuateSupplier(projId));
        map.put("now", new Date());
        List<BidSupplierQuota> quotas = bidQuotaService.queryQuotaListByProj(projId, 2);
        map.put("quotaList", quotas);
        try {
            map.put("quotas", new ObjectMapper().writeValueAsString(quotas));
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return "bid/project_print";
    }
    


    @RequestMapping("/export/pdf")
    public void exportPdf(@RequestParam("projId") String projId, HttpSession sess, HttpServletRequest req, HttpServletResponse res) {
        logger.info("报价详情导出PDF");
        
        String fontPath = sess.getServletContext().getRealPath("/")+"/fonts/simsun.ttc"; 
        BidProject proj = bidProjectService.queryProjectById(projId);
        if (proj == null || proj.getProjStatus() < 4) {
            throw new IllegalArgumentException();
        }
        List<BidProjSupplier> sups = bidSupplierService.queryQuateSupplier(projId);
        Date now = new Date();
        List<BidSupplierQuota> quotas = bidQuotaService.queryQuotaListByProj(projId, 2);

        String url = req.getRequestURL().toString();
        String ctx = req.getContextPath();
        String host = null;
        if (StringUtils.isEmpty(ctx) || "/".equals(ctx)) {
            String[] seg = url.split("://");
            String prefix = seg[0];
            host = prefix + "://" + seg[1].split("/")[0];
        } else {
            host = url.split(ctx)[0] + ctx;
        }
        
        
        try {
            res.setHeader("Content-Disposition", "attachment;fileName="+java.net.URLEncoder.encode("报价详情.pdf", "UTF-8"));
            ITextRenderer renderer = new ITextRenderer();  
            ITextFontResolver fontResolver = renderer.getFontResolver();  
            fontResolver.addFont(fontPath,  
                    BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);  
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            NumberFormat nf = NumberFormat.getPercentInstance();
            String projStatus = "";
            switch (proj.getProjStatus()) {
                case 4:
                    projStatus = "未授标";
                    break;
                case 5:
                    projStatus = "已授标";
                    break;
                case 6:
                    projStatus = "已废标";
                    break;
                case 7:
                    projStatus = "已定标";
                    break;
                case 8:
                    projStatus = "已公示";
                    break;
                case 9:
                    projStatus = "已终止";
                    break;

                default:
                    break;
            }
            StringBuffer html = new StringBuffer();
            html.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
            html.append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">");
            html.append("<html xmlns=\"http://www.w3.org/1999/xhtml\">");
            html.append("<head>");
            html.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />");
            html.append("<style type=\"text/css\" mce_bogus=\"1\">body {font-family: SimSun;}</style>");
            html.append("</head>");
            html.append("<body>");
            html.append("<div style=\"float: none;width: 100%;margin: 30px auto 0;\">");
            html.append("  <h2 style=\"margin:0;line-height:1.1;border-bottom: 1px solid #dfdfdf; color: #0091dc; font-size: 16px; font-weight: bold; margin-bottom: 15px; padding-bottom: 15px; text-align: center;\">供应商报价详情</h2>");
            html.append("  <div style=\"background: #f6f4f5; padding: 25px 0 15px 15px; border: 1px solid #dfdfdf;\">");
            html.append("    <div>");
            html.append("      <dl style=\"margin:0;float: left; font-size: 12px; margin-bottom: 10px; width:49%;margin-right: 1%;\">");
            html.append("        <dt style=\"font-weight: bold;float: left; line-height: 25px; width: 30%; text-align: right;\">项目名称：</dt>");
            html.append("        <dd style=\"margin:0;float: left; width: 70%;\">");
            html.append("          <span style=\"margin-left:5px;height: 28px; padding: 0; font-size: 12px;line-height: 25px; display:block;\">" + proj.getProjName() + "</span>");
            html.append("        </dd>");
            html.append("      </dl>");
            html.append("      <dl style=\"margin:0;float: left; font-size: 12px; margin-bottom: 10px; width:49%;margin-right: 1%;\">");
            html.append("        <dt style=\"font-weight: bold;float: left; line-height: 25px; width: 30%; text-align: right;\">项目编号：</dt>");
            html.append("        <dd style=\"margin:0;float: left; width: 70%;\">");
            html.append("          <span style=\"margin-left:5px;height: 28px; padding: 0; font-size: 12px;line-height: 25px; display:block;\">" + proj.getProjId() + "</span>");
            html.append("        </dd>");
            html.append("      </dl>");
            html.append("      <dl style=\"margin:0;float: left; font-size: 12px; margin-bottom: 10px; width:49%;margin-right: 1%;\">");
            html.append("        <dt style=\"font-weight: bold;float: left; line-height: 25px; width: 30%; text-align: right;\">竞价周期：</dt>");
            html.append("        <dd style=\"margin:0;float: left; width: 70%;\">");
            html.append("          <span style=\"margin-left:5px;height: 28px; padding: 0; font-size: 12px;line-height: 25px; display:block;\">" + df.format(proj.getBidStartTime()) + "至" + df.format(proj.getTimeoutEndTime()) + "</span>");
            html.append("        </dd>");
            html.append("      </dl>");
            html.append("      <dl style=\"margin:0;float: left; font-size: 12px; margin-bottom: 10px; width:49%;margin-right: 1%;\">");
            html.append("        <dt style=\"font-weight: bold;float: left; line-height: 25px; width: 30%; text-align: right;\">项目状态：</dt>");
            html.append("        <dd style=\"margin:0;float: left; width: 70%;\">");
            html.append("          <span style=\"margin-left:5px;height: 28px; padding: 0; font-size: 12px;line-height: 25px; display:block;\">" + projStatus + "</span>");
            html.append("        </dd>");
            html.append("      </dl>");
            html.append("     <div style=\"clear:both;\"></div>");
            html.append("    </div>");
            html.append("  </div>");
            html.append("  <div>");
            html.append("    <div style=\"margin-top: 50px;\">");
            html.append("      <h3 style=\"background: url(" + host + "/static/img/bid/icon-circle.gif) no-repeat left center; font-size: 16px; margin-top: 0; padding-left: 15px;font-weight: 500;\">供应商报价明细</h3>");
            html.append("      <table border=\"0\" cellspacing=\"0\" style=\"width: 100%; margin-top: 20px;border-collapse: collapse;\">");
            html.append("        <tr>");
            html.append("          <th width=\"450\" style=\"background: #dfdfdf; border: 1px solid #dfdfdf; border-right: 1px solid #fff; line-height: 32px; text-align: center; font-size: 12px;\">供应商名称</th>");
            html.append("          <th width=\"240\" style=\"background: #dfdfdf; border: 1px solid #dfdfdf; border-right: 1px solid #fff; line-height: 32px; text-align: center; font-size: 12px;\">报价</th>");
            html.append("          <th style=\"background: #dfdfdf; border: 1px solid #dfdfdf; border-right: 1px solid #dfdfdf; line-height: 32px; text-align: center; font-size: 12px;\">报价时间</th>");
            html.append("        </tr>");
            for (BidSupplierQuota i : quotas) {
                html.append("    <tr>");
                html.append("      <td style=\"border: 1px solid #dfdfdf; padding: 10px; font-size: 12px; vertical-align: middle; text-align: center;\">" + i.getSupName() + "</td>");
                html.append("      <td style=\"border: 1px solid #dfdfdf; padding: 10px; font-size: 12px; vertical-align: middle; text-align: center;\">" + i.getQuotaNum() + "</td>");
                html.append("      <td style=\"border: 1px solid #dfdfdf; padding: 10px; font-size: 12px; vertical-align: middle; text-align: center;\">" + df.format(i.getQuotaTime()) + "</td>");
                html.append("    </tr>");
            }
            html.append("      </table>");
            html.append("    </div>");
            html.append("    <div style=\"margin-top: 50px; position: relative;\">");
            html.append("      <h3 style=\"background: url(" + host + "/static/img/bid/icon-circle.gif) no-repeat left center; font-size: 16px; margin-top: 0; padding-left: 15px;font-weight: 500;\">供应商竞价结果汇总</h3>");
            html.append("      <table border=\"0\" cellspacing=\"0\" style=\"width: 100%; margin-top: 20px;border-collapse: collapse;\">");
            html.append("        <tr>");
            html.append("          <th width=\"450\" style=\"background: #dfdfdf; border: 1px solid #dfdfdf; border-right: 1px solid #fff; line-height: 32px; text-align: center; font-size: 12px;\">供应商名称</th>");
            html.append("          <th width=\"120\" style=\"background: #dfdfdf; border: 1px solid #dfdfdf; border-right: 1px solid #fff; line-height: 32px; text-align: center; font-size: 12px;\">最终报价</th>");
            html.append("          <th width=\"120\" style=\"background: #dfdfdf; border: 1px solid #dfdfdf; border-right: 1px solid #fff; line-height: 32px; text-align: center; font-size: 12px;\">采购预算</th>");
            html.append("          <th width=\"120\" style=\"background: #dfdfdf; border: 1px solid #dfdfdf; border-right: 1px solid #fff; line-height: 32px; text-align: center; font-size: 12px;\">节支金额</th>");
            html.append("          <th style=\"background: #dfdfdf; border: 1px solid #dfdfdf; border-right: 1px solid #dfdfdf; line-height: 32px; text-align: center; font-size: 12px;\">折扣率</th>");
            html.append("        </tr>");
            for (BidProjSupplier i : sups) {
                html.append("    <tr>");
                html.append("      <td style=\"border: 1px solid #dfdfdf; padding: 10px; font-size: 12px; vertical-align: middle; text-align: center;\">" + i.getSupName() + "</td>");
                html.append("      <td style=\"border: 1px solid #dfdfdf; padding: 10px; font-size: 12px; vertical-align: middle; text-align: center;\">" + i.getRealCurrentQuota() + "</td>");
                html.append("      <td style=\"border: 1px solid #dfdfdf; padding: 10px; font-size: 12px; vertical-align: middle; text-align: center;\">" + (proj.getBudget() > 0 ? proj.getBudget() : "无") + "</td>");
                html.append("      <td style=\"border: 1px solid #dfdfdf; padding: 10px; font-size: 12px; vertical-align: middle; text-align: center;\">" + (proj.getBudget() > 0 ? proj.getBudget() - i.getRealCurrentQuota() : "无") + "</td>");
                html.append("      <td style=\"border: 1px solid #dfdfdf; padding: 10px; font-size: 12px; vertical-align: middle; text-align: center;\">" + (proj.getBudget() > 0 ? nf.format((double)(proj.getBudget() - i.getRealCurrentQuota()) / proj.getBudget()) : "无") + "</td>");
                html.append("    </tr>");
            }
            html.append("      </table>");
            html.append("      <div style=\"position: absolute; top: 0; right: 20px; display: block;\"><img src=\"" + host + "/static/img/bid/img_seal_sample02.png\" alt=\"\"></img></div>");
            html.append("    </div>");
            html.append("  </div>");
            html.append("</div>");
            html.append("</body>");
            html.append("</html>");
            
            OutputStream os = res.getOutputStream();
            renderer.setDocumentFromString(html.toString());  
            renderer.layout();  
            renderer.createPDF(os);  
            os.flush();  
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
