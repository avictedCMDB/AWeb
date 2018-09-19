package com.avic.management.services;

import java.util.List;

import com.avic.management.models.Cart;
import com.avic.management.models.Invoice;
import com.avic.management.models.VatSpecial;

public interface CartService {
	/**
	 * ��ӹ��ﳵ
	 * @return 
	 */
	public void addCart(Cart cart);
	/**
	 * ��ѯ���ﳵ����
	 * @return 
	 */
	public int queryCatCount(Cart cart);
	/**
	 * �޸Ĺ��ﳵ����
	 * @return 
	 */
	public void updateCart(Cart cart);
}
