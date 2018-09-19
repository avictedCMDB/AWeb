package com.avic.supervise.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supervise.mappers.SupplierRecommendMapper;
import com.avic.supervise.models.SupplierRecommend;
import com.avic.supervise.services.SupplierRecommendService;

@Service
public class SupplierRecommendServiceImpl implements SupplierRecommendService {
    protected static final Log logger = LogFactory.getLog(SupplierRecommendServiceImpl.class);

    @Autowired
    SupplierRecommendMapper supplierRecommendMapper;

	@Override
	public List<SupplierRecommend> querySupplierRecommends(
			SupplierRecommend supplierRecommend) {
		return supplierRecommendMapper.querySupplierRecommends(supplierRecommend);
	}

	@Override
	public int querySupplierRecommendsCount(SupplierRecommend supplierRecommend) {
		return supplierRecommendMapper.querySupplierRecommendsCount(supplierRecommend);
	}

	@Override
	public void setIfRecommend(SupplierRecommend supplierRecommend) {
		supplierRecommendMapper.setIfRecommend(supplierRecommend);
	}

	@Override
	public SupplierRecommend getSupInfoBySupID(
			SupplierRecommend supplierRecommend) {
		return supplierRecommendMapper.getSupInfoBySupID(supplierRecommend);
	}

	@Override
	public void updateSupInfoDate(SupplierRecommend supplierRecommend) {
		supplierRecommendMapper.updateSupInfoDate(supplierRecommend);
	}

	@Override
	public int getSupInfoExtBySupID(SupplierRecommend supplierRecommend) {
		return supplierRecommendMapper.getSupInfoExtBySupID(supplierRecommend);
	}

	@Override
	public void updateSuperviseRecommendExtPic(
			SupplierRecommend supplierRecommend) {
		supplierRecommendMapper.updateSuperviseRecommendExtPic(supplierRecommend);
	}

	@Override
	public void addSupInfoExt(SupplierRecommend supplierRecommend) {
		supplierRecommendMapper.addSupInfoExt(supplierRecommend);
	}

	@Override
	public String getSupInfoExtImgPath(SupplierRecommend supplierRecommend) {
		return supplierRecommendMapper.getSupInfoExtImgPath(supplierRecommend);
	}



}
