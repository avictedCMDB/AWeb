package com.avic.supplier.controllers;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.constants.SessionKeys;
import com.avic.supplier.models.SupplierAddress;
import com.avic.supplier.models.SupplierCodeList;
import com.avic.supplier.models.SupplierExchange;
import com.avic.supplier.models.SupplierGoodsImage;
import com.avic.supplier.services.SupplierAddressService;
import com.avic.supplier.services.SupplierExchangeService;
import com.avic.supplier.services.SupplierGoodsInfoService;
import com.avic.supplier.services.SupplierOrderService;

@Controller
@RequestMapping("/exchange")
public class SupplierExchangeController {

	protected static final Log logger = LogFactory
			.getLog(SupplierExchangeController.class);
	
	@Autowired
	SupplierExchangeService supplierExchangeService;
	
    @Autowired
    SupplierAddressService supplierAddressService;
	
    @Autowired
	SupplierOrderService supplierOrderService;
    
    @Autowired
	SupplierGoodsInfoService supplierGoodsInfoService;
	/**
	 * ҳ���ʼ������
	 * 
	 * @param map
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("")
	public String index(Map<String, Object> map,
			@ModelAttribute("SupplierExchange") SupplierExchange supplierOrderParam,
			HttpSession httpSession) throws UnsupportedEncodingException {
		logger.info("��Ӧ�̻�����Ϣ����");
		if (supplierOrderParam.getExchangeStatus() == null) {
			supplierOrderParam.setExchangeStatus("");
		}
		//��session��ȡuserid
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        supplierOrderParam.setSupId(supId);
        List<SupplierExchange> ordersList = supplierExchangeService.queryExchangeOrderList(supplierOrderParam);
        //����״̬��ʼ�������
        List<SupplierCodeList> ordersStatusList = supplierExchangeService.queryExchangeOrderStatusList();
        map.put("ordersList", ordersList);//��ѯ�����
        map.put("orderQuery", supplierOrderParam);//��ѯ��������
        map.put("ordersStatusList", ordersStatusList);//����״̬�б�����
        //��ҳ��Ϣ
		String page = String.valueOf(supplierOrderParam.getPage());
		
        int total = supplierExchangeService.queryExchangeOrderListCount(supplierOrderParam);

        int pages = (int) Math.ceil((double) total / supplierOrderParam.getPageSize());
        
        map.put("page", page);
        map.put("total", total);
        map.put("pages", pages);
        map.put("pageAction","supplier/exchange?"
        		+ "&exchangeTimeStar="+(supplierOrderParam.getExchangeTimeStar() == null ? "":supplierOrderParam.getExchangeTimeStar())
        		+ "&exchangeTimeEnd="+(supplierOrderParam.getExchangeTimeEnd() == null ? "":supplierOrderParam.getExchangeTimeEnd())
        		+ "&exchangeId="+(supplierOrderParam.getExchangeId() == null ? "":supplierOrderParam.getExchangeId())
        		+ "&companyname="+URLEncoder.encode((supplierOrderParam.getCompanyname() == null ? "":supplierOrderParam.getCompanyname()),"GBK")
        		+ "&orderId="+(supplierOrderParam.getOrderId() == null ? "":supplierOrderParam.getOrderId())
        		+ "&exchangeStatus="+(supplierOrderParam.getExchangeStatus() == null ? "":supplierOrderParam.getExchangeStatus())
                + "&page=%PAGE%");
		return "order/supplier_exchange";
	}
	
	/**
	 * ҳ���ʼ������
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/exchangeConfirmPage/{exchangeId}")
	public String exchangeConfirmPage(Map<String, Object> map,
			@PathVariable("exchangeId") String exchangeId,
			HttpSession httpSession) {
		logger.info("��Ӧ�̻�����Ϣ���ҳ��");
		//��session��ȡuserid
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        //��ȡ��Ӧ�̵�ַ
        SupplierAddress supplierAddress = new SupplierAddress();
        supplierAddress.setSupId(supId);
      //��ͳ��Ӧ��Ĭ�ϵ�ַΪ�����ַ
		if ("1".equals(httpSession.getAttribute(SessionKeys.SUP_TYPE).toString())) {
			// ����Ϊ�����ַ
			supplierAddress.setAreSupId("1");
			
		}else {
			supplierAddress.setAreSupId(supId);
		}
        List<SupplierAddress> supplierAddressList = supplierAddressService.querySupplierAddressList(supplierAddress);
        map.put("supplierAddressList", supplierAddressList);
        // ��ȡ��Ʒ��Ϣ
        SupplierExchange supplierExchange = new SupplierExchange();
        supplierExchange.setSupId(supId);
        supplierExchange.setExchangeId(exchangeId);
        List<SupplierExchange> result = supplierExchangeService.queryExchangeOrderDetailed(supplierExchange);
        map.put("supplierExchangeList", result);
        map.put("exchangeId", exchangeId);
		return "order/supplier_exchange_confirm";
	}
	
	/**
	 * ��Ӧ����Ʒ���ȷ��
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/exchangeConfirm")
	@ResponseBody
	public Object exchangeConfirm(@RequestParam("exchangeStatus") String exchangeStatus,
			@RequestParam("supplierAddressId") String supplierAddressId,
			@RequestParam("supCheckInfo") String supCheckInfo,
			@RequestParam("exchangeId") String exchangeId,
			HttpSession httpSession) {
		logger.info("��Ӧ�̻�����Ϣ���ȷ��");
		String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
		SupplierExchange supplierExchange = new SupplierExchange();
		supplierExchange.setExchangeId(exchangeId);
		supplierExchange.setSupplierAddressId(supplierAddressId);
		supplierExchange.setSupCheckInfo(supCheckInfo);
		supplierExchange.setExchangeStatus(exchangeStatus);
		supplierExchange.setSupId(supId);
		supplierExchangeService.updateExchangeOrderStatus(supplierExchange);
		return "0";
	}
	/**
	 * ��Ӧ����Ʒ�ջ�ȷ��
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/exchangeDelivery")
	@ResponseBody
	public Object exchangeDelivery(@RequestParam("exchangeStatus") String exchangeStatus,
			@RequestParam("exchangeId") String exchangeId,
			HttpSession httpSession) {
		logger.info("��Ӧ����Ʒ�ջ�ȷ��");
		String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
		SupplierExchange supplierExchange = new SupplierExchange();
		supplierExchange.setExchangeId(exchangeId);
		supplierExchange.setExchangeStatus(exchangeStatus);
		supplierExchange.setSupId(supId);
		supplierExchangeService.updateExchangeOrderStatus(supplierExchange);
		return "0";
	}
	/**
	 * ҳ���ʼ������
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/queryDetailed/{exchangeId}")
	public String queryDetailed(Map<String, Object> map,
			@PathVariable("exchangeId") String exchangeId,
			HttpSession httpSession) {
		logger.info("��Ӧ�̻�����Ϣ���ҳ��");
		//��session��ȡuserid
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        //��ȡ������Ϣ
        SupplierExchange supplierExchangeDetailed = new SupplierExchange();
        supplierExchangeDetailed.setSupId(supId);
        supplierExchangeDetailed.setExchangeId(exchangeId);
        List<SupplierExchange> ordersList = supplierExchangeService.queryExchangeOrderList(supplierExchangeDetailed);
        
        map.put("supplierExchangeDetailed", ordersList.get(0));
        // ��ȡ��Ʒ��Ϣ
        SupplierExchange supplierExchange = new SupplierExchange();
        supplierExchange.setSupId(supId);
        supplierExchange.setExchangeId(exchangeId);
        List<SupplierExchange> resultList = supplierExchangeService.queryExchangeOrderDetailed(supplierExchange);
        //��ѯ����
        SupplierGoodsImage supplierGoodsImage = new SupplierGoodsImage();
        supplierGoodsImage.setBusinessId(exchangeId);
        supplierGoodsImage.setBusinessType("1");
        List<SupplierGoodsImage> imageList = supplierGoodsInfoService.queryImage(supplierGoodsImage);
        map.put("imageList", imageList);
        map.put("supplierExchangeList", resultList);
        map.put("exchangeId", exchangeId);
		return "order/supplier_exchange_check";
	}
	
	/**
	 * ҳ���ʼ������
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/exchangeSendPage/{exchangeId}")
	public String exchangeSendPage(Map<String, Object> map,
			@PathVariable("exchangeId") String exchangeId,
			HttpSession httpSession) {
		logger.info("��Ӧ�̻���������Ϣ���ҳ��");
		//��session��ȡuserid
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        //��ȡ������Ϣ
        SupplierExchange supplierExchangeDetailed = new SupplierExchange();
        supplierExchangeDetailed.setSupId(supId);
        supplierExchangeDetailed.setExchangeId(exchangeId);
        List<SupplierExchange> ordersList = supplierExchangeService.queryExchangeOrderList(supplierExchangeDetailed);
        
        map.put("supplierExchangeDetailed", ordersList.get(0));
        // ��ȡ��Ʒ��Ϣ
        SupplierExchange supplierExchange = new SupplierExchange();
        supplierExchange.setSupId(supId);
        supplierExchange.setExchangeId(exchangeId);
        List<SupplierExchange> resultList = supplierExchangeService.queryExchangeOrderDetailed(supplierExchange);
        map.put("supplierExchangeList", resultList);
        map.put("exchangeId", exchangeId);
        //��ȡ������Ϣ
        
		return "order/supplier_exchange_send";
	}
    /**
     * ����
     * @param map
     * @return
     */
    @RequestMapping("/exchaneGoodsSend/{exchangeId}")
    public String exchaneGoodsSend(Map<String, Object> map,@PathVariable("exchangeId") String exchangeId,@ModelAttribute("SupplierExchange") SupplierExchange supplierOrderParam,
    		HttpSession httpSession) {
        logger.info("��������");
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        supplierOrderParam.setSupId(supId);
        supplierOrderParam.setExchangeStatus("5");
        supplierOrderParam.setExchangeId(exchangeId);
        supplierExchangeService.updateExchangeOrderStatus(supplierOrderParam);
        return "redirect:/supplier/exchange";
    }
    /**
     * ���ط���
     * @param map
     * @param addressID
     * @return
     */
    @RequestMapping("/back")
    public String backSupplierAddress(Map<String, Object> map) {
        logger.info("���ػ�������");
        return "redirect:/supplier/exchange";
    }
}
