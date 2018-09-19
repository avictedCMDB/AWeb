package com.avic.supervise.services;

import java.util.List;

import com.avic.common.exceptions.ServiceException;
import com.avic.supervise.models.Refund;
import com.avic.supervise.models.RefundGoods;

public interface RefundService {
    public List<Refund> getRefundList(String timeStart, String timeEnd, String refundId, String supId, String orderId, String refundStatus, int page, int size) throws ServiceException;
    public int getRefundCount(String timeStart, String timeEnd, String refundId, String supId, String orderId, String refundStatus) throws ServiceException;
    public Refund getRefundStat(String timeStart, String timeEnd, String refundId, String supId, String orderId, String refundStatus) throws ServiceException;
    public Refund getRefundDetail(String refundId) throws ServiceException;
    public List<RefundGoods> getRefundGoods(String refundId, String orderId) throws ServiceException;
    public void updateRefundStatus(String refundId, String orderId) throws ServiceException;
}
