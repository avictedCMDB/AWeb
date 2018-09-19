package com.avic.supervise.controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.beans.ResultObject;
import com.avic.common.constants.SessionKeys;
import com.avic.supervise.models.SettleRecord;
import com.avic.supervise.models.User;
import com.avic.supervise.services.SettleService;
import com.avic.supervise.services.SupService;

@Controller
@RequestMapping("/settle/effective")
public class SettleEffectiveController {
    protected static final Log logger = LogFactory.getLog(SettleEffectiveController.class);

    static final int PAGE_SIZE = 10;
    
    @Autowired
    SettleService settleService;
    @Autowired
    SupService supService;
    
    @RequestMapping("/list")
    public String list(HttpServletRequest req, Map<String, Object> map) {
        String timeStart = req.getParameter("timeStart");
        String timeEnd = req.getParameter("timeEnd");
        String settleId = req.getParameter("settleId");
        String supId = req.getParameter("supId");
        String settleStatus = req.getParameter("settleStatus");
        String page = req.getParameter("page");
        
        logger.info("结算管理-timeStart["+timeStart+"], timeEnd["+timeEnd+"], settleId["+settleId+"], supId["+supId+"], settleStatus["+settleStatus+"], page["+page+"]");
        
        int pageNum = 1;
        int supIdInt = 0;
        if (StringUtils.isNumeric(supId)) {
            supIdInt = Integer.parseInt(supId);
        }
        int settleStatusInt = 0;
        
        if (StringUtils.isNumeric(settleStatus)) {
            settleStatusInt = Integer.parseInt(settleStatus);
        }
        

        if (StringUtils.isNumeric(page)) {
            pageNum = Integer.parseInt(page);
        }
        
        int total = settleService.getSettleRecordCount(timeStart, timeEnd, settleId, supIdInt, settleStatusInt);

        int pages = (int) Math.ceil((double) total / PAGE_SIZE);

        if (pageNum > pages) {
            pageNum = pages;
        }
        if (total > 0) {
            List<SettleRecord> list = settleService.getSettleRecordList(timeStart, timeEnd, settleId, supIdInt, settleStatusInt, pageNum, PAGE_SIZE);
            for (SettleRecord i : list) {
                i.setSupName(supService.getSupName(i.getSupId()));
            }
            map.put("list", list);
        }
        
        if (timeStart == null) {
            timeStart = "";
        }
        if (timeEnd == null) {
            timeEnd = "";
        }
        if (settleId == null) {
            settleId = "";
        }

        map.put("settleId", settleId);
        map.put("supId", supIdInt);
        map.put("settleStatus", settleStatusInt);
        map.put("timeStart", timeStart);
        map.put("timeEnd", timeEnd);
        map.put("total", total);
        map.put("page", pageNum);
        map.put("pageAction", "supervise/settle/effective/list?timeStart="+timeStart+"&timeEnd="+timeEnd+"&settleId="+settleId+"&supId="+supIdInt+"&settleStatus="+settleStatusInt+"&page=%PAGE%");
        map.put("pages", pages);
        map.put("sups", supService.getSupList());
        
        
        return "settle/effective_list";
    }
    
    @RequestMapping("/detail")
    public String detail(HttpServletRequest req, Map<String, Object> map) {
        String settleId = req.getParameter("s");
        
        logger.info("结算管理-查看-settleId["+settleId+"]");
        SettleRecord record = settleService.getSettleRecordDetail(settleId);
        record.setSupName(supService.getSupName(record.getSupId()));
        map.put("record", record);
        map.put("items", settleService.getSettleRecordData(settleId));
        
        return "settle/effective_detail";
    }
    
    @RequestMapping("/submit")
    @ResponseBody
    public ResultObject submit(HttpServletRequest req, HttpSession session) {
        String ids = req.getParameter("ids");
        logger.info("结算管理-生效-ids["+ids+"]");

        User user = (User) session.getAttribute(SessionKeys.LOGIN_SUPERVISE);
        
        List<String> list = new ArrayList<String>();
        
        
        try {
            for (String i : ids.split(",")) {
                list.add(i);
            }
            settleService.effective(list, user.getUserId());
        } catch (Exception e) {
            logger.error("结算生效失败", e);
            return new ResultObject(ResultObject.FAIL, e.getMessage());
        }
        
        return new ResultObject(ResultObject.OK, "结算单已生效");
    }
}
