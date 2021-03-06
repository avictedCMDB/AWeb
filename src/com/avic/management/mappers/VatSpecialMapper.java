package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.VatSpecial;

@Repository
public interface VatSpecialMapper {
	/**
	 * 查询增票信息
	 * @return 
	 */
	public VatSpecial queryVatSpecial(VatSpecial vatSpecial);
	
	/**
	 * 添加增票信息
	 * @return 
	 */
	public void addVat(VatSpecial vatSpecial);
	/**
	 * 修改增票信息
	 * @return 
	 */
	public void updateVat(VatSpecial vatSpecial);
	/**
	 * 删除增票信息
	 * @return 
	 */
	public void deleteVat(VatSpecial vatSpecial);
	/**
	 * 获得业务图片id
	 * @return 
	 */
	public String queryVatIndex();
	
	/**
	 * 获得赠票审核状态
	 * @return 
	 */
	public String queryVatStatus(VatSpecial vatSpecial);
	/**
	 * 修改赠票状态
	 * @return 
	 */
	public void updateVatAuditStatus(VatSpecial vatSpecial);
}
