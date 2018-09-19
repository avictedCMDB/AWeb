package com.avic.supplier.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.supplier.models.SupArea;


@Repository
public interface SupAreaMapper {
	/**
	 * ��ѯ��Ӧ����Ϣ
	 * @return 
	 */
	public List<SupArea> queryAreas(SupArea supArea);
	/**
	 * ��ѯ��Ӧ����Ϣ
	 * @return 
	 */
	public List<SupArea> querySubAreas(SupArea supArea);
}
