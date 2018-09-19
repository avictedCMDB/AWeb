<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>供应商管理中心|中航采购网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/supplier_common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/supplier.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
</head>

<body>
<div class="page-wrapper">
  <div id="header_top">
  <jsp:include page="header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    	
      <jsp:include page="menu.jsp" />
      <div id="matter_section">
      	<div class="company_info clearfix">
          <dl class="dl-horizontal clearfix">
          <c:if test="${sessionScope.loginSupType != '1'}">
          	<c:if test="${sessionScope.loginSupId == '1'}">
          		 <dt><img src="${pageContext.request.contextPath}/static/img/supplier/logo-shop.jpg" alt="" /></dt>
          	</c:if>
	          <c:if test="${sessionScope.loginSupId == '2'}">
	          	 <dt><img src="${pageContext.request.contextPath}/static/img/supplier/logo-shop_staples.gif" alt="" /></dt>
	          </c:if>
	          <c:if test="${sessionScope.loginSupId == '4'}">
	          	 <dt><img src="${pageContext.request.contextPath}/static/img/supplier/logo-shop02.gif" alt="" /></dt>
	          </c:if>
          </c:if>
          <c:if test="${sessionScope.loginSupType == '1'}">
          	<dt>
          		<c:if test="${supplier.supImage == null}">
                  	<img src="${pageContext.request.contextPath}/static/img/supplier/img-profession.jpg" width="120px" height="120px"/>
                </c:if>
                <c:if test="${supplier.supImage != null}">
                    <img src="${pageContext.request.contextPath}${supplier.supImage}" width="120px" height="120px"/>
                </c:if>
          	</dt>
          </c:if>
            <dd>
              <p>店铺名称：<span>${sessionScope.supUsernamecn}</span></p>
              <p>诚信指数：<span class="red">(5)</span></p>
            </dd>
          </dl>
          <div class="remind_area">
            <ul class="clearfix">
              <li>
                <dl>
                  <dt>退货提醒</dt>
                  <dd><a href="${pageContext.request.contextPath}/supplier/return?refoundStatus=0">待审核<span>（${empty supplier.confirmRefoundCount?"0":supplier.confirmRefoundCount}）</span></a></dd>
                  <dd><a href="${pageContext.request.contextPath}/supplier/return?refoundStatus=3">待收货<span>（${empty supplier.takeRefoundCount?"0":supplier.takeRefoundCount}）</span></a></dd>
                </dl>
              </li>
              <li>
                <dl>
                  <dt>换货提醒</dt>
                  <dd><a href="${pageContext.request.contextPath}/supplier/exchange?exchangeStatus=0">待审核<span>（${empty supplier.confirmExchangeCount?"0":supplier.confirmExchangeCount}）</span></a></dd>
                  <dd><a href="${pageContext.request.contextPath}/supplier/exchange?exchangeStatus=3">待收货<span>（${empty supplier.takeExchangeCount?"0":supplier.takeExchangeCount}）</span></a></dd>
                  <dd><a href="${pageContext.request.contextPath}/supplier/exchange?exchangeStatus=4">待发货<span>（${empty supplier.sendExchangeCount?"0":supplier.sendExchangeCount}）</span></a></dd>
                </dl>
              </li>
              <c:if test="${sessionScope.loginSupType == '1'}">
              <li>
                <dl>
                  <dt>询价提醒</dt>
                  <dd><a href="${pageContext.request.contextPath}/supplier/goodsEnquiry?enquiryStatus=0">待报价<span>（${empty supplier.enquiryCount?"0":supplier.enquiryCount}）</span></a></dd>
                </dl>
              </li>
              <li>
                <dl>
                  <dt>需求提醒</dt>
                  <dd><a href="${pageContext.request.contextPath}/supplier/offStandRequire?status=0">待提供<span>（${empty supplier.standardCount?"0":supplier.standardCount}）</span></a></dd>
                </dl>
              </li>
              </c:if>
            </ul>
          </div>
        </div>
      	<div class="manage_photo"><img src="${pageContext.request.contextPath}/static/img/management/img-manage_photo.jpg" alt="欢迎使用 welcome to 中航招采网采购人平台" /></div>
      	
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="footer.jsp" />
<!--.page-wrapper--></div>
</div>
</body>
</html>
