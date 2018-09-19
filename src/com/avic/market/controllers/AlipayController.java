package com.avic.market.controllers;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.avic.alipay.util.AlipayNotify;
import com.avic.common.shortMessage.ShortMessageUtils;
import com.avic.common.utils.CommonFileUtils;
import com.avic.common.utils.ConfigHolder;
import com.avic.market.cpi.CpiService;
import com.avic.market.models.Order;
import com.avic.market.models.PayFlow;
import com.avic.market.models.SettleData;
import com.avic.market.models.Supplier;
import com.avic.market.services.OrderService;
import com.avic.market.services.PayFlowService;
import com.avic.market.services.SettleService;
import com.avic.market.utils.DataCache;

@Controller
@RequestMapping("/alipay")
@Transactional
public class AlipayController {
    protected static final Log logger = LogFactory.getLog(AlipayController.class);
    
    @Autowired
    PayFlowService payFlowService;
    
    @Autowired
    OrderService orderService;

    @Autowired
    CpiService cpiService;
    
    @Autowired
    SettleService settleService;
    
    @Autowired
    DataCache dataCache;
    
    @Autowired
    ConfigHolder configHolder;
    
    @RequestMapping("/alipayNotify/{type:.*}")
    public String alipayNotify(@PathVariable("type") String type,Map<String, Object> map,HttpServletRequest req,HttpServletResponse resp,HttpSession httpSession) {
    	//��ȡ֧����POST����������Ϣ
    	Map<String,String> params = new HashMap<String,String>();
    	Map requestParams = req.getParameterMap();
    	for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
    		String name = (String) iter.next();
    		String[] values = (String[]) requestParams.get(name);
    		String valueStr = "";
    		for (int i = 0; i < values.length; i++) {
    			valueStr = (i == values.length - 1) ? valueStr + values[i]
    					: valueStr + values[i] + ",";
    		}
    		//����������δ����ڳ�������ʱʹ�á����mysign��sign�����Ҳ����ʹ����δ���ת��
    		//valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
    		params.put(name, valueStr);
    	}
    	
    	//��ȡ֧������֪ͨ���ز������ɲο������ĵ���ҳ����תͬ��֪ͨ�����б�(���½����ο�)//
    	//�̻�������
    	String out_trade_no="";
    	String trade_no = "";
    	String trade_status = "";
    	String error = "";
    	try {
			out_trade_no = new String(req.getParameter("out_trade_no").getBytes("ISO-8859-1"),"GBK");
			//֧�������׺�
	    	trade_no = new String(req.getParameter("trade_no").getBytes("ISO-8859-1"),"GBK");
	    	//����״̬
	    	trade_status = new String(req.getParameter("trade_status").getBytes("ISO-8859-1"),"GBK");
    	} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
    	PayFlow payFlow = null;
    	payFlow = payFlowService.getPayFlowByNo(out_trade_no);
    	if(AlipayNotify.verify(params,configHolder.getConfig("alipay.param.partner"),configHolder.getConfig("alipay.param.sign_type"),configHolder.getConfig("alipay.param.alipay_public_key"),configHolder.getConfig("alipay.param.input_charset"))){//��֤�ɹ�
    		//������������̻���ҵ���߼��������
             if (check(out_trade_no)) {
                 if (payFlow != null) {
                     if (payFlow.getPayStatus() != 1) {
                         payFlow.setPayStatus(1);
                         try {
                             payFlow.setResParam(new ObjectMapper().writeValueAsString(params));
                         } catch (Exception e) {
                         }

                         Order order = orderService.getOrderDetail(payFlow.getOrderId());
                         if(trade_status.equals("TRADE_FINISHED")){
                        	 //TODO �޷��˿����� �߼�����
                        	 
                         }else if (trade_status.equals("TRADE_SUCCESS")) {
                             if (order.getOrderStatus() != 15) {
                                 payFlow.setProcStatus(2);
                                 payFlow.setRemark("�������Ǵ�֧��״̬[" + order.getOrderStatus() + "]");
                                 error = "�������Ǵ�֧��״̬[" + order.getOrderStatus() + "]";
                             } else {
                                 orderService.updateOrderStatus(order.getOrderId(), 2);

                                 SettleData settle = new SettleData();
                                 settle.setBusiId(order.getOrderId());
                                 settle.setBusiType(1);
                                 settle.setCompanyName(orderService.getUserCompanyName(order.getUserId()));
                                 settle.setSettleAmount(order.getOrderAmountInit());
                                 settle.setSupId(order.getSupId());
                                 settle.setTotalNum(orderService.getGoodsSum(order.getOrderId()));

                                 settleService.insertSettleData(settle);

                                 payFlow.setProcStatus(1);
                                 payFlow.setRemark("����֧���ɹ�");
                                 Supplier sup = dataCache.getSupplier(order.getSupId());
                                 if (sup.getSupType() == 0) {
                                     try {
                                         CpiService.getInstance().orderConfirm(order.getSupId(), order.getOrderId(), order.getSupOrderId());
                                     } catch (Exception e) {
                                         payFlow.setProcStatus(2);
                                         payFlow.setRemark("֧���ɹ�������Ӧ��ȷ�϶���ʧ��");
                                         error = "֧���ɹ�������Ӧ��ȷ�϶���ʧ��";
                                         logger.error("��Ӧ��ȷ�϶���ʧ��", e);
                                     }
                                     
                                     }
                                 try {
                                     String path = OrderController.class.getResource("/").getPath();
                                     String websiteURL = (path.replace("/build/classes", "").replace("%20"," ").replace("classes/", "") + "message.properties");
                                     StringBuffer msg = new StringBuffer();
                                     String subMsg1 = CommonFileUtils.getMsg(websiteURL,"pay1");
                                     String subMsg2 = CommonFileUtils.getMsg(websiteURL,"pay2");
                                     msg.append(subMsg1).append(order.getOrderId()).append(subMsg2);
                                     ShortMessageUtils.sendSMS(new String[]{orderService.getUserContactNum(order.getUserId())}, msg.toString()); 
                                 } catch (Exception e) {
                                     logger.error("���ŷ���ʧ��", e);
                                 }
                             }
                         } else {
                             payFlow.setProcStatus(2);
                             payFlow.setRemark("����֧��ʧ��");
                             error = "����֧��ʧ��";
                             map.put("error", error);
                             return "order/alipay_fail";
                         }

                         payFlowService.updatePayFlow(payFlow);
                     } else {
                         if (payFlow.getProcStatus() == 2) {
                             error = payFlow.getRemark();
                         }
                     }
                 } else {
                     error = "֧����ˮ��Ч";
					 map.put("error", error);
                     return "order/alipay_fail";
                 }

                 release(out_trade_no);
             } else {
                 payFlow = payFlowService.getPayFlowByNo(out_trade_no);
                 if (payFlow.getProcStatus() == 2) {
                     error = payFlow.getRemark();
                 }
             }

             try {
                 if (type.equals("notifyurl")) {
                     resp.getWriter().write("success");
                     return null;
                 }
                 map.put("error", "֧���ɹ�����л���Ļݹˣ�");
                 map.put("orderId", payFlow.getOrderId());
                 map.put("payAmount", payFlow.getPayAmount());
                 map.put("payGate", payFlow.getPayGate());
                 return "order/alipay_success";
             } catch (IOException e) {
             }
             
         } else {//��֤ʧ��
                 if (type.equals("notifyurl") || type.equals("returnurl")) {
                	 if(trade_status.equals("TRADE_FINISHED")||trade_status.equals("TRADE_SUCCESS")){
                		 try {
                			 if(type.equals("notifyurl")){
                				 resp.getWriter().write("fail");
                				 return null;
                			 }
	                         map.put("error", "֧���ɹ�������ԭ��,��֧�����ٴ�ȷ�ϣ�");
	                         map.put("orderId", payFlow.getOrderId());
	                         map.put("payAmount", payFlow.getPayAmount());
	                         map.put("payGate", payFlow.getPayGate());
						} catch (IOException e) {
							e.printStackTrace();
						}
                         return "order/alipay_success";
                     }else{
                    	 map.put("error", "֧��ʧ��");
                    	 return "order/alipay_fail";
                     }
                     
                 }
 		}

 		//�������������ҵ���߼�����д�������ϴ�������ο�������
// 		try {
//				resp.getWriter().write("success");
//			} catch (IOException e) {
//				e.printStackTrace();
//			}	
			return null;	//�벻Ҫ�޸Ļ�ɾ��
    }
    
    
    private List<String> locks = new ArrayList<String>();

    private synchronized boolean check(String payFlow) {
        if (locks.contains(payFlow)) {
            return false;
        }

        locks.add(payFlow);
        return true;
    }

    private synchronized void release(String payFlow) {
        locks.remove(payFlow);
    }
    
}