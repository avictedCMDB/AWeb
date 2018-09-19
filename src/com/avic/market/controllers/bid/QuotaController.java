package com.avic.market.controllers.bid;

import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.beans.ResultObject;
import com.avic.common.constants.SessionKeys;
import com.avic.common.constants.UserRole;
import com.avic.common.utils.Permission;
import com.avic.market.models.BidMessage;
import com.avic.market.models.BidProjSubject;
import com.avic.market.models.BidProjSupplier;
import com.avic.market.models.BidProject;
import com.avic.market.models.BidSupplierQuota;
import com.avic.market.models.Supplier;
import com.avic.market.services.BidMessageService;
import com.avic.market.services.BidProjectService;
import com.avic.market.services.BidQuotaService;
import com.avic.market.services.CodeListService;
import com.avic.market.services.SupplierService;
import com.avic.passport.models.User;

@Controller
@RequestMapping("/bid/quota")
public class QuotaController {
    
    @Autowired
    BidProjectService bidProjectService;
    @Autowired
    CodeListService codeListService;
    
    @Autowired
    BidQuotaService bidQuotaService;
    
    @Autowired
    BidMessageService bidMessageService;
    
    @Autowired
    SupplierService supplierService;
    
    @RequestMapping("")
    public String index(@Param("projId") String projId, Map<String, Object> map, HttpSession sess) {
        User user = null;
        try {
            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
        } catch(Exception e) {}
        
        
        BidProject proj = bidProjectService.getProjectById(projId);
        
        if (user != null && proj != null) {
            if (proj.getUserId().equals(user.getUserId())) {
                return "redirect:/management/bid/project/hall?projId=" + projId;
            }
        }
        
        String supCode = (String)sess.getAttribute(SessionKeys.SUP_CODE);
        String supId = (String)sess.getAttribute(SessionKeys.SUP_ID);
        String supType = (String)sess.getAttribute(SessionKeys.SUP_TYPE);
        
        if (StringUtils.isEmpty(supCode)) {
            return "redirect:/supplier/login?redirect=/market/bid/quota?projId=" + projId;
        }
        
        
        
        if (!"1".equals(supType)) {
            map.put("success", false);
            map.put("msg", "您不是竞价供应商用户");
            return "bid/join_result";
        }
        
        if (proj == null || (proj.getProjStatus() != 2 && proj.getProjStatus() != 3)) {
            map.put("success", false);
            map.put("msg", "竞价已结束，具体结果请关注竞价公示及短信通知！");
            return "bid/join_result";
        }
        
        BidProjSupplier sup = bidQuotaService.getSupplier(projId, supCode);


        String ca = (String)sess.getAttribute(SessionKeys.CA_UNIQUE_ID);
        
        if (supplierService.checkNeedCA(proj.getCompanyId(), supId) && StringUtils.isEmpty(ca)) {
            return "redirect:/supplier/login/ca?redirect=/market/bid/quota?projId=" + projId;
        }
        
        //Supplier s = supplierService.getSupplierById(sup.getSupCode());
        Date now = new Date();

        proj.setCurrencyName(codeListService.getCodeText("CURRENCY", proj.getCurrency()));
        map.put("proj", proj);
        map.put("sup", sup);
        map.put("now", now);
        
        // 计算加减步长
        if (proj.getMinIncrType() == 1) {
            map.put("quotaStep", 0);
        } else if (proj.getMinIncrType() == 2) {
            map.put("quotaStep", proj.getMinIncrVal());
        } else {
            int val = proj.getQuotaLimitNum() * 100 / proj.getMinIncrVal();
            map.put("quotaStep", val);
        }
        
        if (sup == null) {
            // 未被邀请
            if (proj.getProjType() == 1) {

                map.put("success", false);
                map.put("msg", "您没有被邀请");
                return "bid/join_result";
            }
            // 报名
            if (proj.getProjStatus() != 2 || now.after(proj.getJoinEndTime())) {

                map.put("success", false);
                map.put("msg", "报名已截止");
                return "bid/join_result";
            }
            
            bidQuotaService.joinSupplier(projId, supCode);
            map.put("success", true);
            map.put("msg", "您已报名成功，请耐心等待审核结果");
            return "bid/join_result";
        } else {
            // 审核中
            if (sup.getAuditStatus() == 1) {

                map.put("success", true);
                map.put("msg", "您已报名成功，请耐心等待审核结果");
                return "bid/join_result";
            } else if (sup.getAuditStatus() == 3) {
                map.put("success", false);
                map.put("msg", "您的报名未审核通过，原因：" + sup.getFailReason());
                return "bid/join_result";
            }
        }
        
        // 试竞价
        if (now.getTime() <= proj.getTrialEndTime().getTime()) {
            if (sup.getTrialThreshold() < 0) {
                return "redirect:/market/bid/quota/threshold?projId=" + projId;
            }
            
            
            map.put("sta", "试竞价");
            map.put("time", proj.getTrialEndTime().getTime() - now.getTime());
            
            List<BidSupplierQuota> quotas = bidQuotaService.getTrialSupplierQuota(projId, supCode);
            
            if (quotas == null || quotas.size() == 0) {
                map.put("firstQuota", "");
            } else {
                map.put("firstQuota", quotas.get(quotas.size() - 1).getQuotaNum());
            }
            map.put("currentQuota", sup.getTrialCurrentQuota());
            map.put("threshold", sup.getTrialThreshold());
            

            bidQuotaService.updateTrialLoginStatus(projId, supCode);

            map.put("mys", quotas);
            return "bid/quota";
        }
        
        // 正式竞价
        if (now.getTime() <= proj.getTimeoutEndTime().getTime()) {
            if (sup.getRealThreshold() < 0) {
                return "redirect:/market/bid/quota/threshold?projId=" + projId;
            }

            map.put("threshold", sup.getRealThreshold());
            if (now.getTime() >= proj.getBidStartTime().getTime() && now.getTime() <= proj.getBidEndTime().getTime()) {
                map.put("sta", "正式竞价");
                map.put("time", proj.getBidEndTime().getTime() - now.getTime());
            } else if (now.after(proj.getBidEndTime())) {
                map.put("sta", "超时竞价");
                map.put("time", proj.getTimeoutEndTime().getTime() - now.getTime());
            } else {
                map.put("sta", "等待竞价开始");
                map.put("disable", "disable");
                map.put("time", proj.getBidStartTime().getTime() - now.getTime());
                return "bid/quota";
            }


            map.put("currentQuota", sup.getRealCurrentQuota());
            List<BidSupplierQuota> quotas = bidQuotaService.getRealSupplierQuota(projId, supCode);
            
            if (quotas == null || quotas.size() == 0) {
                map.put("firstQuota", "");
            } else {
                map.put("firstQuota", quotas.get(quotas.size() - 1).getQuotaNum());
            }

            bidQuotaService.updateRealLoginStatus(projId, supCode);
            
            map.put("mys", quotas);
            return "bid/quota";
        }

        map.put("success", false);
        map.put("msg", "竞价已结束，具体结果请关注竞价公示及短信通知！");
        return "bid/join_result";

    }
    
    @RequestMapping("/threshold")
    public String threshold(@RequestParam("projId") String projId, Map<String, Object> map, HttpSession sess) {
        String supCode = (String)sess.getAttribute(SessionKeys.SUP_CODE);
        String supType = (String)sess.getAttribute(SessionKeys.SUP_TYPE);
        
        if (StringUtils.isEmpty(supCode)) {
            return "redirect:/supplier/login?redirect=/market/bid/quota?projId=" + projId;
        }
        
        if (!"1".equals(supType)) {
            map.put("success", false);
            map.put("msg", "您不是竞价供应商用户");
            return "bid/join_result";
        }
        
        BidProject proj = bidProjectService.getProjectById(projId);

        if (proj == null || (proj.getProjStatus() != 2 && proj.getProjStatus() != 3)) {
            map.put("success", false);
            map.put("msg", "竞价已结束，具体结果请关注竞价公示及短信通知！");
            return "bid/join_result";
        }
        
        BidProjSupplier sup = bidQuotaService.getSupplier(projId, supCode);

        if (sup == null || sup.getAuditStatus() != 2) {
            map.put("success", false);
            map.put("msg", "非法操作");
            return "bid/join_result";
        }

        String val = "";
        Date now = new Date();
        
        if (now.getTime() <= proj.getTrialEndTime().getTime()) {
            if (sup.getTrialThreshold() > -1) {
                val = String.valueOf(sup.getTrialThreshold());
            }
        } else if (now.getTime() <= proj.getTimeoutEndTime().getTime()) {
            if (sup.getRealThreshold() > -1) {
                val = String.valueOf(sup.getRealThreshold());
            }
        }
        
        List<BidProjSubject> subjects = bidProjectService.getSubjects(projId);

        proj.setBidCatName(codeListService.getCodeText("BID_CAT", proj.getBidCat()));
        map.put("proj", proj);
        map.put("val", val);
        map.put("subjects", subjects);

        return "bid/threshold";
    }
    
    @RequestMapping("/threshold/submit")
    @ResponseBody
    public ResultObject thresholdSubmit(@RequestParam("projId") String projId, @RequestParam("val") int val, HttpSession sess) {
        String supCode = (String)sess.getAttribute(SessionKeys.SUP_CODE);
        String supType = (String)sess.getAttribute(SessionKeys.SUP_TYPE);
        
        if (StringUtils.isEmpty(supCode)) {
            return new ResultObject(ResultObject.FAIL, "未登录");
        }
        
        if (!"1".equals(supType)) {
            return new ResultObject(ResultObject.FAIL, "您不是竞价供应商用户");
        }
        
        BidProject proj = bidProjectService.getProjectById(projId);

        if (proj == null || (proj.getProjStatus() != 2 && proj.getProjStatus() != 3)) {
            return new ResultObject(ResultObject.FAIL, "竞价已结束，具体结果请关注竞价公示及短信通知！");
        }
        
        BidProjSupplier sup = bidQuotaService.getSupplier(projId, supCode);

        if (sup == null || sup.getAuditStatus() != 2) {
            return new ResultObject(ResultObject.FAIL, "非法操作");
        }

        Date now = new Date();
        
        if (now.getTime() <= proj.getTrialEndTime().getTime()) {
            bidQuotaService.updateSupplierTrialThreshold(projId, supCode, val);
        } else if (now.getTime() <= proj.getTimeoutEndTime().getTime()) {
            bidQuotaService.updateSupplierRealThreshold(projId, supCode, val);
        }
        
        return new ResultObject(ResultObject.OK, "");
    }
    
    @RequestMapping("/rank")
    @ResponseBody
    public ResultObject rank(@RequestParam("projId") String projId, HttpSession sess) {
        String supCode = (String)sess.getAttribute(SessionKeys.SUP_CODE);
        String supType = (String)sess.getAttribute(SessionKeys.SUP_TYPE);
        
        if (StringUtils.isEmpty(supCode)) {
            return new ResultObject(ResultObject.FAIL, "未登录");
        }
        
        if (!"1".equals(supType)) {
            return new ResultObject(ResultObject.FAIL, "您不是竞价供应商用户");
        }
        
        BidProject proj = bidProjectService.getProjectById(projId);

        if (proj == null || (proj.getProjStatus() != 2 && proj.getProjStatus() != 3)) {
            return new ResultObject(ResultObject.FAIL, "竞价已结束，具体结果请关注竞价公示及短信通知！");
        }
        
        BidProjSupplier sup = bidQuotaService.getSupplier(projId, supCode);

        if (sup == null || sup.getAuditStatus() != 2) {
            return new ResultObject(ResultObject.FAIL, "非法操作");
        }
        

        Date now = new Date();
        List<BidSupplierQuota> list = null; 
        if (now.getTime() <= proj.getTrialEndTime().getTime()) {
            list = bidQuotaService.getTrialQuotaRank(projId);
        } else if (now.getTime() >= proj.getBidStartTime().getTime() && now.getTime() <= proj.getTimeoutEndTime().getTime()) {
            list = bidQuotaService.getRealQuotaRank(projId);
        } 
        
        if (list != null && list.size() > 0) {
            for (BidSupplierQuota i : list) {
                if (proj.getPublishQuota() == 1 || supCode.equals(i.getSupCode())) {
                    i.setQuotaNumString(String.valueOf(i.getQuotaNum()));
                } else {
                    i.setQuotaNumString("****");
                }
            }
            
            Collections.sort(list, new Comparator<BidSupplierQuota>() {
                @Override
                public int compare(BidSupplierQuota o1, BidSupplierQuota o2) {
                    if (o1.getQuotaNum() == o2.getQuotaNum()) {
                        return (int)(o1.getQuotaTime().getTime() - o2.getQuotaTime().getTime());
                    } else {
                        return o1.getQuotaNum() - o2.getQuotaNum();
                    }
                }
            });
        }
        

        return new ResultObject(ResultObject.OK, list);
    }
    
    @RequestMapping("/submit")
    @ResponseBody
    public ResultObject submit(@RequestParam("projId") String projId, @RequestParam("val") int val, HttpServletRequest req, HttpSession sess) {
        String supCode = (String)sess.getAttribute(SessionKeys.SUP_CODE);
        String supType = (String)sess.getAttribute(SessionKeys.SUP_TYPE);
        
        if (StringUtils.isEmpty(supCode)) {
            return new ResultObject(ResultObject.FAIL, "未登录");
        }
        
        if (!"1".equals(supType)) {
            return new ResultObject(ResultObject.FAIL, "您不是竞价供应商用户");
        }
        
        BidProject proj = bidProjectService.getProjectById(projId);

        if (proj == null || (proj.getProjStatus() != 2 && proj.getProjStatus() != 3)) {
            return new ResultObject(ResultObject.FAIL, "竞价已结束，具体结果请关注竞价公示及短信通知！");
        }
        
        BidProjSupplier sup = bidQuotaService.getSupplier(projId, supCode);

        if (sup == null || sup.getAuditStatus() != 2) {
            return new ResultObject(ResultObject.FAIL, "非法操作");
        }
        
        
        
        int min = 0;
        if (proj.getMinIncrType() == 2) {
            min = proj.getMinIncrVal();
        } else if (proj.getMinIncrType() == 3) {
            min = proj.getQuotaLimitNum() * proj.getMinIncrVal() / 100;
        }
        

        Date now = new Date();

        BidSupplierQuota data = new BidSupplierQuota();
        data.setBidNum(sup.getBidNum());
        data.setProjId(projId);
        data.setQuotaNum(val);
        data.setSupCode(supCode);
        data.setQuotaIp(getIpAddress(req));

        if (now.getTime() <= proj.getTrialEndTime().getTime()) {
            if (sup.getTrialBan() == 1) {
                return new ResultObject(ResultObject.FAIL, "您已被采购人禁止出价");
            }
            
            if (sup.getTrialCurrentQuota() > 0 && (sup.getTrialCurrentQuota() - val < min || sup.getTrialCurrentQuota() < val)) {
                return new ResultObject(ResultObject.FAIL, "不能小于最低降价幅度：" + min);
            }
            List<BidSupplierQuota> quotas = bidQuotaService.getTrialSupplierQuota(projId, supCode);
            if (quotas != null && quotas.size() > 0) {
                int first = quotas.get(quotas.size() - 1).getQuotaNum();

                if (val < first - first * proj.getQuotaDecrLimit() / 100) {
                    return new ResultObject(ResultObject.FAIL, "最大降幅不能超过首次报价" + proj.getQuotaDecrLimit() + "%");
                }
            }
            
            if (proj.getTimesLimitType() == 2 && quotas.size() >= proj.getTimesLimitNum()) {
                return new ResultObject(ResultObject.FAIL, "已达到报价次数限制：" + proj.getTimesLimitNum());
            }
            
            data.setQuotaRound(quotas.size() + 1);
            data.setQuotaType(1);


        } else if (now.getTime() >= proj.getBidStartTime().getTime() && now.getTime() <= proj.getTimeoutEndTime().getTime()) {
            if (sup.getRealBan() == 1) {
                return new ResultObject(ResultObject.FAIL, "您已被采购人禁止出价");
            }
            if (sup.getRealCurrentQuota() > 0 && (sup.getRealCurrentQuota() - val < min || sup.getRealCurrentQuota() < val)) {
                return new ResultObject(ResultObject.FAIL, "不能小于最低降价幅度：" + min);
            }
            List<BidSupplierQuota> quotas = bidQuotaService.getRealSupplierQuota(projId, supCode);
            if (quotas != null && quotas.size() > 0) {
                int first = quotas.get(quotas.size() - 1).getQuotaNum();
                
                if (val < first - first * proj.getQuotaDecrLimit() / 100) {
                    return new ResultObject(ResultObject.FAIL, "最大降幅不能超过首次报价" + proj.getQuotaDecrLimit() + "%");
                }
            }
            
            if (proj.getTimesLimitType() == 2 && quotas.size() >= proj.getTimesLimitNum()) {
                return new ResultObject(ResultObject.FAIL, "已达到报价次数限制：" + proj.getTimesLimitNum());
            }

            data.setQuotaRound(quotas.size() + 1);
            data.setQuotaType(2);
            
            if (now.after(proj.getBidEndTime())) {
                data.setTimeoutFlag(1);
            }
            
        } else {
            return new ResultObject(ResultObject.FAIL, "竞价已结束，具体结果请关注竞价公示及短信通知！");
        }

        if (proj.getQuotaLimitType() == 2 && proj.getQuotaLimitNum() < val) {
            return new ResultObject(ResultObject.FAIL, "不能超过报价上限" + proj.getQuotaLimitNum());
        }
        
        bidQuotaService.quota(data);

        return new ResultObject(ResultObject.OK, "");
    }

    
    @RequestMapping("/msg/send")
    @ResponseBody
    public ResultObject msgSend(@RequestParam("projId") String projId, @RequestParam("msg") String msg, HttpSession sess) {
        String supCode = (String)sess.getAttribute(SessionKeys.SUP_CODE);
        String supType = (String)sess.getAttribute(SessionKeys.SUP_TYPE);
        
        if (StringUtils.isEmpty(supCode)) {
            return new ResultObject(ResultObject.FAIL, "未登录");
        }
        
        if (!"1".equals(supType)) {
            return new ResultObject(ResultObject.FAIL, "您不是竞价供应商用户");
        }
        
        BidProject proj = bidProjectService.getProjectById(projId);

        if (proj == null || (proj.getProjStatus() != 2 && proj.getProjStatus() != 3)) {
            return new ResultObject(ResultObject.FAIL, "竞价已结束，具体结果请关注竞价公示及短信通知！");
        }
        
        BidProjSupplier sup = bidQuotaService.getSupplier(projId, supCode);

        if (sup == null || sup.getAuditStatus() != 2) {
            return new ResultObject(ResultObject.FAIL, "非法操作");
        }

        Date now = new Date();
        BidMessage message = new BidMessage();
        message.setMsgContent(msg);
        message.setProjId(projId);
        message.setSupCode(supCode);
        message.setSendType(1);
        message.setSendTime(now);
        
        if (now.getTime() <= proj.getTrialEndTime().getTime()) {
            message.setMsgType(1);
        } else if (now.getTime() >= proj.getBidStartTime().getTime() && now.getTime() <= proj.getTimeoutEndTime().getTime()) {
            message.setMsgType(2);
        } else {
            return new ResultObject(ResultObject.FAIL, "非法操作");
        }
        
        bidMessageService.insertMessage(message);
        
        return new ResultObject(ResultObject.OK, message);
    }
    

    
    @RequestMapping("/msg/data")
    @ResponseBody
    public ResultObject msgData(@RequestParam("projId") String projId, @RequestParam("msgId") int msgId, HttpSession sess) {
        String supCode = (String)sess.getAttribute(SessionKeys.SUP_CODE);
        String supType = (String)sess.getAttribute(SessionKeys.SUP_TYPE);
        
        if (StringUtils.isEmpty(supCode)) {
            return new ResultObject(ResultObject.FAIL, "未登录");
        }
        
        if (!"1".equals(supType)) {
            return new ResultObject(ResultObject.FAIL, "您不是竞价供应商用户");
        }
        
        BidProject proj = bidProjectService.getProjectById(projId);

        if (proj == null || (proj.getProjStatus() != 2 && proj.getProjStatus() != 3)) {
            return new ResultObject(ResultObject.FAIL, "竞价已结束，具体结果请关注竞价公示及短信通知！");
        }

        Date now = new Date();
        int msgType = 0;
        if (now.getTime() <= proj.getTrialEndTime().getTime()) {
            msgType = 1;
        } else if (now.getTime() >= proj.getBidStartTime().getTime() && now.getTime() <= proj.getTimeoutEndTime().getTime()) {
            msgType = 2;
        } else {
            return new ResultObject(ResultObject.OK, "");
        }
        
        return new ResultObject(ResultObject.OK, bidMessageService.getMessageList(projId, supCode, msgType, msgId));
    }
    
    public String getIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("X-Real-IP");
        if (!StringUtils.isBlank(ip) && !"unknown".equalsIgnoreCase(ip)) {
            return ip;
        }
        ip = request.getHeader("X-Forwarded-For");
        if (!StringUtils.isBlank(ip) && !"unknown".equalsIgnoreCase(ip)) {
            int index = ip.indexOf(',');
            if (index != -1) {
                return ip.substring(0, index);
            } else {
                return ip;
            }
        } else {
            return request.getRemoteAddr();
        }
    }
}
