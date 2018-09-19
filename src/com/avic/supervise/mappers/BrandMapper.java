package com.avic.supervise.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.supervise.models.Brand;

@Repository
public interface BrandMapper {
	/**
	 *查询推荐品牌
	 * @return 
	 */
	public List<Brand> queryBrand(Brand brand);
	/**
	 *查询推荐品牌数量
	 * @return 
	 */
	public int queryBrandCount(Brand brand);
	/**
	 *取消推荐品牌
	 * @return 
	 */
	public void setIfRecommend(Brand brand);
	
	/**
	 *查询推荐品牌
	 * @return 
	 */
	public Brand getBrandInfoByBid(Brand brand);
	/**
	 * 修改推荐品牌推荐时间
	 * @return 
	 */
	public void updateBrandInfoDate(Brand brand);
	
	/**
	 *查询推荐品牌扩展数量
	 * @return 
	 */
	public int getBrandInfoExtByBid(Brand brand);
	
	/**
	 * 修改推荐品牌扩展图片
	 * @return 
	 */
	public void updateBrandExtPic(Brand brand);
	/**
	 * 添加推荐品牌扩展图片
	 * @return 
	 */
	public void addBrandInfoExt(Brand brand);
	/**
	 *查询品牌扩展信息图片路径 
	 * @return 
	 */
	public String getBrandInfoExtImgPath(Brand brand);
}