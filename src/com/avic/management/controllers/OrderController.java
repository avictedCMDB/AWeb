package com.avic.management.controllers;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.beans.ResultObject;
import com.avic.common.constants.UserRole;
import com.avic.common.exceptions.NoPermissionException;
import com.avic.common.exceptions.UserNotLoginException;
import com.avic.common.utils.MoneyUtil;
import com.avic.common.utils.Permission;
import com.avic.management.models.BidContract;
import com.avic.management.models.BidProjSubject;
import com.avic.management.models.BidProjSupplier;
import com.avic.management.models.BidProjTender;
import com.avic.management.models.BidProject;
import com.avic.management.models.Order;
import com.avic.management.models.OrderContract;
import com.avic.management.models.Quote;
import com.avic.management.models.QuoteSnapshot;
import com.avic.management.services.OrderService;
import com.avic.management.services.QuoteService;
import com.avic.management.services.UserService;
import com.avic.market.utils.UserAgentUtil;
import com.avic.passport.models.User;
import com.avic.supplier.utils.NewExcel;

@Controller
@RequestMapping("/order")
@Transactional
public class OrderController {
    protected static final Log logger = LogFactory.getLog(OrderController.class);
    static final int PAGE_SIZE = 10; //每页显示多少条
    
    @Autowired
    OrderService orderService;
    
    @Autowired
    QuoteService quoteService;
    
    @Autowired
    UserService userService;
    
    @RequestMapping("")
    public String index(@ModelAttribute("order") Order order_query,
    		HttpSession httpSession,HttpServletRequest request) {
        logger.info("订单查询");
        User user = null;
        try {
            user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
        } catch (Exception e) {
            return "redirect:/passport/login";
        }
        String orderStatus = order_query.getOrder_status();
        if (!StringUtils.isEmpty(orderStatus) && orderStatus.startsWith("-")) {
        	order_query.setOrder_status(orderStatus.replaceAll("-", ""));
        }
    	String userId = user.getUserId();
    	order_query.setUser_id(userId);
    	
    	//分页代码
		String page = request.getParameter("page");
		
		int pageNum = 1;
		 
        if (StringUtils.isNumeric(page)) {
            pageNum = Integer.parseInt(page);
        }
        
       //查询数量
        int total = orderService.queryOrdersListCount(order_query);

        int pages = (int) Math.ceil((double) total / PAGE_SIZE);
        
        if (pageNum > pages) {
            pageNum = pages;
        }
    	
        order_query.setPage(pageNum);
        order_query.setPageSize(PAGE_SIZE);
        order_query.setCompanyID("20170228165128000068");
        List<Order> ordersList = new ArrayList<Order>();
        ordersList = orderService.queryOrders(order_query);

        //订单状态初始化结果集
        List<Order> ordersStatusList = new ArrayList<Order>();
        ordersStatusList = orderService.getOrderStatusList();
        
        request.setAttribute("ordersList", ordersList);//查询结果集
        request.setAttribute("order_query", order_query);//查询条件回显
        request.setAttribute("ordersStatusList", ordersStatusList);//订单状态列表结果集
        
        request.setAttribute("page", pageNum);
        request.setAttribute("total", total);
        request.setAttribute("pages", pages);
        
        try {
    	request.setAttribute("pageAction","management/order?order_id=" + URLEncoder.encode(order_query.getOrder_id()==null?"":order_query.getOrder_id(), "GBK")
								+ "&sup_name=" + URLEncoder.encode(order_query.getSup_name()==null?"":order_query.getSup_name(), "GBK")
								+ "&supType=" + URLEncoder.encode(order_query.getSupType()==null?"":order_query.getSupType(), "GBK")
			                    + "&goods_name=" + URLEncoder.encode(order_query.getGoods_name()==null?"":order_query.getGoods_name(), "GBK")
			                    + "&startTime=" + URLEncoder.encode(order_query.getStartTime()==null?"":order_query.getStartTime(), "GBK")
			                    + "&endTime=" + URLEncoder.encode(order_query.getEndTime()==null?"":order_query.getEndTime(), "GBK")
			                    + "&order_status=" + URLEncoder.encode(order_query.getOrder_status()==null?"":order_query.getOrder_status(), "GBK")+ "&page=%PAGE%");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
        if (UserAgentUtil.isPhone(request)) {
        	if (!StringUtils.isEmpty(orderStatus) && orderStatus.startsWith("-")) {
            	return "../market/m/my/index";
        	}
        	return "../market/m/order/list";
        }
        return "management_order";
    }
    
    @RequestMapping("/downloadExcel")
    public void downloadExcel(@ModelAttribute("order") Order order_query,HttpSession httpSession,
    		HttpServletRequest req, HttpServletResponse resp) throws IOException{

    	req.setCharacterEncoding("UTF-8");
    	resp.setCharacterEncoding("UTF-8");
    	resp.setContentType("application/x-download");

    	String filedisplay = "订单详情.xls";
    	filedisplay = URLEncoder.encode(filedisplay, "UTF-8");
    	resp.addHeader("Content-Disposition", "attachment;filename="+ filedisplay);
    	
    	logger.info("订单导出");
        User user = null;
        try {
            user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
        } catch (Exception e) {
            this.index(order_query, httpSession, req);
        }
    	String userId = user.getUserId();
    	order_query.setUser_id(userId);
    	order_query.setCompanyID("20170228165128000068");
    	
       //查询数量
        int total = orderService.queryOrdersListCount(order_query);

        try {
        	if (total > 0) {
	    		List<Order> ordersList = orderService.queryOrdersAllData(order_query);
	    		//调用导出excel共同方法
	    		NewExcel exl = new NewExcel();
	    		//行标题
	    		List<String> columnName = Arrays.asList(new String[] {"订单编号","供应商","商品名称","商品单价","购买数量","合计",
	    				"发票状态","下单时间","订单状态"});
	    		//为excel内容转化数据
	    		List<List<String>> values = transformDataForExcel(ordersList);
	    		exl.createExcel(resp, columnName, values);
	    	}
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
    
    public List<List<String>> transformDataForExcel(List<Order> ordersList){
    	List<List<String>> reList = new ArrayList<List<String>>();
    	for(int i=0;i<ordersList.size();i++){
    		Order order_tmp = (Order) ordersList.get(i);
    		List<String> subList = new ArrayList<String>();
    		subList.add(order_tmp.getOrder_id());
    		subList.add(order_tmp.getSup_name());
    		subList.add(order_tmp.getGoods_name());
    		subList.add(""+new BigDecimal(order_tmp.getGoods_price()).setScale(2,BigDecimal.ROUND_HALF_UP));
    		subList.add(order_tmp.getBuy_num());
    		String amount = ""+new BigDecimal(order_tmp.getOrder_amount()).setScale(2,BigDecimal.ROUND_HALF_UP);
    		subList.add(amount);
    		String InvoiceStatusName = "未开具";
    		if("1".equals(order_tmp.getInvoice_status())){
    			InvoiceStatusName = "已开具";
    		}
    		subList.add(InvoiceStatusName);
    		subList.add(order_tmp.getOrder_time());
    		subList.add(order_tmp.getOrder_status_name());
    		reList.add(subList);
    	}
    	return reList;
    }
    
    @RequestMapping(value = "/doReceived", method ={RequestMethod.POST})
    @ResponseBody
    public Object doReceived(HttpSession httpSession,
    		@RequestParam("o")String order_id)
            throws Exception{
    	String result = "ok";
    	Map<String, String> map = new HashMap<String, String>();
        result = orderService.doReceived(order_id);
        map.put("result", result);
        return map;
    }
    
    @RequestMapping(value = "/orderCancel", method ={RequestMethod.POST})
    @ResponseBody
    public Object orderCancel(
    		@RequestParam("orderID")String order_id,
    		@RequestParam("supID")String sup_id,
    		@RequestParam("supOrderId")String sup_order_id,
    		@RequestParam("sup_type")String sup_type,
    		HttpServletRequest req,HttpSession httpSession)
    throws Exception{
    	User user = null;
    	try {
			user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
        } catch (Exception e) {
            return "redirect:/passport/login";
        }
    	String result = "ok";
    	Map<String, String> map = new HashMap<String, String>();
    	Map<String, String> paramMap = new HashMap<String, String>();
    	paramMap.put("order_id", order_id);
    	paramMap.put("sup_id", sup_id);
    	paramMap.put("sup_order_id", sup_order_id);
    	paramMap.put("sup_type", sup_type);
        result = orderService.orderCancel(req,httpSession,paramMap);
        map.put("result", result);
    	return map;
    }
    
    @RequestMapping(value = "/orderDel", method ={RequestMethod.POST})
    @ResponseBody
    public Object orderDel(
    		@RequestParam("orderID")String order_id,
    		HttpServletRequest req,HttpSession httpSession)
    throws Exception{
    	User user = null;
    	try {
    		user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
    	} catch (Exception e) {
    		return "redirect:/passport/login";
    	}
    	String result = "ok";
    	Map<String, String> map = new HashMap<String, String>();
    	Map<String, String> paramMap = new HashMap<String, String>();
    	paramMap.put("order_id", order_id);
    	result = orderService.orderDel(req,httpSession,paramMap);
    	map.put("result", result);
    	return map;
    }
    /**
     * 查看报价单
     * @param orderID
     * @param supID
     * @param httpSession
     * @param request
     * @param map
     * @return
     */
    @RequestMapping("/quote")
    public String quote(@RequestParam("orderID")String orderID,@RequestParam("supID")String supID,HttpSession httpSession,HttpServletRequest request,Map<String, Object> map) {
        logger.info("报价单查询");
        User user = null;
        try {
            user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
        } catch (Exception e) {
            return "redirect:/passport/login";
        }
        //查询供应商信息
        List<Quote> quotes = new ArrayList<Quote>();
        Quote quote = new Quote();
        quote.setSupID(supID);
        quote.setOrderID(orderID);
        quotes = quoteService.queryQuoteBySupID(quote);
        if(quotes.size()>0){
        	quote = quotes.get(0);
        }
        List<String> paths = new ArrayList<String>();
        
        List<String> fileNames = new ArrayList<String>();
        for (Quote q : quotes) {
        	paths.add(q.getQupteAttachmentPath());
        	
            String fileName = q.getFileName();
            fileNames.add(fileName);
		}
        
        //查询商品列表
        List<QuoteSnapshot> quoteSnapshots = new ArrayList<QuoteSnapshot>();
        QuoteSnapshot quoteSnapshot = new QuoteSnapshot();
        quoteSnapshot.setOrderId(orderID);
        quoteSnapshots = orderService.queryQuoteSnapshot(quoteSnapshot);
        double amount = 0.0;
        for (QuoteSnapshot qs : quoteSnapshots) {
        	amount = amount + (Double.parseDouble(qs.getGoodsPrice())*Integer.parseInt(qs.getBuyNum()));
		}
        map.put("quote", quote);
        map.put("quoteSnapshots", quoteSnapshots);
        map.put("paths", paths);
        map.put("fileNames", fileNames);
        map.put("amount", amount+"");
        return "quote";
    }
    
    
   //下载报价单附件
    @RequestMapping("downloadQuote")    
    public ResponseEntity<byte[]> download(@RequestParam("qupteAttachmentPath")String qupteAttachmentPath,HttpServletRequest request) throws IOException {    
        String path = request.getSession().getServletContext().getRealPath("/")+qupteAttachmentPath;  
        String downLoadFileName = qupteAttachmentPath.substring(qupteAttachmentPath.lastIndexOf("/")+1);
        File file=new File(path);  
        HttpHeaders headers = new HttpHeaders();    
        String fileName=new String(downLoadFileName.getBytes("UTF-8"),"iso-8859-1");//为了解决中文名称乱码问题  
        headers.setContentDispositionFormData("attachment", fileName);   
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);   
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers, HttpStatus.OK);    
    }
    
    @RequestMapping("get_order_count_by_status")
    @ResponseBody
    public ResultObject getOrderCountByStatus (HttpSession session, String status) {
        User user = Permission.check(session, UserRole.BUY,UserRole.CLIENT);
    	Order order = new Order();
    	order.setUser_id(user.getUserId());
    	order.setOrder_status(status);
        int total = orderService.queryOrdersListCount(order);
    	return new ResultObject(ResultObject.OK, total);
    }
    @RequestMapping("/contract")
    public String gen(@RequestParam("orderId") String orderId, HttpSession sess, Map<String, Object> map) throws JsonParseException, JsonMappingException, IOException {
        logger.info("订单管理-生成电子合同");
        contractData(orderId, sess, map);
        return "management_order_contract_detail";
    }
    @RequestMapping("/contractAudit")
    public String audit(@RequestParam("orderId") String orderId, HttpSession sess,
            Map<String, Object> map) throws JsonParseException, JsonMappingException, IOException {
        logger.info("订单管理-审核");
        contractData(orderId, sess, map);
        return "management_contract_audit";
    }
    private void contractData(String orderId, HttpSession sess, Map<String, Object> map) throws JsonParseException, JsonMappingException, IOException {
        User user = null;
        try {
            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
        } catch (UserNotLoginException e) {
            //return "redirect:/passport/login";
        } catch (NoPermissionException e) {
            // "redirect:/passport/login";
        }
        
        Order order = new Order();
        order.setOrder_id(orderId);
        order  = orderService.getOrderById(orderId);
    	OrderContract contract = orderService.queryOrderContract(orderId);
    	if (contract != null) {
    		map.put("contract", contract);
        	map.put("aparam", new ObjectMapper().readValue(contract.getA_param(), Map.class));
            if (!StringUtils.isEmpty(contract.getB_param())) {
                map.put("bparam", new ObjectMapper().readValue(contract.getB_param(), Map.class));
            }
		}
        List<QuoteSnapshot> quoteSnapshots = new ArrayList<QuoteSnapshot>();
        QuoteSnapshot quoteSnapshot = new QuoteSnapshot();
        quoteSnapshot.setOrderId(orderId);
        quoteSnapshots = orderService.queryQuoteSnapshot(quoteSnapshot);
            SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
            map.put("no",  "ZY"+df.format(new Date()));
            StringBuffer strbuf = new StringBuffer();
	        for (QuoteSnapshot i : quoteSnapshots) {
	            strbuf.append(i.getGoodsName()).append(",");
	        }
//        
//        
          map.put("order", order);
          map.put("subs", strbuf.substring(0, strbuf.length() - 1));
          map.put("quoteSnapshots", quoteSnapshots);
          map.put("total", MoneyUtil.digitUppercase(Double.valueOf(order.getOrder_amount())));
          map.put("user", userService.queryUserById(user.getUserId()));


    }
    
    @RequestMapping("/contractInsert")
    @ResponseBody
    public ResultObject contractInsert(HttpSession sess, BidContract contract) {
        User user = null;
        try {
            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
        } catch (Exception e) {
            return new ResultObject(ResultObject.FAIL, "未登录或无权限");
        }
        String orderId = contract.getProjId();
        Order order  = orderService.getOrderById(orderId);
        OrderContract orderContract = new OrderContract();
        orderContract.setContract_name("采购商品");
        orderContract.setContract_code(contract.getContractId());
        orderContract.setOrder_id(orderId);
        orderContract.setSup_name(order.getSup_name());
        orderContract.setContract_price(order.getOrder_amount());
        orderContract.setUser_id(user.getUserId());
        orderContract.setA_param(contract.getaParam());
        orderService.insertContract(orderContract);
        orderService.updateOrderStatus(orderId, 23);
        return new ResultObject(ResultObject.OK, "");
    }
    
    @RequestMapping("/doContractAudit")
    @ResponseBody
    public ResultObject contractAudit(HttpSession sess, @RequestParam("order_id") String order_id,
    		@RequestParam("contract_code") String contract_code,@RequestParam("contractStatus") String contractStatus,
    		@RequestParam("contractRemark") String contractRemark) {
        User user = null;
        try {
            user = Permission.check(sess, UserRole.BUY, UserRole.CLIENT);
        } catch (Exception e) {
            return new ResultObject(ResultObject.FAIL, "未登录或无权限");
        }
        OrderContract orderContract = new OrderContract();
        orderContract.setRemark(contractRemark);
        orderContract.setContract_code(contract_code);
        orderService.updateContract(orderContract);
        orderService.updateOrderStatus(order_id, Integer.valueOf(contractStatus));
        return new ResultObject(ResultObject.OK, "");
    }
    
}