package com.avic.supplier.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.supplier.models.SupplierGoodsImage;
import com.avic.supplier.models.SupplierGoodsInfo;

@Repository
public interface SupplierGoodsInfoMapper {
	/**
	 * 查询商品信息一栏
	 * @return 
	 */
	public List<SupplierGoodsInfo> querySupplierGoodsInfoList(SupplierGoodsInfo supplierGoodInfo);
	
	public Integer querySupplierGoodsInfoListCount(SupplierGoodsInfo supplierGoodInfo);
	/**
	 * 查询商品品牌
	 * @return 
	 */
	public List<SupplierGoodsInfo> querySupplierGoodsInfoBrandNameList(SupplierGoodsInfo supplierGoodInfo);
	
	/**
	 * 删除商品转入回收站
	 * @param supplierGoodInfo
	 */
	public void updateDeleteFlag(SupplierGoodsInfo supplierGoodInfo);
	
	/**
	 * 查询商品详细图片
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
