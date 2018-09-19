package com.avic.market.cpi.adapters;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.entity.StringEntity;
import org.apache.http.message.BasicHeader;
import org.apache.http.util.EntityUtils;
import org.codehaus.jackson.map.ObjectMapper;

import com.avic.common.utils.ConfigHolder;
import com.avic.common.utils.MD5;
import com.avic.market.cpi.ServiceAdapter;
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

public class ColipuServiceAdapter extends ServiceAdapter {
    protected static final Log logger = LogFactory.getLog(ColipuServiceAdapter.class);

    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public void init() {
        logger.info("��������սӿڳ�ʼ�� ...");
        super.init();
        httpHeaders.add(new BasicHeader("Content-Type", "application/json; charset=utf-8"));
        httpHeaders.add(new BasicHeader("Accept", "application/json"));

    }
    
    @Override
    public SYNC_TYPE syncType() {
        return ServiceAdapter.SYNC_TYPE.SYNC_FULL;
    }

    @Override
    public void fetchToken() throws ServiceExecutionFailedException {
        logger.info("���������-��ȡAccessToken");

        Map<String, String> param = new HashMap<String, String>();
        String ts = df.format(new Date());
        param.put("Timestamp", ts);
        param.put("UserName", supplier.getAuthUser());
        param.put("Password", supplier.getAuthPass());
        param.put("Sign", MD5.getMessageDigest((supplier.getAuthUser() + supplier.getAuthPass() + ts + supplier.getAuthPass()).getBytes()));

        Map<String, Object> result;
        try {
            result = execute("/api/auth2/access_token", param);
            supplier.setAccessToken((String) result.get("access_token"));
            supplier.setAccessExpire(df.parse((String) result.get("expires_at")));
        } catch (Exception e) {
            logger.error("���������-AccessToken��ȡʧ��", e);
            throw new ServiceExecutionFailedException(e);
        }

    }

    @Override
    public void refreshToken() throws ServiceExecutionFailedException {
        fetchToken();
    }

    @Override
    public List<SupCategory> fetchCategory() throws ServiceExecutionFailedException, TokenInvalidException {
        logger.info("���������-��ȡ����");

        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());

        List<SupCategory> list = new ArrayList<SupCategory>();
        SupCategory cat = null;
        Map<String, Object> result;
        List<Map<String, Object>> cats;
        try {
            result = execute("/api/product/get_pools", param);
            cats = (List<Map<String, Object>>) result.get("result");
            if (cats == null) {
                throw new ServiceExecutionFailedException("������");
            }

            for (Map<String, Object> i : cats) {
                cat = new SupCategory();
                cat.setSupCatId(Integer.parseInt((String) i.get("id")));
                //cat.setSupCatName(new String(String.valueOf(i.get("name")).getBytes("GBK"), "GBK"));
                cat.setSupCatName((String) i.get("name"));
                cat.setSupId(supplier.getSupId());
                list.add(cat);
            }
            logger.info("���������-�����ȡ�ɹ��������� [" + list.size() + "]");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("���������-�����ȡʧ��", e);
            throw new ServiceExecutionFailedException(e);
        }
        return list;
    }

    @Override
    public List<SupArea> fetchCity(int prov) throws ServiceExecutionFailedException, TokenInvalidException {
        logger.info("���������-��ȡ���� [" + prov + "]");

        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("id", String.valueOf(prov));

        List<SupArea> list = new ArrayList<SupArea>();
        SupArea area = null;
        Map<String, Object> result;
        Map<String, Integer> areas;
        try {
            result = execute("/api/area/cities", param);
            areas = (Map<String, Integer>) result.get("result");
            if (areas == null) {
                throw new ServiceExecutionFailedException("������");
            }

            for (Entry<String, Integer> i : areas.entrySet()) {
                area = new SupArea();
                area.setSupAreaId(i.getValue());
                area.setSupAreaName(i.getKey());
                area.setSupId(supplier.getSupId());
                area.setSupAreaLevel(2);
                area.setSupParentArea(prov);
                list.add(area);
            }
            logger.info("���������-���л�ȡ�ɹ� [" + prov + "]�������� [" + list.size() + "]");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("���������-���л�ȡʧ�� [" + prov + "]", e);
            throw new ServiceExecutionFailedException(e);
        }
        return list;
    }

    @Override
    public List<SupArea> fetchCountry(int city) throws ServiceExecutionFailedException, TokenInvalidException {
        logger.info("���������-��ȡ���� [" + city + "]");

        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("id", String.valueOf(city));

        List<SupArea> list = new ArrayList<SupArea>();
        SupArea area = null;
        Map<String, Object> result;
        Map<String, Integer> areas;
        try {
            result = execute("/api/area/getCounty", param);
            areas = (Map<String, Integer>) result.get("result");
            if (areas == null) {
                throw new ServiceExecutionFailedException("������");
            }

            for (Entry<String, Integer> i : areas.entrySet()) {
                area = new SupArea();
                area.setSupAreaId(i.getValue());
                area.setSupAreaName(i.getKey());
                area.setSupId(supplier.getSupId());
                area.setSupAreaLevel(3);
                area.setSupParentArea(city);
                list.add(area);
            }
            logger.info("���������-���ػ�ȡ�ɹ� [" + city + "]�������� [" + list.size() + "]");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("���������-���ػ�ȡʧ�� [" + city + "]", e);
            throw new ServiceExecutionFailedException(e);
        }
        return list;
    }

    @Override
    public List<SupArea> fetchProvince() throws ServiceExecutionFailedException, TokenInvalidException {
        logger.info("���������-��ȡʡ��");

        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());

        List<SupArea> list = new ArrayList<SupArea>();
        SupArea area = null;
        Map<String, Object> result;
        Map<String, Integer> areas;
        try {
            result = execute("/api/area/provinces", param);
            areas = (Map<String, Integer>) result.get("result");
            if (areas == null) {
                throw new ServiceExecutionFailedException("������");
            }

            for (Entry<String, Integer> i : areas.entrySet()) {
                area = new SupArea();
                area.setSupAreaId(i.getValue());
                area.setSupAreaName(i.getKey());
                area.setSupId(supplier.getSupId());
                area.setSupAreaLevel(1);
                area.setSupParentArea(0);
                list.add(area);
            }
            logger.info("���������-ʡ�ݻ�ȡ�ɹ��������� [" + list.size() + "]");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("���������-ʡ�ݻ�ȡʧ��", e);
            throw new ServiceExecutionFailedException(e);
        }
        return list;
    }

    @Override
    public List<SupArea> fetchTown(int town) throws ServiceExecutionFailedException, TokenInvalidException {
        // �������ļ�����
        return new ArrayList<SupArea>();
    }

    @Override
    public List<String> fetchSku(int cat) throws ServiceExecutionFailedException, TokenInvalidException {
        logger.info("���������-��ȡSKU [" + cat + "]");

        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("catalog_id", String.valueOf(cat));

        List<String> list;

        Map<String, Object> result;

        try {
            result = execute("/api/product/skus", param);
            list = (List<String>) result.get("result");
            if (list == null) {
                throw new ServiceExecutionFailedException("������");
            }

            logger.info("���������-SKU��ȡ�ɹ���[" + cat + "] ������ [" + list.size() + "]");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("���������-SKU��ȡʧ��[" + cat + "]", e);
            throw new ServiceExecutionFailedException(e);
        }
        return list;
    }

    @Override
    public Goods fetchGoods(String sku, int cat) throws ServiceExecutionFailedException, TokenInvalidException {
        logger.info("���������-��ȡ��Ʒ��Ϣ [" + sku + "]");

        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("sku", sku);

        Map<String, String> data;

        Map<String, Object> result;
        
        Goods goods = null;

        try {
            result = execute("/api/product/detail", param);
            data = (Map<String, String>) result.get("result");
            if (data == null) {
                throw new ServiceExecutionFailedException("������");
            }
            
            goods = new Goods();
            goods.setBrandName(data.get("brand_name"));
            goods.setGoodsCode(data.get("upc"));
            goods.setGoodsDesc(data.get("introduction"));
            goods.setGoodsModel(data.get("model"));
            goods.setGoodsName(data.get("name"));
            goods.setGoodsParam(data.get("param"));
            goods.setGoodsService(data.get("service"));
            goods.setGoodsStatus(Integer.parseInt(data.get("state")));
            goods.setGoodsUnit(data.get("unit"));
            goods.setGoodsUrl(data.get("url"));
            goods.setGoodsWare(data.get("ware"));
            goods.setGoodsWeight(data.get("weight"));
            goods.setImagePath(data.get("image_path"));
            goods.setProductArea(data.get("product_area"));
            goods.setSupCatId(cat);
            goods.setSupGoodsId(sku);
            goods.setSupId(supplier.getSupId());

            logger.info("���������-��Ʒ��Ϣ��ȡ�ɹ���[" + sku + "]");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("���������-��Ʒ��Ϣ��ȡʧ��[" + sku + "]", e);
            throw new ServiceExecutionFailedException(e);
        }
        return goods;
    }
    
    @Override
    public Map<String, Price> fetchPrice(List<String> skus) throws ServiceExecutionFailedException, TokenInvalidException {

        
        StringBuffer strBuf = new StringBuffer();
        for (String i : skus) {
            strBuf.append(i + ",");
        }
        
        String skuString = strBuf.substring(0, strBuf.length() - 1);
        logger.info("���������-��ȡ�۸� [" + skuString + "]");

        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("sku", skuString);
        param.put("area", "0_0_0");

        List<Map<String, Object>> list;

        Map<String, Object> result;

        Map<String, Price> map = new HashMap<String, Price>();
        Price price = null;
        try {
            result = execute("/api/product/prices", param);
            list = (List<Map<String, Object>>) result.get("result");
            if (list == null) {
                throw new ServiceExecutionFailedException("������");
            }
            
            for (Map<String, Object> i : list) {
                price = new Price();
                price.setBusinessPrice((Double)i.get("price"));
                price.setSalePrice((Double)i.get("mall_price"));
                
                double p = new BigDecimal(price.getBusinessPrice() * (1 + supplier.getPricePara())).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();

                if(p > price.getSalePrice()){
                    p = price.getBusinessPrice();
                }
                
                price.setAgreePrice(p);
                price.setCountPrice(p);
                map.put((String)i.get("sku"), price);
            }

            logger.info("���������-�۸��ȡ�ɹ���[" + skuString + "]");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("���������-�۸��ȡʧ��[" + skuString + "]", e);
            throw new ServiceExecutionFailedException(e);
        }
        
        return map;
    }

    @Override
    public List<GoodsImage> fetchGoodsImage(List<String> skus) throws ServiceExecutionFailedException, TokenInvalidException {

        
        StringBuffer strBuf = new StringBuffer();
        for (String i : skus) {
            strBuf.append(i + ",");
        }
        
        String skuString = strBuf.substring(0, strBuf.length() - 1);
        logger.info("���������-��ȡ��ƷͼƬ [" + skuString + "]");

        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("sku", skuString);

        List<Map<String, Object>> list;

        Map<String, Object> result;

        List<GoodsImage> images = new ArrayList<GoodsImage>();
        GoodsImage gi = null;
        String sku = null;
        List<Map<String, Object>> imageData = null;
        try {
            result = execute("/api/product/images", param);
            list = (List<Map<String, Object>>) result.get("result");
            if (list == null) {
                throw new ServiceExecutionFailedException("������");
            }
            
            for (Map<String, Object> i : list) {
                sku = (String)i.get("sku");
                imageData = (List<Map<String, Object>>)i.get("images");
                
                if (imageData != null) {
                    for (Map<String, Object> j : imageData) {
                        gi = new GoodsImage();
                        gi.setSupId(supplier.getSupId());
                        gi.setSupGoodsId(sku);
                        gi.setImagePath((String)j.get("path"));
                        gi.setShowOrder((Integer)j.get("order"));
                        images.add(gi);
                    }
                }
            }

            logger.info("���������-��ƷͼƬ��ȡ�ɹ���[" + skuString + "]");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("���������-��ƷͼƬ��ȡʧ��[" + skuString + "]", e);
            throw new ServiceExecutionFailedException(e);
        }
        
        return images;
    }
    
    @Override
    public Map<String, Integer> fetchStock(List<String> skus, List<Integer> nums, List<String> area) throws ServiceExecutionFailedException, TokenInvalidException {


        String a = null;
        
        if (area != null) {
            a = area.get(0) + "_" + area.get(1) + "_" + area.get(2);
        } else {
            a = "0_0_0";
        }

        String skuString = StringUtils.join(skus, ",");
        logger.info("���������-��ȡ��� [" + skuString + "]");

        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("sku", skuString);
        param.put("area", a);

        List<Map<String, Object>> list;

        Map<String, Object> result;

        Map<String, Integer> map = new HashMap<String, Integer>();

        try {
            result = execute("/api/product/stocks", param);
            list = (List<Map<String, Object>>) result.get("result");
            if (list == null) {
                throw new ServiceExecutionFailedException("������");
            }
            
            for (Map<String, Object> i : list) {
                map.put((String)i.get("sku"), (Integer)i.get("num"));
            }

            logger.info("���������-����ȡ�ɹ���[" + skuString + "]");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("���������-����ȡʧ��[" + skuString + "]", e);
            throw new ServiceExecutionFailedException(e);
        }
        
        return map;
    }
    
    @Override
    public Map<String, Integer> fetchStatus(List<String> skus) throws ServiceExecutionFailedException, TokenInvalidException {


        String skuString = StringUtils.join(skus, ",");
        logger.info("���������-��ȡ���¼�״̬ [" + skuString + "]");

        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("sku", skuString);

        List<Map<String, Object>> list;

        Map<String, Object> result;

        Map<String, Integer> map = new HashMap<String, Integer>();

        try {
            result = execute("/api/product/shelf_states", param);
            list = (List<Map<String, Object>>) result.get("result");
            if (list == null) {
                throw new ServiceExecutionFailedException("������");
            }
            
            for (Map<String, Object> i : list) {
                map.put((String)i.get("sku"), Integer.parseInt(String.valueOf(i.get("state"))));
            }

            logger.info("���������-���¼�״̬��ȡ�ɹ���[" + skuString + "]");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("���������-���¼�״̬��ȡʧ��[" + skuString + "]", e);
            throw new ServiceExecutionFailedException(e);
        }
        
        return map;
    }
    
    @Override
    public String orderSubmit(Order order) throws ServiceExecutionFailedException, TokenInvalidException {


        logger.info("���������-����Ԥռ�ύ");
        
        List<Map<String, String>> skus = new ArrayList<Map<String,String>>();
        
        for (OrderSnapshot i : order.getSnapshots()) {
            Map<String, String> m = new HashMap<String, String>();
            m.put("sku", i.getSupGoodsId());
            m.put("num", String.valueOf(i.getBuyNum()));
            m.put("price", String.valueOf(i.getGoodsPriceInit()));
            skus.add(m);
        }

        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("yggc_order", order.getOrderId());
        try {
            param.put("sku", new ObjectMapper().writeValueAsString(skus));
        } catch (Exception e1) {}
        param.put("name", order.getAddrName());
        param.put("province", String.valueOf(order.getAddrProv()));
        param.put("city", String.valueOf(order.getAddrCity()));
        param.put("county", String.valueOf(order.getAddrDist()));
        param.put("address", order.getAddrDetail());
        param.put("zip", order.getAddrZip());
        param.put("phone", order.getAddrTel());
        param.put("mobile", order.getAddrPhone());
        param.put("email", order.getAddrEmail());
        param.put("invoice_type", "2");
        param.put("invoice_title", ConfigHolder.getInstance().getConfig("invoice.title"));
        param.put("invoice_tax_num", "");
        param.put("invoice_bank", "");
        param.put("invoice_bank_account", "");
        param.put("invoice_address", "");
        param.put("invoice_phone", "");
        param.put("payment", "2");
        param.put("order_price", String.format("%.2f", order.getOrderAmountInit()));
        param.put("freight", "0");


        Map<String, Object> result, data;

        Map<String, Integer> map = new HashMap<String, Integer>();
        String orderNo = null;

        try {
            result = execute("/api/order/submit", param);
            data = (Map<String, Object>) result.get("result");
            if (data == null) {
                throw new ServiceExecutionFailedException("δ֪����");
            }

            orderNo = (String)data.get("mall_order_id");

            logger.info("���������-����Ԥռ�ύ�ɹ���[" + orderNo + "]");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("���������-����Ԥռ�ύʧ��", e);
            throw new ServiceExecutionFailedException(e);
        }
        
        return orderNo;
    }
    @Override
    public void orderCancel(String orderId, String supOrderId) throws ServiceExecutionFailedException, TokenInvalidException {

        logger.info("���������-����Ԥռȡ��");
        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("order_id", orderId);

        try {
            execute("/api/order/cancel", param);

            logger.info("���������-����Ԥռȡ���ɹ�");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("���������-����Ԥռȡ��ʧ��", e);
            throw new ServiceExecutionFailedException(e);
        }
    }
    @Override
    public void orderConfirm(String orderId, String supOrderId) throws ServiceExecutionFailedException, TokenInvalidException {

        logger.info("���������-����Ԥռȷ��");
        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("order_id", orderId);

        try {
            execute("/api/order/confirm", param);

            logger.info("���������-����Ԥռȷ�ϳɹ�");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("���������-����Ԥռȷ��ʧ��", e);
            throw new ServiceExecutionFailedException(e);
        }
    }
    @Override
    public Map<String, Object>  trackInfo(String orderId, String supOrderId) throws ServiceExecutionFailedException, TokenInvalidException {

        logger.info("���������-�鿴������Ϣ");
        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("order_id", orderId);
        Map<String, Object> result;
        try {
        	result = execute("/api/order/track", param);

            logger.info("���������-�鿴������Ϣ");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("���������-�鿴������Ϣʧ��", e);
            throw new ServiceExecutionFailedException(e);
        }
        return result;
    }
    private Map<String, Object> execute(String api, Object param) throws Exception, TokenInvalidException {
        ObjectMapper mapper = new ObjectMapper();
        CloseableHttpResponse response = null;
        HttpEntity entity = null;
        String body = null;
        try {
            body = mapper.writeValueAsString(param);
        } catch (Exception e1) {
            // ignore
        }
        HttpUriRequest req = buildRequest(api, new StringEntity(body, "UTF-8"));
        logger.debug("���������-�ӿڵ���[" + api + "] ���� : " + body);
        String content = null;
        int code = 0;
        try {
            response = client.execute(req);
            code = response.getStatusLine().getStatusCode();
            if (code != 200) {
                throw new Exception("���������-�ӿڷ���HTTP״̬�쳣 [" + code + "]");
            }

            entity = response.getEntity();

            content = EntityUtils.toString(entity, "GBK");

            Map<String, Object> result = (Map<String, Object>) mapper.readValue(content, Map.class);
            EntityUtils.consume(entity);

            logger.debug("���������-�ӿڵ��óɹ� [" + api + "] ���� : " + content);

            if ("true".equals(String.valueOf(result.get("success"))) || (result.get("result") != null && result.get("result") instanceof Map)) {
                return result;
            } else {
//                if (result.get("desc") == null) {
//                throw new TokenInvalidException("���������-�ӿڷ�������Ϊʧ�� : " + result.get("desc"));
//                } else {
//                    throw new Exception((String)result.get("desc"));
//                }
                
                if (result.get("desc") != null && ((String)result.get("desc")).contains("token_expired")) {
                    throw new TokenInvalidException("���������-�ӿڷ�������Ϊʧ�� : " + result.get("desc"));
                } else {
                    throw new Exception((String)result.get("desc"));
                }
                
            }

        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("���������-�ӿڵ���ʧ�� [" + api + "]", e);
            throw e;
        } finally {
            try {
                response.close();
            } catch (IOException e) {
            }
        }
    }

	@Override
	public Map<String, Object> selectOrder(String supOrderId)
			throws ServiceExecutionFailedException, TokenInvalidException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> afterSaleAfsApplyCreate(Map afsApplyCreate)
			throws ServiceExecutionFailedException, TokenInvalidException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> serviceListPage(String jdOrderId, int pageIndex,
			int pageSize) throws ServiceExecutionFailedException,
			TokenInvalidException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> auditCancel(Map auditCancel)
			throws ServiceExecutionFailedException, TokenInvalidException {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public void delMessage(String msg) throws ServiceExecutionFailedException, TokenInvalidException {
	    // TODO Auto-generated method stub
	    
	}
	@Override
	public List<GoodsMessage> getMessage() throws ServiceExecutionFailedException, TokenInvalidException {
	    // TODO Auto-generated method stub
	    return null;
	}
}