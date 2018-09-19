package com.avic.management.controllers;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.avic.common.beans.GoodsToCompare;
import com.avic.common.constants.SessionKeys;
import com.avic.common.constants.UserRole;
import com.avic.common.exceptions.NoPermissionException;
import com.avic.common.exceptions.UserNotLoginException;
import com.avic.common.utils.Html2Pdf;
import com.avic.common.utils.Permission;
import com.avic.management.models.CodeList;
import com.avic.management.models.ProductCompare;
import com.avic.management.models.SupGoods;
import com.avic.management.services.CodeListService;
import com.avic.management.services.CommonService;
import com.avic.management.services.ProductCompareService;
import com.avic.management.services.SupGoodsService;
import com.avic.market.models.CompareItem;
import com.avic.passport.models.User;
import com.lowagie.text.DocumentException;

@Controller
@RequestMapping("/compare")
@Transactional
public class compareController {
    protected static final Log logger = LogFactory.getLog(compareController.class);
    static final int PAGE_SIZE = 5; //每页显示多少条
    private final String downLoadFileName = "compare.pdf";
    private final String DOWNLOADPATH = "pdf";
    private final String fontName = "simsun.ttc";
    private final String FONTPATH = "fonts";
    @Autowired
    CommonService commonService;
    @Autowired
    SupGoodsService supGoodsService;
    @Autowired
    ProductCompareService productCompareService;
    @Autowired
    CodeListService codeService;
     
    @RequestMapping("")
    public String index(HttpServletRequest req,Map<String, Object> map,@ModelAttribute("productCompare") ProductCompare productCompare,HttpSession httpSession) {
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
		productCompare.setUserID(user.getUserId());
		//查询数量
        int total = productCompareService.queryProductCompareCount(productCompare);

        int pages = (int) Math.ceil((double) total / PAGE_SIZE);
        
        if (pageNum > pages) {
            pageNum = pages;
        }
		
    	logger.info("商品对比管理");
        List<ProductCompare> productCompares = new ArrayList<ProductCompare>();
        productCompare.setPage(pageNum);
        productCompare.setPageSize(PAGE_SIZE);
        productCompares = productCompareService.queryProductCompares(productCompare);
        
      //添加选购理由列表
        CodeList code = new CodeList();
        List<CodeList> reasonCodes = new ArrayList<CodeList>();
        code.setCodeListType("CHECKED_REASON");
        reasonCodes = codeService.queryCodes(code);
        for (int k = 0; k < productCompares.size(); k++) {
        	 List<String> reasonsL = new ArrayList<String>();
        	 List<String> reasonText = new ArrayList<String>();
             String[] arr = productCompares.get(k).getProCheckedReason().split(",");
        	for (int i = 0; i < arr.length; i++) {
        		reasonsL.add(arr[i]);
			}
        	for (int j = 0; j < reasonCodes.size(); j++) {
        		if(reasonsL.contains(reasonCodes.get(j).getCodeValue())){
        			reasonText.add(reasonCodes.get(j).getCodeText());
        		}
			}
        	productCompares.get(k).setReasonText(reasonText);
		}
        
//        SupGoods sg;
        for (ProductCompare pc : productCompares) {
        	
        	if(pc.getSupGoodsOneID()!=null && pc.getSupGoodsOneID().equals(pc.getSupGoodsCheckedID())){
        		pc.setImagePath(pc.getSupGoodsOneImagePath());
        		pc.setGoodsName(pc.getSupGoodsOneGoodsName());
        		pc.setAgreePrice(pc.getSupGoodsOneAgreePrice());
        	}
        	if(pc.getSupGoodsTwoID()!=null && pc.getSupGoodsTwoID().equals(pc.getSupGoodsCheckedID())){
        		pc.setImagePath(pc.getSupGoodsTwoImagePath());
        		pc.setGoodsName(pc.getSupGoodsTwoGoodsName());
        		pc.setAgreePrice(pc.getSupGoodsTwoAgreePrice());
        	}
        	if(pc.getSupGoodsThreeID()!=null && pc.getSupGoodsThreeID().equals(pc.getSupGoodsCheckedID())){
        		pc.setImagePath(pc.getSupGoodsThreeImagePath());
        		pc.setGoodsName(pc.getSupGoodsThreeGoodsName());
        		pc.setAgreePrice(pc.getSupGoodsThreeAgreePrice());
        	}
        	if(pc.getSupGoodsFourID()!=null && pc.getSupGoodsFourID().equals(pc.getSupGoodsCheckedID())){
        		pc.setImagePath(pc.getSupGoodsFourImagePath());
        		pc.setGoodsName(pc.getSupGoodsFourGoodsName());
        		pc.setAgreePrice(pc.getSupGoodsFourAgreePrice());
        	}
        	/*List<SupGoods> supGoods = new ArrayList<SupGoods>();
			if(pc.getSupGoodsOneID()!=null && !pc.getSupGoodsOneID().equals(pc.getSupGoodsCheckedID())){
				sg = new SupGoods();
				sg.setSupGoodsID(pc.getSupGoodsOneID());
				sg.setSupID(pc.getSupOneID());
				sg=supGoodsService.queryGoods(sg);
				if(sg!=null){
					supGoods.add(sg);
				}
			}
			if(pc.getSupGoodsTwoID()!=null && !pc.getSupGoodsTwoID().equals(pc.getSupGoodsCheckedID())){
				sg = new SupGoods();
				sg.setSupGoodsID(pc.getSupGoodsTwoID());
				sg.setSupID(pc.getSupTwoID());
				sg=supGoodsService.queryGoods(sg);
				if(sg!=null){
					supGoods.add(sg);
				}
			}
			if(pc.getSupGoodsThreeID()!=null && !pc.getSupGoodsThreeID().equals(pc.getSupGoodsCheckedID())){
				sg = new SupGoods();
				sg.setSupGoodsID(pc.getSupGoodsThreeID());
				sg.setSupID(pc.getSupThreeID());
				sg=supGoodsService.queryGoods(sg);
				if(sg!=null){
					supGoods.add(sg);
				}
			}
			if(pc.getSupGoodsFourID()!=null && !pc.getSupGoodsFourID().equals(pc.getSupGoodsCheckedID())){
				sg = new SupGoods();
				sg.setSupGoodsID(pc.getSupGoodsFourID());
				sg.setSupID(pc.getSupFourID());
				sg=supGoodsService.queryGoods(sg);
				if(sg!=null){
					supGoods.add(sg);
				}
			}
			pc.setSupCompareGoods(supGoods);*/
			
		}
        String startTime = productCompare.getStartTime()==null?"":productCompare.getStartTime();
        String endTime = productCompare.getEndTime()==null?"":productCompare.getEndTime();
        String searchGoodsName = productCompare.getSearchGoodsName()==null?"":productCompare.getSearchGoodsName();
        String searchSupName = productCompare.getSearchSupName()==null?"":productCompare.getSearchSupName();
        
        map.put("productCompare", productCompare);
        map.put("productCompares", productCompares);
        map.put("page", pageNum);
        map.put("total", total);
        map.put("pages", pages);
        try {
			map.put("pageAction","management/compare?startTime=" + startTime + "&endTime=" + endTime + "&searchGoodsName=" + URLEncoder.encode(searchGoodsName, "GBK")
			                    + "&searchSupName=" + URLEncoder.encode(searchSupName, "GBK") + "&page=%PAGE%");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
        return "management_compare";
    }
    
    @RequestMapping("/detail")
    public String compareDetail(Map<String, Object> map,@ModelAttribute("goodsToCampare") GoodsToCompare goodsToCompare,HttpServletRequest req,HttpSession httpSession) {
    	User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
    	logger.info("商品对比详细管理");
    	ProductCompare productCompare = new ProductCompare();
    	//删除比对
    	String deleteFlag = req.getParameter("deleteFlag");
    	if ("1".equals(deleteFlag)) {
    		 List<CompareItem> items = (List<CompareItem>) httpSession.getAttribute(SessionKeys.MARKET_COMPARE);
    		 List<CompareItem> newItems = new ArrayList<CompareItem>();
    	        if (items != null) {
    	            for (CompareItem i : items) {
    	                if (i.getSupGoodsId().equals(goodsToCompare.getSupGoodsOneID())) {
    	                	newItems.add(i);
    	                }
    	                if (i.getSupGoodsId().equals(goodsToCompare.getSupGoodsTwoID())) {
    	                	newItems.add(i);
    	                }
    	                if (i.getSupGoodsId().equals(goodsToCompare.getSupGoodsThreeID())) {
    	                	newItems.add(i);
    	                }
    	                if (i.getSupGoodsId().equals(goodsToCompare.getSupGoodsFourID())) {
    	                	newItems.add(i);
    	                }
    	            }
    	        }
    	        
    	        if (items.size() == 0) {
    	        	httpSession.removeAttribute(SessionKeys.MARKET_COMPARE);
    	        } else {
    	        	httpSession.setAttribute(SessionKeys.MARKET_COMPARE, newItems);
    	        }
		}
        //修改比对商品加载
        if(!"".equals(goodsToCompare.getSupCheckedID())&&goodsToCompare.getSupCheckedID()!=null){
        	//查询比对列表
        	productCompare.setCompareID(goodsToCompare.getCompareID());
        	productCompare = productCompareService.queryProductCompare(productCompare);
        	goodsToCompare.setProCheckedReason(productCompare.getProCheckedReason());
        	String[] arr = productCompare.getProCheckedReason().split(",");
        	List<String> reasonList = new ArrayList<String>();
        	for (int i = 0; i < arr.length; i++) {
        		reasonList.add(arr[i]);
			}
        	goodsToCompare.setCheckedReasonList(reasonList);
        	goodsToCompare.setSupCheckedID(productCompare.getSupCheckedID());
        	goodsToCompare.setSupGoodsCheckedID(productCompare.getSupGoodsCheckedID());
        }
        SupGoods campareGoods;
        Map<String,SupGoods> supGoodsMap = new HashMap<String,SupGoods>();
        //修改查询比对商品从比对表中查询
        if(!"".equals(goodsToCompare.getSupCheckedID())&&goodsToCompare.getSupCheckedID()!=null){
        	if(!"".equals(goodsToCompare.getSupGoodsOneID())&&goodsToCompare.getSupGoodsOneID()!=null){
        		campareGoods = new SupGoods();
            	campareGoods.setSupGoodsID(goodsToCompare.getSupGoodsOneID());
            	campareGoods.setSupID(goodsToCompare.getSupOneID());
            	campareGoods.setAgreePrice(productCompare.getSupGoodsOneAgreePrice());
            	campareGoods.setBrandName(productCompare.getSupGoodsOneBrandName());
            	campareGoods.setGoodsName(productCompare.getSupGoodsOneGoodsName());
            	campareGoods.setImagePath(productCompare.getSupGoodsOneImagePath());
            	campareGoods.setProductArea(productCompare.getSupGoodsOneProductArea());
            	supGoodsMap.put("one",campareGoods);
        	}
        	if(!"".equals(goodsToCompare.getSupGoodsTwoID())&&goodsToCompare.getSupGoodsTwoID()!=null){
        		campareGoods = new SupGoods();
            	campareGoods.setSupGoodsID(goodsToCompare.getSupGoodsTwoID());
            	campareGoods.setSupID(goodsToCompare.getSupTwoID());
            	campareGoods.setAgreePrice(productCompare.getSupGoodsTwoAgreePrice());
            	campareGoods.setBrandName(productCompare.getSupGoodsTwoBrandName());
            	campareGoods.setGoodsName(productCompare.getSupGoodsTwoGoodsName());
            	campareGoods.setImagePath(productCompare.getSupGoodsTwoImagePath());
            	campareGoods.setProductArea(productCompare.getSupGoodsTwoProductArea());
            	supGoodsMap.put("two",campareGoods);
        	}
        	if(!"".equals(goodsToCompare.getSupGoodsThreeID())&&goodsToCompare.getSupGoodsThreeID()!=null){
        		campareGoods = new SupGoods();
            	campareGoods.setSupGoodsID(goodsToCompare.getSupGoodsThreeID());
            	campareGoods.setSupID(goodsToCompare.getSupOneID());
            	campareGoods.setAgreePrice(productCompare.getSupGoodsThreeAgreePrice());
            	campareGoods.setBrandName(productCompare.getSupGoodsThreeBrandName());
            	campareGoods.setGoodsName(productCompare.getSupGoodsThreeGoodsName());
            	campareGoods.setImagePath(productCompare.getSupGoodsThreeImagePath());
            	campareGoods.setProductArea(productCompare.getSupGoodsThreeProductArea());
            	supGoodsMap.put("three",campareGoods);
        	}
        	if(!"".equals(goodsToCompare.getSupGoodsFourID())&&goodsToCompare.getSupGoodsFourID()!=null){
        		campareGoods = new SupGoods();
            	campareGoods.setSupGoodsID(goodsToCompare.getSupGoodsFourID());
            	campareGoods.setSupID(goodsToCompare.getSupFourID());
            	campareGoods.setAgreePrice(productCompare.getSupGoodsFourAgreePrice());
            	campareGoods.setBrandName(productCompare.getSupGoodsFourBrandName());
            	campareGoods.setGoodsName(productCompare.getSupGoodsFourGoodsName());
            	campareGoods.setImagePath(productCompare.getSupGoodsFourImagePath());
            	campareGoods.setProductArea(productCompare.getSupGoodsFourProductArea());
            	supGoodsMap.put("four",campareGoods);
        	}
        }else{//从商品表中查询
        	if(!"".equals(goodsToCompare.getSupGoodsOneID())&&goodsToCompare.getSupGoodsOneID()!=null){
            	campareGoods = new SupGoods();
            	campareGoods.setSupGoodsID(goodsToCompare.getSupGoodsOneID());
            	campareGoods.setSupID(goodsToCompare.getSupOneID());
            	campareGoods=supGoodsService.queryGoods(campareGoods);
            	if(campareGoods!=null){
            		supGoodsMap.put("one",campareGoods);
            	}
            }
            if(!"".equals(goodsToCompare.getSupGoodsTwoID())&&goodsToCompare.getSupGoodsTwoID()!=null){
            	campareGoods = new SupGoods();
            	campareGoods.setSupGoodsID(goodsToCompare.getSupGoodsTwoID());
            	campareGoods.setSupID(goodsToCompare.getSupTwoID());
            	campareGoods=supGoodsService.queryGoods(campareGoods);
            	if(campareGoods!=null){
            		supGoodsMap.put("two",campareGoods);
            	}
            }
            if(!"".equals(goodsToCompare.getSupGoodsThreeID())&&goodsToCompare.getSupGoodsThreeID()!=null){
            	campareGoods = new SupGoods();
            	campareGoods.setSupGoodsID(goodsToCompare.getSupGoodsThreeID());
            	campareGoods.setSupID(goodsToCompare.getSupThreeID());
            	campareGoods=supGoodsService.queryGoods(campareGoods);
            	if(campareGoods!=null){
            		supGoodsMap.put("three",campareGoods);
            	}
            }
            if(!"".equals(goodsToCompare.getSupGoodsFourID())&&goodsToCompare.getSupGoodsFourID()!=null){
            	campareGoods = new SupGoods();
            	campareGoods.setSupGoodsID(goodsToCompare.getSupGoodsFourID());
            	campareGoods.setSupID(goodsToCompare.getSupFourID());
            	campareGoods=supGoodsService.queryGoods(campareGoods);
            	if(campareGoods!=null){
            		supGoodsMap.put("four",campareGoods);
            	}
            }
        }
        
        //添加选购理由列表
        CodeList code = new CodeList();
        List<CodeList> reasonCodes = new ArrayList<CodeList>();
        code.setCodeListType("CHECKED_REASON");
        reasonCodes = codeService.queryCodes(code);
        map.put("reasonCodes", reasonCodes);
        map.put("supGoodsMap", supGoodsMap);
        map.put("goodsToCampare", goodsToCompare);
        return "management_compare_detail";
    }
    /*
     * 点击添加选购商品到购物车
     * RedirectAttributes 转发传递参数对象
     */
    @RequestMapping("/addCart")
    public String compareDetail(@ModelAttribute("goodsToCampare") GoodsToCompare goodsToCompare,RedirectAttributes attr,HttpSession httpSession) {
        logger.info("添加选购商品到购物车");
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
    	String userID = user.getUserId();
        
        String compareID="";
        if(!"".equals(goodsToCompare.getCompareID())&&goodsToCompare.getCompareID()!=null){
        	compareID = goodsToCompare.getCompareID();
        }else{
        	compareID = commonService.queryIndex();
        }
        
        ProductCompare productCompare = new ProductCompare();
        productCompare.setCompareID(compareID);
        productCompare.setSupGoodsOneID(goodsToCompare.getSupGoodsOneID());
        productCompare.setSupOneID(goodsToCompare.getSupOneID());
        productCompare.setSupGoodsTwoID(goodsToCompare.getSupGoodsTwoID());
        productCompare.setSupTwoID(goodsToCompare.getSupTwoID());
        productCompare.setSupGoodsThreeID(goodsToCompare.getSupGoodsThreeID());
        productCompare.setSupThreeID(goodsToCompare.getSupThreeID());
        productCompare.setSupGoodsFourID(goodsToCompare.getSupGoodsFourID());
        productCompare.setSupFourID(goodsToCompare.getSupFourID());
        if("1".equals(goodsToCompare.getChooseGoodsIndex())){
        	
        	productCompare.setSupGoodsCheckedID(goodsToCompare.getSupGoodsOneID());
        	productCompare.setSupCheckedID(goodsToCompare.getSupOneID());
        	
        }else if("2".equals(goodsToCompare.getChooseGoodsIndex())){
        	
        	productCompare.setSupGoodsCheckedID(goodsToCompare.getSupGoodsTwoID());
        	productCompare.setSupCheckedID(goodsToCompare.getSupTwoID());
        	
        }else if("3".equals(goodsToCompare.getChooseGoodsIndex())){
        	
        	productCompare.setSupGoodsCheckedID(goodsToCompare.getSupGoodsThreeID());
        	productCompare.setSupCheckedID(goodsToCompare.getSupThreeID());
        	
        }else if("4".equals(goodsToCompare.getChooseGoodsIndex())){
        	
        	productCompare.setSupGoodsCheckedID(goodsToCompare.getSupGoodsFourID());
        	productCompare.setSupCheckedID(goodsToCompare.getSupFourID());
        }
        productCompare.setProCheckedReason(goodsToCompare.getProCheckedReason());
        productCompare.setRemark(goodsToCompare.getRemark());
        productCompare.setUserID(userID);
        //添加历史比对商品 
        productCompare.setSupGoodsOneAgreePrice(goodsToCompare.getSupGoodsOneAgreePrice());
        productCompare.setSupGoodsOneBrandName(goodsToCompare.getSupGoodsOneBrandName());
        productCompare.setSupGoodsOneGoodsName(goodsToCompare.getSupGoodsOneGoodsName());
        productCompare.setSupGoodsOneImagePath(goodsToCompare.getSupGoodsOneImagePath());
        productCompare.setSupGoodsOneProductArea(goodsToCompare.getSupGoodsOneProductArea());
        productCompare.setSupGoodsTwoAgreePrice(goodsToCompare.getSupGoodsTwoAgreePrice());
        productCompare.setSupGoodsTwoBrandName(goodsToCompare.getSupGoodsTwoBrandName());
        productCompare.setSupGoodsTwoGoodsName(goodsToCompare.getSupGoodsTwoGoodsName());
        productCompare.setSupGoodsTwoImagePath(goodsToCompare.getSupGoodsTwoImagePath());
        productCompare.setSupGoodsTwoProductArea(goodsToCompare.getSupGoodsTwoProductArea());
        productCompare.setSupGoodsThreeAgreePrice(goodsToCompare.getSupGoodsThreeAgreePrice());
        productCompare.setSupGoodsThreeBrandName(goodsToCompare.getSupGoodsThreeBrandName());
        productCompare.setSupGoodsThreeGoodsName(goodsToCompare.getSupGoodsThreeGoodsName());
        productCompare.setSupGoodsThreeImagePath(goodsToCompare.getSupGoodsThreeImagePath());
        productCompare.setSupGoodsThreeProductArea(goodsToCompare.getSupGoodsThreeProductArea());
        productCompare.setSupGoodsFourAgreePrice(goodsToCompare.getSupGoodsFourAgreePrice());
        productCompare.setSupGoodsFourBrandName(goodsToCompare.getSupGoodsFourBrandName());
        productCompare.setSupGoodsFourGoodsName(goodsToCompare.getSupGoodsFourGoodsName());
        productCompare.setSupGoodsFourImagePath(goodsToCompare.getSupGoodsFourImagePath());
        productCompare.setSupGoodsFourProductArea(goodsToCompare.getSupGoodsFourProductArea());
        
        if(!"".equals(goodsToCompare.getCompareID())&&goodsToCompare.getCompareID()!=null){
        	productCompareService.updateProductCompare(productCompare);
        }else{
        	productCompareService.addProductCompare(productCompare);
        }
        //sid=供应商编号&gid=商品编号
        attr.addAttribute("sid", productCompare.getSupCheckedID());
        attr.addAttribute("gid", productCompare.getSupGoodsCheckedID());
        attr.addAttribute("compareID",compareID);
        return "redirect:/market/cart/store";
    }
    
    /*
     * 跳转修改对比商品页面
     * RedirectAttributes 转发传递参数对象
     */
    @RequestMapping("/update/{compareID}")
    public String updateProductCompare(@PathVariable("compareID")String compareID,RedirectAttributes attr,HttpSession httpSession) {
        logger.info("跳转修改对比商品页面");
        logger.info("添加选购商品到购物车");
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
        ProductCompare pc = new ProductCompare();
        pc.setCompareID(compareID);
        pc = productCompareService.queryProductCompare(pc);
        attr.addAttribute("returnUrl","management/compare");
        attr.addAttribute("compareID",pc.getCompareID());
        attr.addAttribute("supCheckedID",pc.getSupCheckedID());
        attr.addAttribute("supGoodsCheckedID",pc.getSupGoodsOneID());
        attr.addAttribute("supOneID",pc.getSupOneID());
        attr.addAttribute("supGoodsOneID",pc.getSupGoodsOneID());
        attr.addAttribute("supTwoID",pc.getSupTwoID());
        attr.addAttribute("supGoodsTwoID",pc.getSupGoodsTwoID());
        attr.addAttribute("supThreeID",pc.getSupThreeID());
        attr.addAttribute("supGoodsThreeID",pc.getSupGoodsThreeID());
        attr.addAttribute("supFourID",pc.getSupFourID());
        attr.addAttribute("supGoodsFourID",pc.getSupGoodsFourID());
        attr.addAttribute("proCheckedReason",pc.getProCheckedReason());
        attr.addAttribute("remark", pc.getRemark());
        return "redirect:/management/compare/detail";
    }
    
    /*
     * 跳转修改对比商品页面
     * RedirectAttributes 转发传递参数对象
     */
    @RequestMapping("/del/{compareID}")
    public String delProductCompare(@PathVariable("compareID")String compareID,RedirectAttributes attr,HttpSession httpSession) {
        logger.info("跳转修改对比商品页面");
        logger.info("添加选购商品到购物车");
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
        ProductCompare pc = new ProductCompare();
        pc.setCompareID(compareID);
        productCompareService.delProductCompare(pc);
        return "redirect:/management/compare";
    }
    
    
    //下载文件
    @RequestMapping("downloadPDF")    
    public void downloadPDF(@ModelAttribute("goodsToCampare") GoodsToCompare goodsToCompare,HttpServletRequest request,HttpServletResponse response) throws IOException {
        // itext 生成pdf文档
    	String pdfPath = request.getSession().getServletContext().getRealPath("/")+DOWNLOADPATH+File.separator+downLoadFileName;
    	String fontPath = request.getSession().getServletContext().getRealPath("/")+FONTPATH+File.separator+fontName;  
    	//添加选购理由列表
        CodeList code = new CodeList();
        List<CodeList> reasonCodes = new ArrayList<CodeList>();
        code.setCodeListType("CHECKED_REASON");
        reasonCodes = codeService.queryCodes(code);
    	try {
			Html2Pdf.html2Pdf(goodsToCompare,reasonCodes, pdfPath, fontPath);
		} catch (DocumentException e) {
			e.printStackTrace();
		}
    	
    	//下载pdf文件   
        response.setCharacterEncoding("utf-8");  
        response.setContentType("multipart/form-data");  
//        String fileName = reqeust.getRealPath("/")+"download"+File.separator+"goodsTemplet.xlsx";
        String fileName = request.getSession().getServletContext().getRealPath("/")+DOWNLOADPATH+File.separator+downLoadFileName;
        System.err.println(fileName);
        response.setHeader("Content-Disposition", "attachment;fileName="+java.net.URLEncoder.encode("比价结果.pdf", "UTF-8"));  
        try {
            File file=new File(fileName);  
            InputStream inputStream=new FileInputStream(file);  
            OutputStream os=response.getOutputStream();  
            byte[] b=new byte[1024];  
            int length;  
            while((length=inputStream.read(b))>0){  
                os.write(b,0,length);  
            }  
            inputStream.close();  
        } catch (FileNotFoundException e) {  
            e.printStackTrace();  
        } catch (IOException e) {  
            e.printStackTrace();  
        } 
//        String path = request.getSession().getServletContext().getRealPath("/")+DOWNLOADPATH+File.separator+downLoadFileName;  
//        File file=new File(path);  
//        HttpHeaders headers = new HttpHeaders();    
//        String fileName=new String(downLoadFileName.getBytes("UTF-8"),"iso-8859-1");//为了解决中文名称乱码问题  
//        headers.setContentDispositionFormData("attachment", fileName);   
//        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);   
//        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers, HttpStatus.CREATED);    
    }
    
    @RequestMapping("/auditCompare")
    public String auditCompare(HttpServletRequest req,Map<String, Object> map,String orderID,HttpSession httpSession) {
		
		String page = req.getParameter("page");
		
		int pageNum = 1;
		 
        if (StringUtils.isNumeric(page)) {
            pageNum = Integer.parseInt(page);
        }
        ProductCompare productCompare = new ProductCompare();
		productCompare.setOrderID(orderID);
        //TODO 根据orderID查询比对表 compareID数组
        List<ProductCompare> productCompareIDS = new ArrayList<ProductCompare>();
        productCompareIDS = productCompareService.queryCompareIDS(productCompare);
        if(productCompareIDS.size()>0 && productCompareIDS!=null){
			//TODO 把compareID数组放入比对对象中 条件查询
	        List<String> compareIDS = new ArrayList<String>();
			for (int i = 0; i < productCompareIDS.size(); i++) {
				compareIDS.add(productCompareIDS.get(i).getCompareID());
			}
			
			productCompare.setCompareIDS(compareIDS);
			//查询数量
	        int total = productCompareService.queryAuditProductCompareCount(productCompare);
	
	        int pages = (int) Math.ceil((double) total / PAGE_SIZE);
	        
	        if (pageNum > pages) {
	            pageNum = pages;
	        }
			
	    	logger.info("商品对比管理");
	        List<ProductCompare> productCompares = new ArrayList<ProductCompare>();
	        productCompare.setPage(pageNum);
	        productCompare.setPageSize(PAGE_SIZE);
	        productCompares = productCompareService.queryAuditProductCompares(productCompare);
	        
	      //添加选购理由列表
	        CodeList code = new CodeList();
	        List<CodeList> reasonCodes = new ArrayList<CodeList>();
	        code.setCodeListType("CHECKED_REASON");
	        reasonCodes = codeService.queryCodes(code);
	        for (int k = 0; k < productCompares.size(); k++) {
	        	 List<String> reasonsL = new ArrayList<String>();
	        	 List<String> reasonText = new ArrayList<String>();
	             String[] arr = productCompares.get(k).getProCheckedReason().split(",");
	        	for (int i = 0; i < arr.length; i++) {
	        		reasonsL.add(arr[i]);
				}
	        	for (int j = 0; j < reasonCodes.size(); j++) {
	        		if(reasonsL.contains(reasonCodes.get(j).getCodeValue())){
	        			reasonText.add(reasonCodes.get(j).getCodeText());
	        		}
				}
	        	productCompares.get(k).setReasonText(reasonText);
			}
	        
	//        SupGoods sg;
	        for (ProductCompare pc : productCompares) {
	        	
	        	if(pc.getSupGoodsOneID()!=null && pc.getSupGoodsOneID().equals(pc.getSupGoodsCheckedID())){
	        		pc.setImagePath(pc.getSupGoodsOneImagePath());
	        		pc.setGoodsName(pc.getSupGoodsOneGoodsName());
	        		pc.setAgreePrice(pc.getSupGoodsOneAgreePrice());
	        	}
	        	if(pc.getSupGoodsTwoID()!=null && pc.getSupGoodsTwoID().equals(pc.getSupGoodsCheckedID())){
	        		pc.setImagePath(pc.getSupGoodsTwoImagePath());
	        		pc.setGoodsName(pc.getSupGoodsTwoGoodsName());
	        		pc.setAgreePrice(pc.getSupGoodsTwoAgreePrice());
	        	}
	        	if(pc.getSupGoodsThreeID()!=null && pc.getSupGoodsThreeID().equals(pc.getSupGoodsCheckedID())){
	        		pc.setImagePath(pc.getSupGoodsThreeImagePath());
	        		pc.setGoodsName(pc.getSupGoodsThreeGoodsName());
	        		pc.setAgreePrice(pc.getSupGoodsThreeAgreePrice());
	        	}
	        	if(pc.getSupGoodsFourID()!=null && pc.getSupGoodsFourID().equals(pc.getSupGoodsCheckedID())){
	        		pc.setImagePath(pc.getSupGoodsFourImagePath());
	        		pc.setGoodsName(pc.getSupGoodsFourGoodsName());
	        		pc.setAgreePrice(pc.getSupGoodsFourAgreePrice());
	        	}
				
			}
	        
	        map.put("productCompare", productCompare);
	        map.put("productCompares", productCompares);
	        map.put("page", pageNum);
	        map.put("total", total);
	        map.put("pages", pages);
        }else{
        	map.put("productCompare", productCompare);
 	        map.put("productCompares", new ArrayList<ProductCompare>());
 	        map.put("page", pageNum);
 	        map.put("total", 0);
 	        map.put("pages", 1);
        }
        map.put("pageAction","management/compare/auditCompare?orderID=" + orderID 
		                    + "&page=%PAGE%");
        return "audit/audit_management_compare";
    }
}
