package com.avic.supervise.services.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.common.exceptions.ServiceException;
import com.avic.common.utils.MD5;
import com.avic.supervise.mappers.UserMapper;
import com.avic.supervise.models.CompanyInfo;
import com.avic.supervise.models.Menu;
import com.avic.supervise.models.Role;
import com.avic.supervise.models.User;
import com.avic.supervise.services.UserService;

@Service
public class UserServiceImpl implements UserService {
    protected static final Log logger = LogFactory.getLog(UserServiceImpl.class);
    
    @Autowired
    UserMapper userMapper;

    @Override
    public User login(String username, String password) throws ServiceException {
        logger.info("用户登录Service-username["+username+"]");
        User user = userMapper.queryUserByName(username);   
        if (user == null) {
        	user = new User();
            user.setErrorMsg("管理平台无此账户，请确认账号是否正确。");
        	return user;
        }
        if(!user.getPassword().equalsIgnoreCase(MD5.getMessageDigest(password.getBytes()))){
        	user.setErrorMsg("密码错误。");
        	return user;
        }
        List<User> users = userMapper.getUsersList(user);
        // 获取用户角色
		for (int i = 0; i < users.size(); i++) {
			List<User> roleUserList= userMapper.queryUserRole(users.get(i).getUserName());
			String roleId = "";
			for (int j = 0; j < roleUserList.size(); j++) {
				roleId = roleId + roleUserList.get(j).getAuthority()+",";
			}
			if (roleUserList.size()!= 0 ) {
				roleId = roleId.substring(0,roleId.length() - 1);
			}
			user.setRoleId(roleId);
		}
        return user;
    }

    @Override
    public List<User> getCompanyList() throws ServiceException {
        return userMapper.queryCompanyList();
    }
    
    @Override
    public List<Menu> getUserMenu(String user) throws ServiceException {
        return userMapper.queryUserMenu(user);
    }

	@Override
	public List<User> getUsersList(User user) throws ServiceException {
		List<User> users = userMapper.getUsersList(user);
		// 获取用户角色
		for (int i = 0; i < users.size(); i++) {
			List<User> roleUserList= userMapper.queryUserRole(users.get(i).getUserName());
			String roleName = "";
			for (int j = 0; j < roleUserList.size(); j++) {
				roleName = roleName + roleUserList.get(j).getRoleName()+",";
			}
			if (roleUserList.size()!= 0 ) {
				roleName = roleName.substring(0,roleName.length() - 1);
			}
			users.get(i).setRoleName(roleName);
		}
		return users;
	}

	@Override
	public Integer getUsersCount(User user) throws ServiceException {
		return userMapper.getUsersCount(user);
	}

	@Override
	public String doUserExchange(User user) throws ServiceException {
		String type = user.getType();
		// 1为新增 2为修改
		if ("1".equals(type)) {
			//判断 用户名是否存在
			User userCheck = new User();
			userCheck.setUserName(user.getUserName());
			userCheck.setSearchType("1");
			List<User> checkList = userMapper.getUsersList(userCheck);
			String password = user.getPassword();
			if (checkList.size() != 0) {
				return "1";
			}
			user.setPassword(MD5.getMessageDigest(password.getBytes()));
			// userid
			SimpleDateFormat sdf =   new SimpleDateFormat( "yyyyMMddHHmmss");
			String userId = sdf.format(new Date());
			Random random = new Random();
			userId= userId + String.valueOf(random.nextInt(899999)+100000);
			user.setUserId(userId);
			userMapper.inserUser(user);
		}else {
			//判断密码
			String password = user.getPassword();
			if ("******".equals(password)) {
				user.setPassword(user.getPasswordOld());
			}else {
				user.setPassword(MD5.getMessageDigest(password.getBytes()));
			}
			userMapper.updateUser(user);
		}
		return "0";
	}

	@Override
	public String deleteUser(String userId) {
		userMapper.deleteUserRole(userId);
		userMapper.deleteUser(userId);
		return "删除成功！";
	}

	@Override
	public List<Role> queryRole(String roleId) {
		return userMapper.queryRole(roleId);
	}
	@Override
	public List<Role> queryAllRole() {
		return userMapper.queryAllRole();
	}
	@Override
	public List<User> queryUserRole(String userName) {
		return userMapper.queryUserRole(userName);
	}

	@Override
	public void deployUserRole(String userName, String roleIds) {
		//删除用户所有权限
		userMapper.deleteUserRole(userName);
		//设置新的权限
		String[] roleId = roleIds.split(",");
		for (int i = 0; i < roleId.length; i++) {
			if (!"".equals(roleId[i]) && roleId[i] != null) {
				userMapper.deployUserRole(userName, roleId[i]);
			}
		}
	}

	@Override
	public List<CompanyInfo> queryCompany(String parentRoleId) {
		return userMapper.queryCompany(parentRoleId);
	}

	@Override
	public Integer queryUserByCompanyID(String companyID) {
		return userMapper.queryUserByCompanyID(companyID);
	}

	@Override
	public void updateUserCompany(User user) {
		userMapper.updateUserCompany(user);
	}
	@Override
	
	public void defaultUserRole(String companyID, String roleIds) {
		//删除用户所有权限
		userMapper.deleteDefaultUserRole(companyID);
		//设置默认权限
		String[] roleId = roleIds.split(",");
		for (int i = 0; i < roleId.length; i++) {
			if (!"".equals(roleId[i]) && roleId[i] != null) {
				userMapper.defaultUserRole(companyID, roleId[i]);
			}
		}
	}
}
