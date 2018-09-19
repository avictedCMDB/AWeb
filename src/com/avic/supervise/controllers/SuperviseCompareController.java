package com.avic.supervise.controllers;

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

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.avic.common.beans.GoodsToCompare;
import com.avic.common.constants.SessionKeys;
import com.avic.common.utils.SupHtml2Pdf;

import com.avic.supervise.models.CodeList;
import com.avic.supervise.models.SupGoods;
import com.avic.supervise.models.User;
import com.avic.supervise.services.CodeListService;
import com.avic.supervise.models.SuperviseProductCompare;
import com.avic.supervise.services.SuperviseProductCompareService;
import com.lowagie.text.DocumentException;

@Controller
@RequestMapping("/compare")
public class SuperviseCompareController {
    protected static final Log logger = LogFactory.getLog(SuperviseCompareController.class);
    static final int PAGE_SIZE = 5; //每页显示多少条
    private final String downLoadFileName = "compare.pdf";
    private final String DOWNLOADPATH = "pdf";
    private final String fontName = "simsun.ttc";
    private final String FONTPATH = "fonts";
    @Autowired
    SuperviseProductCompareService productCompareService;
    @Autowired
    CodeListService codeService;
     
    @RequestMapping("")
    public String index(HttpServletRequest req,Map<String, Object> map,@ModelAttribute("productCompare") SuperviseProductCompare productCompare,HttpSession httpSession) {		
		String page = req.getParameter("page");
		
		int pageNum = 1;
		 
        if (StringUtils.isNumeric(page)) {
            pageNum = Integer.parseInt(page);
        }
		//productCompare.setUserID(user.getUserId());
        User user = (User) req.getSession().getAttribute(SessionKeys.LOGIN_SUPERVISE);
        String companyId = user.getCompanyId();
        productCompare.setCompanyID(companyId);
		//查询数量
        int total = productCompareService.queryProductCompareCount(productCompare);

        int pages = (int) Math.ceil((double) total / PAGE_SIZE);
        
        if (pageNum > pages) {
            pageNum = pages;
        }
		
    	logger.info("商品对比管理");
        List<SuperviseProductCompare> productCompares = new ArrayList<SuperviseProductCompare>();
        productCompare.setPage(pageNum);
        productCompare.setPageSize(PAGE_SIZE);
        productCompares = productCompareService.queryProductCompares(productCompare);
      //添加选购理由列表
        List<CodeList> reasonCodes = new ArrayList<CodeList>();
        reasonCodes = codeService.getCodeList("CHECKED_REASON");
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
        for (SuperviseProductCompare pc : productCompares) {
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
			map.put("pageAction","supervise/compare?startTime=" + startTime + "&endTime=" + endTime + "&searchGoodsName=" + URLEncoder.encode(searchGoodsName, "GBK")
			                    + "&searchSupName=" + URLEncoder.encode(searchSupName, "GBK") + "&page=%PAGE%");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
        return "compare/management_compare";
    }
    
    @RequestMapping("/detail")
    public String compareDetail(Map<String, Object> map,@ModelAttribute("goodsToCampare") GoodsToCompare goodsToCompare,HttpSession httpSession) {
    	logger.info("商品对比详细管理");
    	SuperviseProductCompare productCompare = new SuperviseProductCompare();
        //修改比对商品加载
        if(!"".equals(goodsToCompare.getSupCheckedID())&&goodsToCompare.getSupCheckedID()!=null){
        	//查询比对列表
        	productCompare.setCompareID(goodsToCompare.getCompareID());
        	productCompare = productCompareService.queryProductCompare(productCompare);
        	String[] arr = productCompare.getProCheckedReason().split(",");
        	List<String> reasonList = new ArrayList<String>();
        	for (int i = 0; i < arr.length; i++) {
        		reasonList.add(arr[i]);
			}
        	goodsToCompare.setCheckedReasonList(reasonList);
        	goodsToCompare.setProCheckedReason(productCompare.getProCheckedReason());
        	goodsToCompare.setSupCheckedID(productCompare.getSupCheckedID());
        	goodsToCompare.setSupGoodsCheckedID(productCompare.getSupGoodsCheckedID());
        	goodsToCompare.setCompanyName(productCompare.getCompanyName());
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
        }        
        //添加选购理由列表
        CodeList code = new CodeList();
        List<CodeList> reasonCodes = new ArrayList<CodeList>();
        code.setCodeListType("CHECKED_REASON");
        reasonCodes = codeService.getCodeList("CHECKED_REASON");
        map.put("reasonCodes", reasonCodes);
        map.put("supGoodsMap", supGoodsMap);
        map.put("goodsToCampare", goodsToCompare);
        return "compare/management_compare_detail";
    }
   
    
    /*
     * 跳转修改对比商品页面
     * RedirectAttributes 转发传递参数对象
     */
    @RequestMapping("/update/{compareID}")
    public String updateProductCompare(@PathVariable("compareID")String compareID,RedirectAttributes attr,HttpSession httpSession) {
        logger.info("跳转修改对比商品页面");
        logger.info("添加选购商品到购物车");
		SuperviseProductCompare pc = new SuperviseProductCompare();
        pc.setCompareID(compareID);
        pc = productCompareService.queryProductCompare(pc);
        attr.addAttribute("returnUrl","supervise/compare");
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
        attr.addAttribute("companyName", pc.getCompanyName());
        return "redirect:/supervise/compare/detail";
    }
    
    /*
     * 跳转修改对比商品页面
     * RedirectAttributes 转发传递参数对象
     */
    @RequestMapping("/del/{compareID}")
    public String delProductCompare(@PathVariable("compareID")String compareID,RedirectAttributes attr,HttpSession httpSession) {
        logger.info("跳转修改对比商品页面");
        logger.info("添加选购商品到购物车");
		SuperviseProductCompare pc = new SuperviseProductCompare();
        pc.setCompareID(compareID);
        productCompareService.delProductCompare(pc);
        return "redirect:/supervise/compare";
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
        reasonCodes = codeService.getCodeList(code.getCodeListType());
    	try {
			SupHtml2Pdf.html2Pdf(goodsToCompare, reasonCodes, pdfPath, fontPath);
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
}
