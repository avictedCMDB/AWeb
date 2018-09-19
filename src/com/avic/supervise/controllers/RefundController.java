package com.avic.supervise.controllers;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.Consts;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.annotate.JsonAnyGetter;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.alipayrefund.config.AlipayConfig;
import com.avic.alipayrefund.util.AlipayNotify;
import com.avic.alipayrefund.util.AlipaySubmit;
import com.avic.alipayrefund.util.UtilDate;
import com.avic.common.beans.ResultObject;
import com.avic.common.utils.ConfigHolder;
import com.avic.supervise.models.Order;
import com.avic.supervise.models.PayFlow;
import com.avic.supervise.models.Refund;
import com.avic.supervise.models.SettleData;
import com.avic.supervise.services.OrderService;
import com.avic.supervise.services.PayFlowService;
import com.avic.supervise.services.RefundService;
import com.avic.supervise.services.SettleService;
import com.avic.supervise.services.SupService;
import com.chinapay.secss.SecssUtil;

@Controller
@RequestMapping("/refund")
public class RefundController {
    protected static final Log logger = LogFactory.getLog(RefundController.class);

    static final int PAGE_SIZE = 10;
    
    @Autowired
    RefundService refundService;
    @Autowired
    SupService supService;
    @Autowired
    ConfigHolder configHolder;
    @Autowired
    PayFlowService payFlowService;
    @Autowired
    SettleService settleService;
    @Autowired
    OrderService orderService;

    @RequestMapping("/list")
    public String list(HttpServletRequest req, Map<String, Object> map) {
        String timeStart = req.getParameter("timeStart");
        String timeEnd = req.getParameter("timeEnd");
        String refundId = req.getParameter("refundId");
        String supId = req.getParameter("supId");
        String orderId = req.getParameter("orderId");
        String refundStatus = req.getParameter("refundStatus");
        String page = req.getParameter("page");
        
        logger.info("�˻��˿�-timeStart["+timeStart+"], timeEnd["+timeEnd+"], refundId["+refundId+"], supId["+supId+"], orderId["+orderId+"], refundStatus["+refundStatus+"], page["+page+"]");

        int pageNum = 1;

        if (StringUtils.isNumeric(page)) {
            pageNum = Integer.parseInt(page);
        }
        
        int total = refundService.getRefundCount(timeStart, timeEnd, refundId, supId, orderId, refundStatus);

        int pages = (int) Math.ceil((double) total / PAGE_SIZE);

        if (pageNum > pages) {
            pageNum = pages;
        }
        if (total > 0) {
            List<Refund> list = refundService.getRefundList(timeStart, timeEnd, refundId, supId, orderId, refundStatus, pageNum, PAGE_SIZE);
            for (Refund i : list) {
                i.setSupName(supService.getSupName(Integer.parseInt(i.getSupId())));
            }
            map.put("list", list);
            map.put("stat", refundService.getRefundStat(timeStart, timeEnd, refundId, supId, orderId, refundStatus));
        }
        
        if (timeStart == null) {
            timeStart = "";
        }
        if (timeEnd == null) {
            timeEnd = "";
        }
        if (refundId == null) {
            refundId = "";
        }
        if (orderId == null) {
            orderId = "";
        }
        
        map.put("orderId", orderId);
        map.put("supId", supId);
        map.put("timeStart", timeStart);
        map.put("timeEnd", timeEnd);
        map.put("refundId", refundId);
        map.put("refundStatus", refundStatus);
        map.put("sups", supService.getSupList());
        map.put("total", total);
        map.put("page", pageNum);
        map.put("pageAction", "supervise/refund/list?timeStart="+timeStart+"&timeEnd="+timeEnd+"&refundId="+refundId+"&orderId="+orderId+"&supId="+supId+"&refundStatus="+refundStatus+"&page=%PAGE%");
        map.put("pages", pages);
        
        return "refund/list";
    }
    
    @RequestMapping("/detail")
    public String detail(HttpServletRequest req, Map<String, Object> map) {
        String refundId = req.getParameter("r");
        logger.info("�˻��˿�-�鿴-r["+refundId+"]");

        String t = req.getParameter("t");
        map.put("t", t);
        Refund refund = refundService.getRefundDetail(refundId);
        
        if (refund != null) {
            map.put("goods", refundService.getRefundGoods(refundId, refund.getOrderId()));
        }
        
        map.put("refund", refund);
        
        return "refund/detail";
    }
    
    @RequestMapping("/submit")
    @ResponseBody
    public ResultObject submit (HttpServletRequest req) {

        String refundId = req.getParameter("r");

        Refund refund = refundService.getRefundDetail(refundId);

        if (refund == null) {
            return new ResultObject(ResultObject.FAIL, "�˿������");
        }
        if (!"4".equals(refund.getRefundStatus())) {
            return new ResultObject(ResultObject.FAIL, "�˿����δ�˿�״̬��������˿��벻Ҫ�ظ��˿�");
        }

        Order order = orderService.getOrderDetail(refund.getOrderId());
        
        if (order.getBuyType() == 0) {
        
            PayFlow payFlow = payFlowService.getPayFlowByOrderId(refund.getOrderId());
    
            if (payFlow == null) {
                return new ResultObject(ResultObject.FAIL, "δ�ҵ��˿����Ӧ��֧����ˮ");
            }
    
            // ������20+12���
            String payFlowNo = refund.getOrderId() + RandomStringUtils.random(11, "0123456789");
            //֧���������˿�
            if("0005".equals(payFlow.getPayGate())){
            	return new ResultObject(ResultObject.OK, ResultObject.ALIPAYREFUND);
            	
            }else{ //�����������˿ʽ
            	 Map<String, String> param = new HashMap<String, String>();
            	    
                 if (!"1".equals(configHolder.getConfig("chinapay.prod"))) {
         
                     param.put("Version", "20140728");
                     param.put("MerId", configHolder.getConfig("chinapay.mer.id." + payFlow.getPayGate()));
                     param.put("MerOrderNo", payFlowNo);
                     String date = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
                     param.put("TranDate", date.substring(0, 8));
                     param.put("TranTime", date.substring(8));
                     param.put("OriOrderNo", payFlow.getPayFlow());
                     param.put("OriTranDate", new SimpleDateFormat("yyyyMMdd").format(payFlow.getCompleteTime()));
                     param.put("RefundAmt", String.valueOf((int) (refund.getRefundPrice() * 100)));
                     param.put("TranType", "0401");
                     param.put("BusiType", "0001");
                     param.put("MerBgUrl", configHolder.getConfig("chinapay.callback.refund"));
                     param.put("MerResv", refund.getRefundId());
         
                     SecssUtil s = new SecssUtil();
         
                     Properties p = new Properties();  
                     InputStream in = getClass().getClassLoader().getResourceAsStream("chinapay" + payFlow.getPayGate() + ".properties");
                     try {
                         p.load(in);
                         in.close();  
                     } catch (IOException e1) {
                         e1.printStackTrace();
                     }  
                     s.init(p);
                     s.sign(param);
                     param.put("Signature", s.getSign());
                 } else {
                     param.put("Version", "20070129");
                     param.put("MerID", configHolder.getConfig("chinapay.mer.id." + payFlow.getPayGate()));
                     param.put("TransType", "0002");
                     param.put("OrderId", payFlow.getPayFlow());
                     param.put("RefundAmount", StringUtils.leftPad(String.valueOf((int) (refund.getRefundPrice() * 100)), 12, '0'));
                     param.put("TransDate", new SimpleDateFormat("yyyyMMdd").format(payFlow.getCompleteTime()));
                     param.put("ReturnURL", configHolder.getConfig("chinapay.callback.refund"));
                     param.put("Priv1", payFlow.getPayGate() + "-" + refund.getRefundId());
                     
         
                     chinapay.PrivateKey key1 = new chinapay.PrivateKey();
                     chinapay.SecureLink s;
                     boolean flag;
                     flag = key1.buildKey( configHolder.getConfig("chinapay.mer.id." + payFlow.getPayGate()), 0,  configHolder.getConfig("chinapay.mer.prk." + payFlow.getPayGate())); 
                     if (flag == false) {
                         System.out.println("build key error!");
                     }
                     s = new chinapay.SecureLink(key1);
         
                     String cv = s.Sign(param.get("MerID") + param.get("TransDate") + param.get("TransType") + param.get("OrderId") + param.get("RefundAmount") + param.get("Priv1"));
                     param.put("ChkValue", cv);
                 }
         
                 PayFlow pf = new PayFlow();
                 pf.setOrderId(refund.getRefundId());
                 pf.setPayAmount(refund.getRefundPrice());
                 pf.setPayFlow(payFlowNo);
                 pf.setPayStatus(0);
                 pf.setPayType(2);
                 pf.setProcStatus(0);
                 pf.setRemark("���𶩵��˿�");
                 pf.setPayGate(payFlow.getPayGate());
                 try {
                     pf.setReqParam(new ObjectMapper().writeValueAsString(param));
                 } catch (Exception e) {
                 }
         
                 payFlowService.insertPayFlow(pf);
         
                 CloseableHttpClient client = HttpClients.custom().build();
                 RequestConfig config = RequestConfig.custom().setSocketTimeout(1200000).setConnectTimeout(1200000).setAuthenticationEnabled(false)
                         .build();
         
                 HttpPost post = new HttpPost(configHolder.getConfig("chinapay.url.refund"));
                 post.setProtocolVersion(org.apache.http.HttpVersion.HTTP_1_1);
                 post.setConfig(config);
         
                 HttpEntity entity = null;
                 List<NameValuePair> pairs = new ArrayList<NameValuePair>();
         
                 for (Entry<String, String> i : param.entrySet()) {
                     pairs.add(new BasicNameValuePair(i.getKey(), i.getValue()));
                 }
         
                 entity = new UrlEncodedFormEntity(pairs, Consts.UTF_8);
                 if (entity != null) {
                     post.setEntity(entity);
                 }
                 CloseableHttpResponse res = null;
                 try {
                     res = client.execute(post);
                     HttpEntity ent = res.getEntity();
                     String content = EntityUtils.toString(ent);
                     EntityUtils.consume(ent);
                     Map<String, String> data = new HashMap<String, String>();
                     if (!StringUtils.isEmpty(content)) {
                         int pos = content.indexOf("<body>");
                         if (pos > 0) {
                             content = content.substring(pos + 6, content.indexOf("</body>"));
                             content = content.replaceAll("[\n\r]", "");
                         }
                         String[] strs = content.split("&");
                         for (String str : strs) {
                             if (StringUtils.isEmpty(str)) {
                                 continue;
                             }
                             int index = str.indexOf("=");
                             data.put(str.substring(0, index), str.substring(index + 1));
                         }
                     }
                     res.close();
         
                     pf.setPayStatus(1);
                     pf.setResParam(content);
                     
                     if ("0000".equals(data.get("respCode")) || "1003".equals(data.get("respCode")) || "0".equals(data.get("ResponseCode"))) {
         
                         pf.setProcStatus(1);
                         pf.setRemark("�����ѽ����˿�");
                         payFlowService.updatePayFlow(pf);
                         refundService.updateRefundStatus(refundId, refund.getOrderId());
                         
                         SettleData settle = new SettleData();
                         settle.setBusiId(refund.getRefundId());
                         settle.setBusiType(2);
                         settle.setCompanyName(refund.getCompanyName());
                         settle.setSettleAmount(refund.getRefundPriceInit());
                         settle.setSupId(Integer.parseInt(refund.getSupId()));
                         settle.setTotalNum(refund.getRefundAmount());
                         
                         settleService.insertSettleData(settle);
                     } else {
                         pf.setPayStatus(2);
                         pf.setProcStatus(2);
                         if (!"1".equals(configHolder.getConfig("chinapay.prod"))) {
                             pf.setRemark("�����˿�ʧ��[" + data.get("respMsg") + "]");
                         } else {
                             pf.setRemark("�����˿�ʧ��[" + data.get("Message") + "]");
                         }
                         payFlowService.updatePayFlow(pf);
                         if (!"1".equals(configHolder.getConfig("chinapay.prod"))) {
                             return new ResultObject(ResultObject.FAIL, "�����˿�ʧ��[" + data.get("respMsg") + "]");
                         } else {
                             return new ResultObject(ResultObject.FAIL, "�����˿�ʧ��[" + data.get("Message") + "]");
                         }
                     }
         
                     res.close();
                 } catch (Exception e) {
                     logger.error("�����˿�ʧ��", e);
                     return new ResultObject(ResultObject.FAIL, "�����˿�ʧ��");
                 } finally {
                     try {
                         client.close();
                     } catch (Exception e) {
                     }
                 }
            }
           
        
        } else {
            refundService.updateRefundStatus(refundId, refund.getOrderId());
            
            SettleData settle = new SettleData();
            settle.setBusiId(refund.getRefundId());
            settle.setBusiType(2);
            settle.setCompanyName(refund.getCompanyName());
            settle.setSettleAmount(refund.getRefundPriceInit());
            settle.setSupId(Integer.parseInt(refund.getSupId()));
            settle.setTotalNum(refund.getRefundAmount());
            
            settleService.insertSettleData(settle);
            return new ResultObject(ResultObject.OK, "1");
        }

        return new ResultObject(ResultObject.OK, "�˿�ɹ�");
    }
    
    
    
    @RequestMapping("/alipayrefund")
    public String alipayrefund (Map<String, Object> map,HttpServletRequest req) {

        String refundId = req.getParameter("r");
        Refund refund = refundService.getRefundDetail(refundId);
        PayFlow payFlow = payFlowService.getPayFlowByOrderId(refund.getOrderId());
        // ������20+12���
        //String payFlowNo = refund.getOrderId() + RandomStringUtils.random(11, "0123456789");
        //֧���������˿�
         JSONObject json = JSONObject.fromObject(payFlow.getResParam());
         String tradeNo = json.getString("trade_no");
        ////////////////////////////////////�������//////////////////////////////////////

         //���κţ������ʽ����������[8λ]+���к�[3��24λ]���磺201603081000001
         String batch_no = new String(AlipaySubmit.RandomBatchNum());
         //�˿�������������detail_data��ֵ�У���#���ַ����ֵ�������1�����֧��1000�ʣ�����#���ַ����ֵ�����999����
         String batch_num = new String("1");
         //�˿���ϸ���ݣ������ʽ��֧�������׺�^�˿���^��ע�����������#����
         String detailStr = tradeNo+"^"+payFlow.getPayAmount()+"^�к��Ƽ��˿����";
         String detail_data = new String(detailStr);
         //������������������
         Map<String, String> sParaTemp = new HashMap<String, String>();
         sParaTemp.put("service", configHolder.getConfig("alipay.refund.param.service"));
         sParaTemp.put("partner",  configHolder.getConfig("alipay.param.partner"));
         sParaTemp.put("_input_charset", configHolder.getConfig("alipay.param.input_charset"));
         sParaTemp.put("notify_url", configHolder.getConfig("alipay.refund.callback.notify_url"));
//         sParaTemp.put("return_url", configHolder.getConfig("partner"));
         sParaTemp.put("seller_user_id", configHolder.getConfig("alipay.param.seller_id"));
         sParaTemp.put("refund_date", UtilDate.getDateFormatter());
         sParaTemp.put("batch_no", batch_no);
         sParaTemp.put("batch_num", batch_num);
         sParaTemp.put("detail_data", detail_data);
         Map<String, String> alipayMap = AlipaySubmit.buildRequestPara(sParaTemp,configHolder.getConfig("alipay.param.sign_type"),configHolder.getConfig("alipay.param.input_charset"),configHolder.getConfig("alipay.param.private_key"));         
        	 PayFlow pf= new PayFlow();
             pf.setOrderId(refund.getRefundId());
             pf.setPayAmount(refund.getRefundPrice());
             pf.setPayFlow(batch_no);
             pf.setPayStatus(0);
             pf.setPayType(2);
             pf.setProcStatus(0);
             pf.setRemark("���𶩵��˿�");
             pf.setPayGate(payFlow.getPayGate());
             try {
                 pf.setReqParam(new ObjectMapper().writeValueAsString(sParaTemp));
             } catch (Exception e) {
             }           
             payFlowService.insertPayFlow(pf);        	 
         String action = configHolder.getConfig("alipay.param.url")+ "_input_charset=" + configHolder.getConfig("alipay.param.input_charset");
         map.put("form", alipayMap);
         map.put("action", action);
         return "refund/alipay";
    }
    
    
    @RequestMapping("/callback/{type:.*}")
    public String returnurl (@PathVariable("type") String type,Map<String, Object> map,HttpServletRequest request,HttpServletResponse response) {
    	//��ȡ֧����POST����������Ϣ
    	Map<String,String> params = new HashMap<String,String>();
    	Map requestParams = request.getParameterMap();
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
    	//���κ�
    	String batch_no = "";
    	String success_num = "";
    	String result_details = "";
    	
    	try {
			batch_no = new String(request.getParameter("batch_no").getBytes("ISO-8859-1"),"GBK");
			//�����˿�������ת�˳ɹ��ı���
	    	success_num = new String(request.getParameter("success_num").getBytes("ISO-8859-1"),"GBK");
	    	//�����˿������е���ϸ��Ϣ
	    	result_details = new String(request.getParameter("result_details").getBytes("ISO-8859-1"),"GBK");
    	} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
    	//��ȡ֧������֪ͨ���ز������ɲο������ĵ���ҳ����תͬ��֪ͨ�����б�(���Ͻ����ο�)//
    	if(AlipayNotify.verify(params)){//��֤�ɹ�
    		PayFlow pf = new PayFlow();
    		//String[] details = result_details.split("^");//�˿���ϸ����
    		pf = payFlowService.getPayFlowByNo(batch_no);
			Refund refund = refundService.getRefundDetail(pf.getOrderId());
    		if(Integer.parseInt(success_num)>0){//�˿�ɹ�
    			pf.setPayStatus(1);
    			pf.setProcStatus(1);
    			pf.setResParam(result_details);
                pf.setRemark("֧�����˿�ɹ�");
                payFlowService.updatePayFlow(pf);
                
                refundService.updateRefundStatus(pf.getOrderId(), refund.getOrderId());
                
                SettleData settle = new SettleData();
                settle.setBusiId( pf.getOrderId());
                settle.setBusiType(2);
                settle.setCompanyName(refund.getCompanyName());
                settle.setSettleAmount(refund.getRefundPriceInit());
                settle.setSupId(Integer.parseInt(refund.getSupId()));
                settle.setTotalNum(refund.getRefundAmount());
                settleService.insertSettleData(settle);
//                if("returnurl".equals(type)){
//                	map.put("error", "֧�����˿�ɹ���");
//                	map.put("orderId", payFlow.getOrderId());
//                    map.put("payAmount", payFlow.getPayAmount());
//                    map.put("payGate", payFlow.getPayGate());
//                	return "refund/alipay_success";
//                }
    			
    		}else{//�˿�ʧ��
    			 pf.setPayStatus(2);
                 pf.setProcStatus(2);
                 pf.setRemark("֧�����˿�ʧ��");
                 payFlowService.updatePayFlow(pf);
//                 if("returnurl".equals(type)){
//                	map.put("error", "֧�����˿�ʧ�ܣ�");
//                 	return "refund/alipay_fail";
//                 }
    		}
    			
    		try {
				response.getWriter().write("success");//�벻Ҫ�޸Ļ�ɾ��
			} catch (IOException e) {
				e.printStackTrace();
			}	
    	}else{//��֤ʧ��
    		try {
				response.getWriter().write("fail");
			} catch (IOException e) {
				e.printStackTrace();
			}
    	}
         return null;
    }
}