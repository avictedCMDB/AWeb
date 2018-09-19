package com.avic.market.services;

import com.avic.market.models.CompanyInfo;
import com.avic.market.models.SupInfo;
import com.avic.market.models.SupUsers;
import com.avic.market.models.Users;

public interface RegisterService {
	
	public Integer checkExCompanyInfo(CompanyInfo companyInfo);
	public Integer checkExSup(SupUsers supUsers);
	public Integer checkExUser(Users user);
	public Integer checkIphone(CompanyInfo companyInfo);
	public String queryRegisterIndex();
	public String querySupIndex();
	
	public void insertCompanyInfo(CompanyInfo companyInfo);
	public void insertSupUser(SupUsers supUsers);
	public void insertSupInfo(SupInfo supInfo);
	public void insertUsers(Users users);
	
	public void updateSupUserPassword(SupUsers supUsers);
	public void updateUserPassword(Users users);
	public void defaultUserRole(String companyIndex,String roleId);
	public String queryRegisterUserIndex();
}
