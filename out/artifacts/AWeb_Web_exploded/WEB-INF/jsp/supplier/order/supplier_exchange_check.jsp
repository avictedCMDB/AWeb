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
<link href="${pageContext.request.contextPath}/static/css/supplier_exchange.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierUtil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierOrderExchange.js"></script>
<link href="${pageContext.request.contextPath}/static/css/imgbox.css" rel="stylesheet">

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.imgbox.pack.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	<c:forEach var="image" items="${imageList}" varStatus="status">
		$("#img_${status.index}").imgbox();
	</c:forEach>

	});
</script>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  <div id="contents">
    <div class="inner">
	  <h2>换货查看</h2>
	  <div id="step"> 
	    	<ul class="image_list clearfix">
	    		<li class="selected"><img src="${pageContext.request.contextPath}/static/img/management/img-selected.png" /></li>
          <c:if test="${supplierExchangeDetailed.exchangeStatus >= '1' and supplierExchangeDetailed.exchangeStatus != '7'}"> <li class="selected"><img src="${pageContext.request.contextPath}/static/img/management/img-selected.png" alt="2"/></li> </c:if>
          <c:if test="${supplierExchangeDetailed.exchangeStatus < '1' or supplierExchangeDetailed.exchangeStatus == '7'}"> <li>2</li> </c:if>
          <c:if test="${supplierExchangeDetailed.exchangeStatus >= '4' and supplierExchangeDetailed.exchangeStatus != '7'}"> <li class="selected"><img src="${pageContext.request.contextPath}/static/img/management/img-selected.png" alt="2"/></li> </c:if>
          <c:if test="${supplierExchangeDetailed.exchangeStatus < '4' or supplierExchangeDetailed.exchangeStatus == '7'}"> <li>3</li> </c:if>
          <c:if test="${supplierExchangeDetailed.exchangeStatus >= '5' and supplierExchangeDetailed.exchangeStatus != '7'}"> <li class="selected"><img src="${pageContext.request.contextPath}/static/img/management/img-selected.png" alt="2"/></li> </c:if>
          <c:if test="${supplierExchangeDetailed.exchangeStatus < '5' or supplierExchangeDetailed.exchangeStatus == '7'}"> <li>4</li> </c:if>
          <c:if test="${supplierExchangeDetailed.exchangeStatus >= '6' and supplierExchangeDetailed.exchangeStatus != '7'}"> <li class="selected"><img src="${pageContext.request.contextPath}/static/img/management/img-selected.png" alt="2"/></li> </c:if>
          <c:if test="${supplierExchangeDetailed.exchangeStatus < '6' or supplierExchangeDetailed.exchangeStatus == '7'}"> <li>5</li> </c:if>
	    	</ul>
	    	
	    	<ul class="text_step clearfix">
	    		<li>采购人申请换货</li>
	    		<li>供应商审核通过</li>
	    		<li>供应商已收货</li>
	    		<li>采购方待收货</li>
                <li>采购方收货完成</li>
	    	</ul>	      
	    	<!--.replace_step-->	
      </div>
      <h3>换货单基本信息</h3>
      <div class="info_detail">
        <div class="txt_area">
          <label>换货单编号：</label>
          <span>${supplierExchangeDetailed.exchangeId}</span>
          <label>采购单位：</label>
          <span>${supplierExchangeDetailed.companyname}</span>
          <label>订单编号：</label>
          <span>${supplierExchangeDetailed.orderId}</span>
          <label>联系人：</label>
          <span>${supplierExchangeDetailed.addrName}</span>
          <label>联系电话：</label>
          <span>${supplierExchangeDetailed.addrPhone}</span>
          <label>快递公司名称：</label>
          <span>${supplierExchangeDetailed.exchangeExpressName}</span>
          <label>快递单号：</label>
          <span>${supplierExchangeDetailed.exchangeExpressCode}</span>
        </div>
        <div class="section_info">
          <label>备注：</label>
          <span>${supplierExchangeDetailed.remark}</span>
        </div>
        <div class="section_info">
          <label>附件：</label>
          <span class="up_load_img">
          	<c:forEach var="image" items="${imageList}" varStatus="status">
          		<a id="img_${status.index}" href="${pageContext.request.contextPath}${image.url}"><img src="${pageContext.request.contextPath}${image.url}" width="80px" height="80px"/></a>
          	</c:forEach>
          	</span>
        </div>
      </div>
      <h3>换货单明细信息</h3>
      <div class="search_result">
        <table class="details">
          <tr>
            <th width="40">序号</th>
            <th colspan="2">商品信息</th>
            <th width="80">单价(元)</th>
            <th width="80">采购数量</th>
            <th width="80">换货数量</th>
            <th width="80">总金额(元)</th>
            <th width="180" class="last">换货原因</th>
          </tr>
          <c:forEach var="supplierExchange" items="${supplierExchangeList}" varStatus="status">
          <tr>
	          <td>${supplierExchange.rn}</td>
	          <td width="77" class="right_none"><p class="img_pro"><a href="#"><img src="${supplierExchange.imagePath}" width="44px" height="44px"/></a></p></td>
	          <td class="left_none"><a href="${pageContext.request.contextPath}/supplier/goodsInfo/queryDetailed/${supplierExchange.supGoodsId}" target="_blank">${supplierExchange.goodsName}</a></td>
	          <td class="price"><fmt:formatNumber value="${supplierExchange.agreePrice}" pattern="#0.00#"/></td>
	          <td>${supplierExchange.buyNum}</td>
	          <td>${supplierExchange.exchangeNum}</td>
	          <td class="price"><fmt:formatNumber value="${supplierExchange.sumChangePrice}" pattern="#0.00#"/></td>
	          <td>${supplierExchange.exchangeReason}</td>
          </tr>
        </c:forEach>
        </table>
      </div>
      <div class="btn_area"><button type="button" class="btn btn-default gray" onclick="history.go(-1)">返回</button></div>
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>
