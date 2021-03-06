<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.List" %>
<%@ page import="com.avic.management.models.Order" %>
<%@ page import="java.lang.Integer" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.avic.passport.models.User" %>
<%@ page import="com.avic.common.constants.SessionKeys" %>
<%@ page import="com.avic.common.constants.UserRole" %>

<html>
<jsp:include page="../head.jsp">
	<jsp:param value="我的订单" name="title"/>
</jsp:include>
<style type="text/css">
.on{
	padding: 5px;
	background-color: #fff;
	font-size: 12px;
	position: relative;
	text-align: center;
	display: none;
}
.on.show{
	display: block;
}
.on:after{
	z-index: 2;
    content: ' ';
    width: 100%;
    height: 1px;
    background-color: #ccc;
    bottom: -1px;
    left: 0;
    position: absolute;
    -webkit-transform-origin: 0 0;
    transform-origin: 0 0;
    -webkit-transform: scaleY(0.5);
    transform: scaleY(0.5);
}
body.order .order-wrapper .order-list .item .hd:after{
	bottom: 0;
}
body.order .tab:after{
 	display: none;
}
</style>
<body class="order">
<div id="app">
    <div class="header">
        <i class="iconfont back" onclick="location.href = '${pageContext.request.contextPath}/management/order?order_status=-1';">&#xe615;</i>
        <span>我的订单</span>
    </div>
    <div class="tab">
        <div class="item<c:if test='${order_query.order_status == "99" or empty order_query.order_status}'> active</c:if>" onclick="location.href = '${pageContext.request.contextPath}/management/order?order_status=99';">
            <a>全部</a>
        </div>
        <div class="item<c:if test='${order_query.order_status == "1"}'> active</c:if>" onclick="location.href = '${pageContext.request.contextPath}/management/order?order_status=1';">
            <a>待审核</a>
        </div>
        <div class="item<c:if test='${order_query.order_status == "2"}'> active</c:if>" onclick="location.href = '${pageContext.request.contextPath}/management/order?order_status=2';">
            <a>待收货</a>
        </div>
    </div>

    <div class="order-wrapper">
        <div class="order-list" id="order-list">
        	<c:set var="oid" value="0"/>
        	<c:set var="total" value="0"/>
        	<c:if test="${empty ordersList}">
        		<p style="font-size: 30px; color: #999; text-align: center; padding-top: 20px;">暂无订单</p>
        	</c:if>
        	
        	<c:forEach var="item" items="${ordersList}" varStatus="s">
        		<c:if test="${oid != item.order_id}">
        			<c:if test="${!s.first}">
			                    <div class="stat">
			                        <p class="price">合计:<span>￥${total}</span></p>
		                        <c:set var="total" value="0"/>
				                    <c:if test="${item.order_status == '1' or item.order_status == '15'}">
				                    	<p class="buttons">
				                            <a class="b pay">去支付</a>
				                        </p>
				                    </c:if>
				                    <c:if test="${item.order_status == '3'}">
			                        	<p class="buttons">
				                            <a class="b pay" data-rec="${item.order_id}">确认收货</a>
				                        </p>
			                        </c:if>
			                    </div>
			
			                </div>
			            </div>
        			</c:if>
	        		<div class="item">
	                <div class="hd">
	                    <a>供应商：${item.sup_name} </a>
	                    <p class="op">
	                        <a class="o" data-id="${item.order_id}">订单号</a>
	                        <a class="s">${item.order_status_name}</a>
	                    </p>
	                </div>
	                <p class="on" id="o_${item.order_id}">${item.order_id}</p>
	                <div class="pl">
        		</c:if>
        		<c:set var="oid" value="${item.order_id}"/>
                <div class="p">
                    <div class="i">
                        <img src="${item.image_path}" />
                    </div>
                    <div class="w">
                        <p class="n">${item.goods_name}</p>
                        <p class="m">
                            <a>￥${item.goods_price}</a>
                            <a class="c">x${item.buy_num}</a>
                        </p>
                        <c:set var="total" value="${total + item.buy_num * item.goods_price}"/>
                    </div>
                </div>
                <c:if test="${s.last}">
		                    <div class="stat">
		                        <p class="price">合计:<span>￥${total}</span></p>
		                        <c:set var="total" value="0"/>
                				<c:if test="${item.order_status == '1' or item.order_status == '15'}">
		                        	<p class="buttons">
			                            <a class="b pay">去支付</a>
			                        </p>
		                        </c:if>
		                        <c:if test="${item.order_status == '3'}">
		                        	<p class="buttons">
			                            <a class="b pay" data-rec="${item.order_id}">确认收货</a>
			                        </p>
		                        </c:if>
		                    </div>
		
		                </div>
		            </div>
       			</c:if>
        	</c:forEach>
        </div>
    </div>

</div>


<script type="text/javascript">
var hasMore = ${pages == 1 ? 'false' : 'true'}, page = 1;
$(function () {
	$(document).on('click', '.op .o', function () {
		var on = $('#o_' + $(this).attr('data-id'));
		if (on.hasClass("show")) {
			on.removeClass("show");
		} else {
			on.addClass("show")
		} 
	});
	$(document).on('click', '.b.pay:not([data-rec])', function () {
		alert('请到PC端完成支付！');
	});
	$(document).on('click', '[data-rec]', function () {
		var id = $(this).attr('data-rec');
		var result = confirm("是否确认收货?");
		if(result){
			$.ajax({
			    url: '${pageContext.request.contextPath}/management/order/doReceived?o='+id,
			    type: "POST",
			    contentType : 'application/json;charset=gbk',
			    dataType:"json",
			    success: function(data){
			    	if(data.result=='ok'){
			    		window.location.reload();
			    	}else{
			    		alert('确认收货失败！');
			    	}
			    },
			    error: function(res){
		            alert('网路错误，请稍后再试！');
		        }
			});
		}
	});
	$(window).scroll(function(){
	　　var scrollTop = $(this).scrollTop();
	　　var scrollHeight = $(document).height();
	　　var windowHeight = $(this).height();
	　　if(scrollTop + windowHeight == scrollHeight && hasMore){
			page ++;
			$.get('${pageContext.request.contextPath}/${pageAction}'.replace('%PAGE%', page), function (res) {
				var ls = $(res).find('#order-list .item');
				if (!ls || ls.length == 0) {
					hasMore = false;
					return;
				}
				$('#order-list').append(ls);
				if (${pages} == page) {
					hasMore = false;
				} 
			});
	　　}
	});
});
</script>
</body>
</html>