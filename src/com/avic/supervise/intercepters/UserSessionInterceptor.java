package com.avic.supervise.intercepters;

import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.avic.common.beans.ResultObject;
import com.avic.common.constants.SessionKeys;
import com.avic.supervise.models.User;

public class UserSessionInterceptor implements HandlerInterceptor {


    @Override
    public void afterCompletion(HttpServletRequest req,
            HttpServletResponse res, Object action, Exception view)
            throws Exception {

    }

    @Override
    public void postHandle(HttpServletRequest req, HttpServletResponse res,
            Object action, ModelAndView view) throws Exception {
    	
    }
    static String nocheckUrl = "/companyMyInfo/checkIfCheck,/companyMyInfo,/index,/companyMyInfo/loadSubArea";
    
    static String phoneReg = "\\b(ip(hone|od)|android|opera m(ob|in)i"    
            +"|windows (phone|ce)|blackberry"    
            +"|s(ymbian|eries60|amsung)|p(laybook|alm|rofile/midp"    
            +"|laystation portable)|nokia|fennec|htc[-_]"    
            +"|mobile|up.browser|[1-4][0-9]{2}x[1-4][0-9]{2})\\b"; 
    
    @Override
    public boolean preHandle(HttpServletRequest request,
            HttpServletResponse response, Object action) throws Exception {
    	
        
        HttpSession session = request.getSession();
        String servlet = request.getPathInfo();
        
        if (servlet.contains("refund/callback")) {
            return true;
        }
        
        User user = (User) session.getAttribute(SessionKeys.LOGIN_SUPERVISE);
        if (user == null) {
            boolean json = false;
    
            if (action instanceof HandlerMethod) {
                HandlerMethod handler = (HandlerMethod) action;
                Method method = handler.getMethod();
    
                if (method.getAnnotation(ResponseBody.class) != null) {
                    json = true;
                }
            }
            
    
            PrintWriter out = null;
            
            ObjectMapper mapper = new ObjectMapper();
            
            if (json) {
                response.setContentType("application/json; charset=gbk");
                out = response.getWriter();
                out.print(mapper.writeValueAsString(new ResultObject(-100, "�û�δ��¼")));
            } else {
                //response.setContentType("text/html; charset=gbk");
                //response.sendRedirect(request.getContextPath() + "/supervise/login");
                response.setStatus(302); 
                response.setHeader("Location", request.getContextPath() + "/supervise/login");
            }

            return false;
        }
        
        List<String> checkUrls = Arrays.asList(nocheckUrl.split(","));
		if(checkUrls.contains(servlet)){
				return true;
		}
		
        String ifCHeck = "";
        if(session.getAttribute(SessionKeys.COMPANY_IF_CHECK)!=null){
        	ifCHeck = (String) session.getAttribute(SessionKeys.COMPANY_IF_CHECK);
        }
       
        if(!"1".equals(ifCHeck)){
        	response.setStatus(303); 
            response.setHeader("Location", request.getContextPath() + "/supervise/companyMyInfo/checkIfCheck");
            return false;
        }
        return true;
    }

}
