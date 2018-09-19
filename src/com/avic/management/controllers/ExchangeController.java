package com.avic.management.controllers;

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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.avic.common.constants.UserRole;
import com.avic.common.exceptions.NoPermissionException;
import com.avic.common.exceptions.UserNotLoginException;
import com.avic.common.utils.Permission;
import com.avic.management.models.Audit;
import com.avic.management.models.AuditImageInfo;
import com.avic.management.models.CodeList;
import com.avic.management.models.Exchange;
import com.avic.management.models.Invoice;
import com.avic.management.models.MarketAddress;
import com.avic.management.models.OrderSnapshot;
import com.avic.management.services.CodeListService;
import com.avic.management.services.CommonService;
import com.avic.management.services.ExchangeService;
import com.avic.management.services.ImageInfoService;
import com.avic.management.services.InvoiceService;
import com.avic.passport.models.User;

@Controller
@RequestMapping("/exchange")
@Transactional
public class ExchangeController {
    protected static final Log logger = LogFactory.getLog(ExchangeController.class);
    static final int PAGE_SIZE = 10; //ÿҳ��ʾ������
    @Autowired
    CommonService commonService;
    @Autowired
    ExchangeService exchangeService;
    @Autowired
    CodeListService codeListService;
    @Autowired
    ImageInfoService imageInfoService;
    
    @RequestMapping("")
    public String index(@ModelAttribute("exchange") Exchange exchange,HttpServletRequest req,Map<String, Object> map,HttpSession httpSession) {
        logger.info("��ѯ�������б�");
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
		
		String page = req.getParameter("page");
		
		int pageNum = 1;
		 
        if (StringUtils.isNumeric(page)) {
            pageNum = Integer.parseInt(page);
        }
        
        exchange.setUserID(user.getUserId());
        
       //��ѯ����
        int total = exchangeService.queryExchangeCount(exchange);

        int pages = (int) Math.ceil((double) total / PAGE_SIZE);
        
        if (pageNum > pages) {
            pageNum = pages;
        }
        
		CodeList codeList = new CodeList();
		codeList.setCodeListType("EXCHANGE_STATUS");
		List<CodeList> codes = new ArrayList<CodeList>();
		codes = codeListService.queryCodes(codeList);
		List<Exchange> exchanges = new ArrayList<Exchange>();
		
		exchange.setPage(pageNum);
		exchange.setPageSize(PAGE_SIZE);
		exchanges = exchangeService.queryExchange(exchange);
		map.put("codes", codes);
        map.put("exchanges", exchanges);
        map.put("exchange", exchange);
        map.put("page", pageNum);
        map.put("total", total);
        map.put("pages", pages);
        try {
			map.put("pageAction","management/exchange?startTime=" + (exchange.getStartTime()==null?"":exchange.getStartTime()) 
								+ "&endTime=" + (exchange.getEndTime()==null?"":exchange.getEndTime()) 
								+ "&searchExchangeID=" + URLEncoder.encode(exchange.getSearchExchangeID()==null?"":exchange.getSearchExchangeID(), "GBK")
			                    + "&searchSupName=" + URLEncoder.encode(exchange.getSearchSupName()==null?"":exchange.getSearchSupName(), "GBK")
			                    + "&searchOrderID=" + URLEncoder.encode(exchange.getSearchOrderID()==null?"":exchange.getSearchOrderID(), "GBK")
			                    + "&searchExchangeStatus=" + URLEncoder.encode(exchange.getSearchExchangeStatus()==null?"":exchange.getSearchExchangeStatus(), "GBK")+ "&page=%PAGE%");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
        return "management_exchange";
    }
    
    
    @RequestMapping("check/{exchangeID}")
    public String exchangeCheck(@PathVariable("exchangeID")String exchangeID,Map<String, Object> map,HttpSession httpSession) {
        logger.info("�鿴������");
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
		//��ѯ��������ϸ��Ϣ
		Exchange exchange = new Exchange();
		exchange.setExchangeID(exchangeID);
		exchange = exchangeService.queryExchangeByID(exchange);
		//��Ʒ����
		List<OrderSnapshot> orderSnapshots = new ArrayList<OrderSnapshot>();
		OrderSnapshot orderSnapshot = new OrderSnapshot();
		orderSnapshot.setExchangeID(exchangeID);
		orderSnapshot.setOrderId(exchange.getOrderID());
		orderSnapshots = exchangeService.queryOrderSnapshotsByOrderID(exchange);
		exchange.setOrderSnapshots(orderSnapshots);
		//��ѯ����ͼƬ
		List<AuditImageInfo> auditImageInfos = new ArrayList<AuditImageInfo>();
		AuditImageInfo auditImageInfo = new AuditImageInfo();
		auditImageInfo.setBusinessID(exchangeID);
		auditImageInfo.setBusinessType("1");
		auditImageInfos = imageInfoService.queryImages(auditImageInfo);
        map.put("exchange", exchange);
        map.put("imageInfos", auditImageInfos);
        return "management_exchange_check";
    }
    
    @RequestMapping("confirmation/{exchangeID}")
    @Transactional
    public String confirmationExchangeOrder(@PathVariable("exchangeID")String exchangeID,Map<String, Object> map,HttpSession httpSession) {
        logger.info("����-ȷ���ջ�");
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
		//exchange_status 6�ɹ���ȷ���ջ�
		Exchange exchange = new Exchange();
		exchange.setExchangeID(exchangeID);
		exchange.setExchangeStatus("6");
		exchangeService.updateOrderExchangeStatus(exchange);
		//�鿴�Ƿ񶩵��»���δȷ�ϵĻ����� �����޸Ķ���״̬ û���޸�
		int reCount = exchangeService.queryOrderExchangeReceiptCount(exchange);
		if(reCount<=0){
			//�޸Ķ���״̬  order_status 12�����ɹ�
			exchange.setOrderStatus(12);
			exchangeService.updateOrderStatusByExchangeID(exchange);
		}
        return "redirect:/management/exchange";
    }
    @RequestMapping("send/{exchangeID}")
    @Transactional
    public String sendExchangeOrder(@PathVariable("exchangeID")String exchangeID,Map<String, Object> map,HttpSession httpSession) {
        logger.info("��Ӧ�̻�������");
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
		//��ѯ��������ϸ��Ϣ
		Exchange exchange = new Exchange();
		exchange.setExchangeID(exchangeID);
		exchange = exchangeService.queryExchangeByID(exchange);
		//��Ʒ����
		List<OrderSnapshot> orderSnapshots = new ArrayList<OrderSnapshot>();
		OrderSnapshot orderSnapshot = new OrderSnapshot();
		orderSnapshot.setExchangeID(exchangeID);
		orderSnapshot.setOrderId(exchange.getOrderID());
		orderSnapshots = exchangeService.queryOrderSnapshotsByOrderID(exchange);
		exchange.setOrderSnapshots(orderSnapshots);
        map.put("exchange", exchange);
        return "management_exchange_send";
    }
    
    @RequestMapping("sendOrderExchange")
    @Transactional
    public String sendOrderExchange(@ModelAttribute("exchange") Exchange exchange,Map<String, Object> map,HttpSession httpSession) {
        logger.info("�������ύ������");
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
		//�޸Ļ�����״̬
		exchange.setExchangeStatus("3");
		exchangeService.updateOrderExchangeStatus(exchange);
		//�޸��˻��������Ϣ
		if("0".equals(exchange.getExpressType())){
			exchange.setExchangeExpressName("��Ӧ������");
		}
		exchangeService.updateOrderExchangeExpressInfo(exchange);
        return "redirect:/management/exchange";
    }
    @RequestMapping("del/{exchangeIDs}")
    @Transactional
    public String delOrderExchange(@PathVariable("exchangeIDs")String exchangeIDs,Map<String, Object> map,HttpSession httpSession) {
        logger.info("ȡ��������");
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
		//�޸Ļ�����״̬
		String [] exchangeIDArray = exchangeIDs.split(",");
		for (int i = 0; i < exchangeIDArray.length; i++) {
			Exchange exchange = new Exchange();
			exchange.setExchangeStatus("7");
			exchange.setExchangeID(exchangeIDArray[i]);
			exchangeService.updateOrderExchangeStatus(exchange);
		}
		
        return "redirect:/management/exchange";
    }
}