package com.avic.supervise.controllers;

import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.beans.ResultObject;
import com.avic.common.constants.UserRole;
import com.avic.common.exceptions.NoPermissionException;
import com.avic.common.exceptions.UserNotLoginException;
import com.avic.common.utils.Permission;
import com.avic.management.models.MarketAddress;
import com.avic.passport.models.User;
import com.avic.supervise.models.Company;
import com.avic.supervise.models.Count;
import com.avic.supervise.models.Invoice;
import com.avic.supervise.models.SupInfo;
import com.avic.supervise.services.CountService;
import com.avic.supervise.services.InvoiceService;
import com.avic.supervise.services.SupService;

@Controller
@RequestMapping("/count")
public class CountController {
    protected static final Log logger = LogFactory.getLog(CountController.class);

    @Autowired
    CountService countService;
    @Autowired
    SupService supService;
    
    
    @RequestMapping("/supIndex")
    public String supIndex(HttpServletRequest req,Map<String, Object> map,HttpSession httpSession) {
        logger.info("ͳ�Ʒ�����Ӧ����ҳ");
        //��ѯ�������� ��Ӧ����
        List<SupInfo> supInfos = new ArrayList<SupInfo>();
        supInfos = supService.getSupList();
        map.put("supInfos", supInfos);
        return "count/supervise_count";
    }
    @RequestMapping("/companyIndex")
    public String companyIndex(HttpServletRequest req,Map<String, Object> map,HttpSession httpSession) {
        logger.info("ͳ�Ʒ�����ҵ��ҳ");
        //��ѯ�������� ��ҵ��
        List<Company> companies = new ArrayList<Company>();
        companies = countService.queryCompany();
        map.put("companies", companies);
        return "count/supervise_count2";
    }
    
    
    @RequestMapping("/sup")
    @ResponseBody
    public Object sup(@ModelAttribute("count") Count count,HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        List<Count> payCounts = new ArrayList<Count>();
        List<Count> refundCounts = new ArrayList<Count>();
        //�жϹ�Ӧ��ѡ���ѡ�����ѯ
        if("-1".equals(count.getSupID())||count.getSupID()==null){
        	//��ѯѡ��ȫ�� ����ͼͳ������--֧���ɹ��Ķ������������˿
        	payCounts = countService.queryCountSupAll(count);
        	refundCounts = countService.queryRefundCountSupAll(count);
        	if(refundCounts.size()>0){
            	for(int i =0;i<payCounts.size();i++){
            		for(int j =0;j<refundCounts.size();j++){           			
            			if(payCounts.get(i).getSupName().equals(refundCounts.get(j).getSupName())){
            				String payAmount = payCounts.get(i).getOrderAmount();
            				String refundAmount = refundCounts.get(j).getOrderAmount();
            			    String newAmount = String .valueOf(new Double(payAmount) - new Double(refundAmount));
            				payCounts.get(i).setOrderAmount(newAmount);
            				break;
            			}
            		}
            	}
       		
        	}       	
        }else{
        	//��ѯѡ��Ӧ������ͼͳ������
        	payCounts = countService.queryCountBySupID(count);
        	refundCounts = countService.queryRefundCountBySupID(count);
        	if(refundCounts.size()>0){
            	for(int i =0;i<payCounts.size();i++){
            		for(int j =0;j<refundCounts.size();j++){           			
            			if(payCounts.get(i).getOrderTime().equals(refundCounts.get(j).getOrderTime())){
            				String payAmount = payCounts.get(i).getOrderAmount();
            				String refundAmount = refundCounts.get(j).getOrderAmount();
            			    String newAmount = String .valueOf(new Double(payAmount) - new Double(refundAmount));
            				payCounts.get(i).setOrderAmount(newAmount);
            				break;
            			}
            		}
            	}
       		
        	}
        }
       
        map.put("counts", payCounts);
        return map;
    }
    @RequestMapping("/company")
    @ResponseBody
    public Object company(@ModelAttribute("count") Count count,HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        List<Count> payCounts = new ArrayList<Count>();
        List<Count> refundCounts = new ArrayList<Count>();
        List<Count> counts = new ArrayList<Count>();
        //�ж���ҵѡ���ѡ�����ѯ
        if("-1".equals(count.getCompanyID())||count.getCompanyID()==null){
        	//��ѯѡ��ȫ�� ����ͼͳ������
        	payCounts = countService.queryCountCompanyAll(count);
        	refundCounts = countService.queryRefundCountCompanyAll(count);
        	if(refundCounts.size()>0){
            	for(int i =0;i<payCounts.size();i++){
            		for(int j =0;j<refundCounts.size();j++){           			
            			if(payCounts.get(i).getCompanyName().equals(refundCounts.get(j).getCompanyName())){
            				String payAmount = payCounts.get(i).getOrderAmount();
            				String refundAmount = refundCounts.get(j).getOrderAmount();
            			    String newAmount = String .valueOf(new Double(payAmount) - new Double(refundAmount));
            				payCounts.get(i).setOrderAmount(newAmount);
            				break;
            			}
            		}
            	}
       		
        	}        	
        }else{
        	//��ѯѡ��Ӧ������ͼͳ������
        	payCounts = countService.queryCountByCompanyID(count);
        	refundCounts = countService.queryRefundCountByCompanyID(count);
        	if(refundCounts.size()>0){
            	for(int i =0;i<payCounts.size();i++){
            		for(int j =0;j<refundCounts.size();j++){           			
            			if(payCounts.get(i).getOrderTime().equals(refundCounts.get(j).getOrderTime())){
            				String payAmount = payCounts.get(i).getOrderAmount();
            				String refundAmount = refundCounts.get(j).getOrderAmount();
            			    String newAmount = String .valueOf(new Double(payAmount) - new Double(refundAmount));
            				payCounts.get(i).setOrderAmount(newAmount);
            				break;
            			}
            		}
            	}
       		
        	}        	
        }
       
        map.put("counts", payCounts);
        return map;
    }
}
