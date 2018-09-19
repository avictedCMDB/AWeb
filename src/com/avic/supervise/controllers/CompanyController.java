package com.avic.supervise.controllers;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.avic.supervise.models.Company;
import com.avic.supervise.services.CompanyService;

@Controller
@RequestMapping("/company")
public class CompanyController {
    protected static final Log logger = LogFactory.getLog(CompanyController.class);
    static final int PAGE_SIZE = 5; //ÿҳ��ʾ������
    @Autowired
    CompanyService companyService;
    
	@RequestMapping("")
    public String index(@ModelAttribute("company") Company company,HttpServletRequest req,Map<String, Object> map,HttpSession httpSession) {
        logger.info("�ɹ���λ��ѯ");
        //��ѯ�����ɹ���λ�б�
        List<Company> cooperateCompanys = new ArrayList<Company>();
        cooperateCompanys = companyService.queryCooperateCompany(company);
        
        
		String page = req.getParameter("page");
		
		int pageNum = 1;
		 
        if (StringUtils.isNumeric(page)) {
            pageNum = Integer.parseInt(page);
        }
        //��ѯ����
        int total = companyService.getCompanyCount(company);

        int pages = (int) Math.ceil((double) total / PAGE_SIZE);
        
        if (pageNum > pages) {
            pageNum = pages;
        }
        //��ѯ�޺����ɹ���λ�б�
        List<Company> noCooperateCompanys = new ArrayList<Company>();
        company.setPage(pageNum);
        company.setPageSize(PAGE_SIZE);
        noCooperateCompanys = companyService.queryNoCooperateCompany(company);
        
        map.put("noCooperateCompanys", noCooperateCompanys);
        map.put("cooperateCompanys", cooperateCompanys);
        map.put("company", company);
        map.put("page", pageNum);
        map.put("total", total);
        map.put("pages", pages);
        try {
			map.put("pageAction","supervise/company?companyName="+URLEncoder.encode(company.getCompanyName()==null?"":company.getCompanyName(), "GBK")+"&page=%PAGE%");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
        return "company/supervise_company_form";
    }
	
	
	 	@RequestMapping("/addCompany")
	    public String addCompany(@ModelAttribute("company") Company company,Map<String, Object> map,HttpSession httpSession,RedirectAttributes attr) {
	        logger.info("��Ӳɹ���λ");
			
	        companyService.addCompanyMapping(company);
	        attr.addAttribute("supID",company.getSupID());
	        attr.addAttribute("companyName",company.getCompanyName());
	        return "redirect:/supervise/company";
	    }
	 	
	 	@RequestMapping("/delCompany")
	    public String delCompany(@ModelAttribute("company") Company company,Map<String, Object> map,HttpSession httpSession,RedirectAttributes attr) {
	        logger.info("ɾ���ɹ���λ");
			
	        companyService.delCommpanyMapping(company);
	        attr.addAttribute("supID",company.getSupID());
			attr.addAttribute("companyName",company.getCompanyName());
	        return "redirect:/supervise/company";
	    }
}
