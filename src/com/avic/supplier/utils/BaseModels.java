package com.avic.supplier.utils;

public class BaseModels {
	private static final long serialVersionUID = 1L;

	private int page = 1;
	private int pageSize = 10;
	@SuppressWarnings("unused")
	private int pageFrom; // ¿ªÊ¼Êý
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
}
