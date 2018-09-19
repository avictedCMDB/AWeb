package com.avic.market.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.market.mappers.WebsiteNoticeMapper;
import com.avic.market.models.WebsiteNotice;
import com.avic.market.services.WebsiteNoticeService;

@Service
public class WebsiteNoticeServiceImpl implements WebsiteNoticeService {
    
    @Autowired
    WebsiteNoticeMapper websiteNoticeMapper;

    @Override
    public List<WebsiteNotice> queryWebsiteNoticeList(String type, int page, int size) {
        
        if (page < 1) {
            page = 1;
        }

        int start = (page - 1) * size + 1;
        int end = start + size - 1;
        
        return websiteNoticeMapper.queryWebsiteNoticeList(type, start, end);
    }

    @Override
    public int queryWebsiteNoticeCount(String type) {
        return websiteNoticeMapper.queryWebsiteNoticeCount(type);
    }

    @Override
    public WebsiteNotice queryWebsiteNoticeDetail(String id) {
        return websiteNoticeMapper.queryWebsiteNoticeDetail(id);
    }
    
    @Override
    public void updateBrowseCount(String id) {
        websiteNoticeMapper.updateBrowseCount(id);
    }
}
