<%@ page language="java" contentType="text/html; charset=gbk"	pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>供应商管理中心|中航采购网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_delivery.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierOrderExchange.js"></script>
</head>

<body>
<div class="page-wrapper">
<jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    <form id="exchaneSendForm" method="post">
      <div class="order_section">
        <h2>发货单</h2>
          <h3>供应商基本信息</h3>
          <div class="info_detail">
            <div class="txt_area">
              <label>换货单号：</label>
              <span>${supplierExchangeDetailed.exchangeId}</span>
              <label>订单编号：</label>
              <span>${supplierExchangeDetailed.orderId}</span>
              <label>供应商名称：</label>
              <span>${sessionScope.supUsernamecn}</span>
              <label>联系人：</label>
              <span>${supplierExchangeDetailed.addrName}</span>
              <label>联系电话：</label>
              <span>${supplierExchangeDetailed.addrPhone}</span>
            </div>
            <div class="form-group clearfix">
              <label>备注：</label>
              <textarea class="form-control" rows="3" name="supRemark"></textarea>
            </div>
          </div>
          <h3>发货商品信息</h3>
          <div class="search_result">
            <table class="details">
              <tr>
              	<th width="100">序号</th>
                <th colspan="2">商品信息</th>
                <th width="100">单价</th>
                <th width="100">换货数量</th>
                <th width="100">退换金额</th>
                <th width="100">换货原因</th>
                <th class="last" width="100">操作</th>
              </tr>
              <c:forEach var="supplierExchange" items="${supplierExchangeList}" varStatus="status">
          <tr>
	          <td>${supplierExchange.rn}</td>
	          <td width="77" class="right_none"><p class="img_pro"><a href="#"><img src="${supplierExchange.imagePath}" width="44px" height="44px"/></a></p></td>
	          <td class="left_none"><a href="#">${supplierExchange.goodsName}</a></td>
	          <td class="price">${supplierExchange.agreePrice}</td>
	          <td>${supplierExchange.exchangeNum}</td>
	          <td class="price">${supplierExchange.sumChangePrice}</td>
	          <td>${supplierExchange.exchangeReason}</td>
	          <td><a href="${pageContext.request.contextPath}/supplier/goodsInfo/queryDetailed/${supplierExchange.supGoodsId}" target="_blank">查看</a></td>
          </tr>
        </c:forEach>
            </table>
          </div>
          <h3>物流信息</h3>
          <dl class="dl-horizontal">
            <dt>物流信息：</dt>
            <dd>${supplierExchangeDetailed.addrAll}</dd>
          </dl>
          <div class="info_list clearfix">
          	<dl class="dl-horizontal">
              <dt>快递类别：</dt>
              <dd><label>
	              <input type="radio" name="optionsRadios" value="0" checked onchange="exchangeExpress()"/> 自营快递
	        </label>
	        <label>
	              <input type="radio" name="optionsRadios" value="1" onchange="exchangeExpress()"/> 第三方快递
	        </label></dd>
            </dl>
          </div>
          <div class="info_list clearfix" id="expressDiv" style="display:none">
            <dl class="dl-horizontal">
              <dt><span>*</span>快递公司：</dt>
              <dd><input class="form-control" type="text" name="exchangeExpressNameSupOther"/></dd>
            </dl>
            <dl class="dl-horizontal">
              <dt><span>*</span>快递编号：</dt>
              <dd><input class="form-control" type="text" name="exchangeExpressCodeSupOther"/></dd>
            </dl>  
            <div class="btn_add">
            <!--   <button type="button" class="btn btn-default red" onclick="addExpress()">增加</button> -->
            </div>
          </div>
	      <div class="btn_area">
            <ul class="clearfix">
              <li><button type="button" class="btn btn-default red" onclick="exchaneGoodsSend('${pageContext.request.contextPath}/supplier/exchange/exchaneGoodsSend/${exchangeId}')">提交</button></li>
              <li><button type="button" class="btn btn-default gray" onclick="history.go(-1)">返回</button></li>
            </ul>
          </div>
	    	<!--.order_section-->	
      </div>
      <input type="hidden" name="exchangeExpressCodeSup" id="exchangeExpressCodeSup"/>
      <input type="hidden" name="exchangeExpressNameSup" id="exchangeExpressNameSup"/>
      </form>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>