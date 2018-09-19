package com.avic.supplier.mappers;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.supplier.models.CompanyInfo;


@Repository
public interface CompanyInfoMapper {

	public CompanyInfo queryCompanyInfoById(@Param("companyId") String companyId);

	public CompanyInfo queryCompanyInfoByCode(@Param("companyCode") String companyCode);
}
