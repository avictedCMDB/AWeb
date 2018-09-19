package com.avic.market.cpi;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.client.methods.RequestBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import com.avic.market.cpi.exceptions.ServiceExecutionFailedException;
import com.avic.market.cpi.exceptions.TokenInvalidException;
import com.avic.market.models.AfsApplyCreate;
import com.avic.market.models.AsCustomerDto;
import com.avic.market.models.AsDetailDto;
import com.avic.market.models.AsPickwareDto;
import com.avic.market.models.AsReturnwareDto;
import com.avic.market.models.Goods;
import com.avic.market.models.GoodsImage;
import com.avic.market.models.GoodsMessage;
import com.avic.market.models.Order;
import com.avic.market.models.OrderSnapshot;
import com.avic.market.models.Price;
import com.avic.market.models.SupArea;
import com.avic.market.models.SupCategory;
import com.avic.market.models.Supplier;

public abstract class ServiceAdapter {
    public static enum SYNC_TYPE {
        SYNC_FULL,
        SYNC_INCR
    };
    protected Supplier supplier;

    public void invalidToken() {
        supplier.setAccessToken(null);
        supplier.setAccessExpire(null);
    }

    public boolean isTokenValid() {
        if (supplier.getAccessToken() == null) {
            return false;
        }
        return supplier.getAccessExpire().after(new Date());
    }
    
    public abstract SYNC_TYPE syncType();

    public abstract void fetchToken() throws ServiceExecutionFailedException;

    public abstract void refreshToken() throws ServiceExecutionFailedException;
    
    public abstract List<SupCategory> fetchCategory() throws ServiceExecutionFailedException, TokenInvalidException;

    public abstract List<SupArea> fetchProvince() throws ServiceExecutionFailedException, TokenInvalidException;
    public abstract List<SupArea> fetchCity(int prov) throws ServiceExecutionFailedException, TokenInvalidException;
    public abstract List<SupArea> fetchCountry(int city) throws ServiceExecutionFailedException, TokenInvalidException;
    public abstract List<SupArea> fetchTown(int town) throws ServiceExecutionFailedException, TokenInvalidException;
    
    public abstract List<String> fetchSku(int cat) throws ServiceExecutionFailedException, TokenInvalidException;
    public abstract Goods fetchGoods(String sku, int cat) throws ServiceExecutionFailedException, TokenInvalidException;
    public abstract Map<String, Price> fetchPrice(List<String> skus) throws ServiceExecutionFailedException, TokenInvalidException;
    
    public abstract List<GoodsImage> fetchGoodsImage(List<String> skus) throws ServiceExecutionFailedException, TokenInvalidException;
    
    public abstract Map<String, Integer> fetchStock(List<String> skus, List<Integer> nums, List<String> area) throws ServiceExecutionFailedException, TokenInvalidException;

    public abstract Map<String, Integer> fetchStatus(List<String> skus) throws ServiceExecutionFailedException, TokenInvalidException;
    
    public abstract String orderSubmit(Order order) throws ServiceExecutionFailedException, TokenInvalidException;
    public abstract void orderConfirm(String orderId, String supOrderId) throws ServiceExecutionFailedException, TokenInvalidException;
    public abstract void orderCancel(String orderId, String supOrderId) throws ServiceExecutionFailedException, TokenInvalidException;
    public abstract Map<String, Object>  trackInfo(String orderId, String supOrderId) throws ServiceExecutionFailedException, TokenInvalidException;
	public abstract Map<String, Object> selectOrder(String supOrderId) throws ServiceExecutionFailedException, TokenInvalidException;
    
	//退换货申请
	public abstract Map<String, Object> afterSaleAfsApplyCreate(Map afsApplyCreate) throws ServiceExecutionFailedException, TokenInvalidException;
	
	//订单号分页查询服务单概要信息
	public abstract Map<String, Object> serviceListPage(String jdOrderId,int pageIndex,int pageSize) throws ServiceExecutionFailedException, TokenInvalidException;
	
	//取消服务单/客户放弃
	public abstract Map<String, Object> auditCancel(Map auditCancel) throws ServiceExecutionFailedException, TokenInvalidException;
	
	public abstract List<GoodsMessage> getMessage() throws ServiceExecutionFailedException, TokenInvalidException;
	public abstract void delMessage(String msg) throws ServiceExecutionFailedException, TokenInvalidException;
	
    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }
    
    protected CloseableHttpClient client;
    protected List<Header> httpHeaders;
    
    public void init() {
        httpHeaders = new ArrayList<Header>();
        client = HttpClients.custom().build();
    }

    protected HttpUriRequest buildRequest(String api, HttpEntity entity) {
        RequestBuilder builder = RequestBuilder.post();
        
        for (Header i : httpHeaders) {
            builder.addHeader(i);
        }

        if (api.startsWith("http")) {
            builder.setUri(api);
        } else {
            builder.setUri(supplier.getApiUrl() + api);
        }

        builder.setEntity(entity);

        return builder.build();
    }
}
