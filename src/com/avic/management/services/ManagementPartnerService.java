package com.avic.management.services;

import java.util.List;

import com.avic.management.models.EnterpriseSupMapping;

public interface ManagementPartnerService {
	
	
	public List<EnterpriseSupMapping> queryEnterpriseSupMappingList(EnterpriseSupMapping enterpriseSupMapping);
	
	public int queryEnterpriseSupMappingCount(EnterpriseSupMapping enterpriseSupMapping);
	
	public void updateIfBuilding(EnterpriseSupMapping enterpriseSupMapping);
	
	public void insertPartener(EnterpriseSupMapping enterpriseSupMapping);
	
	public List<EnterpriseSupMapping> querySupInfo(EnterpriseSupMapping enterpriseSupMapping);
	
	public int querySupInfoCount(EnterpriseSupMapping enterpriseSupMapping);
	
	public void deleteSupMapping(EnterpriseSupMapping enterpriseSupMapping);
	

}
