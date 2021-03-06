package com.avic.supplier.controllers;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.multipart.MultipartFile;

import com.avic.common.constants.SessionKeys;
import com.avic.common.shortMessage.ShortMessageUtils;
import com.avic.market.cpi.CpiService;
import com.avic.market.cpi.exceptions.NoSuchSupplierException;
import com.avic.market.cpi.exceptions.ServiceExecutionFailedException;
import com.avic.supplier.models.SupArea;
import com.avic.supplier.models.SupplierGoodsImage;
import com.avic.supplier.models.SupplierGoodsInfo;
import com.avic.supplier.services.SupAreaService;
import com.avic.supplier.services.SupplierGoodsInfoService;
import com.avic.supplier.utils.ReadExcel;

@Controller
@RequestMapping("/goodsInfo")
public class SupplierGoodsInfoController {
	protected static final Log logger = LogFactory
			.getLog(SupplierGoodsInfoController.class);

	@Autowired
	SupplierGoodsInfoService supplierGoodsInfoService;

	@Autowired
	SupAreaService areaService;

	/**
	 * 页面初始化方法
	 * 
	 * @param map
	 * @return
	 * @throws UnsupportedEncodingException 
	 * @throws RemoteException 
	 */
	@RequestMapping("")
	public String index(Map<String, Object> map,HttpSession httpSession,
			@ModelAttribute("supplierGoodsInfo") SupplierGoodsInfo supplierGoodsInfo) throws UnsupportedEncodingException, RemoteException {
		String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
		supplierGoodsInfo.setSupId(supId);
		supplierGoodsInfo.setDeleteFlag("0");
//		ShortMessageUtils.sendSMS(new String[]{"13610968993","18525308031"}, "你有新的订单赶紧去审核马六的");
		List<SupplierGoodsInfo> supplierGoodsInfoList = supplierGoodsInfoService
				.querySupplierGoodsInfoList(supplierGoodsInfo);
		map.put("supplierGoodsInfoList", supplierGoodsInfoList);
		List<SupplierGoodsInfo> bankNameList = supplierGoodsInfoService
				.querySupplierGoodsInfoBrandNameList(supplierGoodsInfo);
		map.put("bankNameList", bankNameList);
		map.put("queryParam", supplierGoodsInfo);
		//分页信息
        String page = String.valueOf(supplierGoodsInfo.getPage());
        int total = supplierGoodsInfoService.querySupplierGoodsInfoListCount(supplierGoodsInfo);

        int pages = (int) Math.ceil((double) total / supplierGoodsInfo.getPageSize());
//        map.put("ok", "0");
        map.put("page", page);
        map.put("total", total);
        map.put("pages", pages);
        map.put("pageAction","supplier/goodsInfo?"
        		+ "&brandName="+URLEncoder.encode((supplierGoodsInfo.getBrandName() == null ?"":supplierGoodsInfo.getBrandName()),"GBK")
        		+ "&goodsName="+URLEncoder.encode((supplierGoodsInfo.getGoodsName() == null ?"":supplierGoodsInfo.getGoodsName()),"GBK")
        		+ "&goodsStatus="+(supplierGoodsInfo.getGoodsStatus() == null ?"":supplierGoodsInfo.getGoodsStatus())
        		+ "&goodsDesc="+URLEncoder.encode((supplierGoodsInfo.getGoodsDesc() == null ?"":supplierGoodsInfo.getGoodsDesc()),"GBK")
        		+ "&createDateStar="+(supplierGoodsInfo.getCreateDateStar() == null ?"":supplierGoodsInfo.getCreateDateStar())
        		+ "&createDateEnd="+(supplierGoodsInfo.getCreateDateEnd() == null ?"":supplierGoodsInfo.getCreateDateEnd())
                + "&page=%PAGE%");
		return "goods/supplier_goods_info";
	}
	
//	/**
//	 * 页面查询
//	 * 
//	 * @param map
//	 * @return
//	 */
//	@RequestMapping("/query")
//	public String query(
//			Map<String, Object> map,
//			@ModelAttribute("supplierGoodsInfo") SupplierGoodsInfo supplierGoodsInfo,HttpSession httpSession) {
//		String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
//		supplierGoodsInfo.setSupId(supId);
//		supplierGoodsInfo.setDeleteFlag("0");
//		List<SupplierGoodsInfo> supplierGoodsInfoList = supplierGoodsInfoService
//				.querySupplierGoodsInfoList(supplierGoodsInfo);
//		map.put("supplierGoodsInfoList", supplierGoodsInfoList);
//		List<SupplierGoodsInfo> bankNameList = supplierGoodsInfoService
//				.querySupplierGoodsInfoBrandNameList(supplierGoodsInfo);
//		map.put("bankNameList", bankNameList);
//		map.put("queryParam", supplierGoodsInfo);
//		return "goods/supplier_goods_info";
//	}
	/**
	 * 页面查询
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/uploadPage")
	public String uploadPage(
			Map<String, Object> map,HttpSession httpSession) {
		return "goods/supplier_goods_info_add";
	}
	/**
	 * 页面查询
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/updatePage/{supGoodsId}")
	public String updatePage(@PathVariable("supGoodsId") String supGoodsId,
			Map<String, Object> map,HttpSession httpSession) {
		String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
		SupplierGoodsInfo supplierGoodsInfo = new SupplierGoodsInfo();
		supplierGoodsInfo.setSupId(supId);
		supplierGoodsInfo.setDeleteFlag("0");
		supplierGoodsInfo.setSupGoodsId(supGoodsId);
		List<SupplierGoodsInfo> supplierGoodsInfoList = supplierGoodsInfoService
				.querySupplierGoodsInfoList(supplierGoodsInfo);
		map.put("supplierGoodsValue", supplierGoodsInfoList.get(0));
		return "goods/supplier_goods_info_add02";
	}
	/**
	 * 页面初始化方法
	 * 
	 * @param map
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("updateGoods")
	@ResponseBody
	public String updateGoods(Map<String, Object> map,HttpSession httpSession,
			@RequestParam("supGoodsId") String supGoodsId,
			@RequestParam("goodsName") String goodsName,
			@RequestParam("goodsDesc") String goodsDesc,
			@RequestParam("goodsParam") String goodsParam,
			@RequestParam("brandName") String brandName,
			@RequestParam("goodsModel") String goodsModel,
			@RequestParam("goodsWeight") String goodsWeight,
			@RequestParam("salePrice") String salePrice,
			@RequestParam("productArea") String productArea,
			@RequestParam("goodsUnit") String goodsUnit,
			@RequestParam("goodsService") String goodsService,
			@RequestParam("goodsCode") String goodsCode,
			@RequestParam("goodsUrl") String goodsUrl
			) throws UnsupportedEncodingException {
		String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
		SupplierGoodsInfo supplierGoodsInfo = new SupplierGoodsInfo();
		supplierGoodsInfo.setSupId(supId);
		supplierGoodsInfo.setSupGoodsId(supGoodsId);
		supplierGoodsInfo.setGoodsName(goodsName);
		supplierGoodsInfo.setGoodsDesc(goodsDesc);
		supplierGoodsInfo.setGoodsParam(goodsParam);
		supplierGoodsInfo.setBrandName(brandName);
		supplierGoodsInfo.setGoodsModel(goodsModel);
		supplierGoodsInfo.setGoodsWeight(goodsWeight);
		supplierGoodsInfo.setSalePrice(salePrice);
		supplierGoodsInfo.setProductArea(productArea);
		supplierGoodsInfo.setGoodsUnit(goodsUnit);
		supplierGoodsInfo.setGoodsService(goodsService);
		supplierGoodsInfo.setGoodsCode(goodsCode);
		supplierGoodsInfo.setImagePath(goodsUrl);
		supplierGoodsInfoService.updateGoodsInfo(supplierGoodsInfo);
		return "1";
	}
	/**
	 * 查询商品详细信息
	 * 
	 * @param map
	 * @param goodsId
	 * @return
	 */
	@RequestMapping("/queryDetailed/{supGoodsId}")
	public String queryDetailed(Map<String, Object> map,
			@PathVariable("supGoodsId") String supGoodsId,HttpSession httpSession) {
		logger.info("查询金额");
		String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
		SupplierGoodsInfo supplierGoodsInfo = new SupplierGoodsInfo();
		supplierGoodsInfo.setSupId(supId);
		supplierGoodsInfo.setDeleteFlag("0");
		supplierGoodsInfo.setSupGoodsId(supGoodsId);
		List<SupplierGoodsInfo> supplierGoodsInfoList = supplierGoodsInfoService
				.querySupplierGoodsInfoList(supplierGoodsInfo);
		if (supplierGoodsInfoList == null || supplierGoodsInfoList.size() == 0) {
			map.put("ok", "1");
			return "goods/supplier_goods_info_check"; 
		}
		map.put("supplierGoodsInfo", supplierGoodsInfoList.get(0));
		SupplierGoodsImage supplierGoodsImage = new SupplierGoodsImage();
		supplierGoodsImage.setSupId(Integer.parseInt(supId));
		supplierGoodsImage.setSupGoodsId(supGoodsId);
		List<SupplierGoodsImage> supplierGoodsImageList = supplierGoodsInfoService.queryGoodsImg(supplierGoodsImage);
		map.put("supplierGoodsImageList", supplierGoodsImageList);
		// 获取详细成交价格
		SupplierGoodsInfo orderDataParam = new SupplierGoodsInfo();
		orderDataParam.setSupGoodsId(supGoodsId);
		List<SupplierGoodsInfo> orderDataList= supplierGoodsInfoService.queryOrderData(orderDataParam);
		map.put("orderDataList", orderDataList);
		// 获取统计价格
		SupplierGoodsInfo reportOrderDataParam = new SupplierGoodsInfo();
		reportOrderDataParam.setSupGoodsId(supGoodsId);
		SupplierGoodsInfo reportOrderData = supplierGoodsInfoService.queryReportOrderData(reportOrderDataParam);
		if (orderDataList.size() != 0) {
			reportOrderData.setNowPrice(orderDataList.get(0).getGoodsPrice());
		}
		//分页信息
        String page = String.valueOf(orderDataParam.getPage());
        int total = supplierGoodsInfoService.queryOrderDataCount(orderDataParam);

        int pages = (int) Math.ceil((double) total / orderDataParam.getPageSize());
        
        map.put("page", page);
        map.put("total", total);
        map.put("pages", pages);
        map.put("pageAction","supplier/goodsInfo/queryDetailed/"+supGoodsId+"?"
                + "page=%PAGE%");
		map.put("reportOrderData", reportOrderData);
		return "goods/supplier_goods_info_check";
	}
	/**
	 * 查询价格
	 * 
	 * @param map
	 * @param goodsId
	 * @return
	 */
	@RequestMapping("/queryPrice/{supGoodsId}")
	public String queryPrice(Map<String, Object> map,
			@PathVariable("supGoodsId") String supGoodsId,HttpSession httpSession) {
		logger.info("查询金额");
		String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
		SupplierGoodsInfo supplierGoodsInfo = new SupplierGoodsInfo();
		supplierGoodsInfo.setSupId(supId);
		supplierGoodsInfo.setDeleteFlag("0");
		supplierGoodsInfo.setSupGoodsId(supGoodsId);
		List<SupplierGoodsInfo> supplierGoodsInfoList = supplierGoodsInfoService
				.querySupplierGoodsInfoList(supplierGoodsInfo);
		map.put("supplierGoodsPrice", supplierGoodsInfoList.get(0));
		return "goods/supplier_goods_info_price";
	}

	/**
	 * 查询存库
	 * 
	 * @param map
	 * @return
	 * @throws ServiceExecutionFailedException
	 * @throws NoSuchSupplierException
	 */
	@RequestMapping("/queryStore/{supGoodsId}")
	public String queryStore(Map<String, Object> map,
			@PathVariable("supGoodsId") String supGoodsId,HttpSession httpSession)
			throws NoSuchSupplierException, ServiceExecutionFailedException {
		logger.info("查询库存");
		String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
		// 取得商品信息
		SupplierGoodsInfo supplierGoodsInfo = new SupplierGoodsInfo();
		supplierGoodsInfo.setSupId(supId);
		supplierGoodsInfo.setDeleteFlag("0");
		supplierGoodsInfo.setSupGoodsId(supGoodsId);
		List<SupplierGoodsInfo> supplierGoodsInfoList = supplierGoodsInfoService
				.querySupplierGoodsInfoList(supplierGoodsInfo);
		map.put("supplierGoodsPrice", supplierGoodsInfoList.get(0));
		// 取得地区信息
		SupArea supArea = new SupArea();
		supArea.setSupID(httpSession.getAttribute(SessionKeys.SUP_ID).toString());
		// 加载地区信息
		List<SupArea> areas = areaService.queryAreas(supArea);
		map.put("areasList", areas);
		return "goods/supplier_goods_info_store";
	}

	/**
	 * 删除转入回收站
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/updateDeleteFlag/{supGoodsId}")
	public String updateDeleteFlag(Map<String, Object> map,
			@PathVariable("supGoodsId") String supGoodsId,HttpSession httpSession) {
		logger.info("删除转入回收站");
		String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
		SupplierGoodsInfo supplierGoodsInfo = new SupplierGoodsInfo();
		supplierGoodsInfo.setSupId(supId);
		supplierGoodsInfo.setSupGoodsId(supGoodsId);
		supplierGoodsInfo.setDeleteFlag("1");
		supplierGoodsInfoService.updateDeleteFlag(supplierGoodsInfo);
		return "redirect:/supplier/goodsInfo";
	}

	@RequestMapping("/loadSubArea")
	@ResponseBody
	public Object loadSubArea(@RequestParam("parentId") String parentId,
			HttpSession httpSession)
			throws NoSuchSupplierException, ServiceExecutionFailedException {
		SupArea supArea = new SupArea();
		supArea.setSupParentArea(parentId);
		supArea.setSupID(httpSession.getAttribute(SessionKeys.SUP_ID).toString());
		// 加载地区信息
		List<SupArea> areas = new ArrayList<SupArea>();
		areas = areaService.querySubAreas(supArea);
		return areas;
	}

	@RequestMapping("/queryStoreNumber")
	@ResponseBody
	public Object queryStoreNumber(@RequestParam("area") String area,
			@RequestParam("areaSub") String areaSub,
			@RequestParam("areaLast") String areaLast,
			@RequestParam("supGoodsId") String supGoodsId,
			HttpSession httpSession)
			throws NoSuchSupplierException, ServiceExecutionFailedException {
		// 加载地区信息
		List<String> item = new ArrayList<String>();
		item.add(supGoodsId);
		List<String> item2 = new ArrayList<String>();
		item2.add(area);
		item2.add(areaSub);
		item2.add(areaLast);
		String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
		Map<String, Integer> store = CpiService.getInstance().getGoodsStock(Integer.parseInt(supId),
				item,null,item2);
		return store;
	}
	/**
	 * 文件上传
	 * @param map
	 * @param httpSession
	 * @param supplierGoodsInfo
	 * @param uploadFiles
	 * @return
	 * @throws NoSuchSupplierException
	 * @throws ServiceExecutionFailedException
	 * @throws IOException
	 */
	@RequestMapping("/uploadFiles")
	public Object uploadFile(Map<String, Object> map,HttpSession httpSession,HttpServletRequest request,
			@ModelAttribute("supplierGoodsInfo") SupplierGoodsInfo supplierGoodsInfo,
			 @RequestParam("uploadFile") MultipartFile uploadFiles)
			throws NoSuchSupplierException, ServiceExecutionFailedException, IOException {
		map.put("ok", "0");
		String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
		if (uploadFiles.isEmpty()) {
			map.put("ok", "1");
			map.put("msg", "上传的文件为空文件，请检查问候重新上传！");
		}else {
			String excelVersion = "";
			String old = uploadFiles.getOriginalFilename();
			String postfix = old.substring(old.lastIndexOf("."),old.length());
			if (".xlsx".equals(postfix)) {
				excelVersion="2007";
			}else if (".xls".equals(postfix)) {
				excelVersion="2003";
			}
			List<List<String>> supplierGoodsInfos = null;
            try {
            	supplierGoodsInfos= ReadExcel.readExcelFile(uploadFiles.getInputStream(),excelVersion);
			} catch (Exception e) {
				e.printStackTrace();
				map.put("ok", "2");
				map.put("msg", "上传的文件解析失败，请使用指定的模板文件！");
			}
			// 数据插入
			Map<String, String> reultMap = supplierGoodsInfoService.uploadData(supplierGoodsInfos,supId,request.getContextPath()+"/static/img/img-profession.jpg");
			if (reultMap == null ) {
				map.put("ok", "2");
				map.put("msg", "上传的文件解析失败，请使用指定的模板文件！");
			}else {
				map.put("ok", "3");
				map.put("msg", "上传成功！");
				map.put("count", reultMap.get("count"));
				map.put("sussCount", reultMap.get("sussCount"));
				map.put("errCount", reultMap.get("errCount"));
				map.put("errMsg", reultMap.get("errMsg"));
			}
		}
		//页面查询
		return "goods/supplier_goods_info_add";
	}
	@RequestMapping("/download")  
    public void downloadFile(HttpServletRequest reqeust,HttpServletResponse response) throws UnsupportedEncodingException{  
        response.setCharacterEncoding("utf-8");  
        response.setContentType("multipart/form-data");  
        String type = reqeust.getParameter("type");
//        String fileName = reqeust.getRealPath("/")+"download"+File.separator+"goodsTemplet.xlsx";
        String fileName = reqeust.getSession().getServletContext().getRealPath("/")+"download"+File.separator+"goodsTemplet"+type+".xlsx";
        System.err.println(fileName);
        String headName = "";
        if ("1".equals(type)) {
			headName = "工具工装";
		}else if("2".equals(type)) {
			headName = "非标准件";
		}else if("3".equals(type)) {
			headName = "其他商品";
		}else if("4".equals(type)) {
			headName = "工具工装需求商品";
		}else if("5".equals(type)) {
			headName = "其他需求商品";
		}
        response.setHeader("Content-Disposition", "attachment;fileName="+java.net.URLEncoder.encode(headName+"供应商导入模板.xlsx", "UTF-8"));  
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
    }
	

}
