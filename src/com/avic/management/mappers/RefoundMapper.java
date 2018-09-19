package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.Exchange;
import com.avic.management.models.Invoice;
import com.avic.management.models.OrderSnapshot;
import com.avic.management.models.Refound;

@Repository
public interface RefoundMapper {
	/**
	 * ��ѯ�˻����б�
	 * @return 
	 */
	public List<Refound> queryRefound(Refound refound);
	/**
	 * ȷ���ջ�
	 * @return 
	 */
	public void updateOrderRefoundStatus(Refound refound);
	/**
	 * ��ѯ�˻������ջ�����
	 * @return 
	 */
	public int queryOrderRefoundReceiptCount(Refound refound);
	/**
	 * �޸Ķ���״̬Ϊȷ���ջ�
	 * @return 
	 */
	public void updateOrderStatusByRefoundID(Refound refound);
	/**
	 * ��ѯ�˻�������
	 * @return 
	 */
	public Refound queryRefoundByID(Refound refound);
	/**
	 * ��ѯ�˻�����Ʒ����
	 * @return 
	 */
	public List<OrderSnapshot> queryOrderSnapshotsByRefoundID(Refound refound);
	/**
	 * �޸��˻��������Ϣ
	 * @return 
	 */
	public void updateOrderRefoundExpressInfo(Refound refound);
	
	/**
	 * ��ѯ�˻�������
	 * @return 
	 */
	public int queryRefoundCount(Refound refound);
	
	/**
	 * ��ѯ�˻��������ͽ��
	 * @return 
	 */
	public Refound queryRefoundPriceAndAmountByRefoundID(Refound refound);
	
	/**
	 * �޸��˻��������ͽ��
	 * @return 
	 */
	public void updateOrderRefoundPriceAndAmount(Refound refound);
}