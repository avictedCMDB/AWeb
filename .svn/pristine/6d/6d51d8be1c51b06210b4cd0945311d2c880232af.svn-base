package com.avic.market.services.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.market.mappers.RegisterMapper;
import com.avic.market.models.CompanyInfo;
import com.avic.market.models.SupInfo;
import com.avic.market.models.SupUsers;
import com.avic.market.models.Users;
import com.avic.market.services.RegisterService;

@Service
public class RegisterServiceImpl implements RegisterService{
	
	@Autowired
	RegisterMapper registerMapper;

	@Override
	public Integer checkExCompanyInfo(CompanyInfo companyInfo) {
		// TODO Auto-generated method stub
		return registerMapper.checkExCompanyInfo(companyInfo);
	}

	@Override
	public Integer checkExSup(SupUsers supUsers) {
		// TODO Auto-generated method stub
		return registerMapper.checkExSup(supUsers);
	}

	@Override
	public Integer checkExUser(Users user) {
		// TODO Auto-generated method stub
		return registerMapper.checkExUser(user);
	}

	@Override
	public String queryRegisterIndex() {
		// TODO Auto-generated method stub
		return registerMapper.queryRegisterIndex();
	}

	@Override
	public void insertCompanyInfo(CompanyInfo companyInfo) {
		// TODO Auto-generated method stub
		registerMapper.insertCompanyInfo(companyInfo);
	}

	@Override
	public void insertSupUser(SupUsers supUsers) {
		// TODO Auto-generated method stub
		registerMapper.insertSupUser(supUsers);
		
	}

	@Override
	public void insertSupInfo(SupInfo supInfo) {
		// TODO Auto-generated method stub
		registerMapper.insertSupInfo(supInfo);
	}

	@Override
	public void insertUsers(Users users) {
		// TODO Auto-generated method stub
		registerMapper.insertUsers(users);
	}

	@Override
	public Integer checkIphone(CompanyInfo companyInfo) {
		// TODO Auto-generated method stub
		return registerMapper.checkIphone(companyInfo);
	}

	@Override
	public String querySupIndex() {
		// TODO Auto-generated method stub
		return registerMapper.querySupIndex();
	}

	@Override
	public void updateSupUserPassword(SupUsers supUsers) {
		// TODO Auto-generated method stub
		registerMapper.updateSupUserPassword(supUsers);
		
	}

	@Override
	public void updateUserPassword(Users users) {
		// TODO Auto-generated method stub
		registerMapper.updateUserPassword(users);
	}
	public void defaultUserRole(String companyIndex, String roleId) {
		//采购企业注册设置默认权限
		registerMapper.defaultUserRole(companyIndex, roleId);			
	}
	@Override
	public String queryRegisterUserIndex() {
		// TODO Auto-generated method stub
		return registerMapper.queryRegisterUserIndex();
	}
}
