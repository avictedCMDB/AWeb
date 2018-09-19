package com.avic.supplier.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.supplier.models.SupplierGoodsImage;
import com.avic.supplier.models.SupplierGoodsInfo;

@Repository
public interface SupplierGoodsInfoMapper {
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
	
	public void uploadData(SupplierGoodsInfo supplierGoodInfo);
	
	public void updateGoodsInfo(SupplierGoodsInfo supplierGoodInfo);
	
	public List<SupplierGoodsImage> queryImage(SupplierGoodsImage supplierGoodsImage) ;
	
	public String queryGoodsCatId(String systemType,String levelOne,String levelTwo);
	
	public List<SupplierGoodsInfo> querySupplierGoodsIds(String goodsNames ,String goodsModels , String supId);
}