package com.avic.market.handlers;

import java.io.PrintWriter;
import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.avic.common.beans.ResultObject;
import com.avic.common.exceptions.NoPermissionException;
import com.avic.common.exceptions.PageNotFoundException;
import com.avic.common.exceptions.UserNotLoginException;



public class ExceptionHandler implements HandlerExceptionResolver {
    private static final Log logger = LogFactory.getLog(ExceptionHandler.class);

	@Override
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object action, Exception e) {
		
		
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
		} else {
	        response.setContentType("text/html; charset=gbk");
		}
		try {

	        if (e instanceof PageNotFoundException) {
	            out = response.getWriter();
                response.setStatus(404);
                out.print("页面未找到");
                
                logger.error("页面未找到");
	        } else if (e instanceof UserNotLoginException) {
                logger.error("用户未登录");
	            if (json) {
	                out = response.getWriter();
	                out.print(mapper.writeValueAsString(new ResultObject(-100, "用户未登录")));
	            } else {
	                return new ModelAndView("redirect:/passport/login");
	            }
	        } else if (e instanceof NoPermissionException) {
                logger.error("用户无权限");
	            out = response.getWriter();
                if (json) {
                    out.print(mapper.writeValueAsString(new ResultObject(-200, "用户无权限")));
                } else {
                    response.setStatus(403);
                    out.print("您没有访问这个功能的权限");
                }
	        } else {
                logger.error(e.getMessage(), e);
	            out = response.getWriter();
                if (json) {
                    out.print(mapper.writeValueAsString(new ResultObject(-999, e.getMessage())));
                } else {
                    out.print(e.getMessage());
                }
	        }
		} catch (Exception ex) {
	        logger.error("Error page exception", e);
		} finally {
			if (out != null) {
				out.close();
			}
		}

		return null;
	}
}
