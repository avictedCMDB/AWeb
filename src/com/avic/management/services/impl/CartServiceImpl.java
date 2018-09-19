package com.avic.management.services.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.CartMapper;
import com.avic.management.models.Cart;
import com.avic.management.models.VatSpecial;
import com.avic.management.services.CartService;

@Service
public class CartServiceImpl implements CartService {
    protected static final Log logger = LogFactory.getLog(CartServiceImpl.class);

    @Autowired
    CartMapper cartMapper;

	@Override
	public void addCart(Cart cart) {
		cartMapper.addCart(cart);
	}

	@Override
	public int queryCatCount(Cart cart) {
		return cartMapper.queryCatCount(cart);
	}

	@Override
	public void updateCart(Cart cart) {
		cartMapper.updateCart(cart);
	}

    
}
