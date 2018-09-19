package com.avic.management.mappers;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.management.models.SupUser;

@Repository
public interface SupUserMapper {
    public SupUser querySupUserBySupId(@Param("supId") String supId);
}
