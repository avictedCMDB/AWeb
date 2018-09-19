package com.avic.supervise.services;

import java.util.List;

import com.avic.supervise.models.CodeList;
import com.avic.supervise.models.Menu;
import com.avic.supervise.models.Node;
import com.avic.supervise.models.Role;

public interface RoleService {
	
	public List<Role> queryRoleList(Role role);

	
	public Integer queryRoleListCount(Role role);
	
	public void roleExchange(Role role,String type);
	
	public String roleDelete(String roleId);
	
	public List<Node> queryMenu(String roleId,String systemFlag,String roleIds);
	
	public void deployUserRole(String roleId,String menuIds);
	
	public String querySystemFlag(String parentRole);
	
	public List<CodeList> querySystemFlagCodeList(String roles);
}
