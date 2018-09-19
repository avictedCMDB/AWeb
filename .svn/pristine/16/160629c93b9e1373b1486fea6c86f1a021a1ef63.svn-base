package com.avic.supervise.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supervise.mappers.BrandMapper;
import com.avic.supervise.models.Brand;
import com.avic.supervise.services.BrandService;

@Service
public class BrandServiceImpl implements BrandService {
	protected static final Log logger = LogFactory.getLog(BrandServiceImpl.class);

    @Autowired
    BrandMapper BrandMapper;

	@Override
	public List<Brand> queryBrand(Brand brand) {
		return BrandMapper.queryBrand(brand);
	}

	@Override
	public int queryBrandCount(Brand brand) {
		return BrandMapper.queryBrandCount(brand);
	}

	@Override
	public void setIfRecommend(Brand brand) {
		BrandMapper.setIfRecommend(brand);
	}

	@Override
	public Brand getBrandInfoByBid(Brand brand) {
		return BrandMapper.getBrandInfoByBid(brand);
	}

	@Override
	public void updateBrandInfoDate(Brand brand) {
		BrandMapper.updateBrandInfoDate(brand);
	}

	@Override
	public int getBrandInfoExtByBid(Brand brand) {
		return BrandMapper.getBrandInfoExtByBid(brand);
	}

	@Override
	public void updateBrandExtPic(
			Brand brand) {
		BrandMapper.updateBrandExtPic(brand);
	}

	@Override
	public void addBrandInfoExt(Brand brand) {
		BrandMapper.addBrandInfoExt(brand);
	}

	@Override
	public String getBrandInfoExtImgPath(Brand brand) {
		return BrandMapper.getBrandInfoExtImgPath(brand);
	}
}
