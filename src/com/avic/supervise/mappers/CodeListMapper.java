package com.avic.supervise.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.supervise.models.CodeList;

@Repository
public interface CodeListMapper {
    public List<CodeList> queryCodeList(@Param("type") String type);
}
