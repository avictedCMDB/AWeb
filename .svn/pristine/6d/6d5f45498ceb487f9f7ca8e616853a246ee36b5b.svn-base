package com.avic.market.mappers;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.market.models.User;

@Repository
public interface UserMapper {
    public User queryUserById(@Param("userId") String userId);
    public User queryUserAndCompanyById(@Param("userId") String userId);
}
