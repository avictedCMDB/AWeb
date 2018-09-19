package com.avic.supervise.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.supervise.models.CodeList;
import com.avic.supervise.models.Menu;
import com.avic.supervise.models.Role;

@Repository
public interface RoleMapper {
	
public List<Role> queryRoleList(Role role);

	
	public Integer queryRoleListCount(Role role);
	
	public void inserRole(Role role);
	
	public void updateRole(Role role);
	
	public void deleteRole(String roleId);
	
	public Integer queryRoleUserCount(String roleId);
	
	public List<Menu> queryMenu(String systemFlag,String roleIds);
	
	public List<Menu> queryRoleMenu(String roleId);
	
	public void deleteRoleMenu(String roleId);
	
	public void insertRoleMenu(String id,String roleId,String menuId);
	
	public String querySystemFlag(@Param(value="parentRoleId")String parentRoleId);
	
	public List<CodeList> querySystemFlagCodeList(@Param(value="roles") String roles);

}