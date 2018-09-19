package com.avic.supervise.controllers;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.avic.common.constants.SessionKeys;
import com.avic.supervise.models.CompanyMyInfo;
import com.avic.supervise.models.User;
import com.avic.supervise.services.CompanyMyInfoService;
import com.avic.supervise.services.UserService;

@Controller
@RequestMapping("/login")
public class LoginController {
    protected static final Log logger = LogFactory.getLog(LoginController.class);
    
    @Autowired
    UserService userService;
    @Autowired
    CompanyMyInfoService companyMyInfoService;
    
    @RequestMapping("")
    public String index(HttpServletRequest req, Map<String, Object> map) {
        String redirect = req.getParameter("redirect");
        
        if (StringUtils.isEmpty(redirect)) {
            redirect = req.getHeader("referer");
        }
        
        logger.info("用户登录页面访问-referer["+redirect+"]");
        

        if (!StringUtils.isEmpty(redirect)) {
            map.put("redirect", redirect);
        }
        
        return "login";
    }
    
    @RequestMapping("/submit")
    public String submit(HttpServletRequest req, HttpSession session, Map<String, Object> map) {
        String username = req.getParameter("f_name");
        String password = req.getParameter("f_pass");
        logger.info("用户登录提交-username["+username+"]");
        
        String error = null;
        User user = null;
        
        if (StringUtils.isEmpty(username)) {
            error = "请输入用户名";
        } else if (StringUtils.isEmpty(password)) {
            error = "请输入密码";
        } else {
            user = userService.login(username, password);
            
            if (user.getErrorMsg()!=null && !"".equals(user.getErrorMsg())) {
                error = user.getErrorMsg();
            }
        }
        
        if (error == null) {
        	CompanyMyInfo companyMyInfo = new CompanyMyInfo();
			companyMyInfo.setCreateUser(user.getUserId());
			companyMyInfo = companyMyInfoService.queryCompanyMyInfo(companyMyInfo);
			
            session.setAttribute(SessionKeys.LOGIN_SUPERVISE, user);
            session.setAttribute(SessionKeys.LOGIN_SUPERVISE_MENU, userService.getUserMenu(user.getUserId()));
            session.setAttribute(SessionKeys.COMPANY_IF_CHECK, companyMyInfo.getIfCheck());
            return "redirect:/supervise/index";
        } else {
            map.put("username", username);
            map.put("error", error);
            return "login";
        }
        
    }
    
    @RequestMapping("logout")
    public String logout(HttpSession session) {
        logger.info("用户退出登录");
        session.removeAttribute(SessionKeys.LOGIN_SUPERVISE);
        session.removeAttribute(SessionKeys.LOGIN_SUPERVISE_MENU);
        
        return "redirect:/supervise/login";
    }
}
