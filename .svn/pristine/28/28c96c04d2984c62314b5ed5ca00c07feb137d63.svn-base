<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>商品比对</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management_campare.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/compare.js"></script>
</head>
<body>
<!-- <div class="page-wrapper"> -->
  <div id="contents">
  <input id="path" type="hidden" value="${pageContext.request.contextPath}">
    <!-- <div class="inner"> -->
      <div id="matter_section">
      	<!-- <h2>商品比对查看</h2> -->
      	<div class="search_result">
          <table border="0">
            <tr>
              <th width="155">选购商品</th>
              <th width="590">比对商品</th>
              <th width="100">选择原因</th>
            </tr>
            <c:forEach var="productCompare" items="${productCompares}" varStatus="status">
            <tr>
              <td>
                <p class="img_pro"><img src="${productCompare.imagePath}" width="120" height="100"/></p>
                <p class="pro_name">${productCompare.goodsName}</p>
                <p class="price">￥${productCompare.agreePrice}</p>
              </td>
              <td>
                <ul class="clearfix">
                	<c:if test="${!empty productCompare.supGoodsOneID}">
	                  <li>
	                    <p class="img_pro"><img src="${productCompare.supGoodsOneImagePath}" width="120" height="100"/></p>
	                    <p class="pro_name">${productCompare.supGoodsOneGoodsName}</p>
	                    <p class="price">￥${productCompare.supGoodsOneAgreePrice}</p>
	                  </li>
                  </c:if>
                  <c:if test="${!empty productCompare.supGoodsTwoID}">
	                  <li>
	                    <p class="img_pro"><img src="${productCompare.supGoodsTwoImagePath}" width="120" height="100"/></p>
	                    <p class="pro_name">${productCompare.supGoodsTwoGoodsName}</p>
	                    <p class="price">￥${productCompare.supGoodsTwoAgreePrice}</p>
	                  </li>
                  </c:if>
                  <c:if test="${!empty productCompare.supGoodsThreeID}">
	                  <li>
	                    <p class="img_pro"><img src="${productCompare.supGoodsThreeImagePath}" width="120" height="100"/></p>
	                    <p class="pro_name">${productCompare.supGoodsThreeGoodsName}</p>
	                    <p class="price">￥${productCompare.supGoodsThreeAgreePrice}</p>
	                  </li>
                  </c:if>
                  <c:if test="${!empty productCompare.supGoodsFourID}">
	                  <li>
	                    <p class="img_pro"><img src="${productCompare.supGoodsFourImagePath}" width="120" height="100"/></p>
	                    <p class="pro_name">${productCompare.supGoodsFourGoodsName}</p>
	                    <p class="price">￥${productCompare.supGoodsFourAgreePrice}</p>
	                  </li>
                  </c:if>
                </ul>
              </td>
              <td>
              	<c:if test="${productCompare.reasonText.size()>0}">
              		<c:forEach var="reason" items="${productCompare.reasonText}" varStatus="status">
              			${reason}<br/>
              		</c:forEach>
              	</c:if>
              </td>
            </tr>
            </c:forEach>
          </table>
        <!--.search_result--></div>
        <jsp:include page="../page.jsp" />
      <!--#matter_section-->	
      </div>
    <!--.inner--><!-- </div> -->
  <!--#contents--></div>
<!--.page-wrapper--><!-- </div> -->

</body>
</html>