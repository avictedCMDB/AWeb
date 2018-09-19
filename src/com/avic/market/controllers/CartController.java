package com.avic.market.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.beans.ResultObject;
import com.avic.common.constants.SessionKeys;
import com.avic.common.constants.UserRole;
import com.avic.common.exceptions.PageNotFoundException;
import com.avic.common.exceptions.ServiceException;
import com.avic.common.utils.Permission;
import com.avic.market.cpi.CpiService;
import com.avic.market.cpi.exceptions.NoSuchSupplierException;
import com.avic.market.cpi.exceptions.ServiceExecutionFailedException;
import com.avic.market.models.Address;
import com.avic.market.models.CartItem;
import com.avic.market.services.AddressService;
import com.avic.market.services.CartService;
import com.avic.market.services.GoodsService;
import com.avic.passport.models.User;

@Controller
@RequestMapping("/cart")
public class CartController {
    protected static final Log logger = LogFactory.getLog(CartController.class);
    
    @Autowired
    CartService cartService;
    
    @Autowired
    AddressService addressService;
    
    @Autowired
    CpiService cpiService;
    
    @Autowired
    GoodsService goodsService;
    
    
    @RequestMapping("/add")
    @ResponseBody
    public ResultObject add(HttpServletRequest req, HttpSession session) {
        User user = Permission.check(session, UserRole.BUY, UserRole.CLIENT);
        // ��Ӧ�̱��
        String sid = req.getParameter("sid");
        // ��Ʒ���
        String gid = req.getParameter("gid");
        // ����
        String num = req.getParameter("num");
        logger.info("���ӹ��ﳵController-sid["+sid+"], gid["+gid+"], num["+num+"]");
        
        if (!StringUtils.isNumeric(sid) || StringUtils.isEmpty(gid) || !StringUtils.isNumeric(num)) {
            logger.error("���ӹ��ﳵController-������Ч-sid["+sid+"], gid["+gid+"], num["+num+"]");
            return new ResultObject(ResultObject.FAIL, "������Ч");
        }
        
        /*
        if (!cartService.checkGoodsCompare(user.getUserId(), Integer.parseInt(sid), gid)) {
            return new ResultObject(ResultObject.FAIL, "��Ʒδ�Աȣ����Ƚ��жԱ��ټ��빺�ﳵ��");
        }
        */
        
        CartItem item = new CartItem();
        item.setBuyNum(Integer.parseInt(num));
        item.setSupGoodsId(gid);
        item.setSupId(Integer.parseInt(sid));
        item.setUserId(user.getUserId());
        
        try {
            cartService.addToCart(item);
            int cartNum = cartService.countGoodsNum(user.getUserId());
            session.setAttribute(SessionKeys.CART_NUM, cartNum);
            return new ResultObject(ResultObject.OK, cartNum);
        } catch (ServiceException e) {
            return new ResultObject(ResultObject.FAIL, "���ӹ��ﳵʧ��");
        }
    }
    
    @RequestMapping("list")
    public String list(HttpServletRequest req, HttpSession session, Map<String, Object> map) {
        User user = Permission.check(session, UserRole.BUY, UserRole.CLIENT);
        logger.info("���ﳵ�б�");
        
        List<CartItem> list = cartService.getCartGoodsList(user.getUserId());
        
        if (list != null && list.size() > 0) {
            // <supId, skus>
            Map<Integer, List<String>> supSku = new HashMap<Integer, List<String>>();
            for (CartItem i : list) {
                if (i.getSupType() == 1) {
                    continue;
                }
                List<String> skus = supSku.get(i.getSupId());
                
                if (skus == null) {
                    skus = new ArrayList<String>();
                    supSku.put(i.getSupId(), skus);
                }
                
                skus.add(i.getSupGoodsId());
            }

            logger.info("���ﳵ�б�-��ȡ���");
            Map<String, Integer> stocks = new HashMap<String, Integer>();
            for (Entry<Integer, List<String>> i : supSku.entrySet()) {
                Address addr = addressService.getDefaultAddress(user.getUserId(), i.getKey());
                List<String> area = null;
                if (addr != null) {
                    area = new ArrayList<String>();
                    area.add(addr.getAreaLevelOne());
                    area.add(addr.getAreaLevelTwo());
                    area.add(addr.getAreaLevelThree());
                    if (!StringUtils.isEmpty(addr.getAreaLevelFour())) {
                        area.add(addr.getAreaLevelFour());
                    }
                }
                Map<String, Integer> s = new HashMap<String, Integer>();
                try {
                   s  = cpiService.getGoodsStock(i.getKey(), i.getValue(), null, area);
                } catch (Exception e) {
                    logger.info("���ﳵ�б�-��ȡ���ʧ��,��Ӧ��["+i.getKey()+"]", e);
                    String exceInf = e.getMessage();
                	List<String> newSkus = new ArrayList<String>();
                    if(exceInf.contains("sku����")){     
                    	String skuCode = exceInf.split("��")[1];
                    	for(int k = 0; k<i.getValue().size(); k++){
                    		if(!skuCode.contains(i.getValue().get(k))){
                    			newSkus.add(i.getValue().get(k));
                    		}
                    	}
                    }
                    try {
						s  = cpiService.getGoodsStock(i.getKey(), newSkus, null, area);
					} catch (Exception e1) {
	                    logger.info("���ﳵ�б�-��ȡ���ʧ��,��Ӧ��["+i.getKey()+"]", e);
					} 
                }
                for (Entry<String, Integer> j : s.entrySet()) {
                    stocks.put(i.getKey() + "#" + j.getKey(), j.getValue());
                }
            }
            
            for (CartItem i : list) {
                if (i.getSupType() == 1) {
                    double ep = goodsService.getEnquiryPrice(user.getUserId(), String.valueOf(i.getSupId()), i.getSupGoodsId());
                    if (ep > 0) {
                        i.setAgreePrice(ep);
                    }
                    i.setStock(99999);
                    continue;
                }
                Integer ii = stocks.get(i.getSupId() + "#" + i.getSupGoodsId());
                i.setStock(ii == null ? 0 : ii);
            }
        }
        
        map.put("list", list);
        
        return "order/cart";
    }


    @RequestMapping("clear")
    public String clear(HttpSession session, Map<String, Object> map) {
        User user = Permission.check(session, UserRole.BUY, UserRole.CLIENT);
        logger.info("��չ��ﳵ");
        
        cartService.clearCart(user.getUserId());
        
        session.setAttribute(SessionKeys.CART_NUM, 0);

        return "redirect:/market/cart/list";
    }


    @RequestMapping("del")
    @ResponseBody
    public ResultObject del(HttpServletRequest req, HttpSession session, Map<String, Object> map) {
        User user = Permission.check(session, UserRole.BUY, UserRole.CLIENT);
        // ��ţ�sid#gid^sid#gid ...
        String ids = req.getParameter("ids");
        logger.info("ɾ�����ﳵController-ids["+ids+"]");
        
        if (StringUtils.isEmpty(ids)) {
            logger.error("ɾ�����ﳵController-������Ч-ids["+ids+"]");
            return new ResultObject(ResultObject.FAIL, "������Ч");
        }

        String[] sep = ids.split("\\^");
        
        List<CartItem> items = new ArrayList<CartItem>();
        for (String s : sep) {
            CartItem i = new CartItem();
            String[] seg = s.split("#", 2);
            if (seg.length != 2 || !StringUtils.isNumeric(seg[0])) {
                logger.error("ɾ�����ﳵController-������Ч-ids["+ids+"]");
                return new ResultObject(ResultObject.FAIL, "������Ч");
            }
            
            i.setSupId(Integer.parseInt(seg[0]));
            i.setSupGoodsId(seg[1]);
            i.setUserId(user.getUserId());
            items.add(i);
        }
        
        cartService.deleteCartGoods(items);

        int cartNum = cartService.countGoodsNum(user.getUserId());
        session.setAttribute(SessionKeys.CART_NUM, cartNum);
        return new ResultObject(ResultObject.OK, cartNum);
    }
    

    @RequestMapping("num")
    @ResponseBody
    public ResultObject num(HttpServletRequest req, HttpSession session, Map<String, Object> map) {
        User user = Permission.check(session, UserRole.BUY, UserRole.CLIENT);
        // ��Ӧ�̱��
        String sid = req.getParameter("sid");
        // ��Ʒ���
        String gid = req.getParameter("gid");
        // ����
        String num = req.getParameter("num");
        // ��������
        String all = req.getParameter("all");
        logger.info("���¹��ﳵ��Ʒ����Controller-sid["+sid+"], gid["+gid+"], num["+num+"], all["+all+"]");
        
        if (!StringUtils.isNumeric(sid) || StringUtils.isEmpty(gid) || !StringUtils.isNumeric(num) || !StringUtils.isNumeric(all)) {
            logger.error("���¹��ﳵ��Ʒ����Controller-������Ч-sid["+sid+"], gid["+gid+"], num["+num+"]");
            return new ResultObject(ResultObject.FAIL, "������Ч");
        }

        CartItem item = new CartItem();
        item.setBuyNum(Integer.parseInt(num));
        item.setSupGoodsId(gid);
        item.setSupId(Integer.parseInt(sid));
        item.setUserId(user.getUserId());
        
        try {
            cartService.updateCartNum(item);
            //int cartNum = cartService.countGoodsNum(user.getUserId());
            session.setAttribute(SessionKeys.CART_NUM, Integer.parseInt(all));
            return new ResultObject(ResultObject.OK, "");
        } catch (ServiceException e) {
            return new ResultObject(ResultObject.FAIL, "���¹��ﳵ��Ʒʧ��");
        }
        
    }
    

    @RequestMapping("/store")
    public String store(HttpServletRequest req, HttpSession session) {
        User user = Permission.check(session, UserRole.BUY, UserRole.CLIENT);
        // ��Ӧ�̱��
        String sid = req.getParameter("sid");
        // ��Ʒ���
        String gid = req.getParameter("gid");
        // �Աȱ��
        String cid = req.getParameter("compareID");
        logger.info("�ԱȺ����ӹ��ﳵController-sid["+sid+"], gid["+gid+"], cid["+cid+"]");
        
        if (!StringUtils.isNumeric(sid) || StringUtils.isEmpty(gid)) {
            logger.error("�ԱȺ����ӹ��ﳵController-������Ч-sid["+sid+"], gid["+gid+"], cid["+cid+"]");
            throw new PageNotFoundException();
        }
        
        CartItem item = new CartItem();
        item.setBuyNum(1);
        item.setSupGoodsId(gid);
        item.setSupId(Integer.parseInt(sid));
        item.setUserId(user.getUserId());
        item.setCompareId(cid);
        
        cartService.addToCart(item);
        int cartNum = cartService.countGoodsNum(user.getUserId());
        session.setAttribute(SessionKeys.CART_NUM, cartNum);
        session.removeAttribute(SessionKeys.MARKET_COMPARE);
        return "redirect:/market/cart/list";
    }
}