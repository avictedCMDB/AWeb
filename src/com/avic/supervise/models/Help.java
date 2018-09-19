package com.avic.supervise.models;

import java.io.Serializable;

public class Help implements Serializable{
	private static final long serialVersionUID = 1L;
	private String id;
    private String title;
    private String context;
    private String type;			//���� 0���ɹ��˰��� 1����Ӧ�̰��� 2����������
    private String fileName;
    private String filePath;
    private String status;			//0 ���� 1 ͣ��
    private String createDate;
    private String helpTypeBuyer;	//�ɹ��˰�������
    private String helpTypeSup;		//��Ӧ�̰�������
    private String helpTypeBuyerName;	//�ɹ��˰�������
    private String helpTypeSupName;		//��Ӧ�̰�������
    
    private String searchTitle;
    private String searchContext;
    private String searceType;
    
    private String helpPath;
    
    private int page = 1;
	private int pageSize = 10;
	@SuppressWarnings("unused")
	private int pageFrom ;				//��ʼ��
	@SuppressWarnings("unused")
	private int pageTo;					//������
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
		return (this.page-1)*this.pageSize+1;
	}
	public void setPageFrom(int pageFrom) {
		this.pageFrom = pageFrom;
	}
	public int getPageTo() {
		return this.page*this.pageSize;
	}
	public void setPageTo(int pageTo) {
		this.pageTo = pageTo;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getHelpTypeBuyer() {
		return helpTypeBuyer;
	}
	public void setHelpTypeBuyer(String helpTypeBuyer) {
		this.helpTypeBuyer = helpTypeBuyer;
	}
	public String getHelpTypeSup() {
		return helpTypeSup;
	}
	public void setHelpTypeSup(String helpTypeSup) {
		this.helpTypeSup = helpTypeSup;
	}
	public String getSearchTitle() {
		return searchTitle;
	}
	public void setSearchTitle(String searchTitle) {
		this.searchTitle = searchTitle;
	}
	public String getSearchContext() {
		return searchContext;
	}
	public void setSearchContext(String searchContext) {
		this.searchContext = searchContext;
	}
	public String getSearceType() {
		return searceType;
	}
	public void setSearceType(String searceType) {
		this.searceType = searceType;
	}
	public String getHelpTypeBuyerName() {
		return helpTypeBuyerName;
	}
	public void setHelpTypeBuyerName(String helpTypeBuyerName) {
		this.helpTypeBuyerName = helpTypeBuyerName;
	}
	public String getHelpTypeSupName() {
		return helpTypeSupName;
	}
	public void setHelpTypeSupName(String helpTypeSupName) {
		this.helpTypeSupName = helpTypeSupName;
	}
	public String getHelpPath() {
		return helpPath;
	}
	public void setHelpPath(String helpPath) {
		this.helpPath = helpPath;
	}
    
}