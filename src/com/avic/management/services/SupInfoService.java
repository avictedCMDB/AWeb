package com.avic.management.services;

import java.util.List;

import com.avic.management.models.SupInfo;

public interface SupInfoService {
	/**
	 * ��ѯ��Ӧ����Ϣ
	 * @return 
	 */
	public List<SupInfo> querySupInfos();
	/**
	 * ��ѯ��Ӧ����Ϣ
	 * @return 
	 */
	public List<SupInfo> querySupInfosBySupType(SupInfo supInfo);
	/**
	 * ��ѯ��Ӧ�̵绰
	 * @return 
	 */
	public List<SupInfo> querySupInfosTelBySupID(SupInfo supInfo);

    /**
     * ��ѯ���۹�Ӧ��
     * @param supInfo
     * @return
     */
	public int queryBidSupInfoCount(String compId, String supCode, String supName, String contactPerson, String contactNum);
    public List<SupInfo> queryBidSupInfoList(String compId, String supCode, String supName, String contactPerson, String contactNum, int page, int size);
    public SupInfo querySupInfoByCode(String supCode);
    
    public List<SupInfo> querySupInfosTelBySupCode(List<String> codes);
}