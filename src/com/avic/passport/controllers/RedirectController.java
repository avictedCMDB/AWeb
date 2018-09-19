package com.avic.passport.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.avic.common.constants.SessionKeys;
import com.avic.common.constants.UserRole;
import com.avic.common.exceptions.UserNotLoginException;
import com.avic.common.utils.Permission;
import com.avic.passport.models.User;

@Controller
@RequestMapping("/redirect")
public class RedirectController {
    @RequestMapping("")
    public String index(HttpSession session) {
        User user = (User)session.getAttribute(SessionKeys.LOGIN_USER);
        if (user == null) {
            return "redirect:/passport/login";
        }
        
        /*if (user.getAuthorities().contains(UserRole.PAY.value())) {
            return "redirect:/management/finance/index";
        }
        if (user.getAuthorities().contains(UserRole.CHECK.value())) {
            return "redirect:/management/audit";
        }*/
        /*if (user.getAuthorities().contains(UserRole.BUY.value()) || user.getAuthorities().contains(UserRole.CLIENT.value())) {*/
            return "redirect:/management/main";
        /*}*/
        /*return null;*/
    }
}
