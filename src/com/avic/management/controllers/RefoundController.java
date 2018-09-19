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
import com.avic.management.models.AuditImageInfo;
import com.avic.management.models.CodeList;
import com.avic.management.models.Exchange;
import com.avic.management.models.Invoice;
import com.avic.management.models.OrderSnapshot;
import com.avic.management.models.Refound;
import com.avic.management.services.CodeListService;
import com.avic.management.services.CommonService;
import com.avic.management.services.ImageInfoService;
import com.avic.management.services.InvoiceService;
import com.avic.management.services.RefoundService;
import com.avic.passport.models.User;

@Controller
@RequestMapping("/refound")
@Transactional
public class RefoundController {
    protected static final Log logger = LogFactory.getLog(RefoundController.class);
    static final int PAGE_SIZE = 10; //ÿҳ��ʾ������
    @Autowired
    CommonService commonService;
    @Autowired
    RefoundService refoundService;
    @Autowired
    CodeListService codeListService;
    @Autowired
    ImageInfoService imageInfoService;
    
    @RequestMapping("")
    public String index(@ModelAttribute("refound") Refound refound,HttpServletRequest req,Map<String, Object> map,HttpSession httpSession) {
        logger.info("��Ʊ����");
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
        refound.setUserID(user.getUserId());
      //��ѯ����
        int total = refoundService.queryRefoundCount(refound);

        int pages = (int) Math.ceil((double) total / PAGE_SIZE);
        
        if (pageNum > pages) {
            pageNum = pages;
        }
		CodeList codeList = new CodeList();
		codeList.setCodeListType("REFUND_STATUS");
		List<CodeList> codes = new ArrayList<CodeList>();
		codes = codeListService.queryCodes(codeList);
		List<Refound> refounds = new ArrayList<Refound>();
		refound.setPage(pageNum);
		refound.setPageSize(PAGE_SIZE);
		refounds = refoundService.queryRefound(refound);
		map.put("codes", codes);
        map.put("refounds", refounds);
        map.put("refound", refound);
        map.put("page", pageNum);
        map.put("total", total);
        map.put("pages", pages);
        try {
			map.put("pageAction","management/refound?startTime=" + (refound.getStartTime()==null?"":refound.getStartTime()) 
								+ "&endTime=" + (refound.getEndTime()==null?"":refound.getEndTime()) 
								+ "&searchRefoundID=" + URLEncoder.encode(refound.getSearchRefoundID()==null?"":refound.getSearchRefoundID(), "GBK")
			                    + "&searchSupName=" + URLEncoder.encode(refound.getSearchSupName()==null?"":refound.getSearchSupName(), "GBK")
			                    + "&searchOrderID=" + URLEncoder.encode(refound.getSearchOrderID()==null?"":refound.getSearchOrderID(), "GBK")
			                    + "&searchRefoundStatus=" + URLEncoder.encode(refound.getSearchRefoundStatus()==null?"":refound.getSearchRefoundStatus(), "GBK")+ "&page=%PAGE%");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
        return "/refound/management_refound";
    }
    @RequestMapping("check/{refoundID}")
    public String refoundCheck(@PathVariable("refoundID")String refoundID,Map<String, Object> map,HttpSession httpSession) {
        logger.info("�鿴�˻���");
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
		//��ѯ��������ϸ��Ϣ
		Refound refound = new Refound();
		refound.setRefoundID(refoundID);
		refound = refoundService.queryRefoundByID(refound);
		//��Ʒ����
		List<OrderSnapshot> orderSnapshots = new ArrayList<OrderSnapshot>();
		OrderSnapshot orderSnapshot = new OrderSnapshot();
		orderSnapshot.setRefoundID(refoundID);
		orderSnapshot.setOrderId(refound.getOrderID());
		orderSnapshots = refoundService.queryOrderSnapshotsByRefoundID(refound);
		refound.setOrderSnapshots(orderSnapshots);
		//��ѯ����ͼƬ
		List<AuditImageInfo> auditImageInfos = new ArrayList<AuditImageInfo>();
		AuditImageInfo auditImageInfo = new AuditImageInfo();
		auditImageInfo.setBusinessID(refoundID);
		auditImageInfo.setBusinessType("2");
		auditImageInfos = imageInfoService.queryImages(auditImageInfo);
        map.put("refound", refound);
        map.put("imageInfos", auditImageInfos);
        return "/refound/management_refound_check";
    }
    
    @RequestMapping("send/{refoundID}")
    @Transactional
    public String sendRefoundOrder(@PathVariable("refoundID")String refoundID,Map<String, Object> map,HttpSession httpSession) {
        logger.info("��Ӧ���˻�");
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
		//��ѯ��������ϸ��Ϣ
		Refound refound = new Refound();
		refound.setRefoundID(refoundID);
		refound = refoundService.queryRefoundByID(refound);
		//��Ʒ����
		List<OrderSnapshot> orderSnapshots = new ArrayList<OrderSnapshot>();
		OrderSnapshot orderSnapshot = new OrderSnapshot();
		orderSnapshot.setRefoundID(refoundID);
		orderSnapshot.setOrderId(refound.getOrderID());
		orderSnapshots = refoundService.queryOrderSnapshotsByRefoundID(refound);
		refound.setOrderSnapshots(orderSnapshots);
        map.put("refound", refound);
        return "/refound/management_refound_send";
    }
    
    @RequestMapping("sendOrderRefound")
    @Transactional
    public String sendOrderRefound(@ModelAttribute("refound") Refound refound,Map<String, Object> map,HttpSession httpSession) {
        logger.info("�˻����ύ������");
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
		//�޸Ļ�����״̬
		refound.setRefoundStatus("3");
		refoundService.updateOrderRefoundStatus(refound);
		if("0".equals(refound.getExpressType())){
			refound.setRefoundExpressName("��Ӧ������");
		}
		//�޸��˻��������Ϣ
		refoundService.updateOrderRefoundExpressInfo(refound);
        return "redirect:/management/refound";
    }
    @RequestMapping("del/{refoundIDs}")
    @Transactional
    public String delOrderExchange(@PathVariable("refoundIDs")String refoundIDs,Map<String, Object> map,HttpSession httpSession) {
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
		String [] refoundIDArray = refoundIDs.split(",");
		for (int i = 0; i < refoundIDArray.length; i++) {
			Refound refound = new Refound();
			refound.setRefoundStatus("6");
			refound.setRefoundID(refoundIDArray[i]);
			refoundService.updateOrderRefoundStatus(refound);
		}
		
        return "redirect:/management/refound";
    }
}
