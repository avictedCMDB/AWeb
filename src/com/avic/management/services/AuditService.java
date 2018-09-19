package com.avic.management.services;

import java.util.List;

import com.avic.management.models.Audit;
import com.avic.management.models.AuditImageInfo;
import com.avic.management.models.AuditOrder;
import com.avic.management.models.Invoice;
import com.avic.management.models.OrderSnapshot;

public interface AuditService {
	/**
	 * ��ѯ����˶����б�
	 * @return 
	 */
	public List<Audit> queryAudits(Audit audit);
	/**
	 * ��ѯ����˶�������
	 * @return 
	 */
	public int queryAuditsCount(Audit audit);
	/**
	 * ���ݶ���id��ѯ��Ʒ�б�
	 * @return 
	 */
	public List<OrderSnapshot> queryGoodsSnapshotByOrderID(OrderSnapshot orderSnapshot);
	/**
	 * ������Ʒ����ģ����ѯ����id����
	 * @return 
	 */
	public List<OrderSnapshot> queryGoodsSnapshotOfLikeGoodsName(Audit audit);
	/**
	 * ���ݶ���ID��ѯ���������Ϣ
	 * @return 
	 */
	public AuditOrder queryAuditOrderByOrderID(AuditOrder auditOrder);
	/**
	 * �޸Ķ������
	 */
	public void updateAuditOrder(AuditOrder auditOrder);
	/**
	 * ��ѯ����б�����
	 */
	public int queryAuditCount(Audit audit);
	/**
	 * ���ݶ���id��ѯ���ͼƬ
	 * @return 
	 */
	public List<AuditImageInfo> queryAuditImages(AuditOrder auditOrder);
	/**
	 * �������ͼƬ��Ϣ
	 */
	public void addAuditImages(AuditImageInfo auditImageInfo);
}