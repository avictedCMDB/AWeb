package com.avic.passport.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.passport.models.User;

@Repository
public interface UserMapper {
    public User queryUserByName(@Param("userName") String userName);
    public List<String> queryAuthorityById(@Param("userId") String userId);
    public User queryCompanyByName(@Param("userName") String userName);
}
