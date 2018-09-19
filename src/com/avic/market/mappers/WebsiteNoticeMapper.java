package com.avic.market.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.market.models.CategoryRelation;
import com.avic.market.models.MarketCategory;
import com.avic.market.models.SupCategory;
import com.avic.market.models.SysCategory;
import com.avic.market.models.WebsiteNotice;

@Repository
public interface WebsiteNoticeMapper {
    public List<WebsiteNotice> queryWebsiteNoticeList(@Param("type") String type, @Param("start") int start, @Param("end") int end);
    public int queryWebsiteNoticeCount(@Param("type") String type);
    public WebsiteNotice queryWebsiteNoticeDetail(@Param("id") String id);
    public void updateBrowseCount(@Param("id") String id);
}
