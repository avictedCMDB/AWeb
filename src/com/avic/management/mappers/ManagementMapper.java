package com.avic.management.mappers;


import org.springframework.stereotype.Repository;
import com.avic.management.models.Management;

@Repository
public interface ManagementMapper {
	/**
	 * 采购首页统计数据
	 * @return 
	 */
	public Management queryManagementCount(Management management);
}
