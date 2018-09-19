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
<title>供应商管理中心|中航招标网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supervise_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supervise.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    	<h2>结算单基本信息</h2>
    	<h3 class="title_h3">结算单基本信息</h3>
        <div class="info_detail">
          <div class="txt_area">
            <div class="section_info">
              <label>结算单编号：</label>
              <span>${supplierStatement.settleId}</span>
              <label>供应商：</label>
              <span>${sessionScope.supUsernamecn}</span>
              <label>结算金额：</label>
              <span>${supplierStatement.settleAmount}元</span>
              <label>结算周期：</label>
              <span>${supplierStatement.dateStart}至${supplierStatement.dateEnd}</span>
            </div>
            
          </div>
      </div>
      <h3 class="title_h3">商品明细信息</h3>
      <div class="search_result">
        <table class="details">
          <tr>
            <th width="120">业务编号</th>
            <th width="120">业务类型</th>
            <th width="120">下单日期</th>
            <th>采购单位</th>
            <th width="90">总数量</th>
            <th width="90">总金额</th>
          </tr>
          <c:forEach var="supplierStatementDetailed" items="${supplierStatementDetailedList}" varStatus="status">
				<tr>
	              <td>
	              <c:choose>
	              <c:when test="${supplierStatementDetailed.busiType == '1'}">  
					        <a href="${pageContext.request.contextPath}/supplier/order/detail?o=${supplierStatementDetailed.busiId}">${supplierStatementDetailed.busiId}</a>
					   </c:when>
					   <c:otherwise> 
					    	<a href="${pageContext.request.contextPath}/supplier/return/returnDetailedPage/${supplierStatementDetailed.busiId}">${supplierStatementDetailed.busiId}</a>
					   </c:otherwise>
					   </c:choose>
	              </td>
	             <c:choose>
					   <c:when test="${supplierStatementDetailed.busiType == '1'}">  
					        <td>订单</td>
					   </c:when>
					   <c:otherwise> 
					    	<td>退款</td>
					   </c:otherwise>
				  </c:choose>
	              <td>${supplierStatementDetailed.createTime}</td>
	              <td>${supplierStatementDetailed.companyName}</td>
	              <td>${supplierStatementDetailed.totalNum}</td>
	              <td><c:choose>
					   <c:when test="${supplierStatementDetailed.busiType == '1'}">  
					        
					   </c:when>
					   <c:otherwise> 
					    	-
					   </c:otherwise>
				  </c:choose>
	              ${supplierStatementDetailed.settleAmount}</td>
	            </tr>
			</c:forEach>
        </table>
        <p class="sum">结算总金额：<span>${supplierStatement.settleAmount}元</span></p>
        <div class="btn_area"><button type="button" class="btn btn-default red" onclick="history.go(-1)">返回</button></div>
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>
