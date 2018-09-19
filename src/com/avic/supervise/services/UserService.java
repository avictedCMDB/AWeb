package com.avic.supervise.services;

import java.util.List;

import com.avic.common.exceptions.ServiceException;
import com.avic.supervise.models.CompanyInfo;
import com.avic.supervise.models.Menu;
import com.avic.supervise.models.Role;
import com.avic.supervise.models.User;

public interface UserService {
    public User login(String username, String password) throws ServiceException;
    public List<User> getCompanyList() throws ServiceException;
    public List<Menu> getUserMenu(String user) throws ServiceException;
    
    public List<User> getUsersList(User user) throws ServiceException;
    
    public Integer getUsersCount(User user) throws ServiceException;
    
    public String doUserExchange(User user) throws ServiceException;
    
    public String deleteUser(String userId);
    
    public List<Role> queryRole(String roleId);
    
    public List<CompanyInfo> queryCompany(String parentRoleId);
    
    public List<User> queryUserRole(String userName); 
    
    public void deployUserRole(String userName,String roleIds); 
    
    public Integer queryUserByCompanyID(String companyID) ;
    
    public void updateUserCompany(User user);
    
    public List<Role> queryAllRole();
    
    public void defaultUserRole(String companyID,String roleIds); 
}