<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
	<title>首页|中航招标网</title>
	<link href="${pageContext.request.contextPath}/static/campaign/css/bootstrap.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/static/campaign/css/common.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/static/campaign/css/campaign_aug.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/static/campaign/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
	<!-- Fontello CSS -->
	<link href="${pageContext.request.contextPath}/static/campaign/fonts/fontello/css/fontello.css" rel="stylesheet">
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/campaign/js/jquery.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/campaign/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(function(){
	var _w = parseInt($(window).width());
	var realWidth = $(".ad_img").width();
	var realLeft = (_w-realWidth) / 2;
	if(realWidth>=_w){
		$("#banner").css("margin-left",realLeft+'px');
	}
	else{
		$("#banner").css({"margin-left":auto,"margin-right":auto});
	}
})
var loading = false;

var async = function (url, param, callback, failed, skipCheck) {
	if (!skipCheck) {
		if (loading) return;
		loading = true;
	}
	$.ajax({
		url:url,
		type:"POST",
		data:param,
		dataType:"json",
		success:function (msg) {
			if (!skipCheck) {
			loading = false;
			}
			if (msg.hasOwnProperty('status')) {
				if (msg.status === 0) {
					if (callback) {
						callback(msg);
					}
				} else if (msg.status === -100) {
					window.location.href = '${pageContext.request.contextPath}/passport/login';
				} else if (msg.status === -200) {
					alert("您没有使用此功能的权限");
					return;
				} else {
					if (failed) {
						failed(msg);
					} else {
						alert(msg.result);
					}
				}
			} else {
				this.error();
			}
		},
		error:function () {
			if (!skipCheck) {
			loading = false;
			}
			alert("操作失败，请重试");
		}
	});
}
</script>
	<script type="text/javascript">
		
		$(function () {
			
			$(".goods-compare-btn").click(function () {
				var sid = $(this).attr("data-sid");
				var gid = $(this).attr("data-gid");
				compareAdd(sid, gid);
			});
			
			$(".cart-add-btn").click(function () {
				var sid = $(this).attr("data-sid");
				var gid = $(this).attr("data-gid");
				
				async('${pageContext.request.contextPath}/market/cart/add', {sid:sid, gid:gid, num:1}, function (msg) {
					setCartNum(msg.result);
					alert("添加购物车成功");
				});
			});
		});
	</script>
	<style>


	</style>
	</head>

	<body>
		<div class="page-wrapper">
		<jsp:include page="../header.jsp" />
			<div id="nav_area">
			<div class="inner clearfix" style="z-index:999;">
				<jsp:include page="../categorys.jsp" />
			</div>
		    <!--#nav_area-->
		  </div>
			<div id="content">
				<div id="banner">
				    <img class="ad_img" src="${pageContext.request.contextPath}/static/campaign/img/campaign_aug/title.jpg">
				</div>
				<div id="main_inner">
					<div class="inner">
						<div class="section">
							<h3><img src="${pageContext.request.contextPath}/static/campaign/img/campaign_aug/banner01.png"></h3>
							<div class="goods_list">
								<ul class="clearfix">
								
								<c:forEach var="item" items="${goods1}" varStatus="sta">
									<li>
										<div class="goods-wrap">
											<div class="goods-img"><a target="_blank" href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}"><img src="${item.imagePath}"></a></div>
											<div class="goods-price">
												<strong>￥${item.agreePrice }</strong>
												<span class="right">銷量：<b>${item.saleNum }</b></span>
											</div>
											<div class="goods-name">
												<a target="_blank" href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}"><strong>${fn:escapeXml(item.goodsName)}</strong></a>
											</div>
											<div class="goods-operate">
												<button data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default red cart-add-btn" type="button">加入购物车</button>
												<button data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default goods-compare-btn" type="button">对比</button>
											</div>
										</div>
									</li>
								</c:forEach>
								</ul>
							</div>
						</div>
						<div class="section">
							<h3><img src="${pageContext.request.contextPath}/static/campaign/img/campaign_aug/banner02.png"></h3>
							<div class="goods_list">
								<ul class="clearfix">
									
								<c:forEach var="item" items="${goods2}" varStatus="sta">
									<li>
										<div class="goods-wrap">
											<div class="goods-img"><a target="_blank" href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}"><img src="${item.imagePath}"></a></div>
											<div class="goods-price">
												<strong>￥${item.agreePrice }</strong>
												<span class="right">銷量：<b>${item.saleNum }</b></span>
											</div>
											<div class="goods-name">
												<a target="_blank" href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}"><strong>${fn:escapeXml(item.goodsName)}</strong></a>
											</div>
											<div class="goods-operate">
												<button data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default red cart-add-btn" type="button">加入购物车</button>
												<button data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default goods-compare-btn" type="button">对比</button>
											</div>
										</div>
									</li>
								</c:forEach>
								</ul>
							</div>
						</div>
						<div class="section">
							<h3><img src="${pageContext.request.contextPath}/static/campaign/img/campaign_aug/banner03.png"></h3>
							<div class="goods_list">
								<ul class="clearfix">
									
								<c:forEach var="item" items="${goods3}" varStatus="sta">
									<li>
										<div class="goods-wrap">
											<div class="goods-img"><a target="_blank" href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}"><img src="${item.imagePath}"></a></div>
											<div class="goods-price">
												<strong>￥${item.agreePrice }</strong>
												<span class="right">銷量：<b>${item.saleNum }</b></span>
											</div>
											<div class="goods-name">
												<a target="_blank" href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}"><strong>${fn:escapeXml(item.goodsName)}</strong></a>
											</div>
											<div class="goods-operate">
												<button data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default red cart-add-btn" type="button">加入购物车</button>
												<button data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default goods-compare-btn" type="button">对比</button>
											</div>
										</div>
									</li>
								</c:forEach>
								</ul>
							</div>
						</div>
						<div class="section">
							<h3><img src="${pageContext.request.contextPath}/static/campaign/img/campaign_aug/banner04.png"></h3>
							<div class="goods_list">
								<ul class="clearfix">
									
								<c:forEach var="item" items="${goods4}" varStatus="sta">
									<li>
										<div class="goods-wrap">
											<div class="goods-img"><a target="_blank" href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}"><img src="${item.imagePath}"></a></div>
											<div class="goods-price">
												<strong>￥${item.agreePrice }</strong>
												<span class="right">銷量：<b>${item.saleNum }</b></span>
											</div>
											<div class="goods-name">
												<a target="_blank" href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}"><strong>${fn:escapeXml(item.goodsName)}</strong></a>
											</div>
											<div class="goods-operate">
												<button data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default red cart-add-btn" type="button">加入购物车</button>
												<button data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default goods-compare-btn" type="button">对比</button>
											</div>
										</div>
									</li>
								</c:forEach>
								</ul>
							</div>
						</div>
						<div class="section">
							<h3><img src="${pageContext.request.contextPath}/static/campaign/img/campaign_aug/banner05.png"></h3>
							<div class="goods_list">
								<ul class="clearfix">
									
								<c:forEach var="item" items="${goods5}" varStatus="sta">
									<li>
										<div class="goods-wrap">
											<div class="goods-img"><a target="_blank" href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}"><img src="${item.imagePath}"></a></div>
											<div class="goods-price">
												<strong>￥${item.agreePrice }</strong>
												<span class="right">銷量：<b>${item.saleNum }</b></span>
											</div>
											<div class="goods-name">
												<a target="_blank" href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}"><strong>${fn:escapeXml(item.goodsName)}</strong></a>
											</div>
											<div class="goods-operate">
												<button data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default red cart-add-btn" type="button">加入购物车</button>
												<button data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default goods-compare-btn" type="button">对比</button>
											</div>
										</div>
									</li>
								</c:forEach>
								</ul>
							</div>
						</div>
						<div class="section">
							<h3><img src="${pageContext.request.contextPath}/static/campaign/img/campaign_aug/banner06.png"></h3>
							<div class="goods_list">
								<ul class="clearfix">
									
								<c:forEach var="item" items="${goods6}" varStatus="sta">
									<li>
										<div class="goods-wrap">
											<div class="goods-img"><a target="_blank" href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}"><img src="${item.imagePath}"></a></div>
											<div class="goods-price">
												<strong>￥${item.agreePrice }</strong>
												<span class="right">銷量：<b>${item.saleNum }</b></span>
											</div>
											<div class="goods-name">
												<a target="_blank" href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}"><strong>${fn:escapeXml(item.goodsName)}</strong></a>
											</div>
											<div class="goods-operate">
												<button data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default red cart-add-btn" type="button">加入购物车</button>
												<button data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default goods-compare-btn" type="button">对比</button>
											</div>
										</div>
									</li>
								</c:forEach>
								</ul>
							</div>
						</div>
						<div class="section section_special">
							<h3><img src="${pageContext.request.contextPath}/static/campaign/img/campaign_aug/banner07.png"></h3>
							<div class="goods_list">
								<ul class="clearfix">
									
								<c:forEach var="item" items="${goods7}" varStatus="sta">
									<li>
										<div class="goods-wrap">
											<div class="goods-img"><a target="_blank" href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}"><img src="${item.imagePath}"></a></div>
											<div class="goods-price">
												<strong>￥${item.agreePrice }</strong>
												<span class="right">銷量：<b>${item.saleNum }</b></span>
											</div>
											<div class="goods-name">
												<a target="_blank" href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}"><strong>${fn:escapeXml(item.goodsName)}</strong></a>
											</div>
											<div class="goods-operate">
												<button data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default red cart-add-btn" type="button">加入购物车</button>
												<button data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default goods-compare-btn" type="button">对比</button>
											</div>
										</div>
									</li>
								</c:forEach>
								</ul>
							</div>
						</div>
						
						<jsp:include page="../goods/compare.jsp" />
				
					<!-- .inner --></div>
				</div>
			</div>
		<jsp:include page="../footer.jsp" />
			<!--.page-wrapper-->
		</div>
	
	</body>

</html>