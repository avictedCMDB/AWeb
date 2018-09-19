package com.avic.supplier.controllers;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cn.org.bjca.client.security.SecurityEngineDeal;

import com.avic.common.constants.SessionKeys;
import com.avic.common.utils.ConfigHolder;
import com.avic.supplier.models.SupplierUser;
import com.avic.supplier.services.SupplierSupUserService;

@Controller
@RequestMapping("/login")
public class SupplierLoginController {

	protected static final Log logger = LogFactory
			.getLog(SupplierLoginController.class);

	@Autowired
	SupplierSupUserService supplierSupUserService;
	
	@Autowired
	ConfigHolder configHolder;

	/**
	 * 页面初始化方法
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("")
	public String index(@RequestParam(value="redirect", defaultValue="") String redirect, Map<String, Object> map) {
	    map.put("redirect", redirect);
		return "login";
	}
	

    @RequestMapping("/ca")
    public String ca(@RequestParam(value="redirect", defaultValue="") String redirect, HttpSession sess, Map<String, Object> map) 
    throws Exception {
        map.put("redirect", redirect);
        
        SecurityEngineDeal.setProfilePath(configHolder.getConfig("ca.profile.path"));
        
        SecurityEngineDeal sed = SecurityEngineDeal.getInstance(configHolder.getConfig("ca.webapp.name"));
        String function = configHolder.getConfig("ca.function");

        String cert = sed.getServerCertificate();
        String random = sed.genRandom(24);
        String sign = sed.signData(random);


        sess.setAttribute(SessionKeys.CA_RANDOM, random);
        
        map.put("cert", cert);
        map.put("random", random);
        map.put("sign", sign);
        
        return "login_ca";
    }

	@RequestMapping("/submit")
    public String submit(HttpServletRequest req, HttpSession session, Map<String, Object> map) {
        String username = req.getParameter("loginName");
        String password = req.getParameter("loginPassword");
        
        String error = null;
        SupplierUser loginUser = null;
        
        if (StringUtils.isEmpty(username)) {
            error = "请输入用户名";
        } else if (StringUtils.isEmpty(password)) {
            error = "请输入密码";
        } else {
        	SupplierUser supplierUser = new SupplierUser();
        	supplierUser.setSupName(username);
        	supplierUser.setSupPassword(password);
        	loginUser = supplierSupUserService.queryLoginUser(supplierUser);
        	
        	if (loginUser.getErrorMsg()!=null && !"".equals(loginUser.getErrorMsg())) {
                error = loginUser.getErrorMsg();
            }
        }
        
        if (error == null) {
            session.setAttribute(SessionKeys.LOGIN_SUP_USER, loginUser.getSupName());
            session.setAttribute(SessionKeys.SUP_ID, loginUser.getSupId());
            session.setAttribute(SessionKeys.SUP_CODE, loginUser.getSupCode());
            session.setAttribute(SessionKeys.SUP_USERNAMECN, loginUser.getSupUsernamecn());
            session.setAttribute(SessionKeys.SUP_TYPE, loginUser.getSupType());
            session.setAttribute(SessionKeys.SUP_CONTACT_NUM, loginUser.getContactNum());
            session.setAttribute(SessionKeys.COMPANY_IF_CHECK, loginUser.getIfCheck());
            String redirect = req.getParameter("redirect");
            
            if (StringUtils.isNotEmpty(redirect)) {
                map.put("href", redirect);
            } else {
                map.put("href", "0");
            }
            
        } else {
            map.put("error", error);
            map.put("userName", username);
            return "login";
        }
        return "login";
        
    }

    @RequestMapping("/ca/submit")
    public String caSubmit(HttpServletRequest req, HttpSession session, Map<String, Object> map) throws Exception {
        String redirect = req.getParameter("redirect");
        
        map.put("redirect", redirect);
        

        SecurityEngineDeal.setProfilePath(configHolder.getConfig("ca.profile.path"));
        
        SecurityEngineDeal sed = SecurityEngineDeal.getInstance(configHolder.getConfig("ca.webapp.name"));
        
        //获得登陆用户cert
        String clientCert = req.getParameter("UserCert");
        String UserSignedData = req.getParameter("UserSignedData");
        String ranStr = (String) session.getAttribute(SessionKeys.CA_RANDOM);

        String uniqueId = "";
        //验证客户端证书
        try {

            int retValue = sed.validateCert(clientCert);

            if (retValue == 1) {

                //session.setAttribute("ContainerName", ContainerName);

                try {
                    sed.getCertInfo(clientCert, 17);
                } catch (Exception e) {
                    map.put("error", "客户端证书验证失败:" + e.getMessage());
                    return "login_ca";
                }
               // session.setAttribute("UniqueID", uniqueIdStr);

                try {
                    //获得登陆用户ID
                    uniqueId = sed.getCertInfoByOid(clientCert,
                            "1.2.156.112562.2.1.1.1");
                } catch (Exception e) {
                    
                }
                if(uniqueId==null||(uniqueId!=null&&uniqueId.equals(""))){
                    try {
                        //获得登陆用户ID
                        uniqueId = sed.getCertInfoByOid(clientCert,
                                "2.16.840.1.113732.2");
                    } catch (Exception e) {
                        map.put("error", "客户端证书验证失败:" + e.getMessage());
                        return "login_ca";
                    }
                }
                
            } else {
                String str = "客户端证书验证失败！";

                if (retValue == -1) {
                    map.put("error", str + "登录证书的根不被信任");
                } else if (retValue == -2) {
                    map.put("error", str + "登录证书超过有效期");
                } else if (retValue == -3) {
                    map.put("error", str + "登录证书为作废证书");
                } else if (retValue == -4) {
                    map.put("error", str + "登录证书被临时冻结");
                } else if (retValue == -5) {
                    map.put("error", str + "登录证书未生效");
                } else {
                    map.put("error", str);
                }
                return "login_ca";
            }
        } catch (Exception ex) {
            map.put("error", "客户端证书验证失败:" + ex.getMessage());
            return "login_ca";
        }

        //验证客户端签名
        try {
            if (sed.verifySignedData(clientCert, ranStr, UserSignedData)) {
            
            } else {
                map.put("error", "验证客户端签名错误！");
                return "login_ca";
            }
        } catch (Exception e) {
            map.put("error", "验证客户端签名错误:" + e.getMessage());
            return "login_ca";
        }
        SupplierUser loginUser = null;;
        loginUser = supplierSupUserService.queryCompUser(uniqueId);
        
        if (loginUser == null) {
            map.put("error", "用户无效");
            return "login_ca";
        }


        session.setAttribute(SessionKeys.LOGIN_SUP_USER, loginUser.getSupName());
        session.setAttribute(SessionKeys.SUP_ID, loginUser.getSupId());
        session.setAttribute(SessionKeys.SUP_CODE, loginUser.getSupCode());
        session.setAttribute(SessionKeys.SUP_USERNAMECN, loginUser.getSupUsernamecn());
        session.setAttribute(SessionKeys.SUP_TYPE, loginUser.getSupType());
        session.setAttribute(SessionKeys.SUP_CONTACT_NUM, loginUser.getContactNum());
        session.setAttribute(SessionKeys.COMPANY_IF_CHECK, loginUser.getIfCheck());
        
        if (StringUtils.isNotEmpty(redirect)) {
            map.put("href", redirect);
        } else {
            map.put("href", "0");
        }

        
        session.setAttribute(SessionKeys.CA_UNIQUE_ID, uniqueId);
        session.removeAttribute(SessionKeys.CA_RANDOM);

        return "login_ca";
        
    }

	@RequestMapping("logout")
	public String logout(HttpSession session) {
		logger.info("用户退出登录");
		session.removeAttribute(SessionKeys.LOGIN_SUP_USER);
		session.removeAttribute(SessionKeys.SUP_ID);
        session.removeAttribute(SessionKeys.SUP_CODE);
        session.removeAttribute(SessionKeys.SUP_TYPE);
        session.removeAttribute(SessionKeys.CA_UNIQUE_ID);
		return "login";
	}
	@RequestMapping("isNoCheck")
	public String isNoCheck(HttpSession session) {
		logger.info("用户退出登录");
//		session.removeAttribute(SessionKeys.LOGIN_SUP_USER);
//		session.removeAttribute(SessionKeys.SUP_ID);
//        session.removeAttribute(SessionKeys.SUP_CODE);
//        session.removeAttribute(SessionKeys.SUP_TYPE);
		return "supplier_myinfo_nocheck";
	}

}
