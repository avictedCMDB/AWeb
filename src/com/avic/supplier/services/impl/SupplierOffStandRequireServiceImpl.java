package com.avic.supplier.services.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supplier.mappers.SupplierAddressMapper;
import com.avic.supplier.mappers.SupplierGoodsInfoMapper;
import com.avic.supplier.mappers.SupplierOffStandRequireMapper;
import com.avic.supplier.models.SupplierGoodsInfo;
import com.avic.supplier.models.SupplierOffStandRequire;
import com.avic.supplier.services.SupplierOffStandRequireService;

@Service
public class SupplierOffStandRequireServiceImpl implements SupplierOffStandRequireService{
	@Autowired
	SupplierOffStandRequireMapper supplierOffStandRequireMapper;
	
	@Autowired
	SupplierGoodsInfoMapper supplierGoodsInfoMapper;
	
	@Autowired
	SupplierAddressMapper supplierAddressMapper;

	@Override
	public List<SupplierOffStandRequire> querySupplierOffStandRequiret(
			SupplierOffStandRequire supplierOffStandRequire) {
		List<SupplierOffStandRequire> supplierOffStandRequireList = supplierOffStandRequireMapper.querySupplierOffStandRequiret(supplierOffStandRequire);
//		String itemQutoPath = "";
//		for (int i = 0; i < supplierOffStandRequireList.size(); i++) {
//			String qutoPath = supplierOffStandRequireList.get(i).getQuotePath();
//			String qutoPaths[] = qutoPath.split(",");
//			for (int j = 0; j < qutoPaths.length; j++) {
//				if (qutoPaths[j].contains(supplierOffStandRequire.getSupId()+":")) {
//					itemQutoPath = qutoPaths[j].substring(qutoPaths[j].indexOf(":")+1,qutoPaths[j].length());
//				}
//			}
//			supplierOffStandRequireList.get(i).setQuotePath(itemQutoPath);
//		}
		return supplierOffStandRequireList;
	}

	@Override
	public Integer querySupplierOffStandRequiretCount(
			SupplierOffStandRequire supplierOffStandRequire) {
		return supplierOffStandRequireMapper.querySupplierOffStandRequiretCount(supplierOffStandRequire);
	}
	//判断是否为数字
	public boolean isNumeric(String str){ 
		   Pattern pattern = Pattern.compile("-?[0-9]+.?[0-9]+"); 
		   Matcher isNum = pattern.matcher(str);
		   if( !isNum.matches() ){
		       return false; 
		   } 
		   return true; 
		}
	@Override
	public Map<String, Object> uploadData(List<List<String>> supplierGoodInfos,String imgPath) {
		if (supplierGoodInfos == null) {
			return null;
		}
		int count = supplierGoodInfos.size();
		int errCount = 0;
		int sussCount = 0;
		String errMsg = "";
		String goodsNames = "";
		String goodsModels = "";
		List<SupplierGoodsInfo> supplierGoodInfoList = new ArrayList<SupplierGoodsInfo>();
		for (int i = 0; i < supplierGoodInfos.size(); i++) {
			SupplierGoodsInfo supplierGoodInfo = new SupplierGoodsInfo();
			List<String> execlData = supplierGoodInfos.get(i);
			supplierGoodInfo.setGoodsStatus("1");
			// 系统分类 暂无使用
			String systemType = execlData.get(0);
			String levelOne = execlData.get(1);
			String levelTwo = execlData.get(2);
			String marketCatId = this.supplierGoodsInfoMapper.queryGoodsCatId(systemType,levelOne, levelTwo);
			if (marketCatId == null || "".equals(marketCatId)) {
				errCount++;
				errMsg = errMsg + "，"+(i+2)+"行 【分类信息不存在】";
				continue;
			}else {
				supplierGoodInfo.setMarketCatId(marketCatId);
			}
			if (execlData.get(3) == null || "".equals(execlData.get(3))) {
				errCount++;
				errMsg = errMsg + "，"+(i+2)+"行 【商品名称不能为空】";
				continue;
			}
			supplierGoodInfo.setGoodsName(execlData.get(3));
			goodsNames = goodsNames + ",'" + execlData.get(3)+"'";
			supplierGoodInfo.setGoodsDesc(execlData.get(9));
			supplierGoodInfo.setGoodsParam(execlData.get(10));
			supplierGoodInfo.setBrandName(execlData.get(4));
			if (execlData.get(5) == null || "".equals(execlData.get(5))) {
				errCount++;
				errMsg = errMsg + "，"+(i+2)+"行 【规格型号不能为空】";
				continue;
			}
			supplierGoodInfo.setGoodsModel(execlData.get(5));
			goodsModels = goodsModels + ",'" + execlData.get(5)+"'";
			supplierGoodInfo.setGoodsStuff(execlData.get(6));
			supplierGoodInfo.setGoodsWeight(execlData.get(11));
			supplierGoodInfo.setProductArea(execlData.get(12));
			supplierGoodInfo.setGoodsCode(execlData.get(13));
			supplierGoodInfo.setGoodsWare(execlData.get(14));
			supplierGoodInfo.setGoodsUnit(execlData.get(15));
			if (execlData.get(7) == null || "".equals(execlData.get(7))) {
				errCount++;
				errMsg = errMsg + "，"+(i+2)+"行 【价格不能为空】";
				continue;
			}
			if(!this.isNumeric(execlData.get(7))){
				errCount++;
				errMsg = errMsg + "，"+(i+2)+"行 【价格只能输入数字】";
				continue;
			}
			supplierGoodInfo.setCountPrice(new BigDecimal(Double.parseDouble(execlData.get(7))).setScale(2,BigDecimal.ROUND_HALF_UP).toString());
			supplierGoodInfo.setSalePrice(new BigDecimal(Double.parseDouble(execlData.get(7))).setScale(2,BigDecimal.ROUND_HALF_UP).toString());
			supplierGoodInfo.setAgreePrice(new BigDecimal(Double.parseDouble(execlData.get(7))).setScale(2,BigDecimal.ROUND_HALF_UP).toString());
			if (execlData.get(8) == null || "".equals(execlData.get(8))) {
				errCount++;
				errMsg = errMsg + "，"+(i+2)+"行 【购买数量不能为空】";
				continue;
			}
			if(!this.isNumeric(execlData.get(8))){
				errCount++;
				errMsg = errMsg + "，"+(i+2)+"行 【购买数量只能输入数字】";
				continue;
			}
			supplierGoodInfo.setQuoteNum(execlData.get(8));
			supplierGoodInfo.setGoodsService(execlData.get(16));
			supplierGoodInfo.setImagePath(imgPath);
			sussCount++;
			supplierGoodInfoList.add(supplierGoodInfo);
		}
		Map<String, Object> reultMap = new HashMap<String, Object>();
		reultMap.put("count", String.valueOf(count));
		reultMap.put("sussCount", String.valueOf(sussCount));
		reultMap.put("errCount", String.valueOf(errCount));
		reultMap.put("goodsNames", goodsNames.substring(1,goodsNames.length()));
		reultMap.put("goodsModels", goodsModels.substring(1, goodsModels.length()));
		String reultMsg = "导入总条数："+count +"  成功条数："+sussCount + "  失败条数："+errCount +"<br/>";
		if (!"".equals(errMsg)) {
			errMsg = errMsg.substring(1,errMsg.length());
			reultMsg = reultMsg + "错误行数："+errMsg;
		}
		reultMap.put("errMsg",errMsg);
		reultMap.put("supplierGoodInfoList",supplierGoodInfoList);
		return reultMap;
	}

	@Override
	public void updateStatus(String id, String goodsIds,String supId,String sendFilePath) {
//		supplierOffStandRequireMapper.updateStatus(id, goodsIds,supId,sendFilePath );
	}

	@Override
	public void insertQuote(List<List<String>> supplierGoodInfos,String id,String sendFilePath,String supId,String imgPath,String fileName) {
		// 解析XML
		Map<String, Object> reultMap = uploadData(supplierGoodInfos,imgPath);
		List<SupplierGoodsInfo> supplierGoodInfoList = (List<SupplierGoodsInfo>) reultMap.get("supplierGoodInfoList");
		for (int i = 0; i < supplierGoodInfoList.size(); i++) {
			//商品上传
			supplierGoodInfoList.get(i).setSupId(supId);
			String goodsIndex = supplierAddressMapper.querySupplierIndex();
			supplierGoodInfoList.get(i).setSupGoodsId(goodsIndex);
			supplierGoodsInfoMapper.uploadData(supplierGoodInfoList.get(i));
		}
		String goodsNames = reultMap.get("goodsNames").toString();
		String goodsModels = reultMap.get("goodsModels").toString();
		// 查询明细
		List<SupplierGoodsInfo> supplierGoodsInfoList = supplierGoodsInfoMapper.querySupplierGoodsIds(goodsNames, goodsModels, supId);
		// 插入报价单表
		String index = supplierAddressMapper.querySupplierIndex();
		supplierOffStandRequireMapper.inserQuoteInfo(index, supId, id, sendFilePath,fileName);
		// 插入报价单详细
		for (int i = 0; i < supplierGoodsInfoList.size(); i++) {
			String detailIndex = supplierAddressMapper.querySupplierIndex();
			String quoteNum ="0";
			for (int j = 0; j < supplierGoodInfoList.size(); j++) {
				if (supplierGoodsInfoList.get(i).getGoodsName().equals(supplierGoodInfoList.get(j).getGoodsName())
						&& supplierGoodsInfoList.get(i).getGoodsModel().equals(supplierGoodInfoList.get(j).getGoodsModel())) {
					quoteNum = supplierGoodInfoList.get(j).getQuoteNum();
				}
			}
			supplierOffStandRequireMapper.inserQuoteDetail(detailIndex, index, supId, supplierGoodsInfoList.get(i).getSupGoodsId(), quoteNum);
		}
		// 更新需求表状态
		supplierOffStandRequireMapper.updateStatus(id,supId);
	}

	@Override
	public List<SupplierGoodsInfo> querySupplierGoodsInfoList(String id,String supId) {
		return supplierOffStandRequireMapper.querySupplierGoodsInfoList(id,supId);
	}

	@Override
	public SupplierOffStandRequire querySendOffPer(String id) {
		return supplierOffStandRequireMapper.querySendOffPer(id);
	}
}
