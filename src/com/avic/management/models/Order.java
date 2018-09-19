package com.avic.management.models;

import java.io.Serializable;
import java.util.List;

public class Order implements Serializable{
	private static final long serialVersionUID = 1L;
	private String order_id; // 订单编号

	private String sup_id; // 合作平台编号

	private String order_time; // 下单时间

	private String order_status; // 订单状态

	private String order_amount; // 订单金额

	private String sup_name; // 合作平台名称

	private String goods_url; // 商品url

	private String sup_goods_id; // 商品编号

	private String image_path; // 商品图片

	private double goods_price; // 商品价格

	private String buy_num; // 购买数量

	private double totalprice; // 单件商品的购买总价

	private String refund_status; // 退换货状态
	
	private String goods_name; // 商品名称

	private String goods_model; // 规格型号

	private String order_status_name; // 订单状态名称

	private String rowspan; // 列合并

	private String user_id; // 用户id

	private String order_status_type; // 页面订单状态查询条件的回显标志，1：select选中；2：li选中。

    private String sup_order_id; // 用户id
    
    private String sup_type; // 供应商类别（供应商类型：0电商，1传统）

    private String order_amount_init; // 订单初始金额
    
    private String companyID;
    
    private String addrProv;
    
    private String addrCity;
    
    private String addrDist;
    
    private String addrTown;
    
    private String addrDetail;
    
    private String addrName;
    
    private String addrZip;
    
    private String addrPhone;
    
    private String addrTel;
    
    private String addrEmail;
    
    private String supGoodsID;
    
    private String startTime;
    
    private String endTime;
    
    private String addrAll;
    
    private String supType;
	
    private String compareId;
    
    private String contractCode;
    
    
	private List<OrderSnapshot> snapshots;
	
	public String getOrder_amount_init() {
        return order_amount_init;
    }
	public void setOrder_amount_init(String order_amount_init) {
        this.order_amount_init = order_amount_init;
    }
	
	public List<OrderSnapshot> getSnapshots() {
        return snapshots;
    }
	public void setSnapshots(List<OrderSnapshot> snapshots) {
        this.snapshots = snapshots;
    }

	private String statusName; // 订单状态名称

	private String statusValue; // 订单状态值
	
	private	String	invoice_status	;	//	发票状态
	
	private	String	eNum	;	//	换货次数
	
	private	String	rNum	;	//	退货次数

	private	String	express_name	;	//	快递公司名称---监管平台发票管理
	
	private	String	express_code	;	//	快递单号---监管平台发票管理
	
	private	String	sup_express_name	;	//	快递公司名称---传统供应商发货信息
	
	private	String	sup_express_code	;	//	快递单号---传统供应商发货信息
	
	
	private int page = 1;
	private int pageSize = 10;
	@SuppressWarnings("unused")
	private int pageFrom ;				//开始数
	@SuppressWarnings("unused")
	private int pageTo;					//结束数
	private	String	total	;	//	订单数
	
	private	String	isShowThhBtn	;	//	是否显示退换货按钮

	public String getGoods_model() {
		return goods_model;
	}
	public void setGoods_model(String goods_model) {
		this.goods_model = goods_model;
	}
	public String getIsShowThhBtn() {
		return isShowThhBtn;
	}
	public void setIsShowThhBtn(String isShowThhBtn) {
		this.isShowThhBtn = isShowThhBtn;
	}
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
	
	public String getSup_order_id() {
        return sup_order_id;
    }
	public void setSup_order_id(String sup_order_id) {
        this.sup_order_id = sup_order_id;
    }
	public String getBuy_num() {
		return buy_num;
	}

	public void setBuy_num(String buy_num) {
		this.buy_num = buy_num;
	}

	public String getGoods_name() {
		return goods_name;
	}

	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}

	public String getGoods_url() {
		return goods_url;
	}

	public void setGoods_url(String goods_url) {
		this.goods_url = goods_url;
	}

	public String getImage_path() {
		return image_path;
	}

	public void setImage_path(String image_path) {
		this.image_path = image_path;
	}

	public String getOrder_amount() {
		return order_amount;
	}

	public void setOrder_amount(String order_amount) {
		this.order_amount = order_amount;
	}

	public String getOrder_id() {
		return order_id;
	}

	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}

	public String getOrder_status() {
		return order_status;
	}

	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}

	public String getOrder_status_name() {
		return order_status_name;
	}

	public void setOrder_status_name(String order_status_name) {
		this.order_status_name = order_status_name;
	}

	public String getOrder_status_type() {
		return order_status_type;
	}

	public void setOrder_status_type(String order_status_type) {
		this.order_status_type = order_status_type;
	}

	public String getOrder_time() {
		return order_time;
	}

	public void setOrder_time(String order_time) {
		this.order_time = order_time;
	}

	public String getRefund_status() {
		return refund_status;
	}

	public void setRefund_status(String refund_status) {
		this.refund_status = refund_status;
	}

	public String getRowspan() {
		return rowspan;
	}

	public void setRowspan(String rowspan) {
		this.rowspan = rowspan;
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

	public String getStatusValue() {
		return statusValue;
	}

	public void setStatusValue(String statusValue) {
		this.statusValue = statusValue;
	}

	public String getSup_goods_id() {
		return sup_goods_id;
	}

	public void setSup_goods_id(String sup_goods_id) {
		this.sup_goods_id = sup_goods_id;
	}

	public String getSup_id() {
		return sup_id;
	}

	public void setSup_id(String sup_id) {
		this.sup_id = sup_id;
	}

	public String getSup_name() {
		return sup_name;
	}

	public void setSup_name(String sup_name) {
		this.sup_name = sup_name;
	}

	public double getGoods_price() {
		return goods_price;
	}
	public void setGoods_price(double goods_price) {
		this.goods_price = goods_price;
	}
	public double getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(double totalprice) {
		this.totalprice = totalprice;
	}
	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
	public String getInvoice_status() {
		return invoice_status;
	}
	
	public void setInvoice_status(String invoice_status) {
		this.invoice_status = invoice_status;
	}
	public String getENum() {
		return eNum;
	}
	public void setENum(String num) {
		eNum = num;
	}
	public String getRNum() {
		return rNum;
	}
	public void setRNum(String num) {
		rNum = num;
	}
	public String getExpress_code() {
		return express_code;
	}
	public void setExpress_code(String express_code) {
		this.express_code = express_code;
	}
	public String getExpress_name() {
		return express_name;
	}
	public void setExpress_name(String express_name) {
		this.express_name = express_name;
	}
	public String getTotal() {
		return total;
	}
	public void setTotal(String total) {
		this.total = total;
	}
	public String getSup_type() {
		return sup_type;
	}
	public void setSup_type(String sup_type) {
		this.sup_type = sup_type;
	}
	public String getSup_express_code() {
		return sup_express_code;
	}
	public void setSup_express_code(String sup_express_code) {
		this.sup_express_code = sup_express_code;
	}
	public String getSup_express_name() {
		return sup_express_name;
	}
	public void setSup_express_name(String sup_express_name) {
		this.sup_express_name = sup_express_name;
	}
	public String getCompanyID() {
		return companyID;
	}
	public void setCompanyID(String companyID) {
		this.companyID = companyID;
	}
	public String getAddrProv() {
		return addrProv;
	}
	public void setAddrProv(String addrProv) {
		this.addrProv = addrProv;
	}
	public String getAddrCity() {
		return addrCity;
	}
	public void setAddrCity(String addrCity) {
		this.addrCity = addrCity;
	}
	public String getAddrDist() {
		return addrDist;
	}
	public void setAddrDist(String addrDist) {
		this.addrDist = addrDist;
	}
	public String getAddrTown() {
		return addrTown;
	}
	public void setAddrTown(String addrTown) {
		this.addrTown = addrTown;
	}
	public String getAddrDetail() {
		return addrDetail;
	}
	public void setAddrDetail(String addrDetail) {
		this.addrDetail = addrDetail;
	}
	public String getAddrZip() {
		return addrZip;
	}
	public void setAddrZip(String addrZip) {
		this.addrZip = addrZip;
	}
	public String getAddrPhone() {
		return addrPhone;
	}
	public void setAddrPhone(String addrPhone) {
		this.addrPhone = addrPhone;
	}
	public String getAddrTel() {
		return addrTel;
	}
	public void setAddrTel(String addrTel) {
		this.addrTel = addrTel;
	}
	public String getSupGoodsID() {
		return supGoodsID;
	}
	public void setSupGoodsID(String supGoodsID) {
		this.supGoodsID = supGoodsID;
	}
	public String geteNum() {
		return eNum;
	}
	public void seteNum(String eNum) {
		this.eNum = eNum;
	}
	public String getrNum() {
		return rNum;
	}
	public void setrNum(String rNum) {
		this.rNum = rNum;
	}
	public String getAddrName() {
		return addrName;
	}
	public void setAddrName(String addrName) {
		this.addrName = addrName;
	}
	public String getAddrEmail() {
		return addrEmail;
	}
	public void setAddrEmail(String addrEmail) {
		this.addrEmail = addrEmail;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getAddrAll() {
		return addrAll;
	}
	public void setAddrAll(String addrAll) {
		this.addrAll = addrAll;
	}
	public String getSupType() {
		return supType;
	}
	public void setSupType(String supType) {
		this.supType = supType;
	}
	public String getCompareId() {
		return compareId;
	}
	public void setCompareId(String compareId) {
		this.compareId = compareId;
	}
	public String getContractCode() {
		return contractCode;
	}
	public void setContractCode(String contractCode) {
		this.contractCode = contractCode;
	}
	
}