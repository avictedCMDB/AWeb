package com.avic.management.mappers;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.management.models.SysCompanyHis;

@Repository
public interface SysCompanyHisMapper {
    public SysCompanyHis queryCompanyHisBySupId(@Param("supId") String supId);
}
