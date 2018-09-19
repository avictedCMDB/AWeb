package com.avic.supervise.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supervise.mappers.InvoiceMapper;
import com.avic.supervise.mappers.NewsMapper;
import com.avic.supervise.models.WebsiteNotice;
import com.avic.supervise.services.NewsService;

@Service
public class NewsServieImpl implements NewsService{
	@Autowired
    NewsMapper newsMapper;

	@Override
	public List<WebsiteNotice> queryWebsiteNotice(WebsiteNotice websiteNotice) {
		// TODO Auto-generated method stub
		return newsMapper.queryWebsiteNotice(websiteNotice);
	}

	@Override
	public Integer queryWebsiteNoticeCount(WebsiteNotice websiteNotice) {
		// TODO Auto-generated method stub
		return newsMapper.queryWebsiteNoticeCount(websiteNotice);
	}

	@Override
	public void updateIsPublish(WebsiteNotice websiteNotice) {
		newsMapper.updateIsPublish(websiteNotice);
		
	}

	@Override
	public void deleteNews(WebsiteNotice websiteNotice) {
		newsMapper.deleteNews(websiteNotice);
		
	}

	@Override
	public void updateNews(WebsiteNotice websiteNotice) {
		newsMapper.updateNews(websiteNotice);
		
	}

	@Override
	public void insertNews(WebsiteNotice websiteNotice) {
		newsMapper.insertNews(websiteNotice);
		
	}
}
