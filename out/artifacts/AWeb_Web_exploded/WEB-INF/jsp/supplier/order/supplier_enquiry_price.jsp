<%@ page language="java" contentType="text/html; charset=gbk"	pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>首页|中航招标网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/new_price.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierUtil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierEnquiry.js"></script>
</head>

<body>
<div id="vat_info">
  <div class="inner">
    <div class="add_title clearfix">最新报价</div>
    <div class="main_inner">
      <div class="up_area clearfix">
        <dl class="clearfix date_list">
              <dt>商品名称：</dt>
              <dd>
                  ${supplierGoodsEnquiry.goodsName}
              </dd>
            </dl>
            <dl class="clearfix date_list">
              <dt>规格型号：</dt>
              <dd>
               	${supplierGoodsEnquiry.goodsModel}
              </dd>
      	    </dl>
            <dl class="clearfix date_list">
              <dt>购买数量：</dt>
              <dd>
                ${supplierGoodsEnquiry.goodsNum}
              </dd>
      	    </dl>
            <dl class="clearfix date_list">
              <dt>商品价格：</dt>
              <dd>
                ${supplierGoodsEnquiry.goodsPriceBefore}
              </dd>
      	    </dl>
            <dl class="clearfix date_list">
              <dt>最新报价：</dt>
              <dd>
                <input type="text" class="form-control" id="goodsPriceAfter"/>
                <input type="hidden" id="goodsId" value="${supplierGoodsEnquiry.id}"/>
              </dd>
      	    </dl>
            
        </div>
      <div class="btn_list">
          <button class="btn btn-default blue" onclick="updateYesEnquiryStatus('${pageContext.request.contextPath}/supplier/goodsEnquiry/updateGoodsEnquiry')">保存</button>
          <button class="btn btn-default gray" onclick="window.close()">取消</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>