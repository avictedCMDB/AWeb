package com.avic.supervise.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.supervise.models.SupArea;
import com.avic.supervise.models.SupInfo;

@Repository
public interface SupMapper {
    public List<SupInfo> querySupInfoList();
    public List<SupArea> querySupArea(@Param("supId") int supId, @Param("parent") int parent);
}
