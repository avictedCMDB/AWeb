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
<title>��Ӧ�̹�������|�к��ɹ���</title>
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
              <p>�������ƣ�<span>${sessionScope.supUsernamecn}</span></p>
              <p>����ָ����<span class="red">(5)</span></p>
            </dd>
          </dl>
          <div class="remind_area">
            <ul class="clearfix">
              <li>
                <dl>
                  <dt>�˻�����</dt>
                  <dd><a href="${pageContext.request.contextPath}/supplier/return?refoundStatus=0">�����<span>��${empty supplier.confirmRefoundCount?"0":supplier.confirmRefoundCount}��</span></a></dd>
                  <dd><a href="${pageContext.request.contextPath}/supplier/return?refoundStatus=3">���ջ�<span>��${empty supplier.takeRefoundCount?"0":supplier.takeRefoundCount}��</span></a></dd>
                </dl>
              </li>
              <li>
                <dl>
                  <dt>��������</dt>
                  <dd><a href="${pageContext.request.contextPath}/supplier/exchange?exchangeStatus=0">�����<span>��${empty supplier.confirmExchangeCount?"0":supplier.confirmExchangeCount}��</span></a></dd>
                  <dd><a href="${pageContext.request.contextPath}/supplier/exchange?exchangeStatus=3">���ջ�<span>��${empty supplier.takeExchangeCount?"0":supplier.takeExchangeCount}��</span></a></dd>
                  <dd><a href="${pageContext.request.contextPath}/supplier/exchange?exchangeStatus=4">������<span>��${empty supplier.sendExchangeCount?"0":supplier.sendExchangeCount}��</span></a></dd>
                </dl>
              </li>
              <c:if test="${sessionScope.loginSupType == '1'}">
              <li>
                <dl>
                  <dt>ѯ������</dt>
                  <dd><a href="${pageContext.request.contextPath}/supplier/goodsEnquiry?enquiryStatus=0">������<span>��${empty supplier.enquiryCount?"0":supplier.enquiryCount}��</span></a></dd>
                </dl>
              </li>
              <li>
                <dl>
                  <dt>��������</dt>
                  <dd><a href="${pageContext.request.contextPath}/supplier/offStandRequire?status=0">���ṩ<span>��${empty supplier.standardCount?"0":supplier.standardCount}��</span></a></dd>
                </dl>
              </li>
              </c:if>
            </ul>
          </div>
        </div>
      	<div class="manage_photo"><img src="${pageContext.request.contextPath}/static/img/management/img-manage_photo.jpg" alt="��ӭʹ�� welcome to �к��в����ɹ���ƽ̨" /></div>
      	
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="footer.jsp" />
<!--.page-wrapper--></div>
</div>
</body>
</html>
