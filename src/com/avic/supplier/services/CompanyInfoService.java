package com.avic.supplier.services;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.avic.supplier.models.CompanyInfo;
import com.avic.supplier.models.SupArea;


public interface CompanyInfoService {

    public CompanyInfo queryCompanyInfoById(String companyId);

    public CompanyInfo queryCompanyInfoByCode(String companyCode);
}
