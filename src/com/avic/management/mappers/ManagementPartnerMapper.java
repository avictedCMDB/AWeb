package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.EnterpriseSupMapping;

@Repository
public interface ManagementPartnerMapper {
	
public List<EnterpriseSupMapping> queryEnterpriseSupMappingList(EnterpriseSupMapping enterpriseSupMapping);
	
	public int queryEnterpriseSupMappingCount(EnterpriseSupMapping enterpriseSupMapping);
	
	public void updateIfBuilding(EnterpriseSupMapping enterpriseSupMapping);
	
	public void insertPartener(EnterpriseSupMapping enterpriseSupMapping);
	
	public List<EnterpriseSupMapping> querySupInfo(EnterpriseSupMapping enterpriseSupMapping);
	
	public int querySupInfoCount(EnterpriseSupMapping enterpriseSupMapping);
	
	public void deleteSupMapping(EnterpriseSupMapping enterpriseSupMapping);

}
