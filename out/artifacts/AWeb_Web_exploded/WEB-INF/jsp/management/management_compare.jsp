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
<title>商品比对管理|中航采购网</title>
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
<div class="page-wrapper">
  <jsp:include page="header.jsp" />  
  <div id="contents">
  <input id="path" type="hidden" value="${pageContext.request.contextPath}">
    <div class="inner">
      <jsp:include page="left_menu.jsp">
		  <jsp:param name="menu" value="compare" />
	  </jsp:include>
      <div id="matter_section">
      <form id="managementCompareForm" action="/AWeb/management/compare" method="post">
      	<%-- <input type="hidden" id="supOneID" name="supOneID" value="${goodsToCampare.supOneID}"/>
      	<input type="hidden" id="supTwoID" name="supTwoID" value="${goodsToCampare.supTwoID}"/>
      	<input type="hidden" id="supThreeID" name="supThreeID" value="${goodsToCampare.supThreeID}"/>
      	<input type="hidden" id="supFourID" name="supFourID" value="${goodsToCampare.supFourID}"/>
      	<input type="hidden" id="supGoodsOneID" name="supGoodsOneID" value="${goodsToCampare.supGoodsOneID}"/>
      	<input type="hidden" id="supGoodsTwoID" name="supGoodsTwoID" value="${goodsToCampare.supGoodsTwoID}"/>
      	<input type="hidden" id="supGoodsThreeID" name="supGoodsThreeID" value="${goodsToCampare.supGoodsThreeID}"/>
      	<input type="hidden" id="supGoodsFourID" name="supGoodsFourID" value="${goodsToCampare.supGoodsFourID}"/>
      	<input type="hidden" id="returnUrl" name="returnUrl" value="${goodsToCampare.returnUrl}"/>
      	<input type="hidden" id="chooseGoodsIndex" name="chooseGoodsIndex"/>
      	<input type="hidden" id="ProCheckedReason" name="ProCheckedReason"/> --%>
      	<h2>商品比对管理</h2>
      	<div class="search_area section clearfix">
          <dl>
            <dt>商品比对日期</dt>
            <dd>
              <ul class="clearfix">
                <li>
                  <div class="input-group">
	                  <c:choose>
	                  	<c:when test="${empty productCompare.startTime}">
	                  	 	<input id="startTime" name="startTime" type="text" class="form-control special_input"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
		                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
	                  	</c:when>
	                  	<c:otherwise>
	                  		 <input id="startTime" name="startTime" value="${productCompare.startTime}" type="text" class="form-control special_input"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
		                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
	                  	</c:otherwise>
	                  </c:choose>
                  </div>
                </li>
                <li>至</li>
                <li>
                  <div class="input-group">
                  	<c:choose>
	                  	<c:when test="${empty productCompare.endTime}">
		                    <input id="endTime" name="endTime" type="text" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
		                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  		</c:when>
                  		<c:otherwise>
	                  		<input id="endTime" name="endTime"  value="${productCompare.endTime}" type="text" class="form-control special_input"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
		                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
	                  	</c:otherwise>
	                  </c:choose>
                  </div>
                </li>
              </ul>
            </dd>
          </dl>
          <dl>
            <dt>商品名称</dt>
            <dd>
	            <c:choose>
		            <c:when test="${empty productCompare.searchGoodsName}">
              			<input id="searchGoodsName" name="searchGoodsName" type="text" class="form-control">
            		</c:when>
                  	<c:otherwise>
                  		<input id="searchGoodsName" name="searchGoodsName" value="${productCompare.searchGoodsName}" type="text" class="form-control">
	                </c:otherwise>
	            </c:choose>
            </dd>
          </dl>
          <dl>
            <dt>供应商名称</dt>
            <dd>
            	<c:choose>
		            <c:when test="${empty productCompare.searchSupName}">
              			<input id="searchSupName" name="searchSupName" type="text" class="form-control">
            		</c:when>
                  	<c:otherwise>
                  		<input id="searchSupName" name="searchSupName" value="${productCompare.searchSupName}" type="text" class="form-control">
	                </c:otherwise>
	            </c:choose>
              
            </dd>
          </dl>
          <ul>
            <li><button type="button" class="btn btn-default red" onclick="search();">查询</button></li>
            <li><button type="button" class="btn btn-default gray" onclick="clear();">清空</button></li>
          </ul>
        <!--.search_area--></div>
        </form>
      	<div class="search_result">
          <table border="0">
            <tr>
              <th width="155">选购商品</th>
              <th width="590">比对商品</th>
              <th width="100">选择原因</th>
              <th width="100" class="last">操作</th>
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
              <td>
                <a href="javascript:void(0);" onclick="updateProductCompare('${productCompare.compareID}');">修改</a>
                <a href="javascript:void(0);" onclick="deleteProductCompare('${productCompare.compareID}');">删除</a>
                <c:if test="${!empty productCompare.linkOrderID}">
                	<a href="${pageContext.request.contextPath}/management/order?order_id=${productCompare.orderID}">查看订单</a>
                </c:if>
              </td>
            </tr>
            </c:forEach>
          </table>
        <!--.search_result--></div>
      	<!-- <div class="page">
          <ul class="pagination">
            <li><a href="#">&laquo;</a></li>
            <li><a href="#">1</a></li>
            <li><a href="#">2</a></li>
            <li class="active"><a href="#">3</a></li>
            <li>...</li>
            <li><a href="#">99</a></li>
            <li><a href="#">100</a></li>
            <li><a href="#">&raquo;</a></li>
          </ul>
        </div> -->
        <jsp:include page="page.jsp" />
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="footer.jsp"/>
<!--.page-wrapper--></div>

</body>
</html>