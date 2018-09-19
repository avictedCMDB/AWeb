package com.avic.supervise.services;

import java.util.List;

import com.avic.supervise.models.WebsiteNotice;

public interface NewsService {
	
	public List<WebsiteNotice> queryWebsiteNotice(WebsiteNotice websiteNotice);

	
	public Integer queryWebsiteNoticeCount(WebsiteNotice websiteNotice);
	
	public void updateIsPublish(WebsiteNotice websiteNotice) ;
	
	public void deleteNews(WebsiteNotice websiteNotice) ;
	
	public void updateNews(WebsiteNotice websiteNotice) ;
	
	public void insertNews(WebsiteNotice websiteNotice) ;
}
