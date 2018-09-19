package com.avic.management.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.ManagementMapper;
import com.avic.management.mappers.ManagementPartnerMapper;
import com.avic.management.models.EnterpriseSupMapping;
import com.avic.management.services.ManagementPartnerService;

@Service
public class ManagementPartnerServiceImpl implements ManagementPartnerService{

	@Autowired
	ManagementPartnerMapper managementPartnerMapper;
	
	@Override
	public List<EnterpriseSupMapping> queryEnterpriseSupMappingList(
			EnterpriseSupMapping enterpriseSupMapping) {
		// TODO Auto-generated method stub
		return managementPartnerMapper.queryEnterpriseSupMappingList(enterpriseSupMapping);
	}

	@Override
	public int queryEnterpriseSupMappingCount(
			EnterpriseSupMapping enterpriseSupMapping) {
		// TODO Auto-generated method stub
		return managementPartnerMapper.queryEnterpriseSupMappingCount(enterpriseSupMapping);
	}

	@Override
	public void updateIfBuilding(EnterpriseSupMapping enterpriseSupMapping) {
		managementPartnerMapper.updateIfBuilding(enterpriseSupMapping);
	}

	@Override
	public List<EnterpriseSupMapping> querySupInfo(
			EnterpriseSupMapping enterpriseSupMapping) {
		// TODO Auto-generated method stub
		return managementPartnerMapper.querySupInfo(enterpriseSupMapping);
	}

	@Override
	public void insertPartener(EnterpriseSupMapping enterpriseSupMapping) {
		// TODO Auto-generated method stub
		managementPartnerMapper.insertPartener(enterpriseSupMapping);
	}

	@Override
	public int querySupInfoCount(EnterpriseSupMapping enterpriseSupMapping) {
		// TODO Auto-generated method stub
		return managementPartnerMapper.querySupInfoCount(enterpriseSupMapping);
	}

	@Override
	public void deleteSupMapping(EnterpriseSupMapping enterpriseSupMapping) {
		// TODO Auto-generated method stub
		managementPartnerMapper.deleteSupMapping(enterpriseSupMapping);
	}

}