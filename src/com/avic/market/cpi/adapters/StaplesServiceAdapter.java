package com.avic.market.cpi.adapters;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
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
import org.apache.http.message.BasicHeader;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.codehaus.jackson.map.ObjectMapper;

import com.avic.common.utils.ConfigHolder;
import com.avic.market.cpi.ServiceAdapter;
import com.avic.market.cpi.exceptions.ServiceExecutionFailedException;
import com.avic.market.cpi.exceptions.TokenInvalidException;
import com.avic.market.models.Goods;
import com.avic.market.models.GoodsImage;
import com.avic.market.models.GoodsMessage;
import com.avic.market.models.Order;
import com.avic.market.models.OrderSnapshot;
import com.avic.market.models.Price;
import com.avic.market.models.SupArea;
import com.avic.market.models.SupCategory;

public class StaplesServiceAdapter extends ServiceAdapter {
    protected static final Log logger = LogFactory.getLog(StaplesServiceAdapter.class);
    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    

    public void init() {
        logger.info("ʷ̩���ӿڳ�ʼ�� ...");
        super.init();
        httpHeaders.add(new BasicHeader("Content-Type", "application/json; charset=utf-8"));
        httpHeaders.add(new BasicHeader("Accept", "application/json"));

    }
    
    @Override
    public SYNC_TYPE syncType() {
        return ServiceAdapter.SYNC_TYPE.SYNC_INCR;
    }
    
    @Override
    public void fetchToken() throws ServiceExecutionFailedException {
        if (supplier.getRefreshToken() == null || supplier.getRefreshExpire().before(new Date())) {
            logger.info("ʷ̩��-Refresh Token��Ч�����¼���Access Token");
            Map<String, String> param = new HashMap<String, String>();
            param.put("grant_type", "authorization_code");
            param.put("client_id", supplier.getAuthUser());
            param.put("client_secret", supplier.getAuthPass());
            param.put("state", "available");
            param.put("scope", "abc");
            param.put("redirect_uri", "http://www.xxxx.com");
            param.put("code", supplier.getAuthCode());
            Map<String, Object> result;
            List<Map<String, Object>> data;
            try {
                result = execute("/api/access_token", param);
                data = (List<Map<String, Object>>)result.get("result");

                result = data.get(0);
                
                supplier.setAccessToken((String)result.get("access_token"));
                supplier.setRefreshToken((String)result.get("refresh_token"));
                supplier.setAccessExpire(df.parse((String)result.get("expires_in")));
                supplier.setRefreshExpire(df.parse((String)result.get("refresh_token_expires")));
                
                logger.info("ʷ̩��-Token���سɹ�");
            } catch (Exception e) {
                logger.error("ʷ̩��-Token����ʧ��", e);
                throw new ServiceExecutionFailedException(e);
            }
        } else {
            logger.info("ʷ̩��-Access Token��Ч��ˢ��Access Token");
            Map<String, String> param = new HashMap<String, String>();
            param.put("refresh_token", supplier.getRefreshToken());
            param.put("client_id", supplier.getAuthUser());
            param.put("client_secret", supplier.getAuthPass());

            Map<String, Object> result;
            List<Map<String, Object>> data;
            try {
                result = execute("/api/refresh_token", param);
                data = (List<Map<String, Object>>)result.get("result");

                result = data.get(0);
                
                supplier.setAccessToken((String)result.get("access_token"));
                supplier.setRefreshToken((String)result.get("refresh_token"));
                supplier.setAccessExpire(df.parse((String)result.get("expires_in")));
                supplier.setRefreshExpire(df.parse((String)result.get("refresh_token_expires")));
                
                logger.info("ʷ̩��-Access Token���سɹ�");
            } catch (Exception e) {
                logger.error("ʷ̩��-Access Token����ʧ��", e);
                throw new ServiceExecutionFailedException(e);
            }
        }
        
        
    }

    @Override
    public void refreshToken() throws ServiceExecutionFailedException {
        fetchToken();
    }

    @Override
    public List<SupCategory> fetchCategory() throws ServiceExecutionFailedException, TokenInvalidException {
        logger.info("ʷ̩��-��ȡ����");

        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());

        List<SupCategory> list = new ArrayList<SupCategory>();
        SupCategory cat = null;
        Map<String, Object> result;
        List<Map<String, Object>> cats;
        try {
            result = execute("/api/goods/getPageNum", param);
            cats = (List<Map<String, Object>>) result.get("result");
            if (cats == null) {
                throw new ServiceExecutionFailedException("������");
            }

            for (Map<String, Object> i : cats) {
                cat = new SupCategory();
                cat.setSupCatId((Integer) i.get("page_num"));
                cat.setSupCatName((String) i.get("name"));
                cat.setSupId(supplier.getSupId());
                list.add(cat);
            }
            logger.info("ʷ̩��-�����ȡ�ɹ��������� [" + list.size() + "]");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("ʷ̩��-�����ȡʧ��", e);
            throw new ServiceExecutionFailedException(e);
        }
        return list;
    }

    @Override
    public List<SupArea> fetchProvince() throws ServiceExecutionFailedException, TokenInvalidException {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public List<SupArea> fetchCity(int prov) throws ServiceExecutionFailedException, TokenInvalidException {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public List<SupArea> fetchCountry(int city) throws ServiceExecutionFailedException, TokenInvalidException {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public List<SupArea> fetchTown(int town) throws ServiceExecutionFailedException, TokenInvalidException {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public List<String> fetchSku(int cat) throws ServiceExecutionFailedException, TokenInvalidException {
        logger.info("ʷ̩��-��ȡSKU [" + cat + "]");

        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("pageNum", String.valueOf(cat));

        List<String> list = new ArrayList<String>();

        Map<String, Object> result;

        try {
            result = execute("/api/goods/product/getSku", param);
            String data = (String) result.get("result");
            if (data == null) {
                throw new ServiceExecutionFailedException("������");
            }
            
            for (String s : data.split(",")) {
                list.add(s.trim());
            }

            logger.info("ʷ̩��-SKU��ȡ�ɹ���[" + cat + "] ������ [" + list.size() + "]");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("ʷ̩��-SKU��ȡʧ��[" + cat + "]", e);
            throw new ServiceExecutionFailedException(e);
        }
        return list;
    }

    @Override
    public Goods fetchGoods(String sku, int cat) throws ServiceExecutionFailedException, TokenInvalidException {
        logger.info("ʷ̩��-��ȡ��Ʒ��Ϣ [" + sku + "]");

        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("sku", sku);

        Map<String, String> data;

        Map<String, Object> result;
        
        Goods goods = null;

        try {
            result = execute("/api/goods/product/getDetail", param);
            data = (Map<String, String>) result.get("result");
            if (data == null) {
                throw new ServiceExecutionFailedException("������");
            }
            
            goods = new Goods();
            goods.setBrandName(data.get("brandName"));
            goods.setGoodsCode(data.get("upc"));
            goods.setGoodsDesc(data.get("introduction"));
            goods.setGoodsModel(data.get("goodsModel"));
            goods.setGoodsName(data.get("name"));
            goods.setGoodsParam(data.get("param"));
            goods.setGoodsService(data.get("service"));
            goods.setGoodsStatus(Integer.parseInt(data.get("state")));
            goods.setGoodsUnit(data.get("saleUnit"));
            goods.setGoodsUrl(data.get("url"));
            goods.setGoodsWare(data.get("wareQD"));
            goods.setGoodsWeight(data.get("weight"));
            goods.setImagePath(data.get("imagePath"));
            goods.setProductArea(data.get("productArea"));
            goods.setSupCatId(Integer.parseInt(data.get("category")));
            goods.setSupGoodsId(sku);
            goods.setSupId(supplier.getSupId());

            logger.info("ʷ̩��-��Ʒ��Ϣ��ȡ�ɹ���[" + sku + "]");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("ʷ̩��-��Ʒ��Ϣ��ȡʧ��[" + sku + "]", e);
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
        logger.info("ʷ̩��-��ȡ�۸� [" + skuString + "]");

        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("sku", skuString);

        List<Map<String, Object>> list;

        Map<String, Object> result;

        Map<String, Price> map = new HashMap<String, Price>();
        Price price = null;
        try {
            result = execute("/api/goods/product/getPrice", param);
            list = (List<Map<String, Object>>) result.get("result");
            if (list == null) {
                throw new ServiceExecutionFailedException("������");
            }
            
            for (Map<String, Object> i : list) {
                price = new Price();
                price.setBusinessPrice(Double.valueOf(i.get("bizPrice").toString()));
                price.setSalePrice(Double.valueOf(i.get("supplierPrice").toString()));
                double p = new BigDecimal(price.getBusinessPrice() * (1 + supplier.getPricePara())).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();

                if(p > price.getSalePrice()){
                    p = price.getBusinessPrice();
                }
                price.setAgreePrice(p);
                price.setCountPrice(p);
                map.put((String)i.get("skuId"), price);
            }

            logger.info("ʷ̩��-�۸��ȡ�ɹ���[" + skuString + "]");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("ʷ̩��-�۸��ȡʧ��[" + skuString + "]", e);
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
        logger.info("ʷ̩��-��ȡ��ƷͼƬ [" + skuString + "]");

        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("sku", skuString);

        List<Map<String, Object>> list;
        Map<String, Object> map;
        Map<String, Object> result;

        List<GoodsImage> images = new ArrayList<GoodsImage>();
        GoodsImage gi = null;
        String sku = null;
        List<Map<String, String>> imageData = null;
        try {
            result = execute("/api/goods/product/skuImage", param);
            if (result.get("result") instanceof Map) {
                map = (Map<String, Object>) result.get("result");
                if (map == null) {
                    throw new ServiceExecutionFailedException("������");
                }
                
                for (Entry<String, Object> j : map.entrySet()) {
                    sku = j.getKey();
                    imageData = (List<Map<String, String>>)j.getValue();
                    
                    if (imageData != null) {
                        for (Map<String, String> k : imageData) {
                            gi = new GoodsImage();
                            gi.setSupId(supplier.getSupId());
                            gi.setSupGoodsId(sku);
                            gi.setImagePath(k.get("path"));
                            gi.setShowOrder(Integer.parseInt(k.get("orderSort")));
                            images.add(gi);
                        }
                    }
                }
            } else {
                list = (List<Map<String, Object>>) result.get("result");
                if (list == null) {
                    throw new ServiceExecutionFailedException("������");
                }
                
                for (Map<String, Object> i : list) {
                    for (Entry<String, Object> j : i.entrySet()) {
                        sku = j.getKey();
                        imageData = (List<Map<String, String>>)j.getValue();
                        
                        if (imageData != null) {
                            for (Map<String, String> k : imageData) {
                                gi = new GoodsImage();
                                gi.setSupId(supplier.getSupId());
                                gi.setSupGoodsId(sku);
                                gi.setImagePath(k.get("path"));
                                gi.setShowOrder(Integer.parseInt(k.get("orderSort")));
                                images.add(gi);
                            }
                        }
                    }
                }
            }

            logger.info("ʷ̩��-��ƷͼƬ��ȡ�ɹ���[" + skuString + "]");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("ʷ̩��-��ƷͼƬ��ȡʧ��[" + skuString + "]", e);
            throw new ServiceExecutionFailedException(e);
        }
        
        return images;
    }
    
    @Override
    public Map<String, Integer> fetchStock(List<String> skus, List<Integer> nums, List<String> area) throws ServiceExecutionFailedException, TokenInvalidException {

     

        String a = null;
        
        if (area != null) {
            a = StringUtils.join(area, "_");
        } else {
            a = "1_0_0_0";
        }
        
        
        String skuString = StringUtils.join(skus, ",");
        logger.info("ʷ̩��-��ȡ��� [" + skuString + "]");

        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("sku", skuString);
        param.put("area", a);

        List<Map<String, Object>> list;

        Map<String, Object> result;

        Map<String, Integer> map = new HashMap<String, Integer>();

        try {
            result = execute("/api/goods/product/getStockById", param);
            list = (List<Map<String, Object>>) result.get("result");
            if (list == null) {
                throw new ServiceExecutionFailedException("������");
            }
            
            for (Map<String, Object> i : list) {
            	if("Ԥ��".equals((String)i.get("desc"))){
            		map.put((String)i.get("sku"), Integer.parseInt("-1"));
            	}else if("�޻�".equals((String)i.get("desc"))){
            		map.put((String)i.get("sku"), Integer.parseInt("0"));
            	}
            	else{
            		map.put((String)i.get("sku"), (Integer)i.get("num"));
            	}               
            }

            logger.info("ʷ̩��-����ȡ�ɹ���[" + skuString + "]");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("ʷ̩��-����ȡʧ��[" + skuString + "]", e);
            throw new ServiceExecutionFailedException(e);
        }
        
        return map;
    }
    
    @Override
    public Map<String, Integer> fetchStatus(List<String> skus) throws ServiceExecutionFailedException, TokenInvalidException {

        
        String skuString = StringUtils.join(skus, ",");
        logger.info("ʷ̩��-��ȡ���¼�״̬ [" + skuString + "]");

        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("sku", skuString);

        List<Map<String, Object>> list;

        Map<String, Object> result;

        Map<String, Integer> map = new HashMap<String, Integer>();

        try {
            result = execute("/api/goods/product/skuState", param);
            list = (List<Map<String, Object>>) result.get("result");
            if (list == null) {
                throw new ServiceExecutionFailedException("������");
            }
            
            for (Map<String, Object> i : list) {
                map.put((String)i.get("sku"),(Integer)i.get("state"));
            }

            logger.info("ʷ̩��-���¼�״̬��ȡ�ɹ���[" + skuString + "]");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("ʷ̩��-���¼�״̬��ȡʧ��[" + skuString + "]", e);
            throw new ServiceExecutionFailedException(e);
        }
        
        return map;
    }
    
    @Override
    public String orderSubmit(Order order) throws ServiceExecutionFailedException, TokenInvalidException {

        
        logger.info("ʷ̩��-����Ԥռ�ύ");
        
        List<Map<String, String>> skus = new ArrayList<Map<String,String>>();
        
        for (OrderSnapshot i : order.getSnapshots()) {
            Map<String, String> m = new HashMap<String, String>();
            m.put("skuId", i.getSupGoodsId());
            m.put("num", String.valueOf(i.getBuyNum()));
            skus.add(m);
        }


        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("thirdOrder", order.getOrderId());
        try {
            param.put("sku", new ObjectMapper().writeValueAsString(skus));
        } catch (Exception e1) {}

        param.put("name", order.getAddrName());
        param.put("province", String.valueOf(order.getAddrProv()));
        param.put("city", String.valueOf(order.getAddrCity()));
        param.put("county", String.valueOf(order.getAddrDist()));
        param.put("town", String.valueOf(order.getAddrTown()));
        param.put("address", order.getAddrDetail());
        param.put("zip", order.getAddrZip());
        param.put("phone", order.getAddrTel());
        param.put("mobile", order.getAddrPhone());
        param.put("email", order.getAddrEmail());
        param.put("creatorName", order.getAddrName());
        param.put("creatorPhone", order.getAddrTel());
        param.put("creatorMobile", order.getAddrPhone());
        param.put("createdTime", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
        param.put("detailAddress", order.getAddrAll());
        param.put("invoiceState", "0");
        param.put("invoiceType", "1");
        param.put("companyName", ConfigHolder.getInstance().getConfig("invoice.title"));
        param.put("invoiceContent", "1");
        param.put("payment", "2");

        List<Map<String, Object>> list;

        Map<String, Object> result, data;

        Map<String, Integer> map = new HashMap<String, Integer>();
        Map<String, Double> price = new HashMap<String, Double>();
        
        String orderNo = null;

        try {
            result = execute("/api/order/submit", param);
            data = (Map<String, Object>) result.get("result");
            if (data == null) {
                throw new ServiceExecutionFailedException("δ֪����");
            }

            
            orderNo = (String)data.get("supplierOrderId");
            
            // ����ʵ���µ��۸�
            list = (List<Map<String, Object>>) data.get("sku");
            for (Map<String, Object> i : list) {
                price.put((String)i.get("skuId"), (Double)i.get("bizPrice"));
                
            }
            
            for (OrderSnapshot i : order.getSnapshots()) {
                if (price.containsKey(i.getSupGoodsId())) {
                    i.setGoodsPriceInit(price.get(i.getSupGoodsId()));
                }
            }
            order.setOrderAmountInit((Double)data.get("orderPrice"));

            logger.info("ʷ̩��-����Ԥռ�ύ�ɹ���[" + orderNo + "]");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("ʷ̩��-����Ԥռ�ύʧ��", e);
            throw new ServiceExecutionFailedException(e);
        }
        
        return orderNo;
    }
    
    @Override
    public void orderCancel(String orderId, String supOrderId) throws ServiceExecutionFailedException, TokenInvalidException {
        logger.info("ʷ̩��-����Ԥռȡ��");
        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("supplierOrderId", supOrderId);

        try {
            execute("/api/order/cancelPreOrder", param);

            logger.info("ʷ̩��-����Ԥռȡ���ɹ�");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("ʷ̩��-����Ԥռȡ��ʧ��", e);
            throw new ServiceExecutionFailedException(e);
        }
    }
    @Override
    public void orderConfirm(String orderId, String supOrderId) throws ServiceExecutionFailedException, TokenInvalidException {
        logger.info("ʷ̩��-����Ԥռȷ��");
        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("supplierOrderId", supOrderId);

        try {
            execute("/api/order/confirmOrder", param);

            logger.info("ʷ̩��-����Ԥռȷ�ϳɹ�");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("ʷ̩��-����Ԥռȷ��ʧ��", e);
            throw new ServiceExecutionFailedException(e);
        }
    }
    @Override
    public Map<String, Object>  trackInfo(String orderId, String supOrderId) throws ServiceExecutionFailedException, TokenInvalidException {

        logger.info("ʷ̩��-�鿴������Ϣ");
        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("supplierOrderId", supOrderId);
        Map<String, Object> result;
        try {
        	result = execute("/api/order/orderTrack", param);

            logger.info("ʷ̩��-�鿴������Ϣ");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("ʷ̩��-�鿴������Ϣʧ��", e);
            throw new ServiceExecutionFailedException(e);
        }
        return result;
    }
    @Override
    public Map<String, Object>  selectOrder(String supOrderId) throws ServiceExecutionFailedException, TokenInvalidException {

        logger.info("ʷ̩��-�鿴������Ϣ");
        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("supplierOrderId", supOrderId);
        Map<String, Object> result;
        try {
        	result = execute("/api/order/selectOrder", param);

            logger.info("ʷ̩��-�鿴������Ϣ");
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("ʷ̩��-�鿴������Ϣʧ��", e);
            throw new ServiceExecutionFailedException(e);
        }
        return result;
    }
    public Map<String, Object> execute(String api, Map<String, String> param) throws Exception, TokenInvalidException {
        ObjectMapper mapper = new ObjectMapper();
        CloseableHttpResponse response = null;
        HttpEntity entity = null;
        
        param.put("groupCode", supplier.getCompanyCode());
        param.put("customerCode", supplier.getDeptCode());
        List<BasicNameValuePair> nv = new ArrayList<BasicNameValuePair>();
        String url = api + "?";
        for (Entry<String, String> i: param.entrySet()) {
            //nv.add(new BasicNameValuePair(i.getKey(), i.getValue()));
            url = url + i.getKey() + "=" + (i.getValue() == null ? "" : URLEncoder.encode(i.getValue(), "UTF-8")) + "&";
        }

        HttpUriRequest req = buildRequest(url, null);//new UrlEncodedFormEntity(nv));
        logger.debug("ʷ̩��-�ӿڵ���[" + api + "] ���� : " + mapper.writeValueAsString(param));
        String content = null;
        int code = 0;
        try {
            response = client.execute(req);
            code = response.getStatusLine().getStatusCode();
            if (code != 200) {
                throw new Exception("ʷ̩��-�ӿڷ���HTTP״̬�쳣 [" + code + "]");
            }

            entity = response.getEntity();

            content = EntityUtils.toString(entity);

            Map<String, Object> result = (Map<String, Object>) mapper.readValue(content, Map.class);
            EntityUtils.consume(entity);

            logger.debug("ʷ̩��-�ӿڵ��óɹ� [" + api + "] ���� : " + content);

            if ("true".equals(String.valueOf(result.get("success"))) || 
            		(result.get("result") != null && (result.get("result") instanceof Map || result.get("result") instanceof List))) {
                return result;
            } else {
                if (result.containsKey("resultMessage") && ((String)result.get("resultMessage")).contains("token����ֵ����ȷ")) {
                    throw new TokenInvalidException((String)result.get("resultMessage"));
                }
                
                throw new Exception((String)result.get("resultMessage"));
            }

        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("ʷ̩��-�ӿڵ���ʧ�� [" + api + "]", e);
            throw e;
        } finally {
            try {
                response.close();
            } catch (IOException e) {
            }
        }
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
	    logger.info("ʷ̩��-ɾ��������Ϣ[" + msg + "]");
        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("id", msg);
        try {
            execute("/api/message/del", param);
            logger.info("ʷ̩��-ɾ��������Ϣ�ɹ�����Ϣ[" + msg + "]");
            
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("ʷ̩��-ɾ��������Ϣʧ��", e);
            throw new ServiceExecutionFailedException(e);
        }
	}
	
	@Override
	public List<GoodsMessage> getMessage() throws ServiceExecutionFailedException, TokenInvalidException {
	    logger.info("ʷ̩��-��ȡ������Ϣ");
        Map<String, String> param = new HashMap<String, String>();
        param.put("token", supplier.getAccessToken());
        param.put("del", "0");
        param.put("type", "2,4,6");
        Map<String, Object> result;
        try {
            result = execute("/api/message/get", param);
            
            List<Map<String, Object>> list = (List<Map<String, Object>>)result.get("result");
            List<GoodsMessage> msgs = new ArrayList<GoodsMessage>();
            
            for (Map<String, Object> map : list) {
                GoodsMessage msg = new GoodsMessage();
                msg.setMsgId(String.valueOf(map.get("id")));
                Map<String, Object> r = (Map<String, Object>)map.get("result");
                msg.setSku(String.valueOf(r.get("skuId")));
                
                String type = String.valueOf(map.get("type"));
                
                if ("2".equals(type)) {
                    msg.setOperation(GoodsMessage.Operation.PRICE);
                } else if ("4".equals(type)) {
                    String state = String.valueOf(r.get("state"));
                    
                    if ("1".equals(state)) {
                        msg.setOperation(GoodsMessage.Operation.STATE_ON);
                    } else {
                        msg.setOperation(GoodsMessage.Operation.STATE_OFF);
                    }
                } else if ("6".equals(type)) {
                    String state = String.valueOf(r.get("state"));
                    if ("1".equals(state)) {
                        msg.setOperation(GoodsMessage.Operation.GOODS_ADD);
                    } else if ("2".equals(state)) {
                        msg.setOperation(GoodsMessage.Operation.GOODS_UPDATE);
                    } else if ("3".equals(state)) {
                        msg.setOperation(GoodsMessage.Operation.GOODS_DELETE);
                    }
                } else {
                   continue;
                }
                
                msgs.add(msg);
            }
            
            logger.info("ʷ̩��-��ȡ������Ϣ�ɹ�������[" + msgs.size() + "]");
            return msgs;
            
        } catch (TokenInvalidException ex) {
            throw ex;
        } catch (Exception e) {
            logger.error("ʷ̩��-��ȡ������Ϣʧ��", e);
            throw new ServiceExecutionFailedException(e);
        }
	}
}