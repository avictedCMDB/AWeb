package com.avic.management.controllers;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.avic.common.constants.SmsContents;
import com.avic.common.constants.UserRole;
import com.avic.common.exceptions.NoPermissionException;
import com.avic.common.exceptions.PageNotFoundException;
import com.avic.common.exceptions.UserNotLoginException;
import com.avic.common.shortMessage.ShortMessageUtils;
import com.avic.common.utils.ConfigHolder;
import com.avic.common.utils.Permission;
import com.avic.management.models.AuditImageInfo;
import com.avic.management.models.Cart;
import com.avic.management.models.OffStandardRequire;
import com.avic.management.models.Quote;
import com.avic.management.models.QuoteDetail;
import com.avic.management.models.SpecialGoodsBean;
import com.avic.management.models.SupGoods;
import com.avic.management.models.SupInfo;
import com.avic.management.services.CartService;
import com.avic.management.services.ImageInfoService;
import com.avic.management.services.OffStandardRequireService;
import com.avic.management.services.QuoteDetailService;
import com.avic.management.services.QuoteService;
import com.avic.management.services.SpecialGoodsService;
import com.avic.management.services.SupGoodsService;
import com.avic.management.services.SupInfoService;
import com.avic.market.utils.UserAgentUtil;
import com.avic.passport.models.User;

@Controller
@RequestMapping("/specialGoods")
@Transactional
public class SpecialGoodsController {
    protected static final Log logger = LogFactory.getLog(SpecialGoodsController.class);
    static final int PAGE_SIZE = 10; //每页显示多少条
    @Autowired
    SpecialGoodsService specialGoodsService;
    @Autowired
    SupInfoService supInfoService;
    @Autowired
    OffStandardRequireService offStandardRequireService;
    @Autowired
    CartService cartService; 
    @Autowired
    SupGoodsService supGoodsService;
    @Autowired
    ImageInfoService imageInfoService;
    @Autowired
    QuoteService quoteSerice;
    @Autowired
    QuoteDetailService quoteDetailService;
    
    //允许上传的文件最大大小(100M,单位为byte)
    int maxSize = 1024*1024*2;
    
    String fileType = ".bmp,.png,.gif,.jpeg,.jpg,.xls,.xlsx,.doc,.docx,.pdf";
    
    @RequestMapping("")
    public String index(HttpSession httpSession,Map<String, Object> map, HttpServletRequest request) {
        logger.info("非标商品管理");
        User user = null;
        String isShowBtn1 = "0";
        try {
            user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
            SpecialGoodsBean sgBean = new SpecialGoodsBean();
            sgBean.setCompany_id(user.getCompanyId());
            int supCount = specialGoodsService.getRelationShipSupCount(sgBean);
            if(supCount>0){
            	isShowBtn1 = "1";
            }
        } catch (Exception e) {
            return "redirect:/passport/login";
        }
        if (UserAgentUtil.isPhone(request)) {
        	return "../market/m/special/pub_goods_req";
        }
        map.put("isShowBtn1", isShowBtn1);
        return "profession_special_goods";
    }
    
    @RequestMapping("/supSelect")
    public String supSelectDoInit(HttpServletRequest request) {
        logger.info("非标商品管理-选择供应商跳转");
        String sup_type = request.getParameter("o");//1:合作供应商;2:平台其他供应商; 
        request.setAttribute("sup_type",sup_type);
        if (UserAgentUtil.isPhone(request)) {
        	return "../market/m/special/select_sup";
        }
        return "management_sup_select";
    }
    
    @RequestMapping("/supSelectData")
    @ResponseBody
    public Object supSelectDoInitData(HttpServletRequest request,HttpSession httpSession,
    		@RequestParam("sup_name")String sup_name) {
    	logger.info("非标商品管理-选择供应商获取列表");
    	
    	User user = null;
        try {
            user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
        } catch (Exception e) {
            return "redirect:/passport/login";
        }
        
        String sup_type = request.getParameter("o");//1:合作供应商;2:平台其他供应商;
    	
    	SpecialGoodsBean sgBean = new SpecialGoodsBean();
        sgBean.setSup_type(sup_type);
        sgBean.setCompany_id(user.getCompanyId());
        sgBean.setSup_name(sup_name);
    	
//      获取供应商列表
    	List<SpecialGoodsBean> supList = specialGoodsService.supSelectDoInitData(sgBean);
    	if (supList == null) {
    		throw new PageNotFoundException();
    	}
    	
    	return supList;
    }
    
    @RequestMapping(value = "/doSave", method ={RequestMethod.POST})
    @ResponseBody
    public Object doSave(HttpSession httpSession,
    		@RequestParam("goods_desc_new")String goods_desc_new,
    		@RequestParam("sup_id")String sup_id,
    		@RequestParam("auditImages")String[] auditImages,
    		@RequestParam("isRelease")String isRelease,
    		@RequestParam("goodsName")String goodsName,
    		@RequestParam("closeDate")String closeDate)
            throws Exception{
    	User user = null;
    	try {
			user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
        } catch (Exception e) {
            return "redirect:/passport/login";
        }
        
        String user_id = user.getUserId();
    	String result = "ok";
    	
    	Map<String, String> map = new HashMap<String, String>();
    	//验证需求名称不能重复
    	int count = offStandardRequireService.checkGoodsName(goodsName);
    	if(count>0){
    		 result = "failed";
    		 map.put("result", result);
    	     return map;
    	}
    	Map<String, String> paramMap = new HashMap<String, String>();
    	paramMap.put("goods_desc_new", java.net.URLDecoder.decode(goods_desc_new , "UTF-8"));
    	paramMap.put("sup_id", sup_id);
    	paramMap.put("user_id", user_id);
    	paramMap.put("imgCount", auditImages.length+"");
    	paramMap.put("isRelease", isRelease);
    	paramMap.put("goodsName", goodsName);
    	paramMap.put("closeDate", closeDate);
    	for (int i = 0; i < auditImages.length; i++) {
			String realPath = ConfigHolder.getInstance().getConfig("special_goods_url")+ '/' + user.getUserId()+"/"+auditImages[i];
			auditImages[i] = realPath;
		}
        result = specialGoodsService.doSaveInTables(paramMap,auditImages);
        if("0".equals(isRelease)){
        	 if("ok".equals(result)){
             	String[] supIds = sup_id.split(",");
             	List<String> ids = new ArrayList<String>();
             	for (int i = 0; i < supIds.length; i++) {
             		if(supIds[i] != null && !"".equals(supIds[i])){
             			ids.add(supIds[i]);
             		}
     			}
             	//给供应商发送短信
             	List<SupInfo> supInfos = new ArrayList<SupInfo>();
             	SupInfo supInfo = new SupInfo();
             	supInfo.setSupIDS(ids);
             	supInfos = supInfoService.querySupInfosTelBySupID(supInfo);
             	String content = SmsContents.SMS_SPECIAL_GOODS_HEAD+java.net.URLDecoder.decode(goods_desc_new , "UTF-8")
             	                 +SmsContents.SMS_SPECIAL_GOODS_FOOT+"("+user.getCompanyName()+")。";
             	
             	for (int i = 0; i < supInfos.size(); i++) {
             		String tel = supInfos.get(i).getContactNum();
             		if(!"".equals(tel) && tel != null){
             			String[] mobiles = new String[1];
             			mobiles[0] = tel;
             			ShortMessageUtils.sendSMS(mobiles, content);
             		}
             		
     			}
             	
             	
             }
        }
       
        map.put("result", result);
        return map;
    }
    
    @RequestMapping("/offStandardRequirePage")
    public String queryOffStandardRequire(HttpServletRequest req,@ModelAttribute("offStandardRequire")OffStandardRequire offStandardRequire,Map<String, Object> map,HttpSession httpSession) {
        logger.info("非标商品列表");
        User user = null;
        try {
            user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
        } catch (Exception e) {
            return "redirect:/passport/login";
        }
        
        String page = req.getParameter("page");
		
		int pageNum = 1;
		 
        if (StringUtils.isNumeric(page)) {
            pageNum = Integer.parseInt(page);
        }
        //查询供应商列表
        List<SupInfo> supInfos = new ArrayList<SupInfo>();
        SupInfo supInfo = new SupInfo();
        supInfo.setSupType("1");
        supInfos = supInfoService.querySupInfosBySupType(supInfo);
        offStandardRequire.setUserID(user.getUserId());
        //查询数量
        int total = offStandardRequireService.queryOffStandardRequiresCount(offStandardRequire);

        int pages = (int) Math.ceil((double) total / PAGE_SIZE);
        
        if (pageNum > pages) {
            pageNum = pages;
        }
        offStandardRequire.setPage(pageNum);
        offStandardRequire.setPageSize(PAGE_SIZE);
        List<OffStandardRequire> offStandardRequires = new ArrayList<OffStandardRequire>();
        offStandardRequires = offStandardRequireService.queryOffStandardRequires(offStandardRequire);
        for (OffStandardRequire osr : offStandardRequires) {
        	//查询商品列表
        	List<AuditImageInfo> auditImageInfos = new ArrayList<AuditImageInfo>();
			AuditImageInfo auditImageInfo = new AuditImageInfo();
			auditImageInfo.setBusinessID(osr.getID());
			auditImageInfo.setBusinessType("8");
			auditImageInfos = imageInfoService.queryImages(auditImageInfo);
			osr.setAuditImageInfos(auditImageInfos);
			if("0".equals(osr.getIsRelease())){
				//查询供应商列表
				String[] supIDS = osr.getSupID().split(",");
				OffStandardRequire o = new OffStandardRequire();
				o.setSupIDS(Arrays.asList(supIDS));
				List<SupInfo> supInfoList = new ArrayList<SupInfo>();
				supInfoList = offStandardRequireService.querySupInfosBySupIDS(o);
				osr.setSupInfos(supInfoList);
			}
			
		}
        map.put("supInfos", supInfos);
        map.put("offStandardRequire", offStandardRequire);
        map.put("offStandardRequires", offStandardRequires);
        map.put("page", pageNum);
        map.put("total", total);
        map.put("pages", pages);
        try {
			map.put("pageAction","management/specialGoods/offStandardRequirePage?startTime=" + URLEncoder.encode(offStandardRequire.getGoodsDescNew()==null?"":offStandardRequire.getGoodsDescNew(), "GBK") 
								+ "&supID=" + URLEncoder.encode(offStandardRequire.getSupID()==null?"":offStandardRequire.getSupID(), "GBK")
								+ "&goodsName=" + URLEncoder.encode(offStandardRequire.getGoodsName()==null?"":offStandardRequire.getGoodsName(), "GBK")
								+ "&isRelease=" + URLEncoder.encode(offStandardRequire.getIsRelease()==null?"":offStandardRequire.getIsRelease(), "GBK")
								+ "&beginDate=" + URLEncoder.encode(offStandardRequire.getBeginDate()==null?"":offStandardRequire.getBeginDate(), "GBK")
								+ "&endDate=" + URLEncoder.encode(offStandardRequire.getEndDate()==null?"":offStandardRequire.getEndDate(), "GBK")
			                    + "&searchOrderId=" + URLEncoder.encode(offStandardRequire.getStatus()==null?"":offStandardRequire.getStatus(), "GBK")+ "&page=%PAGE%");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
        if (UserAgentUtil.isPhone(req)) {
        	return "../market/m/special/req_list";
        }
        return "management_special";
    }
    
    
    @RequestMapping("/specialCheck")
    public String specialCheck(HttpServletRequest req,@RequestParam("requireID")String requireID,Map<String, Object> map,HttpSession httpSession) {
        logger.info("非标商品列表");
        User user = null;
        try {
            user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
        } catch (Exception e) {
            return "redirect:/passport/login";
        }
        
        List<String> amounts = new ArrayList<String>();
        List<Quote> quotes = new ArrayList<Quote>();
        Quote quote = new Quote();
        quote.setRequireID(requireID);
        quotes = quoteSerice.queryQuoteBySupID(quote);
        for (Quote q : quotes) {
        	List<QuoteDetail> quoteDetails = new ArrayList<QuoteDetail>();
            QuoteDetail qd = new QuoteDetail();
            qd.setQuoteID(q.getId());
            quoteDetails = quoteDetailService.queryQuoteDetailByRequireID(qd);
			q.setQuoteDetails(quoteDetails);
			double amount = 0;
			for (QuoteDetail quoteDetail : quoteDetails) {
				amount = amount + Double.parseDouble(quoteDetail.getSalePrice())*Integer.parseInt(quoteDetail.getQuoteNum());
			}
			amounts.add(new Double(amount).toString());
		}
        map.put("quotes", quotes);
        map.put("amounts", amounts);
        if (UserAgentUtil.isPhone(req)) {
        	return "../market/m/special/progress";
        }
        return "management_special_check";
    }
    
    
    
    @RequestMapping("/addCart")
    @ResponseBody
    public Object addCart(HttpServletRequest req,@RequestParam("specialGoodsParams") String specialGoodsParams,HttpSession httpSession) {
        logger.info("非标准商品添加到购物车");
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
		String[] specialParams = specialGoodsParams.split("#");
		for (int i = 0; i < specialParams.length; i++) {
			String[] params = specialParams[i].split(",");
			Cart cart = new Cart();
			cart.setUserID(user.getUserId());
			cart.setSupID(params[0]);
			cart.setSupGoodsID(params[1]);
			cart.setBuyNum(params[2]);
			cart.setQuoteID(params[3]);
			int count = cartService.queryCatCount(cart);
			if(count>0){
				cartService.updateCart(cart);
			}else{
				//添加到购物车
				cartService.addCart(cart);
			}
		}
		
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("status", "success");
		return map;
    }

    @RequestMapping("/getSpecial")
    public String getSpecial(HttpServletRequest req,@RequestParam("id")String id,Map<String, Object> map,HttpSession httpSession) {
        logger.info("修改需求初始化");
        User user = null;
        try {
            user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
        } catch (Exception e) {
            return "redirect:/passport/login";
        }
        OffStandardRequire offStandardRequire = new OffStandardRequire();
        offStandardRequire.setID(id);
        offStandardRequire = offStandardRequireService.getOffStandardRequireByID(offStandardRequire);
        if(!"".equals(offStandardRequire.getSupID()) && offStandardRequire.getSupID() != null){
        	String[] supIDS = offStandardRequire.getSupID().split(",");
    		OffStandardRequire o = new OffStandardRequire();
    		o.setSupIDS(Arrays.asList(supIDS));
    		List<SupInfo> supInfoList = new ArrayList<SupInfo>();
    		supInfoList = offStandardRequireService.querySupInfosBySupIDS(o);
    		offStandardRequire.setSupInfos(supInfoList);
    		String supIDSNames = "";
    		for (int i = 0; i < supInfoList.size(); i++) {
				supIDSNames += ","+supInfoList.get(i).getSupName()+"_"+supInfoList.get(i).getSupID();
			}
    		offStandardRequire.setSupIDSNames(supIDSNames);
        }
        String isShowBtn1 = "0";
        SpecialGoodsBean sgBean = new SpecialGoodsBean();
        sgBean.setCompany_id(user.getCompanyId());
        int supCount = specialGoodsService.getRelationShipSupCount(sgBean);
        if(supCount>0){
        	isShowBtn1 = "1";
        }
		List<AuditImageInfo> imageInfos = new ArrayList<AuditImageInfo>();
		AuditImageInfo auditImageInfo = new AuditImageInfo();
		auditImageInfo.setBusinessID(id);
		auditImageInfo.setBusinessType("8");
		imageInfos = imageInfoService.queryImages(auditImageInfo);
		offStandardRequire.setAuditImageInfos(imageInfos);
		offStandardRequire.setImgCount(imageInfos.size()+"");
        map.put("offStandardRequire", offStandardRequire);
        map.put("isShowBtn1", isShowBtn1);
        return "profession_special_goods";
    }
    
    @RequestMapping("/updateSpecial")
    @ResponseBody
    public Object updateSpecial(HttpSession httpSession,
    		@RequestParam("goods_desc_new")String goods_desc_new,
    		@RequestParam("sup_id")String sup_id,
    		@RequestParam("auditImages")String[] auditImages,
    		@RequestParam("isRelease")String isRelease,
    		@RequestParam("goodsName")String goodsName,
    		@RequestParam("id")String id,
    		@RequestParam("closeDate")String closeDate)
            throws Exception{
    	User user = null;
    	try {
			user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
        } catch (Exception e) {
            return "redirect:/passport/login";
        }
        
        String user_id = user.getUserId();
    	String result = "ok";
    	
    	Map<String, String> map = new HashMap<String, String>();
    	//验证需求名称不能重复
    	/*int count = offStandardRequireService.checkGoodsName(goodsName);
    	if(count>0){
    		 result = "failed";
    		 map.put("result", result);
    	     return map;
    	}*/
    	OffStandardRequire offStandardRequire = new OffStandardRequire();
    	offStandardRequire.setGoodsDescNew(goods_desc_new);
    	offStandardRequire.setUserID(user_id);
    	offStandardRequire.setSupID(sup_id);
    	offStandardRequire.setImgCount(auditImages.length+"");
    	offStandardRequire.setIsRelease(isRelease);
    	offStandardRequire.setGoodsName(goodsName);
    	offStandardRequire.setStatus("0");
    	offStandardRequire.setCloseDate(closeDate);
    	offStandardRequire.setID(id);
//    	paramMap.put("goods_desc_new", java.net.URLDecoder.decode(goods_desc_new , "UTF-8"));
    	for (int i = 0; i < auditImages.length; i++) {
			String realPath = ConfigHolder.getInstance().getConfig("special_goods_url")+ "/" + user.getUserId()+"/"+auditImages[i];
			auditImages[i] = realPath;
		}
        offStandardRequireService.updateSpecial(offStandardRequire,auditImages);
        if("0".equals(isRelease)){
        	if("ok".equals(result)){
             	String[] supIds = sup_id.split(",");
             	List<String> ids = new ArrayList<String>();
             	for (int i = 0; i < supIds.length; i++) {
             		if(supIds[i] != null && !"".equals(supIds[i])){
             			ids.add(supIds[i]);
             		}
     			}
             	//给供应商发送短信
             	List<SupInfo> supInfos = new ArrayList<SupInfo>();
             	SupInfo supInfo = new SupInfo();
             	supInfo.setSupIDS(ids);
             	supInfos = supInfoService.querySupInfosTelBySupID(supInfo);
             	String content = SmsContents.SMS_SPECIAL_GOODS_HEAD+java.net.URLDecoder.decode(goods_desc_new , "UTF-8")
             	                 +SmsContents.SMS_SPECIAL_GOODS_FOOT+"("+user.getCompanyName()+")。";
             	
             	for (int i = 0; i < supInfos.size(); i++) {
             		String tel = supInfos.get(i).getContactNum();
             		if(!"".equals(tel) && tel != null){
             			String[] mobiles = new String[1];
             			mobiles[0] = tel;
             			ShortMessageUtils.sendSMS(mobiles, content);
             		}
             		
     			}
        	}
             	
        }
       
        map.put("result", result);
        return map;
    }
    
    @RequestMapping("/delSpecial")
    @ResponseBody
    public Object delSpecial(HttpServletRequest req,@RequestParam("id") String id,HttpSession httpSession) {
        logger.info("删除需求");
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
		OffStandardRequire offStandardRequire = new OffStandardRequire();
		offStandardRequire.setID(id);
		offStandardRequireService.deleteSpecial(offStandardRequire);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("status", "success");
		return map;
    }
    
    @RequestMapping("/cancellationInit")
    public String cancellationInit(HttpServletRequest req,@RequestParam("id")String id,Map<String, Object> map,HttpSession httpSession) {
    	logger.info("作废需求初始化");
        User user = null;
        try {
            user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
        } catch (Exception e) {
            return "redirect:/passport/login";
        }
        OffStandardRequire offStandardRequire = new OffStandardRequire();
        offStandardRequire.setID(id);
        offStandardRequire = offStandardRequireService.getOffStandardRequireByID(offStandardRequire);
        if(!"".equals(offStandardRequire.getSupID()) && offStandardRequire.getSupID() != null){
        	String[] supIDS = offStandardRequire.getSupID().split(",");
    		OffStandardRequire o = new OffStandardRequire();
    		o.setSupIDS(Arrays.asList(supIDS));
    		List<SupInfo> supInfoList = new ArrayList<SupInfo>();
    		supInfoList = offStandardRequireService.querySupInfosBySupIDS(o);
    		offStandardRequire.setSupInfos(supInfoList);
        }
		List<AuditImageInfo> imageInfos = new ArrayList<AuditImageInfo>();
		AuditImageInfo auditImageInfo = new AuditImageInfo();
		auditImageInfo.setBusinessID(id);
		auditImageInfo.setBusinessType("8");
		imageInfos = imageInfoService.queryImages(auditImageInfo);
		offStandardRequire.setAuditImageInfos(imageInfos);
        map.put("offStandardRequire", offStandardRequire);
        return "profession_special_goods_edit";
    }
    
    @RequestMapping("/cancellation")
    @ResponseBody
    public Object cancellation(HttpServletRequest req,@RequestParam("id") String id,@RequestParam("cancelReason") String cancelReason,HttpSession httpSession) {
        logger.info("作废需求");
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
		OffStandardRequire offStandardRequire = new OffStandardRequire();
		offStandardRequire.setID(id);
		offStandardRequire.setStatus("3");
		offStandardRequire.setCancelReason(cancelReason);
		offStandardRequireService.cancleReason(offStandardRequire);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("status", "success");
		return map;
    }
    //下载报价单附件
    @RequestMapping("downloadSpecial")    
    public ResponseEntity<byte[]> download(@RequestParam("specialPath")String specialPath,HttpServletRequest request,HttpSession httpSession) throws IOException {    
    	User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return null;
		} catch (NoPermissionException e){
			return null;
		}
		//添加验证是否存在文件
		OffStandardRequire offStandardRequire = new OffStandardRequire();
		offStandardRequire.setQuotePath(specialPath);
		int count = offStandardRequireService.queryFileEx(offStandardRequire);
		if(count<=0){
			//防止恶意攻击
			return null;
		}
		
    	String path = request.getSession().getServletContext().getRealPath("/")+specialPath;  
        String downLoadFileName = specialPath.substring(specialPath.lastIndexOf("/")+1);
        File file=new File(path);  
        HttpHeaders headers = new HttpHeaders();    
        String fileName=new String(downLoadFileName.getBytes("UTF-8"),"iso-8859-1");//为了解决中文名称乱码问题  
        headers.setContentDispositionFormData("attachment", fileName);   
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);   
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers,  HttpStatus.OK);    
    }
    
    //下载附件
    @RequestMapping("downloadSpecialFile")    
    public ResponseEntity<byte[]> download(@RequestParam("specialAttachmentPath")String specialAttachmentPath,HttpServletRequest request) throws IOException {    
        String path = request.getSession().getServletContext().getRealPath("/")+specialAttachmentPath;  
        String downLoadFileName = specialAttachmentPath.substring(specialAttachmentPath.lastIndexOf("/")+1);
        File file=new File(path);  
        HttpHeaders headers = new HttpHeaders();    
        String fileName=new String(downLoadFileName.getBytes("UTF-8"),"iso-8859-1");//为了解决中文名称乱码问题  
        headers.setContentDispositionFormData("attachment", fileName);   
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);   
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers, HttpStatus.OK);    
    }
    
    //下载模版
    @RequestMapping("downloadSpecialTemp")    
    public ResponseEntity<byte[]> downloadSpecialTemp(HttpServletRequest request) throws IOException {    
        String path = request.getSession().getServletContext().getRealPath("/")+"download"+File.separator+"specialTemps.xlsx";;  
        String downLoadFileName = "采购需求商品导入模版.xlsx";
        File file=new File(path);  
        HttpHeaders headers = new HttpHeaders();    
        String fileName=new String(downLoadFileName.getBytes("UTF-8"),"iso-8859-1");//为了解决中文名称乱码问题  
        headers.setContentDispositionFormData("attachment", fileName);   
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);   
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers, HttpStatus.OK);    
    }
    
    @RequestMapping("/uploadPic")  
    @ResponseBody  
    public Object uploadPic(@RequestParam(value = "file", required = false) MultipartFile file,HttpServletRequest request,HttpSession httpSession) throws Exception {  
    	User user = new User();
    	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
    	String path = request.getSession().getServletContext().getRealPath(ConfigHolder.getInstance().getConfig("special_goods_url"))+ File.separator + user.getUserId();  
        String fileName = file.getOriginalFilename();
        String suffix = "";
        
        if(isSpecialChar(fileName)){
       	 return "fileNameSpecialError";
       }
        
        int dot = fileName.lastIndexOf('.'); 
        if ((dot >-1) && (dot < (fileName.length()))) { 
        	suffix = fileName.substring(dot); 
        }
        
        
        if ( !Arrays.<String> asList(fileType.split(",")).contains(suffix.toLowerCase()))
        {
            return "fileNameError";
        }
      //判断文件大小是否超限
        if (file.getSize() > maxSize)
        {
            return "fileSizeError";
        }
//        String fileNameStr = (new Date().getTime())+fileName;  
        String fileNameStr = new Date().getTime()+suffix;
        File targetFile = new File(path, fileNameStr);  
        if(!targetFile.exists()){  
            targetFile.mkdirs();  
        }  
        //保存  
        try {  
            file.transferTo(targetFile);  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        
        return ConfigHolder.getInstance().getConfig("special_goods_url") + "/" + user.getUserId()+"/"+fileNameStr;  
    }  

    @RequestMapping("/deletePic")  
    @ResponseBody  
    public Object deletePic(@RequestParam("fileName")String fileName,HttpServletRequest request,HttpSession httpSession) throws Exception {  
    	Map<String, String> result = new HashMap<String, String>();
    	result.put("status", "success");
    	User user = new User();
    	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
    	String path = request.getSession().getServletContext().getRealPath(ConfigHolder.getInstance().getConfig("special_goods_url"))+ File.separator + user.getUserId();  
        String sPath = path+ File.separator + fileName;
        try{
        	this.deleteFile(sPath);
        }catch (Exception e) {
        	result.put("status", "fail");
		}
        return result;
    }  
    
    /**
     * 删除单个文件
     * 
     * @param sPath
     *            被删除文件的路径+文件名
     * @return 单个文件删除成功返回true，否则返回false
     */
    public boolean deleteFile(String sPath) {
        Boolean flag = false;
        File file = new File(sPath);
        // 路径为文件且不为空则进行删除
        if (file.isFile() && file.exists()) {
            file.delete();
            flag = true;
        }
        return flag;
    }
    
    /**
     * 判断是否含有特殊字符
     *
     * @param str
     * @return true为包含，false为不包含
     */
    public static boolean isSpecialChar(String str) {
        String regEx = "[~#^$@%&!\\-\\+*()<>:;'\"{}【】 ]|\n|\r|\t";
        Pattern p = Pattern.compile(regEx);
        Matcher m = p.matcher(str);
        return m.find();
    }
}