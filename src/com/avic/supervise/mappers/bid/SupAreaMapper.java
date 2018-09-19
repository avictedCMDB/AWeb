package com.avic.supervise.mappers.bid;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.management.models.SupArea;

@Repository
public interface SupAreaMapper {
	/**
	 * 查询供应商信息
	 * @return 
	 */
	public List<SupArea> queryAreas(SupArea supArea);
	/**
	 * 查询供应商信息
	 * @return 
	 */
	public List<SupArea> querySubAreas(SupArea supArea);
	
	public List<SupArea> queryAllAreas(@Param("supId") String supId);
	
	public SupArea queryAreaById(@Param("supId") String supId, @Param("supAreaId") String supAreaId);
}
