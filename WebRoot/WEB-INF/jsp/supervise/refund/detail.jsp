<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../meta.jsp" >
	<jsp:param value="退货单查看" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/supervise_return.css" rel="stylesheet">
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
	  <h2>退货单查看</h2>
      <h3 class="title_h3">退货单基本信息</h3>
      <div class="info_detail">
        <div class="txt_area">
          <div class="section_info">
            <label>订单编号：</label>
            <span>${refund.orderId }</span>
            <label>采购单位名称：</label>
            <span>${refund.companyName }</span>
            <label>采购人联系人：</label>
            <span>${refund.addrName }</span>
            <label>采购人联系电话：</label>
            <span>${empty refund.addrPhone ? refund.addrTel : refund.addrPhone }</span>
            <label>退货单编号：</label>
            <span>${refund.refundId }</span>
            <label>退货总数量：</label>
            <span>${refund.refundAmount }</span>
            <label>退货总金额：</label>
              <c:if test="${t == '1'}">
            <span><fmt:formatNumber value="${refund.refundPriceInit}" pattern="#0.00#"></fmt:formatNumber></span>
              </c:if>
              <c:if test="${t != '1'}">
            <span><fmt:formatNumber value="${refund.refundPrice}" pattern="#0.00#"></fmt:formatNumber></span>
              </c:if>
          </div>
          <div class="section_info">
            <label>备注：</label>
            <span>${refund.remark }</span>
          </div>
          <div class="section_info">
            <label>附件：</label>
            <span></span>
          </div>
          
        </div>
      </div>
      <h3 class="title_h3">退货单明细</h3>
      <div class="search_result">
        <table class="details">
          <tr>
            <th width="40">序号</th>
            <th colspan="2">商品信息</th>
            <th width="100">单价(元)</th>
            <th width="100">退货数量</th>
            <th width="100">退换金额(元)</th>
            <th width="200" class="last">退货原因</th>
          </tr>
          <c:forEach var="item" varStatus="sta" items="${goods}">
          <tr>
            <td>${sta.index + 1}</td>
            <td width="77" class="right_none"><p class="img_pro"><a href="${pageContext.request.contextPath}/supervise/order/goods?gid=${item.supGoodsId}&sid=${item.supId}">
            <c:if test="${item.supType == 1}">
               <img width="55px" height="55px" src="${pageContext.request.contextPath}${item.imagePath == null ? '/static/img/img-profession.jpg' : item.imagePath}">
			</c:if>
			<c:if test="${item.supType == 0}">
               <img width="55px" height="55px" src="${item.imagePath}">
			</c:if>
            </a></p></td>
            <td class="left_none"><a href="${pageContext.request.contextPath}/supervise/order/goods?gid=${item.supGoodsId}&sid=${item.supId}&t=${t}">${item.goodsName }</a></td>
              <c:if test="${t == '1'}">
            <td class="price"><fmt:formatNumber value="${item.goodsPriceInit}" pattern="#0.00#"></fmt:formatNumber></td>
              </c:if>
              <c:if test="${t != '1'}">
            <td class="price"><fmt:formatNumber value="${item.goodsPrice}" pattern="#0.00#"></fmt:formatNumber></td>
              </c:if>
            <td>${item.refundNum }</td>
              <c:if test="${t == '1'}">
            <td class="price"><fmt:formatNumber value="${item.refundNum * item.goodsPriceInit}" pattern="#0.00#"></fmt:formatNumber></td>
              </c:if>
              <c:if test="${t != '1'}">
            <td class="price"><fmt:formatNumber value="${item.refundNum * item.goodsPrice}" pattern="#0.00#"></fmt:formatNumber></td>
              </c:if>
            <td></td>
          </tr>
          </c:forEach>
        </table>
      </div>
      <div class="btn_area"><button type="button" class="btn btn-default gray" onclick="history.go(-1);">关闭</button></div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>
