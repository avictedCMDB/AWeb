package com.avic.market.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.market.models.CodeList;

@Repository
public interface CodeListMapper {
    public List<CodeList> queryCodeListByType(@Param("type") String type);
    public CodeList queryCodeListByValue(@Param("type") String type, @Param("val") String val);
}
