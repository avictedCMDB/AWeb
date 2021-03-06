<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>待办事项|中航采购网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
</head>
<body>
<div class="page-wrapper">
 <jsp:include page="header.jsp" />  
  <div id="contents">
    <div class="inner">
      <jsp:include page="left_menu.jsp">
		  <jsp:param name="menu" value="" />
	  </jsp:include>
      <div id="matter_section">
      	<h2>待办事项</h2>
      	<div class="remind_area">
      		<ul>
      		    <c:forEach  var="menu" items="${sessionScope.login_user.menus}" varStatus="status">
      		    	<c:forEach  var="childMenu" items="${menu.childMenus}" varStatus="status">
      		    		<c:if test="${childMenu.href == '/management/order'}">
      		    		<li>
		      				<dl>
		      					<dt>订单提醒</dt>
		      					<dd><a href="${pageContext.request.contextPath}/management/order?order_status=2">待收货<span>（${management.waitOrderCount}）</span></a></dd>
		      					<dd><a href="${pageContext.request.contextPath}/management/order?order_status=15">待支付<span>（${management.waitPayOrderCount}）</span></a></dd>
		      				</dl>
		      			</li>
      		    		</c:if>
      		    		<c:if test="${childMenu.href == '/management/refound'}">
	      		    		<li class="reeturns_list">
			      				<dl>
			      					<dt>退货提醒</dt>
			      					<dd><a href="${pageContext.request.contextPath}/management/refound?searchRefoundStatus=1">待发货<span>（${management.returnOrderCount}）</span></a></dd>
			      					<dd><a href="${pageContext.request.contextPath}/management/refound?searchRefoundStatus=2">已退回<span>（${management.rejectRefoundCount}）</span></a></dd>
			      				</dl>
			      			</li>
      		    		</c:if>
      		    		<c:if test="${childMenu.href == '/management/exchange'}">
	      		    		<li>
			      				<dl>
			      					<dt>换货提醒</dt>
			      					<dd><a href="${pageContext.request.contextPath}/management/exchange?searchExchangeStatus=1">待发货<span>（${management.changeOrderCount}）</span></a></dd>
			      					<dd><a href="${pageContext.request.contextPath}/management/exchange?searchExchangeStatus=2">已退回<span>（${management.rejectExchangeCount}）</span></a></dd>
			      				</dl>
			      			</li>
      		    		</c:if>
      		    		
      		    		<c:if test="${childMenu.href == '/management/enterprise'}">
	      		    		<li>
			      				<dl>
			      					<dt>询价提醒</dt>
			      					<dd><a href="${pageContext.request.contextPath}/management/enterprise?enquiryStatus=1">已报价<span>（${management.enquiryGoodsCount}）</span></a></dd>
			      				</dl>
			      			</li>
      		    		</c:if>
      		    		
      		    		<c:if test="${childMenu.href == '/management/specialGoods/offStandardRequirePages'}">
	      		    		<li>
			      				<dl>
			      					<dt>需求提醒</dt>
			      					<dd><a href="${pageContext.request.contextPath}/management/specialGoods/offStandardRequirePage?status=1">已提供<span>（${management.offStandardRequireCount}）</span></a></dd>
			      				</dl>
			      			</li>
      		    		</c:if>
      		    		
      		    		<c:if test="${childMenu.href == '/management/audit/auditorAudit'}">
	      		    		<li>
			      				<dl>
			      					<dt>订单审核提醒</dt>
			      					<dd><a href="${pageContext.request.contextPath}/management/audit/auditorAudit">待审核<span>（${management.checkOrderCount}）</span></a></dd>
			      				</dl>
			      			</li>
      		    		</c:if>
      		    		<c:if test="${childMenu.href == '/management/finance/list'}">
	      		    		<li>
			      				<dl>
			      					<dt>订单支付提醒</dt>
			      					<dd><a href="${pageContext.request.contextPath}/management/finance/list">待支付<span>（${management.waitPayOrderCountB2B}）</span></a></dd>
			      				</dl>
			      			</li>
      		    		</c:if>      		    		
      		    	</c:forEach>
      		    </c:forEach>
      		</ul>
      	</div>
      	
      	<div class="manage_photo"><img src="${pageContext.request.contextPath}/static/img/management/img-manage_photo.jpg" alt="欢迎使用 welcome to 中航招采网采购人平台" /></div>
      	
      <!--#matter_section-->	
      </div>
      
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>