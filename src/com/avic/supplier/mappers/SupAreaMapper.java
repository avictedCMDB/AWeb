package com.avic.supplier.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.supplier.models.SupArea;


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
}
