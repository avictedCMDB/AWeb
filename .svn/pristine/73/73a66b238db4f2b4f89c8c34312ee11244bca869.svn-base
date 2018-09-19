package com.avic.management.controllers;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import com.avic.common.constants.UserRole;
import com.avic.common.exceptions.NoPermissionException;
import com.avic.common.exceptions.UserNotLoginException;
import com.avic.common.utils.Permission;
import com.avic.management.models.Management;
import com.avic.management.services.CommonService;
import com.avic.management.services.ManagementService;
import com.avic.passport.models.User;

@Controller
@RequestMapping("/main")
@Transactional
public class ManagementController {
    protected static final Log logger = LogFactory.getLog(ManagementController.class);
    
    @Autowired
    CommonService commonService;
    @Autowired
    ManagementService managementService;
    
    @RequestMapping("")
    public String main(Map<String, Object> map,HttpSession httpSession) {
        logger.info("采购首页统计数据");
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
		Management management = new Management();
		management.setUserID(user.getUserId());
		management.setCompanyId(user.getCompanyId());
		management = managementService.queryManagementCount(management);
        map.put("management", management);
        return "management";
    }
    
}
