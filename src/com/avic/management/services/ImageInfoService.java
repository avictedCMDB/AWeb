package com.avic.management.services;

import java.util.List;

import com.avic.management.models.AuditImageInfo;
import com.avic.management.models.AuditOrder;

public interface ImageInfoService {
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
