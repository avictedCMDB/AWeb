package com.avic.management.mappers;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.passport.models.User;


@Repository
public interface UserMapper {
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
	
	public com.avic.management.models.User queryUserById(@Param("userId") String userId);

}