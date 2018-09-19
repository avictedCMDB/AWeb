package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.AuditImageInfo;
import com.avic.management.models.AuditOrder;

@Repository
public interface ImageInfoMapper {
	/**
	 * ����ҵ��id��ѯͼƬ
	 * @return 
	 */
	public List<AuditImageInfo> queryImages(AuditImageInfo auditImageInfo);
	/**
	 * ������ƱͼƬ
	 * @return 
	 */
	public void addVatImage(AuditImageInfo auditImageInfo);
	/**
	 * ɾ����ƱͼƬ
	 * @return 
	 */
	public void deleteVatImage(AuditImageInfo auditImageInfo);
}