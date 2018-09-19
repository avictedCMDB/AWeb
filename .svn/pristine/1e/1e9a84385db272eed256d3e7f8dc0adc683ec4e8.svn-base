package com.avic.market.services;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.avic.common.exceptions.ServiceException;
import com.avic.market.models.MarketCategory;
import com.avic.market.models.SysCategory;
import com.avic.market.models.WebsiteNotice;

public interface WebsiteNoticeService {
    public List<WebsiteNotice> queryWebsiteNoticeList(String type, int page, int size);
    public int queryWebsiteNoticeCount(String type);
    public WebsiteNotice queryWebsiteNoticeDetail(String id);
    public void updateBrowseCount(String id);
}
