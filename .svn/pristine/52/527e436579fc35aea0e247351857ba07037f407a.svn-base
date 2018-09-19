package com.avic.management.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.AuditMapper;
import com.avic.management.models.Audit;
import com.avic.management.models.AuditImageInfo;
import com.avic.management.models.AuditOrder;
import com.avic.management.models.OrderSnapshot;
import com.avic.management.services.AuditService;

@Service
public class AuditServiceImpl implements AuditService {
    protected static final Log logger = LogFactory.getLog(AuditServiceImpl.class);

    @Autowired
    AuditMapper auditMapper;

	@Override
	public List<Audit> queryAudits(Audit audit) {
		return auditMapper.queryAudits(audit);
	}

	@Override
	public List<OrderSnapshot> queryGoodsSnapshotByOrderID(
			OrderSnapshot orderSnapshot) {
		return auditMapper.queryGoodsSnapshotByOrderID(orderSnapshot);
	}

	@Override
	public int queryAuditsCount(Audit audit) {
		return auditMapper.queryAuditsCount(audit);
	}

	@Override
	public List<OrderSnapshot> queryGoodsSnapshotOfLikeGoodsName(
			Audit audit) {
		return auditMapper.queryGoodsSnapshotOfLikeGoodsName(audit);
	}

	@Override
	public AuditOrder queryAuditOrderByOrderID(AuditOrder auditOrder) {
		return auditMapper.queryAuditOrderByOrderID(auditOrder);
	}

	@Override
	public void updateAuditOrder(AuditOrder auditOrder) {
		auditMapper.updateAuditOrder(auditOrder);
	}

	@Override
	public int queryAuditCount(Audit audit) {
		return auditMapper.queryAuditCount(audit);
	}

	@Override
	public List<AuditImageInfo> queryAuditImages(AuditOrder auditOrder) {
		return auditMapper.queryAuditImages(auditOrder);
	}

	@Override
	public void addAuditImages(AuditImageInfo auditImageInfo) {
		auditMapper.addAuditImages(auditImageInfo);
	}

    
}
