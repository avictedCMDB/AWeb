package com.avic.supervise.mappers.bid;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.management.models.BidContractFile;

@Repository
public interface BidContractFileMapper {
    public List<BidContractFile> queryContractFileList(@Param("projId") String projId, @Param("supCode") String supCode);
    public BidContractFile queryContractFileById(@Param("projId") String projId, @Param("supCode") String supCode, @Param("fileId") String fileId);
}
