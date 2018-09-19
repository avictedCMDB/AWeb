package com.avic.market.controllers.bid;

import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.avic.market.models.BidProject;
import com.avic.market.services.BidProjectService;
import com.avic.market.services.UserService;

@Controller
@RequestMapping("/bid/publicity")
public class PublicityController {
    protected static final Log logger = LogFactory.getLog(PublicityController.class);

    @Autowired
    BidProjectService bidProjectService;
    
    @Autowired
    UserService userService;


    @RequestMapping("")
    public String index(@RequestParam("projId") String projId, HttpSession sess, Map<String, Object> map) {
        logger.info("公示页面");

        BidProject proj = bidProjectService.getProjectById(projId);
        if (proj == null || proj.getProjStatus() != 8) {
            map.put("success", false);
            map.put("msg", "非法操作");
            return "bid/join_result";
        }
        
        int diff = (int)((proj.getPublicityEnd().getTime() - proj.getPublicityStart().getTime()) / 86400000);

        map.put("diff", diff);
        map.put("proj", proj);
        map.put("subs", bidProjectService.getSubjects(projId));
        map.put("sup", bidProjectService.getAwardSupplier(projId));
        map.put("user", userService.getUserAndCompanyById(proj.getUserId()));
        map.put("now", new Date());
        
        return "bid/publicity";
    }
}
