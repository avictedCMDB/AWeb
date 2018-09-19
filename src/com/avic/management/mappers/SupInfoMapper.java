package com.avic.management.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.management.models.SupInfo;

@Repository
public interface SupInfoMapper {
    /**
     * ��ѯ��Ӧ����Ϣ
     * 
     * @return
     */
    public List<SupInfo> querySupInfos();

    /**
     * ��ѯ��Ӧ����Ϣ
     * 
     * @return
     */
    public List<SupInfo> querySupInfosBySupType(SupInfo supInfo);

    /**
     * ��ѯ��Ӧ�̵绰
     * 
     * @return
     */
    public List<SupInfo> querySupInfosTelBySupID(SupInfo supInfo);

    /**
     * ��ѯ���۹�Ӧ��
     * 
     * @param supInfo
     * @return
     */
    public int queryBidSupInfoCount(@Param("compId") String compId, @Param("supCode") String supCode, @Param("supName") String supName,
            @Param("contactPerson") String contactPerson, @Param("contactNum") String contactNum);
    public List<SupInfo> queryBidSupInfoList(@Param("compId") String compId, @Param("supCode") String supCode, @Param("supName") String supName,
            @Param("contactPerson") String contactPerson, @Param("contactNum") String contactNum, @Param("start") int start,
            @Param("end") int end);
    public SupInfo querySupInfoByCode(@Param("supCode") String supCode);
    
    public List<SupInfo> querySupInfosTelBySupCode(@Param("codes") List<String> codes);
}