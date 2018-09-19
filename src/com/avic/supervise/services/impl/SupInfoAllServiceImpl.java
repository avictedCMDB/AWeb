package com.avic.supervise.services.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supervise.mappers.SupInfoAllMapper;
import com.avic.supervise.models.SupInfoAll;
import com.avic.supervise.services.SupInfoAllService;

@Service
public class SupInfoAllServiceImpl implements SupInfoAllService {
    
    @Autowired
    SupInfoAllMapper supInfoAllMapper;

	@Override
	public void addSupInfoAll(SupInfoAll supInfoAll) {
		supInfoAllMapper.addSupInfoAll(supInfoAll);
	}

	@Override
	public void updateSupInfoAll(SupInfoAll supInfoAll) {
		supInfoAllMapper.updateSupInfoAll(supInfoAll);
	}

	@Override
	public String querySupInfoAllIndex() {
		return supInfoAllMapper.querySupInfoAllIndex();
	}
}
