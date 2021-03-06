<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<jsp:include page="../head.jsp">
	<jsp:param value="购物车" name="title"/>
</jsp:include>
<style type="text/css">
body.cart .sup-list .sup .p .p-cell .info-wrap .name{
	line-height: 16px;
}
body.cart .sup-list .sup .p .p-cell .info-wrap .count input{
	padding: 5px 0;
}
body.cart .sup-list .sup .p .p-cell .info-wrap .count .op{
	height: 26px;
}
</style>
<body class="cart include-footer">

<div id="app">
		<div class="header">
            <i class="iconfont back" onclick="history.go(-1);">&#xe615;</i>
            <span>购物车</span>
        </div>
			<c:set value="0" var="sup"></c:set>
			<c:set value="0" var="lastSup"></c:set>
   			<c:if test="${empty list}">
   				<p style="text-align: center; font-size: 22px; padding-top: 30px; color: #999;">购物车是空的</p>
   			</c:if>
   			<c:if test="${not empty list}">
   			<div class="sup-list">
			<c:forEach var="item" items="${list}" varStatus="sta">
				<c:if test="${sup != item.supId}">
					<c:if test="${not sta.first}">
						</div>
					</c:if>
                	<c:set value="${item.supId}" var="lastSup"/>
					<c:set value="${item.supId}" var="sup"></c:set>
            		<div class="sup">
                		<p class="n"><i class="s sup" data-sup="${sup}" data-id="${sup}"></i>供应商：${dataCache.getSupplierName(sup)}</p>
				</c:if>
					<!-- ============================================================================= -->
							<div class="p" data-sup="${item.supId}">
			                    <i class="s prod" data-sid="${item.supId}"></i>
			                    <div class="p-cell">
			                        <div class="img-wrap">
			                            <c:if test="${item.supType == 1}">
											<img src="${pageContext.request.contextPath}${item.imagePath == null ? '/static/img/img-profession.jpg' : item.imagePath}"/>
										</c:if>
										<c:if test="${item.supType == 0}">
											<img src="${item.imagePath}"/>
										</c:if>
			                        </div>
			                        <div class="info-wrap">
			                            <a class="name" style="text-decoration: none; color: #000;" href="${pageContext.request.contextPath}/market/goods/show?sid=${item.supId}&gid=${item.supGoodsId}">${fn:escapeXml(item.goodsName)}<c:if test="${item.supType == '1'}">(${fn:escapeXml(item.goodsModel)})</c:if></a>
			                            <span class="price">￥<fmt:formatNumber value="${item.agreePrice}" pattern="#0.00#"></fmt:formatNumber></span>
			                            <div class="count">
			                                <span class="op add iconfont" data-sid="${item.supId}" data-gid="${item.supGoodsId}" onclick="updateCount('${item.supId}', '${item.supGoodsId}', 1);">&#xe622;</span>
			                                <input type="tel" autocomplete="off" class="goods-count" id="count_${item.supId}_${item.supGoodsId}" data-gid="${item.supGoodsId}" data-sid="${item.supId}" data-price="<fmt:formatNumber value="${item.agreePrice}" pattern="#0.00#"></fmt:formatNumber>"
			                                	data-stock="<c:choose><c:when test="${item.supId == 2}">${item.stock < 0 ? 9999 : item.stock}</c:when><c:otherwise>${item.stock < 0 ? 0 : item.stock}</c:otherwise></c:choose>" value="${item.buyNum}" data-name='${fn:escapeXml(item.goodsName)}'/>
			                                <span class="op sub iconfont" data-sid="${item.supId}" data-gid="${item.supGoodsId}" onclick="updateCount('${item.supId}', '${item.supGoodsId}', -1);">&#xe620;</span>
			                            </div>
			                        </div>
			                    </div>
			                </div>
					<!-- ============================================================================= -->
	       		 <c:if test="${sta.last || lastSup != sup && not sta.first}">
	       		 </div>
	       		 </c:if>
            </c:forEach>
            </div>
   			</c:if>
            <%--<div class="sup" v-for="i in 3"> 
                <p class="n"><i class="s active"></i>供应商：JD</p>
                <div class="p" v-for="j in i+1">
                    <i class="s active"></i>
                    <div class="p-cell">
                        <div class="img-wrap">
                            <img src="${pageContext.request.contextPath}/static/image/index-prod.jpg"/>
                        </div>
                        <div class="info-wrap">
                            <a class="name">DNSJAKDNAJWDNAWNDJKANFCKJAWNDKJAWDNJKAWDNJKAWNKJDANKWJDNKAJ</a>
                            <span class="price">￥6789.00</span>
                            <div class="count">
                                <span class="op add iconfont" @click="val++">&#xe622;</span>
                                <input type="tel" autocomplete="off" v-model="val">
                                <span class="op sub iconfont" @click="val == 1 ? 1 : val--">&#xe620;</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div> --%>
   			<c:if test="${not empty list}">
        <div class="stat" style="z-index:5;">
	        <a><i class="s" id="select-all"></i>全选</a>
	        <a class="a">
	            合计:<span id="allPrice">￥0.00</span>
	        </a>
	        <a class="gen-order">生成订单</a>
	    </div>
	    </c:if>
	
<jsp:include page="../foot.jsp">
	<jsp:param value="购物车" name="tab"/>
</jsp:include>

<script type="text/javascript">
var app = new Vue({
	el	: '.footer',
	data: {
		cartCount	: 0,
		cs			: {},
		allPrice	: 0
	},
	methods	: {
	}
});
function updateCount (sid, gid, c, f) {
	var el = $('#count_' + sid + '_' + gid);
	var count = parseInt(el.val());
	count = count + c;
	count = count < 1 ? 1 : count;
	el.val(count);
	var es = $('.goods-count'), all = 0;
	for (var i = 0; i < es.length; i++) {
		all += parseInt(es.eq(i).val());
	}
	if (!f) {
		$.post('${pageContext.request.contextPath}/market/cart/num?t=' + new Date().getTime(), {sid:sid, gid:gid, num:count, all : all}, function(res){});
		app.cartCount = all;
	}
	updateStat();
}
$(function () {
	$('.goods-count').on('input propertychange', function () {
		var self = $(this);
		if (self.val()) {
			self.val(self.val().replace(/[^0-9]/ig,""));
		} else {
			self.val('1 ');
		}
		updateCount(self.attr('data-sid'), self.attr('data-gid'), 0);
	});
	$('.gen-order').click(function () {
		var gs = $('i.s.prod.active').parent().find('input[data-gid]');
		if (!gs || gs.length == 0) {
			alert('请选择要下单的商品！');
			return;
		}
		if ($('i.s.prod.active[data-sid="' + gs.eq(0).attr('data-sid') + '"]').length != gs.length) {
			alert('请选择同一个供应商！');
			return;
		}
		for (var i = 0; i < gs.length; i++) {
			var g = gs.eq(i);
			var stock = parseInt(g.attr('data-stock'));
			if (parseInt(g.val()) > stock) {
				alert('商品[' + g.attr('data-name') + '],库存不足！');
				return;
			}
		}
		var choose = [];
		for (var i = 0; i < gs.length; i++) {
			choose.push(gs.eq(i).attr('data-sid') + '_' + gs.eq(i).attr('data-gid') + '_' + gs.eq(i).val());
		}
		location.href = '${pageContext.request.contextPath}/market/order/confirm?warning=1&ids=' + choose.join(',');
	});
	$('i.s.sup').click(function () {
		var that = $(this);
		if (that.hasClass('active')) {
			that.removeClass('active');
			$('i.s.prod[data-sid="' + that.attr('data-id') + '"]').removeClass('active');
		} else {
			that.addClass('active');
			$('i.s.prod[data-sid="' + that.attr('data-id') + '"]').removeClass('active').addClass('active');
		}
		updateStat();
	});
	$('i.s.prod').click(function () {
		var that = $(this);
		if (that.hasClass('active')) {
			that.removeClass('active');
		} else {
			that.addClass('active');
		}
		updateStat();
	});
	$('#select-all').click(function () {
		var that = $(this);
		if (that.hasClass('active')) {
			that.removeClass('active');
			$('i.s').removeClass('active');
		} else {
			that.addClass('active');
			$('i.s').addClass('active');
		}
		updateStat();
	});
	<c:if test="${error != null}">
		alert("${error}");
	</c:if>
});
function updateStat() {
	var gs = $('i.s.prod.active').next().find('.goods-count');
	var p = 0;
	for (var i = 0; i < gs.length; i++) {
		p += parseFloat(gs.eq(i).val()) * parseFloat(gs.eq(i).attr('data-price'));
	}
	$('#allPrice').text('￥' + p.toFixed(2));
}
</script>
</body>
</html>