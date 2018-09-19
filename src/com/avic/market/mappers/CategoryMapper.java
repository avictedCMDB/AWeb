package com.avic.market.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.market.models.CategoryRelation;
import com.avic.market.models.MarketCategory;
import com.avic.market.models.SupCategory;
import com.avic.market.models.SysCategory;

@Repository
public interface CategoryMapper {
    public List<SysCategory> queryCatList();
    public void deleteAllSupCat(@Param("supId") int supId);
    public void batchInsertSupCat(@Param("list") List<SupCategory> list);
    public List<SysCategory> querySysCatTree();
    public void insertCatBrand();
    public void deleteCatBrand();
    public List<CategoryRelation> queryCategoryRelation();
    public List<MarketCategory> queryMarketCatList();
    public List<MarketCategory> queryMarketCatByParent(@Param("parent") String parent);
}
