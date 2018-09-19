package com.avic.supervise.controllers;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.avic.common.constants.SessionKeys;
import com.avic.management.models.SupArea;
import com.avic.passport.models.Menu;
import com.avic.supervise.models.CodeList;
import com.avic.supervise.models.Company;
import com.avic.supervise.models.CompanyInfo;
import com.avic.supervise.models.CompanyMyInfo;
import com.avic.supervise.models.DepartmentNode;
import com.avic.supervise.models.Node;
import com.avic.supervise.models.OrganizationInfoNode;
import com.avic.supervise.models.Role;
import com.avic.supervise.models.User;
import com.avic.supervise.services.CodeListService;
import com.avic.supervise.services.CompanyInfoService;
import com.avic.supervise.services.CompanyMyInfoService;
import com.avic.supervise.services.CompanyService;
import com.avic.supervise.services.SupAreaService;
import com.avic.supervise.services.UserService;

@Controller
@RequestMapping("/companyInfo")
public class OrganizationInfoController {
    protected static final Log logger = LogFactory.getLog(OrganizationInfoController.class);
    static final int PAGE_SIZE = 10; //ÿҳ��ʾ������
    @Autowired
    CompanyInfoService companyInfoService;
    @Autowired
    UserService userService;
    @Autowired
    CompanyMyInfoService companyMyInfoService;
    @Autowired
    CodeListService codeListService;
    
    @Autowired
    SupAreaService areaService;
    
	
	 	/**
	 	 * ��ѯ���β���
	 	 * @param companyInfo
	 	 * @param map
	 	 * @param httpSession
	 	 * @return
	 	 * @throws UnsupportedEncodingException 
	 	 */
	 	@RequestMapping("/organizationInfo")
	    public String organizationInfo(@ModelAttribute("companyInfo") CompanyInfo companyInfo,HttpServletRequest req,Map<String, Object> map,HttpSession httpSession) throws UnsupportedEncodingException {
	        logger.info("��ʼ���༭��˾");
	        User user = (User) httpSession.getAttribute(SessionKeys.LOGIN_SUPERVISE);
	        User userParam = new User();
	        String userName = req.getParameter("userName");
        	String contactPerson = req.getParameter("contactPerson");
        	String contactNum = req.getParameter("contactNum");
        	userParam.setUserName(userName);
        	userParam.setContactPerson(contactPerson);
        	userParam.setContactNum(contactNum);
        	
	        if(companyInfo.getSearCompanyCode() != null && !"".equals(companyInfo.getSearCompanyCode())){
	        	//User user = (User) httpSession.getAttribute(SessionKeys.LOGIN_SUPERVISE);
	        	userParam.setCompanyId(companyInfo.getSearCompanyCode());
	        	 map.put("searCompanyCode", companyInfo.getSearCompanyCode());
	        }else{
	        	userParam.setCompanyId(user.getCompanyId());
	        }
	        companyInfo.setCompanyCode(user.getCompanyId());
     		
     		// ��ҳ��Ϣ
     		String page = String.valueOf(companyInfo.getPage());

     		int total = userService.getUsersCount(userParam);

     		int pages = (int) Math.ceil((double) total / userParam.getPageSize());
     		
     		userParam.setPage(Integer.parseInt(page));

     		List<User> userList = userService.getUsersList(userParam);
     		
     		map.put("userList", userList);
     		map.put("page", page);
     		map.put("total", total);
     		map.put("pages", pages);
     		map.put("pageAction",
     				"supervise/companyInfo/organizationInfo"+ "?page=%PAGE%"+ "&username="+ URLEncoder.encode(userParam.getUserName() == null ? "": userParam.getUserName(), "GBK")
     						+ "&searCompanyCode="+URLEncoder.encode(companyInfo.getSearCompanyCode() == null ? "": companyInfo.getSearCompanyCode(), "GBK")
     						+ "&companyCode="+URLEncoder.encode(companyInfo.getCompanyCode() == null ? "": companyInfo.getCompanyCode(), "GBK")
     						+ "&contactPerson="+ URLEncoder.encode(userParam.getContactPerson() == null ? "": userParam.getContactPerson(), "GBK")
     						+ "&contactNum=" + (userParam.getContactNum() == null ?"":userParam.getContactNum()));
	        
	        List<OrganizationInfoNode> organizationInfoNodes = new ArrayList<OrganizationInfoNode>();
	        organizationInfoNodes = companyInfoService.queryOrganizationInfoNodes(companyInfo);
	        
	        //��ѯ���л���
	        List<CompanyInfo> organizationDepartments = new ArrayList<CompanyInfo>();
	        organizationDepartments = companyInfoService.queryOrganizationDepartments(companyInfo);
	        CompanyInfo ci = new CompanyInfo();
	        ci.setId(user.getCompanyId());
	        ci = companyInfoService.queryCompanyInfo(ci);
	        
	        map.put("user", userParam);
	        map.put("companyNameRoot", ci.getCompanyName());
	        map.put("departments", organizationInfoNodes);
	        map.put("companyCode", companyInfo.getCompanyCode());
	        map.put("organizationDepartments", organizationDepartments);
	        return "companyInfo/supervise_organization_info";
	    }
	 	
	 	@RequestMapping("/saveOrganiizationInfo")
	 	@ResponseBody
	    public Object saveOrganiizationInfo(@ModelAttribute("companyInfo") CompanyInfo companyInfo,HttpSession httpSession) {
	 		logger.info("���ӹ�˾");
	        Map<String, String> result = new HashMap<String, String>();
	        User user = (User) httpSession.getAttribute(SessionKeys.LOGIN_SUPERVISE);
	        String companyCodeSeq = companyInfoService.getSeqID();
	        companyInfo.setId(companyCodeSeq);
	        companyInfo.setCompanyCode(companyCodeSeq);
	        companyInfo.setCreateUser(user.getUserId());
	        int companyCount = companyInfoService.getCompanyInfoCountByCompanyName(companyInfo);
	        if(companyCount>0){
	        	result.put("status","��˾�����Ѿ����ڣ�");
	        	return result;
	        }else{
	        	companyInfoService.addCompanyInfo(companyInfo);
	        	result.put("status","success");
	        }
	        return result;
	    }
	 	
	 	@RequestMapping("/updateOrganiizationInfo")
	 	@ResponseBody
	    public Object updateOrganiizationInfo(HttpServletRequest req,@ModelAttribute("companyInfo") CompanyInfo companyInfo,HttpSession httpSession) {
	 		logger.info("�޸Ļ���");
	        Map<String, String> result = new HashMap<String, String>();
	        User user = (User) httpSession.getAttribute(SessionKeys.LOGIN_SUPERVISE);
	        
	        companyInfo.setCompanyCode(companyInfo.getId());
	        companyInfo.setCreateUser(user.getUserId());
	        int companyCount = companyInfoService.getCompanyInfoCountByCompanyName(companyInfo);
	        if(companyCount>0){
	        	result.put("status","��˾�����Ѿ����ڣ�");
	        	return result;
	        }else{
	        	companyInfoService.updateCompanyInfo(companyInfo);
	        	result.put("status","success");
	        }
	        return result;
	    }
	 	
	 	@RequestMapping("/delOrganiizationInfo")
	 	@ResponseBody
	    public Object delOrganiizationInfo(@ModelAttribute("companyInfo") CompanyInfo companyInfo,HttpSession httpSession) {
	 		logger.info("ɾ������");
	        Map<String, String> result = new HashMap<String, String>();
	        companyInfo.setCompanyCode(companyInfo.getId());
	        int userCount = companyInfoService.queryOrganizationUserCount(companyInfo);
	        if(userCount>0){
	        	result.put("status", "havaUsersError");
	        	return result;
	        }
	        companyInfoService.deleteCompanyDepartments(companyInfo);
	        result.put("status","success");
	        return result;
	    }
	 	
	 	@RequestMapping("/showOrganizationInfo")
	 	@ResponseBody
	    public Object showOrganizationInfo(@ModelAttribute("companyInfo") CompanyInfo companyInfo,HttpSession httpSession) {
	 		logger.info("��ѯ����");
	        Map<String, Object> result = new HashMap<String, Object>();
	        User user = (User) httpSession.getAttribute(SessionKeys.LOGIN_SUPERVISE);
	        CompanyInfo ci = new CompanyInfo();
	        ci = companyInfoService.queryCompanyInfo(companyInfo);
	        result.put("companyInfo",ci);
	        return result;
	    }
	 	
}