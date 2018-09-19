package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.Audit;
import com.avic.management.models.AuditImageInfo;
import com.avic.management.models.AuditOrder;
import com.avic.management.models.Invoice;
import com.avic.management.models.OrderSnapshot;

@Repository
public interface AuditMapper {
	/**
	 * 查询待审核订单列表
	 * @return 
	 */
	public List<Audit> queryAudits(Audit audit);
	
	/**
	 * 查询待审核订单数量
	 * @return 
	 */
	public int queryAuditsCount(Audit audit);
	
	/**
	 * 根据订单id查询商品列表
	 * @return 
	 */
	public List<OrderSnapshot> queryGoodsSnapshotByOrderID(OrderSnapshot orderSnapshot);
	/**
	 * 根据商品名称模糊查询订单id集合
	 * @return 
	 */
	public List<OrderSnapshot> queryGoodsSnapshotOfLikeGoodsName(Audit audit);
	
	/**
	 * 根据订单ID查询订单审核信息
	 * @return 
	 */
	public AuditOrder queryAuditOrderByOrderID(AuditOrder auditOrder);
	/**
	 * 修改订单审核
	 */
	public void updateAuditOrder(AuditOrder auditOrder);
	/**
	 * 查询审核列表数量
	 */
	public int queryAuditCount(Audit audit);
	/**
	 * 根据订单id查询审核图片
	 * @return 
	 */
	public List<AuditImageInfo> queryAuditImages(AuditOrder auditOrder);
	
	/**
	 * 添加审核图片信息
	 */
	public void addAuditImages(AuditImageInfo auditImageInfo);
}
