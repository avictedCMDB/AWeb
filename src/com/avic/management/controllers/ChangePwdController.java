package com.avic.management.controllers;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.constants.UserRole;
import com.avic.common.exceptions.NoPermissionException;
import com.avic.common.exceptions.UserNotLoginException;
import com.avic.common.utils.MD5;
import com.avic.common.utils.Permission;
import com.avic.management.services.CommonService;
import com.avic.market.cpi.exceptions.NoSuchSupplierException;
import com.avic.market.cpi.exceptions.ServiceExecutionFailedException;
import com.avic.passport.models.User;

@Controller
@RequestMapping("/info")
@Transactional
public class ChangePwdController {
    protected static final Log logger = LogFactory.getLog(ChangePwdController.class);
    @Autowired
    CommonService commonService;
    
    @Autowired
    com.avic.management.services.UserService userService;
    
    @RequestMapping("")
    public String index(HttpServletRequest req,Map<String, Object> map,HttpSession httpSession) {
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
        return "management_changepassword";
    }
    
    
    @RequestMapping("/changePwd")
    @ResponseBody
    public Object changePassword(@RequestParam("oldPassword")String oldPassword,@RequestParam("newPassword")String newPassword,HttpSession httpSession) throws NoSuchSupplierException, ServiceExecutionFailedException {
    	Map<String, Object> map = new HashMap<String, Object>();
    	User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
    	//判断用户名密码是否存在
		user.setPassword(MD5.getMessageDigest(oldPassword.getBytes()));
		int cnt = userService.selectUserByPassword(user);
		if(cnt>0){
			//修改密码
			user.setPassword(MD5.getMessageDigest(newPassword.getBytes()));
			userService.changePassword(user);
			map.put("result", "success");
		}else{
			map.put("result", "faild");
		}
    	return map;
    }
    
}
