package com.avic.supervise.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.supervise.models.Help;

@Repository
public interface HelpMapper {
	/**
	 * 查询帮助中心列表
	 * @return 
	 */
	public List<Help> queryHelps(Help help);
	/**
	 * 根据帮助信息id查询帮助信息
	 * @return 
	 */
	public Help queryHelpById(Help help);
	/**
	 * 添加帮助中心信息
	 * @return 
	 */
	public void addHelp(Help help);
	/**
	 * 修改帮助中心信息
	 * @return 
	 */
	public void updateHelp(Help help);
	/**
	 * 启用或停用帮助中心
	 * @return 
	 */
	public void updateHelpStatus(Help help);
	
	/**
	 * 删除帮助中心
	 * @return 
	 */
	public void deleteHelp(Help help);
	
	/**
	 * 查询帮助中心数量
	 * @return 
	 */
	public int queryHelpCount(Help help);
	
	public int queryFileEx(Help help);
}
