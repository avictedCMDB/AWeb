package com.avic.supervise.models;

public class WebsiteNotice {
	private String id;
	private String noticeSubject;
	private String noticeType;
	private String beginDate;
	private String endDate;
	private byte[] content;
	private String contentString;
	private String createDate;
	private String createUser;
	private String browseCount;
	private String isPublish;
	private String publishDate;
	private String publishSatrDate;
	private String publishEndDate;
	private String isTop;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNoticeSubject() {
		return noticeSubject;
	}
	public void setNoticeSubject(String noticeSubject) {
		this.noticeSubject = noticeSubject;
	}
	public String getNoticeType() {
		return noticeType;
	}
	public void setNoticeType(String noticeType) {
		this.noticeType = noticeType;
	}
	public String getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	
	public byte[] getContent() {
		return content;
	}
	public void setContent(byte[] content) {
		this.content = content;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCreateUser() {
		return createUser;
	}
	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}
	public String getBrowseCount() {
		return browseCount;
	}
	public void setBrowseCount(String browseCount) {
		this.browseCount = browseCount;
	}
	public String getIsPublish() {
		return isPublish;
	}
	public void setIsPublish(String isPublish) {
		this.isPublish = isPublish;
	}
	public String getPublishDate() {
		return publishDate;
	}
	public void setPublishDate(String publishDate) {
		this.publishDate = publishDate;
	}
	
	public String getContentString() {
		if (content == null || content.length == 0) {
			return "";
		}
		contentString = new String(content);
		return contentString;
	}

	private int page = 1;
	private int pageSize = 10;
	@SuppressWarnings("unused")
	private int pageFrom; // ��ʼ��
	@SuppressWarnings("unused")
	private int pageTo;
	
	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPageFrom() {
		return (this.page - 1) * this.pageSize + 1;
	}

	public void setPageFrom(int pageFrom) {
		this.pageFrom = pageFrom;
	}

	public int getPageTo() {
		return this.page * this.pageSize;
	}

	public void setPageTo(int pageTo) {
		this.pageTo = pageTo;
	}
	public String getPublishSatrDate() {
		return publishSatrDate;
	}
	public void setPublishSatrDate(String publishSatrDate) {
		this.publishSatrDate = publishSatrDate;
	}
	public String getPublishEndDate() {
		return publishEndDate;
	}
	public void setPublishEndDate(String publishEndDate) {
		this.publishEndDate = publishEndDate;
	}
	public String getIsTop() {
		return isTop;
	}
	public void setIsTop(String isTop) {
		this.isTop = isTop;
	}
	
}
