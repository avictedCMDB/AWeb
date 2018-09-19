package com.avic.management.mappers;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.passport.models.User;


@Repository
public interface UserMapper {
	/**
	 *修改密码
	 * @return 
	 */
	public void changePassword(User user);
	
	/**
	 * 根据用户名密码查询用户
	 * @return 
	 */
	public int selectUserByPassword(User user);
	
	public com.avic.management.models.User queryUserById(@Param("userId") String userId);

}
