package com.avic.management.controllers.bid;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.beans.ResultObject;
import com.avic.common.constants.UserRole;
import com.avic.common.exceptions.NoPermissionException;
import com.avic.common.exceptions.UserNotLoginException;
import com.avic.common.utils.Permission;
import com.avic.management.models.BidProjSupplier;
import com.avic.management.services.BidProjectService;
import com.avic.management.services.BidSupplierService;
import com.avic.management.services.SupInfoService;
import com.avic.management.services.SupUserService;
import com.avic.management.services.SysCompanyHisService;
import com.avic.passport.models.User;

@Controller("BidAuditController")
@RequestMapping("/bid/audit")
public class AuditController {
    protected static final Log logger = LogFactory.getLog(AuditController.class);

    @Autowired
    BidSupplierService bidSupplierService;

    @Autowired
    BidProjectService bidProjectService;

    @Autowired
    SupInfoService supInfoService;
    
    @Autowired
    SysCompanyHisService sysCompanyHisService;
    
    @Autowired
    SupUserService supUserService;

    @RequestMapping("")
    public String index(HttpSession sess, Map<String, Object> map) {
    	logger.info("投标管理");
        User user = null;
        try {
            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
        } catch (UserNotLoginException e) {
            return "redirect:/passport/login";
        } catch (NoPermissionException e) {
            return "redirect:/passport/login";
        }
        return "bid/audit";
    }

    @RequestMapping("/data")
    @ResponseBody
    public ResultObject data(HttpSession sess, @RequestParam(value = "projId", defaultValue = "") String projId,
            @RequestParam(value = "projName", defaultValue = "") String projName,
            @RequestParam(value = "supName", defaultValue = "") String supName,
            @RequestParam(value = "publishTime", defaultValue = "") String publishTime,
            @RequestParam(value = "projType", defaultValue = "0") int projType,
            @RequestParam(value = "auditStatus", defaultValue = "0") int auditStatus,
            @RequestParam(value = "page", defaultValue = "1") int page) {

        User user = null;
        try {
            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
        } catch (Exception e) {
            return new ResultObject(ResultObject.FAIL, "未登录或无权限");
        }

        int size = 10;

        int total = bidSupplierService.querySupplierCount(user.getUserId(), projId, projName, supName, publishTime, projType, auditStatus);

        int pages = (int) Math.ceil((double) total / size);

        if (page > pages) {
            page = pages;
        }

        Map<String, Object> map = new HashMap<String, Object>();
        if (total > 0) {
            map.put("data", bidSupplierService.querySupplierList(user.getUserId(), projId, projName, supName, publishTime, projType,
                    auditStatus, page, size));
        }
        map.put("pages", pages);
        return new ResultObject(ResultObject.OK, map);
    }

    @RequestMapping("/sup")
    public String sup(@RequestParam("supId") String supId, Map<String, Object> map, HttpSession sess) {
    	logger.info("投标管理-查看");
        User user = null;
        try {
            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
        } catch (UserNotLoginException e) {
            return "redirect:/passport/login";
        } catch (NoPermissionException e) {
            return "redirect:/passport/login";
        }
        map.put("sup", supUserService.querySupUserBySupId(supId));
        map.put("comp", sysCompanyHisService.queryCompanyHisBySupId(supId));
        return "bid/audit_sup";
    }

    @RequestMapping("/op")
    public String op(@RequestParam("projId") String projId, @RequestParam("supCode") String supCode, Map<String, Object> map, HttpSession sess) {

    	logger.info("投标管理-审核");
        User user = null;
        try {
            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
        } catch (UserNotLoginException e) {
            return "redirect:/passport/login";
        } catch (NoPermissionException e) {
            return "redirect:/passport/login";
        }
        map.put("sup", bidSupplierService.queryProjSupplier(projId, supCode));
        map.put("supInfo", supInfoService.querySupInfoByCode(supCode));
        map.put("proj", bidProjectService.queryProjectById(projId));
        return "bid/audit_op";
    }

    @RequestMapping("/submit")
    @ResponseBody
    public ResultObject submit(@RequestParam("projId") String projId, @RequestParam("supCode") String supCode,
            @RequestParam("failReason") String failReason, @RequestParam("result") int result, HttpSession sess) {

        User user = null;
        try {
            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
        } catch (Exception e) {
            return new ResultObject(ResultObject.FAIL, "未登录或无权限");
        }
        
        BidProjSupplier sup = new BidProjSupplier();
        sup.setProjId(projId);
        sup.setSupCode(supCode);
        sup.setFailReason(failReason);
        sup.setAuditStatus(result);
        sup.setAuditUser(user.getUserId());
        
        if (result == 2) {
            for (;;) {
                String bidNum = "BH" + RandomStringUtils.random(3, "0123456789");
                if (!bidSupplierService.existsBidNum(projId, bidNum)) {
                    sup.setBidNum(bidNum);
                    break;
                }
            }
        }
        
        bidSupplierService.updateSupplierAudit(sup);

        return new ResultObject(ResultObject.OK, "");
    }
}
