package com.avic.supplier.services;

import java.util.List;
import java.util.Map;

import com.avic.supplier.models.SupplierGoodsImage;
import com.avic.supplier.models.SupplierGoodsInfo;

public interface SupplierGoodsInfoService {
	
	/**
	 * ��ѯ��Ʒ��Ϣһ��
	 * @return 
	 */
	public List<SupplierGoodsInfo> querySupplierGoodsInfoList(SupplierGoodsInfo supplierGoodInfo);
	
	public Integer querySupplierGoodsInfoListCount(SupplierGoodsInfo supplierGoodInfo);
	
	/**
	 * ��ѯ��ƷƷ��
	 * @return 
	 */
	public List<SupplierGoodsInfo> querySupplierGoodsInfoBrandNameList(SupplierGoodsInfo supplierGoodInfo);
	
	/**
	 * ɾ����Ʒת�����վ
	 * @param supplierGoodInfo
	 */
	public void updateDeleteFlag(SupplierGoodsInfo supplierGoodInfo);
	
	/**
	 * ��ѯ��Ʒ��ϸͼƬ
	 * @param supplierGoodInfo
	 */
	public List<SupplierGoodsImage> queryGoodsImg(SupplierGoodsImage supplierGoodsImage);
	
	public List<SupplierGoodsInfo> queryOrderData(SupplierGoodsInfo supplierGoodInfo);
	
	public Integer queryOrderDataCount(SupplierGoodsInfo supplierGoodInfo);
	
	public SupplierGoodsInfo queryReportOrderData(SupplierGoodsInfo supplierGoodInfo);
	
	public Map<String, String> uploadData(List<List<String>> supplierGoodInfos,String supId,String imgPath);
	
	public void updateGoodsInfo(SupplierGoodsInfo supplierGoodInfo);
	
	public List<SupplierGoodsImage> queryImage(SupplierGoodsImage supplierGoodsImage) ;
	
	public List<SupplierGoodsInfo> querySupplierGoodsIds(String goodsNames ,String goodsModels , String supId);
}