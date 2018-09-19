package com.avic.supplier.services;

import java.util.List;
import java.util.Map;

import com.avic.supplier.models.SupplierGoodsInfo;
import com.avic.supplier.models.SupplierOffStandRequire;

public interface SupplierOffStandRequireService {
	
	public List<SupplierOffStandRequire> querySupplierOffStandRequiret(SupplierOffStandRequire supplierOffStandRequire) ;
	
	public Integer querySupplierOffStandRequiretCount(SupplierOffStandRequire supplierOffStandRequire);
	
	public Map<String, Object> uploadData(List<List<String>> supplierGoodInfos,String imgPath);
	
	public void updateStatus(String id ,String goodsIds,String supId,String sendFilePath);
	
	
	public List<SupplierGoodsInfo> querySupplierGoodsInfoList(String id,String supId) ;
	
	/**
	 * 
	 * @param supplierGoodInfos 上传商品信息
	 * @param id 需求单信息
	 * @param sendFilePath 报价单地址
	 */
	public void insertQuote(List<List<String>> supplierGoodInfos,String id,String sendFilePath,String supId,String imgPath,String fileName);
	
	public SupplierOffStandRequire querySendOffPer(String id) ;
	
	
	
}
