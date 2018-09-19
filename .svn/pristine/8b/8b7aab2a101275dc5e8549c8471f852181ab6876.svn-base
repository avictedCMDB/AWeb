package com.avic.supervise.controllers;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.constants.SessionKeys;
import com.avic.supervise.models.Help;
import com.avic.supervise.models.User;
import com.avic.supervise.models.WebsiteNotice;
import com.avic.supervise.services.NewsService;
import com.avic.supplier.models.SupplierAddress;
import com.avic.supplier.services.SupplierAddressService;

@Controller
@RequestMapping("/news")
public class NewsController {
	
	protected static final Log logger = LogFactory.getLog(NewsController.class);
	
	@Autowired
    NewsService newsService;
	
    /**
     * 公告页面列表页面
     */
    @RequestMapping("")
    public String index(HttpServletRequest req,Map<String, Object> map, @ModelAttribute("websiteNotice") WebsiteNotice websiteNotice, HttpSession httpSession)
            throws UnsupportedEncodingException {
    	logger.info("公告页面");
        List<WebsiteNotice> websiteNoticeList = newsService.queryWebsiteNotice(websiteNotice);
        map.put("websiteNoticeList", websiteNoticeList);
        //分页信息
		String page = String.valueOf(websiteNotice.getPage());
		
        int total = newsService.queryWebsiteNoticeCount(websiteNotice);

        int pages = (int) Math.ceil((double) total / websiteNotice.getPageSize());
        
        map.put("page", page);
        map.put("total", total);
        map.put("pages", pages);
        map.put("websiteNoticeParam", websiteNotice);
        map.put("pageAction","supervise/news?"
        		+ "&noticeType="+(websiteNotice.getNoticeType() == null ?"":websiteNotice.getNoticeType())
        		+ "&publishSatrDate="+(websiteNotice.getPublishSatrDate() == null ?"":websiteNotice.getPublishSatrDate())
        		+ "&publishEndDate="+(websiteNotice.getPublishEndDate() == null ?"":websiteNotice.getPublishEndDate())
        		+ "&noticeSubject="+URLEncoder.encode((websiteNotice.getNoticeSubject() == null ?"":websiteNotice.getNoticeSubject()),"GBK")
                + "&page=%PAGE%");
        return "news/supervise_news";
    }
    /**
     * 公告页面列表页面
     */
    @RequestMapping("inserPage")
    public String inserPage(HttpServletRequest req,Map<String, Object> map, HttpSession httpSession)
            throws UnsupportedEncodingException {
    	logger.info("公告新增页面");
        return "news/supervise_news_add";
    }
    
    /**
     * 公告页面列表页面
     */
    @RequestMapping("updatePage")
    public String updatePage(HttpServletRequest req,Map<String, Object> map, HttpSession httpSession,
    		@RequestParam("id") String id)
            throws UnsupportedEncodingException {
    	logger.info("公告新增页面");
    	WebsiteNotice websiteNotice = new WebsiteNotice();
    	websiteNotice.setId(id);
    	List<WebsiteNotice> websiteNoticeList = newsService.queryWebsiteNotice(websiteNotice);
    	map.put("websiteNotice", websiteNoticeList.get(0));
        return "news/supervise_news_add";
    }
    
    /**
     * 公告页面列表页面
     */
    @RequestMapping("updateIsPublish")
    @ResponseBody
    public String updateIsPublish(HttpServletRequest req,Map<String, Object> map, HttpSession httpSession,
    		@RequestParam("id") String id,@RequestParam("isPublish") String isPublish)
            throws UnsupportedEncodingException {
    	logger.info("公告发布");
    	WebsiteNotice websiteNotice = new WebsiteNotice();
    	websiteNotice.setId(id);
    	websiteNotice.setIsPublish(isPublish);
    	newsService.updateIsPublish(websiteNotice);
        return "0";
    }
    /**
     * 公告页面列表页面
     */
    @RequestMapping("updateIsTop")
    @ResponseBody
    public String updateIsTop(HttpServletRequest req,Map<String, Object> map, HttpSession httpSession,
    		@RequestParam("id") String id,@RequestParam("isTop") String isTop)
            throws UnsupportedEncodingException {
    	logger.info("公告发布");
    	WebsiteNotice websiteNotice = new WebsiteNotice();
    	websiteNotice.setId(id);
    	websiteNotice.setIsTop(isTop);
    	newsService.updateIsPublish(websiteNotice);
        return "0";
    }
    
    /**
     * 公告页面列表页面
     */
    @RequestMapping("deleteNews")
    @ResponseBody
    public String deleteNews(HttpServletRequest req,Map<String, Object> map, HttpSession httpSession,
    		@RequestParam("id") String id)
            throws UnsupportedEncodingException {
    	logger.info("公告删除");
    	WebsiteNotice websiteNotice = new WebsiteNotice();
    	websiteNotice.setId(id);
    	newsService.deleteNews(websiteNotice);
        return "0";
    }
    
    /**
     * 公告页面列表页面
     */
    @RequestMapping("saveNews")
    @ResponseBody
    public String saveNews(HttpServletRequest req,Map<String, Object> map, HttpSession httpSession,
    		@RequestParam("id") String id,
    		@RequestParam("noticeType") String noticeType,
    		@RequestParam("noticeSubject") String noticeSubject,
    		@RequestParam("content") String content,
    		@RequestParam("beginDate") String beginDate,
    		@RequestParam("isPublish") String isPublish,
    		@RequestParam("endDate") String endDate)
            throws UnsupportedEncodingException {
    	logger.info("公告新增");
    	WebsiteNotice websiteNotice = new WebsiteNotice();
    	websiteNotice.setBeginDate(beginDate);
		websiteNotice.setEndDate(endDate);
		websiteNotice.setContent(content.getBytes());
		websiteNotice.setNoticeSubject(noticeSubject);
		websiteNotice.setNoticeType(noticeType);
		if ("0".equals(isPublish)) {
			websiteNotice.setIsPublish(isPublish);
		}
    	if ("".equals(id) || id == null) {
    		User user= (User) httpSession.getAttribute(SessionKeys.LOGIN_SUPERVISE);
			websiteNotice.setCreateUser(user.getUserNameCN());
    		newsService.insertNews(websiteNotice);
		}else {
			websiteNotice.setId(id);
			newsService.updateNews(websiteNotice);
		}
    	websiteNotice.setId(id);
        return "0";
    }
    
}
