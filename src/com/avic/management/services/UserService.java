package com.avic.management.services;

import com.avic.passport.models.User;


public interface UserService {
	/**
	 *�޸�����
	 * @return 
	 */
	public void changePassword(User user);
	/**
	 * �����û��������ѯ�û�
	 * @return 
	 */
	public int selectUserByPassword(User user);
	
	public com.avic.management.models.User queryUserById(String userId);
}