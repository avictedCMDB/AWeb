package com.avic.management.mappers;

import org.springframework.stereotype.Repository;

import com.avic.management.models.Cart;
import com.avic.management.models.VatSpecial;

@Repository
public interface CartMapper {
	
	/**
	 * 添加购物车
	 * @return 
	 */
	public void addCart(Cart cart);
	/**
	 * 查询购物车数量
	 * @return 
	 */
	public int queryCatCount(Cart cart);
	/**
	 * 修改购物车数量
	 * @return 
	 */
	public void updateCart(Cart cart);
}
