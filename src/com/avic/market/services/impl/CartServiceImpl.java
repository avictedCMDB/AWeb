package com.avic.market.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avic.common.exceptions.ServiceException;
import com.avic.market.mappers.CartMapper;
import com.avic.market.models.CartItem;
import com.avic.market.services.CartService;

@Service
public class CartServiceImpl implements CartService {
    protected static final Log logger = LogFactory.getLog(CartServiceImpl.class);
    
    @Autowired
    CartMapper cartMapper;

    @Override
    public void addToCart(CartItem item) throws ServiceException {
        logger.info("��ӹ��ﳵService");
        
        try {
            int count = cartMapper.queryCartItemCount(item);
            if (count > 0) {
                cartMapper.increaseCartNum(item);
            } else {
                cartMapper.insertCartItem(item);
            }
        } catch (Exception e) {
            logger.error("��ӹ��ﳵʧ��", e);
            throw new ServiceException(e);
        }
    }

    @Override
    public int countGoodsNum(String userId) throws ServiceException {
        logger.info("��ѯ���ﳵ����Service-userId["+userId+"]");
        return cartMapper.queryCartGoodsNum(userId);
    }
    
    @Override
    public List<CartItem> getCartGoodsList(String userId) throws ServiceException {
        logger.info("��ѯ���ﳵ�б�Service-userId["+userId+"]");
        return cartMapper.queryCartGoodsList(userId);
    }
    
    @Transactional
    @Override
    public void clearCart(String userId) throws ServiceException {
        logger.info("��չ��ﳵService-userId["+userId+"]");
        
        try {
            cartMapper.deleteCart(userId);
        } catch (Exception e) {
            logger.error("��չ��ﳵʧ��", e);
            throw new ServiceException(e);
        }
    }
    
    @Transactional
    @Override
    public void deleteCartGoods(List<CartItem> items) throws ServiceException {
        logger.info("ɾ�����ﳵ��ƷService");
        
        try {
            cartMapper.batchDeleteCartGoods(items);
        } catch (Exception e) {
            logger.error("ɾ�����ﳵ��Ʒʧ��", e);
            throw new ServiceException(e);
        }
    }
    
    @Override
    public void updateCartNum(CartItem item) throws ServiceException {
        logger.info("���¹��ﳵ��Ʒ����Service");
        try {
            cartMapper.updateCartNum(item);
        } catch (Exception e) {
            logger.error("���¹��ﳵ��Ʒ����ʧ��", e);
            throw new ServiceException(e);
        }
    }
    
    @Override
    public List<CartItem> getCartGoodsByIds(String userId, int supId, List<String> ids) throws ServiceException {
        logger.info("ͨ��ID��ȡ���ﳵ��Ʒ��ϢService");
        return cartMapper.queryCartGoodsByIds(userId, supId, ids);
    }

    @Override
    public boolean checkGoodsCompare(String userId, int supId, String supGoodsId) throws ServiceException {
        logger.info("�����Ʒ�Ƿ��ѶԱ�");
        return cartMapper.queryGoodsCompareCount(userId, String.valueOf(supId), supGoodsId) > 0;
    }
    
    @Override
    public List<String> getCartCompare(List<CartItem> items) throws ServiceException {
        return cartMapper.queryCartCompare(items);
    }
    
    @Override
    public String getQuoteId(String userId, int supId, String goodsId) throws ServiceException {
        return cartMapper.queryQuoteId(userId, supId, goodsId);
    }
}
