package com.avic.market.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.market.models.OffStandardRequire;

@Repository
public interface OffStandardRequireMapper {
    public List<OffStandardRequire> queryLastestRequires(@Param("num") int num);
}
