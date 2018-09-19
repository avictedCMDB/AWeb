package com.avic.supplier.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.supplier.models.SupCategory;


@Repository
public interface CategoryMapper {
    public List<SupCategory> queryCatList(@Param("supId") int supId);
    public void insertCategory(SupCategory cat);
}
