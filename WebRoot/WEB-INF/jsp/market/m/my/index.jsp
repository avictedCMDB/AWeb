<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<jsp:include page="../head.jsp">
	<jsp:param value="我的" name="title"/>
</jsp:include>
<style type="text/css">
.item.active p{
	color: #067cca!important;
}
.order-item{
	border-bottom: 1px solid #eee;
}
body.my .tab .item[data-count]:after{
	content: attr(data-count);
    display: block;
    width: 14px;
    height: 14px;
    line-height: 14px;
    background-color: #f00;
    border-radius: 7px;
    font-size: 12px;
    color: #fff;
    position: absolute;
    right: 26px;
    top: 4px;
}
.logout{
	color: #fff;
	position: absolute;
	right: 0;
	top: 0;
	z-index: 10;
	padding: 10px;
}

.prod-info p{
    overflow: hidden;
    word-break: break-all;
    -webkit-line-clamp: 3;
    line-clamp: 3;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    line-height: 20px;
}
</style>
<body class="my include-footer">

<div id="app">
	<a class="logout" onclick="location.href = '${pageContext.request.contextPath}/passport/login/logout';">退出</a>
	<div class="user">
	    <img class="head" src="${pageContext.request.contextPath}/static/image/my-head.png">
	    <p class="name">账户管理</p>
	</div>
	
	<div class="tab margin-top-10">
	    <div data-status="1" onclick="location.href = '${pageContext.request.contextPath}/management/order?order_status=-1';" class="item<c:if test="${order_query.order_status == '1'}"> active</c:if>" data-count=''>
	        <a class="unpaid"></a>
	        <p>待支付</p>
	    </div>
	    <div data-status="2" onclick="location.href = '${pageContext.request.contextPath}/management/order?order_status=-2';" class="item<c:if test="${order_query.order_status == '2'}"> active</c:if>" data-count=''>
	        <a class="receiving"></a>
	        <p>待收货</p>
	    </div>
	    <div class="item">
	        <a class="address" onclick="location.href = '${pageContext.request.contextPath}/management/specialGoods/offStandardRequirePage';"></a>
	        <p>需求管理</p>
	    </div>
	    <div class="item" onclick="location.href = '${pageContext.request.contextPath}/management/order';">
	        <a class="order"></a>
	        <p>全部订单</p>
	    </div>
	</div>
	
		<c:if test="${empty ordersList}">
			<p style="font-size: 30px; text-align: center; padding-top: 10px; color: #999;">暂无订单</p>
		</c:if>
	<div class="order-list margin-top-10">
		<c:forEach var="item" items="${ordersList}" varStatus="s">
			<div class="order-item">
		        <div class="prod-img">
		            <img src="${item.image_path}"/>
		        </div>
		        <div class="prod-info">
		            <p>${item.goods_name}</p>
		            <a class="p">￥${item.goods_price}</a>
		        </div>
		        <div class="op">
		            操作
		        </div>
		    </div>
		</c:forEach>
	</div>
	<div style="height: 50px; width: 1px; opacity: 0;"></div>
<jsp:include page="../foot.jsp">
	<jsp:param value="我的" name="tab"/>
</jsp:include>
</div>

<script type="text/javascript">
var app = new Vue({
	el	: '#app',
	data: {
		cartCount	: 0
	}
});
$('.op').click(function () {
	alert('请在PC端操作！');
});

$(function () {
	$.post('${pageContext.request.contextPath}/market/my/get_cart_count', function (res) {
		if (res && res.status == 0) {
			app.cartCount = res.result;
		}
	});
	$.post('${pageContext.request.contextPath}/management/order/get_order_count_by_status', {status : 1}, function (res) {
		if (res && res.status == 0) {
			if (res.result == 0) {
				$('[data-status="1"]').removeAttr('data-count');
			} else {
				$('[data-status="1"]').attr('data-count', res.result);
			}
		}
	});
	$.post('${pageContext.request.contextPath}/management/order/get_order_count_by_status', {status : 2}, function (res) {
		if (res && res.status == 0) {
			if (res.result == 0) {
				$('[data-status="2"]').removeAttr('data-count');
			} else {
				$('[data-status="2"]').attr('data-count', res.result);
			}
		}
	});
});
</script>
</body>
</html>