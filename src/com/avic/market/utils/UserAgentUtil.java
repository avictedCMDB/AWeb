package com.avic.market.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

public class UserAgentUtil {

	private static String phoneReg = "\\b(ip(hone|od)|android|opera m(ob|in)i"    
            +"|windows (phone|ce)|blackberry"    
            +"|s(ymbian|eries60|amsung)|p(laybook|alm|rofile/midp"    
            +"|laystation portable)|nokia|fennec|htc[-_]"    
            +"|mobile|up.browser|[1-4][0-9]{2}x[1-4][0-9]{2})\\b"; 
	
    private static String tableReg = "\\b(ipad|tablet|(Nexus 7)|up.browser"    
            +"|[1-4][0-9]{2}x[1-4][0-9]{2})\\b";    
      
    private static Pattern phonePat = Pattern.compile(phoneReg, Pattern.CASE_INSENSITIVE);    
    private static Pattern padPat = Pattern.compile(tableReg, Pattern.CASE_INSENSITIVE); 
	
	public static boolean isPhone (String ua) {
		if (ua == null) {
			return false;
		}
        Matcher matcherPhone = phonePat.matcher(ua);    
        return matcherPhone.find() ? true : false;
	}
	
	public static boolean isPad (String ua) {
		if (ua == null) {
			return false;
		}
        Matcher matcherPad = padPat.matcher(ua);    
        return matcherPad.find() ? true : false;
	}
	
	public static boolean isPhone (HttpServletRequest request) {
		return isPhone(request.getHeader("User-Agent"));
	}
	
}
