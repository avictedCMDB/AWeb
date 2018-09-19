package com.avic.supervise.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supervise.mappers.SupervisePartnerMapper;
import com.avic.supervise.models.EnterpriseSupMapping;
import com.avic.supervise.services.SupervisePartnerService;

@Service
public class SupervisePartnerServiceImpl implements SupervisePartnerService{

	@Autowired
	SupervisePartnerMapper SupervisePartnerMapper;
	
	@Override
	public List<EnterpriseSupMapping> queryEnterpriseSupMappingList(
			EnterpriseSupMapping enterpriseSupMapping) {
		// TODO Auto-generated method stub
		return SupervisePartnerMapper.queryEnterpriseSupMappingList(enterpriseSupMapping);
	}

	@Override
	public int queryEnterpriseSupMappingCount(
			EnterpriseSupMapping enterpriseSupMapping) {
		// TODO Auto-generated method stub
		return SupervisePartnerMapper.queryEnterpriseSupMappingCount(enterpriseSupMapping);
	}

	@Override
	public void updateIfBuilding(EnterpriseSupMapping enterpriseSupMapping) {
		SupervisePartnerMapper.updateIfBuilding(enterpriseSupMapping);
	}

	@Override
	public List<EnterpriseSupMapping> querySupInfo(
			EnterpriseSupMapping enterpriseSupMapping) {
		// TODO Auto-generated method stub
		return SupervisePartnerMapper.querySupInfo(enterpriseSupMapping);
	}

	@Override
	public void insertPartener(EnterpriseSupMapping enterpriseSupMapping) {
		// TODO Auto-generated method stub
		SupervisePartnerMapper.insertPartener(enterpriseSupMapping);
	}

	@Override
	public int querySupInfoCount(EnterpriseSupMapping enterpriseSupMapping) {
		// TODO Auto-generated method stub
		return SupervisePartnerMapper.querySupInfoCount(enterpriseSupMapping);
	}

	@Override
	public void deleteSupMapping(EnterpriseSupMapping enterpriseSupMapping) {
		// TODO Auto-generated method stub
		SupervisePartnerMapper.deleteSupMapping(enterpriseSupMapping);
	}

}
