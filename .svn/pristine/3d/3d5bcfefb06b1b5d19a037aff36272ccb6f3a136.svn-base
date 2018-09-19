<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="商品搜索" name="title" />
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/product-list.css" rel="stylesheet">
	<script type="text/javascript">
		function toggleBrand() {
			var ul = $("#brand_ul");
			if (ul.attr("data-org-height")) {
				if (ul.attr("data-expanded") == "true") {
					ul.height(72);
					ul.attr("data-expanded", "false");
				} else {
					ul.height(ul.attr("data-org-height"));
					ul.attr("data-expanded", "true");
				}
			}
		}
		
		$(function () {
			$(".cat-level1-a").click(function () {
				var catId = $(this).attr("data-cat-id");
				if ($("#cat_sub_" + catId).css("display") != 'none') {
					return;
				}
				$(".cat-level3").slideUp();
				$(".cat-level2").slideUp();
				$("#cat_sub_" + catId).slideDown();
			});
			$(".cat-level2-a").click(function () {
				var catId = $(this).attr("data-cat-id");
				if ($("#cat_sub_" + catId).css("display") != 'none') {
					return;
				}
				$(".cat-level3").slideUp();
				$("#cat_sub_" + catId).slideDown();
			});
			
			var cat = '${cat}',cat1 = '${cat1}', cat2 = '${cat2}', cat3 = '${cat3}';
	
			if (cat1 > 0) {
				$("#cat_sub_" + cat1).show();
			}
			
			if (cat2 > 0) {
				$("#cat_sub_" + cat2).show();
			}
			
			$("#goods_cat_" + cat).css("color", "#db433d");
			
			
			
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
		<div id="contents">
			<div class="inner">
				<div class="breadcrumb">
					<ul>
						<li><a href="${pageContext.request.contextPath}">首页</a><span>&gt;</span></li>
						<c:if test="${cat1 > 0}">
							<li><a href="${pageContext.request.contextPath}/market/goods/search?cat=${cat1}">${dataCache.getCategoryName(cat1)}</a><span>&gt;</span></li>
						</c:if>
						<c:if test="${cat2 > 0}">
							<li><a href="${pageContext.request.contextPath}/market/goods/search?cat=${cat2}">${dataCache.getCategoryName(cat2)}</a><span>&gt;</span></li>
						</c:if>
						<c:if test="${cat3 > 0}">
							<li><a href="${pageContext.request.contextPath}/market/goods/search?cat=${cat3}">${dataCache.getCategoryName(cat3)}</a><span>&gt;</span></li>
						</c:if>
						<c:if test="${searchKeyword != ''}">
							<li><a href="${pageContext.request.contextPath}/market/goods/search?cat=${cat}&q=${fn:escapeXml(searchKeyword)}">搜索“${fn:escapeXml(searchKeyword)}”</a><span>&gt;</span></li>
						</c:if>
					</ul>
					<!--.breadcrumb-->
				</div>

				<div id="product_list" class="clearfix">
					<div id="category">
						<h2>所有类目</h2>
						<c:forEach var="level1" items="${dataCache.getCategoryTree()}" varStatus="sta1">
							<h3>
								<a id="goods_cat_${level1.sysCatId}" href="javascript:void(0);" class="cat-level1-a" data-cat-id="${level1.sysCatId}">${level1.sysCatName}<span class="fa fa-caret-down write"></span></a>
							</h3>
							<ul style="display:none;" class="cat-level2" id="cat_sub_${level1.sysCatId}">
								<c:forEach var="level2" items="${level1.childCategory}" varStatus="sta2">
									<li <c:if test="${sta2.last}"> class="none_dotted"</c:if>><a id="goods_cat_${level2.sysCatId}" href="javascript:void(0);" class="cat-level2-a" data-cat-id="${level2.sysCatId}">${level2.sysCatName}</a>
										<ul style="display:none;" class="cat-level3" id="cat_sub_${level2.sysCatId}">
											<c:forEach var="level3" items="${level2.childCategory}" varStatus="sta3">
												<li><a id="goods_cat_${level3.sysCatId}" href="${pageContext.request.contextPath}/market/goods/search?q=${fn:escapeXml(searchKeyword)}&cat=${level3.sysCatId}&o=${order}&view=${view}">${level3.sysCatName}</a></li>
											</c:forEach>
										</ul></li>
								</c:forEach>
							</ul>
						</c:forEach>
						<!--#category-->
					</div>

					<div id="contact_main">
						<p>
							<!-- <strong class="font-color-red font-16">全部</strong> -->
							搜索到<strong class="font-color-red font-16">${total}</strong>件相关商品
						</p>
						<div id="brands_price">
							<c:if test="${!empty brandList}">
								<div class="brands clearfix">
									<div class="sl_key">品牌</div>
									<div class="sl_value clearfix">
										<ul style="overflow:hidden;" id="brand_ul">
											<c:forEach var="item" items="${brandList}" varStatus="sta">
												<li style=" width:auto;" <c:if test="${item == searchBrand}">class="active"</c:if>><a
													href="${pageContext.request.contextPath}/market/goods/search?q=${fn:escapeXml(searchKeyword)}&cat=${cat}&price=${price}&brand=${fn:escapeXml(item)}&o=${order}&view=${view}">${fn:escapeXml(item)}</a></li>
											</c:forEach>
										</ul>
										<div class="clearfix"></div>
										<div class="btn_more">
											<a href="javascript:void(0);" onclick="toggleBrand();"><img src="${pageContext.request.contextPath}/static/img/product-list/btn-more.gif" alt=""></a>
										</div>
									</div>
								</div>
							</c:if>
							<div class="brands clearfix">
								<div class="sl_key">价格</div>
								<div class="sl_value clearfix">
									<ul>
										<li <c:if test="${price == '0,99'}">class="active"</c:if> style="width:auto;"><a
											href="${pageContext.request.contextPath}/market/goods/search?q=${fn:escapeXml(searchKeyword)}&cat=${cat}&price=0,99&brand=${fn:escapeXml(searchBrand)}&o=${order}&view=${view}">0-99</a></li>
										<li <c:if test="${price == '100,999'}">class="active"</c:if> style="width:auto;"><a
											href="${pageContext.request.contextPath}/market/goods/search?q=${fn:escapeXml(searchKeyword)}&cat=${cat}&price=100,999&brand=${fn:escapeXml(searchBrand)}&o=${order}&view=${view}">100-999</a></li>
										<li <c:if test="${price == '1000,4999'}">class="active"</c:if> style="width:auto;"><a
											href="${pageContext.request.contextPath}/market/goods/search?q=${fn:escapeXml(searchKeyword)}&cat=${cat}&price=1000,4999&brand=${fn:escapeXml(searchBrand)}&o=${order}&view=${view}">1000-4999</a></li>
										<li <c:if test="${price == '5000,0'}">class="active"</c:if> style="width:auto;"><a
											href="${pageContext.request.contextPath}/market/goods/search?q=${fn:escapeXml(searchKeyword)}&cat=${cat}&price=5000,0&brand=${fn:escapeXml(searchBrand)}&o=${order}&view=${view}">5000以上</a></li>
									</ul>
								</div>
							</div>
							<!--#brands-->
						</div>
						<div id="sort_row">
							<ul class="clearfix">
								<li><a href="${pageContext.request.contextPath}/market/goods/search?q=${fn:escapeXml(searchKeyword)}&cat=${cat}&price=${price}&brand=${fn:escapeXml(searchBrand)}&o=${order}&view=list"
									<c:if test="${view == 'list'}"> class="active"</c:if>><img src="${pageContext.request.contextPath}/static/img/product-list/btn-list.gif" alt="列表"></a></li>
								<li><a href="${pageContext.request.contextPath}/market/goods/search?q=${fn:escapeXml(searchKeyword)}&cat=${cat}&price=${price}&brand=${fn:escapeXml(searchBrand)}&o=${order}&view=pic"
									<c:if test="${view == 'pic'}"> class="active"</c:if>><img src="${pageContext.request.contextPath}/static/img/product-list/btn-preview.gif" alt="大图"></a></li>
								<li><a
									href="${pageContext.request.contextPath}/market/goods/search?q=${fn:escapeXml(searchKeyword)}&cat=${cat}&price=${price}&brand=${fn:escapeXml(searchBrand)}&o=${order > 0 ? 0 : 1}&view=${view}"
									<c:if test="${order > 0}"> class="active"</c:if>><img src="${pageContext.request.contextPath}/static/img/product-list/btn-price.gif" alt="价格"></a></li>
							</ul>
						</div>

						<c:if test="${view != 'list'}">
							<div id="items">
								<ul class="clearfix">
									<c:forEach var="item" items="${list}" varStatus="sta">
										<c:choose>
											<c:when test="${sta.index % 4 == 3}">
												<li class="none">
											</c:when>
											<c:otherwise>
												<li>
											</c:otherwise>
										</c:choose>
										<div class="photo">
											<a href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}"> <img src="${item.imagePath}" alt="" width="220px" height="190px"></a>
										</div>
										<div class="price">￥${item.agreePrice }</div>
										<div class="volume">销量：${item.saleNum }</div>
										<a href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}" class="describe" style="height:35px; display:block; overflow:hidden;">【${dataCache.getSupplierName(item.supId)}】${fn:escapeXml(item.goodsName)}</a>
										<ul class="btn_list clearfix">
											<li><a href="javascript:void(0);" data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="cart-add-btn"><img
													src="${pageContext.request.contextPath}/static/img/product-list/btn-cart.gif" alt="加入购物车"></a></li>
											<li><a href="javascript:void(0);"><img src="${pageContext.request.contextPath}/static/img/product-list/btn-collection.gif" alt="收藏"></a></li>
											<li class="none"><a href="javascript:void(0);" data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="goods-compare-btn"><img
													src="${pageContext.request.contextPath}/static/img/product-list/btn-contrast.gif" alt="对比"></a></li>
										</ul>
										</li>
									</c:forEach>
								</ul>
								<!--#items-->
							</div>
						</c:if>
						<c:if test="${view == 'list'}">
							<div class="tab02" id="table_list">
								<table>
									<tr>
										<th width="300">商品名称</th>
										<th>品牌</th>
										<th>招采价</th>
										<th>销量</th>
										<th>供应商</th>
										<th width="250">操作</th>
									</tr>
									<c:forEach var="item" items="${list}" varStatus="sta">
										<tr>
											<td class="left_align"><a href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}">${fn:escapeXml(item.goodsName)}</a></td>
											<td>${fn:escapeXml(item.brandName)}</td>
											<td class="price">${item.agreePrice}</td>
											<td>${item.saleNum }</td>
											<td>${dataCache.getSupplierName(item.supId)}</td>
											<td>
												<ul class="clearfix">
													<li><button type="button" data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default table_btn cart-add-btn">
															<i class="fa fa-shopping-cart shopping"></i>加入购物车
														</button></li>
													<li><button type="button" class="btn btn-default table_btn">
															<i class="fa fa-heart"></i>收藏
														</button></li>
													<li><button type="button" data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default table_btn goods-compare-btn">
															<i class="fa fa-exchange"></i>比对
														</button></li>
												</ul>
											</td>
										</tr>
									</c:forEach>
								</table>
							</div>
						</c:if>
						<jsp:include page="compare.jsp" />
						<jsp:include page="../page.jsp" />
						<!--#contact_main-->
					</div>
					<!--#product_list-->
				</div>
				<!--.inner-->
			</div>
			<!--#contents-->
		</div>
		<jsp:include page="../footer.jsp" />
		<!--.page-wrapper-->
	</div>
	<script type="text/javascript">
		var brandHeight = $("#brand_ul").height();
		if (brandHeight > 72) {
			$("#brand_ul").height(72);
			$("#brand_ul").attr("data-org-height", brandHeight);
		}

		$(".breadcrumb ul li span").last().hide();

		function top_search() {
			var kw = $.trim($("#search_keyword").val());
			window.location.href = "${pageContext.request.contextPath}/market/goods/search?cat=${cat}&view=${view}&q=" + kw;
		}
	</script>
</body>

</html>