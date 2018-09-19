package com.avic.market.intercepters;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.avic.market.utils.UserAgentUtil;

public class UserAgentInterceptor implements HandlerInterceptor {
	

    protected static final Log logger = LogFactory.getLog(UserAgentInterceptor.class);
    protected static final ObjectMapper objectMapper = new ObjectMapper();

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object object, Exception exception)
			throws Exception {

	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object object, ModelAndView mv)
			throws Exception {
		if (mv != null && mv.getViewName() != null && UserAgentUtil.isPhone(request.getHeader("User-Agent")) && !mv.getViewName().startsWith("forward:")) {
			mv.setViewName("m/" + mv.getViewName());
		}
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object action) throws Exception {
		logger.debug("UserAgent : " + request.getHeader("User-Agent"));
		return true;
	}

}
