package com.avic.supervise.controllers;

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
import com.avic.supervise.models.SettleData;
import com.avic.supervise.models.User;
import com.avic.supervise.services.SettleService;
import com.avic.supervise.services.SupService;

@Controller
@RequestMapping("/settle/pending")
public class SettlePendingController {
    protected static final Log logger = LogFactory.getLog(SettlePendingController.class);

    static final int PAGE_SIZE = 10;
    
    @Autowired
    SettleService settleService;
    @Autowired
    SupService supService;
    
    @RequestMapping("/list")
    public String list(HttpServletRequest req, Map<String, Object> map) {
        
        String supId = req.getParameter("supId");
        String timeStart = req.getParameter("timeStart");
        String timeEnd = req.getParameter("timeEnd");
        String companyName = req.getParameter("companyName");
        String page = req.getParameter("page");
        
        logger.info("待结算列表-supId["+supId+"], timeStart["+timeStart+"], timeEnd["+timeEnd+"], companyName["+companyName+"], page["+page+"]");
        

        if (StringUtils.isEmpty(supId) || StringUtils.isEmpty(timeStart) || StringUtils.isEmpty(timeEnd)) {
            
        } else {
        
        int pageNum = 1;
        int supIdInt = Integer.parseInt(supId);

        if (StringUtils.isNumeric(page)) {
            pageNum = Integer.parseInt(page);
        }
        
        int total = settleService.getSettleDataCount(supIdInt, timeStart, timeEnd, companyName);

        int pages = (int) Math.ceil((double) total / PAGE_SIZE);

        if (pageNum > pages) {
            pageNum = pages;
        }
        if (total > 0) {
            List<SettleData> list = settleService.getSettleDataList(supIdInt, timeStart, timeEnd, companyName, pageNum, PAGE_SIZE);
            
            map.put("list", list);
        }
        
        if (companyName == null) {
            companyName = "";
        }

        map.put("companyName", companyName);
        map.put("supId", supId);
        map.put("timeStart", timeStart);
        map.put("timeEnd", timeEnd);
        map.put("total", total);
        map.put("page", pageNum);
        map.put("pageAction", "supervise/settle/pending/list?timeStart="+timeStart+"&timeEnd="+timeEnd+"&companyName="+companyName+"&supId="+supId+"&page=%PAGE%");
        map.put("pages", pages);
        }
        map.put("sups", supService.getSupList());
        
        return "settle/pending_list";
    }
    
    @RequestMapping("/submit")
    @ResponseBody
    public ResultObject submit(HttpServletRequest req, HttpSession session) {
        String supId = req.getParameter("supId");
        String timeStart = req.getParameter("timeStart");
        String timeEnd = req.getParameter("timeEnd");
        String companyName = req.getParameter("companyName");

        logger.info("生成结算单-supId["+supId+"], timeStart["+timeStart+"], timeEnd["+timeEnd+"], companyName["+companyName+"]");
        

        if (StringUtils.isEmpty(supId) || StringUtils.isEmpty(timeStart) || StringUtils.isEmpty(timeEnd)) {
            return new ResultObject(ResultObject.FAIL, "参数无效，请先查询待结算数据");
        }
        int supIdInt = Integer.parseInt(supId);

        int total = settleService.getSettleDataCount(supIdInt, timeStart, timeEnd, companyName);
        
        if (total > 0) {
            User user = (User) session.getAttribute(SessionKeys.LOGIN_SUPERVISE);
            try {
                String settleId = settleService.settle(supIdInt, timeStart, timeEnd, companyName, user.getUserId());
                return new ResultObject(ResultObject.OK, "生成结算单成功, 单号【"+settleId+"】");
            } catch (Exception e) {
                logger.error("生成结算单失败", e);
                return new ResultObject(ResultObject.FAIL, e.getMessage());
            }
        } else {
            return new ResultObject(ResultObject.FAIL, "无待结算数据");
        }

    }
}
