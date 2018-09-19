package com.avic.market.controllers;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.avic.market.models.WebsiteNotice;
import com.avic.market.services.WebsiteNoticeService;

@Controller("market.NoticeController")
@RequestMapping("/notice")
public class NoticeController {
    protected static final Log logger = LogFactory.getLog(NoticeController.class);

    @Autowired
    WebsiteNoticeService websiteNoticeService;

    @RequestMapping("")
    public String index(@RequestParam("type") String type, @RequestParam(value = "page", defaultValue = "1") int page,
            Map<String, Object> map) {
        logger.info("公告");

        int total = websiteNoticeService.queryWebsiteNoticeCount(type);

        int pages = (int) Math.ceil((double) total / 10);

        if (page > pages) {
            page = pages;
        }
        if (total > 0) {
            map.put("list", websiteNoticeService.queryWebsiteNoticeList(type, page, 10));
        }
        map.put("pages", pages);
        map.put("total", total);
        map.put("page", page);
        map.put("type", type);

        map.put("pageAction", "market/notice?type=" + type + "&page=%PAGE%");

        return "notice/notice_list";
    }

    @RequestMapping("/detail")
    public String detail(@RequestParam("id") String id, Map<String, Object> map) {
        logger.info("公告详细");

        websiteNoticeService.updateBrowseCount(id);
        WebsiteNotice data = websiteNoticeService.queryWebsiteNoticeDetail(id);
        if (data != null) {
            data.setContentString(new String(data.getContent()));
        }
        map.put("data", data);
        
        return "notice/notice_detail";
    }
}
