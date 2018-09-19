<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="专业市场" name="title" />
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/profession-list.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/profession_product.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/prof.js"></script>	
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
	function toggleSup() {
		var ul = $("#sup_ul");
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
	function toggleCat() {
		var ul = $("#cat_ul");
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
			
			$("#filter_btn").click(function () {
				var price1 = $("#price_start").val();
				var price2 = $("#price_end").val();
				var model = $("#model_input").val();
				var stuff = $("#stuff_input").val();
				
				var link = $(this).attr("data-link");
				
				window.location.href = link + "&price1=" + price1 + "&price2=" + price2 + "&model=" + encodeURIComponentGBK(model) + "&stuff=" + encodeURIComponentGBK(stuff);
			});
		});
	</script>
	</head>

	<body>
	<input type="hidden" id="path" value="${pageContext.request.contextPath}"/>
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
							<li><a href="${pageContext.request.contextPath}/market/goods/prof/index">专业市场</a><span>&gt;</span></li>
						<c:if test="${searchKeyword != ''}">
							<li><a href="${pageContext.request.contextPath}/market/goods/prof?q=${fn:escapeXml(searchKeyword)}">搜索“${fn:escapeXml(searchKeyword)}”</a><span>&gt;</span></li>
						</c:if>
						
					</ul>
					<!--.breadcrumb-->
				</div>

					<div id="product_list" class="clearfix">
					<c:if test="${!empty hot}">
                       <div id="hotsale" class="clearfix">
                         <div class="title_hot">
                           热卖推荐
                         </div>
                         <div class="hot_list clearfix">
                         <c:forEach varStatus="sta" var="item" items="${hot}">
                           <dl class="dl-horizontal">
                             <dt style="margin-top:8px;"><a target="_blank" href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}">
                             <img src="${pageContext.request.contextPath}${item.imagePath == null ? '/static/img/img-profession.jpg' : item.imagePath}" width="96px" height="78px" />
                             </a></dt>
                             <dd>
                               <div class="name"><a target="_blank" style="height:35px; display:block; overflow:hidden;" href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}">${item.goodsName}(${item.goodsModel})</a></div>
                               <div class="price">￥${item.agreePrice }</div>
                               <div class="btn_list"><button type="button" data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default cart-add-btn">加入购物车</button></div>
                             </dd>
                           </dl>
                         </c:forEach>
                         </div>
                       </div>
                       </c:if>
                       
						<div id="contact_main">
							<p>
							搜索到<strong class="font-color-red font-16">${total}</strong>件相关商品
							</p>
							<div id="brands_price">
								<c:if test="${!empty catList1}">
								<div class="brands clearfix">
									<div class="sl_key">一级分类</div>
									<div class="sl_value clearfix">
										<ul style="overflow:hidden;" id="cat_ul">
											<c:forEach var="item" items="${catList1}" varStatus="sta">
												<li style=" width:auto;" <c:if test="${item.marketCatId == cat1}">class="active"</c:if>><a
													href="${pageContext.request.contextPath}/market/goods/prof?price1=${price1}&price2=${price2}&stuff=${fn:escapeXml(stuff)}&desc=${fn:escapeXml(desc)}&model=${model}&cat1=${item.marketCatId == cat1 ? '' : item.marketCatId}&cat2=&cat3=&brand=${fn:escapeXml(searchBrand)}&sup=${sup}&o=${order}">${fn:escapeXml(item.marketCatName)}</a></li>
													
											</c:forEach>
										</ul>
										<div class="clearfix"></div>
										<div class="btn_more">
											<a href="javascript:void(0);" onclick="toggleCat();"><img src="${pageContext.request.contextPath}/static/img/product-list/btn-more.gif" alt=""></a>
										</div>
									</div>
								</div>
								</c:if>
								<c:if test="${!empty catList2}">
								<div class="brands clearfix">
									<div class="sl_key">二级分类</div>
									<div class="sl_value clearfix">
										<ul style="overflow:hidden;" id="cat_ul">
											<c:forEach var="item" items="${catList2}" varStatus="sta">
												<li style=" width:auto;" <c:if test="${item.marketCatId == cat2}">class="active"</c:if>><a
													href="${pageContext.request.contextPath}/market/goods/prof?price1=${price1}&price2=${price2}&stuff=${fn:escapeXml(stuff)}&desc=${fn:escapeXml(desc)}&model=${model}&cat1=${cat1}&cat2=${item.marketCatId == cat2 ? '' : item.marketCatId}&cat3=&q=${fn:escapeXml(searchKeyword)}&brand=${fn:escapeXml(searchBrand)}&sup=${sup}&o=${order}">${fn:escapeXml(item.marketCatName)}</a></li>
													
											</c:forEach>
										</ul>
										<div class="clearfix"></div>
										<div class="btn_more">
											<a href="javascript:void(0);" onclick="toggleCat();"><img src="${pageContext.request.contextPath}/static/img/product-list/btn-more.gif" alt=""></a>
										</div>
									</div>
								</div>
								</c:if>
								<c:if test="${!empty catList3}">
								<div class="brands clearfix">
									<div class="sl_key">三级分类</div>
									<div class="sl_value clearfix">
										<ul style="overflow:hidden;" id="cat_ul">
											<c:forEach var="item" items="${catList3}" varStatus="sta">
												<li style=" width:auto;" <c:if test="${item.marketCatId == cat3}">class="active"</c:if>><a
													href="${pageContext.request.contextPath}/market/goods/prof?price1=${price1}&price2=${price2}&stuff=${fn:escapeXml(stuff)}&desc=${fn:escapeXml(desc)}&model=${model}&cat1=${cat1}&cat2=${cat2}&cat3=${item.marketCatId == cat3 ? '' : item.marketCatId}&q=${fn:escapeXml(searchKeyword)}&brand=${fn:escapeXml(searchBrand)}&sup=${sup}&o=${order}">${fn:escapeXml(item.marketCatName)}</a></li>
													
											</c:forEach>
										</ul>
										<div class="clearfix"></div>
										<div class="btn_more">
											<a href="javascript:void(0);" onclick="toggleCat();"><img src="${pageContext.request.contextPath}/static/img/product-list/btn-more.gif" alt=""></a>
										</div>
									</div>
								</div>
								</c:if>
								<c:if test="${!empty supList}">
								<div class="brands clearfix">
									<div class="sl_key">供应商</div>
									<div class="sl_value clearfix">
										<ul style="overflow:hidden;" id="sup_ul">
											<c:forEach var="item" items="${supList}" varStatus="sta">
												<li style=" width:auto;" <c:if test="${item.supId == sup}">class="active"</c:if>><a
													href="${pageContext.request.contextPath}/market/goods/prof?price1=${price1}&price2=${price2}&stuff=${fn:escapeXml(stuff)}&desc=${fn:escapeXml(desc)}&model=${model}&cat1=${cat1}&cat2=${cat2}&cat3=${cat3}&q=${fn:escapeXml(searchKeyword)}&brand=${fn:escapeXml(searchBrand)}&sup=${item.supId == sup ? '' : item.supId}&o=${order}">${fn:escapeXml(item.supName)}<c:if test="${item.ifBuilding > 0}"><i class="file"><img src="${pageContext.request.contextPath}/static/img/profession/icon-hezuo.png" /></i></c:if></a></li>
											</c:forEach>
										</ul>
										<div class="clearfix"></div>
										<div class="btn_more">
											<a href="javascript:void(0);" onclick="toggleSup();"><img src="${pageContext.request.contextPath}/static/img/product-list/btn-more.gif" alt=""></a>
										</div>
									</div>
								</div>
								</c:if>
								
								<c:if test="${!empty brandList}">
								<div class="brands clearfix">
									<div class="sl_key">品牌</div>
									<div class="sl_value clearfix">
										<ul style="overflow:hidden;" id="brand_ul">
											<c:forEach var="item" items="${brandList}" varStatus="sta">
												<li style=" width:auto;" <c:if test="${item == searchBrand}">class="active"</c:if>><a
													href="${pageContext.request.contextPath}/market/goods/prof?price1=${price1}&price2=${price2}&stuff=${fn:escapeXml(stuff)}&desc=${fn:escapeXml(desc)}&model=${model}&cat1=${cat1}&cat2=${cat2}&cat3=${cat3}&q=${fn:escapeXml(searchKeyword)}&brand=${item == searchBrand ? '' : fn:escapeXml(item)}&sup=${sup}&o=${order}">${fn:escapeXml(item)}</a></li>
											</c:forEach>
										</ul>
										<div class="clearfix"></div>
										<div class="btn_more">
											<a href="javascript:void(0);" onclick="toggleBrand();"><img src="${pageContext.request.contextPath}/static/img/product-list/btn-more.gif" alt=""></a>
										</div>
									</div>
								</div>
								</c:if>

								<div class="brands brands_last clearfix">
									<div class="sl_key special_ksy">规格型号</div>
									<div class="sl_value special_value clearfix">
										<input class="form-control" type="text" id="model_input" value="${model}">
									</div>
									<div class="sl_key special_ksy">材质</div>
									<div class="sl_value special_value clearfix">
										<input class="form-control" type="text" id="stuff_input" value="${stuff}">
									</div>
                                    <div class="sl_key special_ksy">价格区间</div>
									<div class="sl_value special_value clearfix">
										<input class="form-control special_input" id="price_start" type="text" value="${price1 > 0 ? price1 : ''}">-<input class="form-control special_input" type="text" id="price_end" value="${price2 > 0 ? price2 : ''}">
									</div>
                                    <div class="sl_key special_ksy"><button type="button" class="btn btn-default add_btn" data-link="${pageContext.request.contextPath}/market/goods/prof?desc=${fn:escapeXml(desc)}&cat1=${cat1}&cat2=${cat2}&cat3=${cat3}&q=${fn:escapeXml(searchKeyword)}&brand=${fn:escapeXml(searchBrand)}&sup=${sup}" id="filter_btn">搜索</button></div>
								</div>
								<!--#brands-->
							</div>
							<div id="sort_row">
								<ul class="clearfix">
									<li><a href="${pageContext.request.contextPath}/market/goods/prof?price1=${price1}&price2=${price2}&stuff=${fn:escapeXml(stuff)}&desc=${fn:escapeXml(desc)}&model=${model}&cat1=${cat1}&cat2=${cat2}&cat3=${cat3}&q=${fn:escapeXml(searchKeyword)}&brand=${fn:escapeXml(searchBrand)}&sup=${sup}&o=0"
										<c:if test="${order == 0}"> class="active"</c:if>><img src="${pageContext.request.contextPath}/static/img/product-list/btn-list.gif" alt="列表"></a></li>
									<li><a
										href="${pageContext.request.contextPath}/market/goods/prof?price1=${price1}&price2=${price2}&stuff=${fn:escapeXml(stuff)}&desc=${fn:escapeXml(desc)}&model=${model}&cat1=${cat1}&cat2=${cat2}&cat3=${cat3}&q=${fn:escapeXml(searchKeyword)}&brand=${fn:escapeXml(searchBrand)}&sup=${sup}&o=<c:if test="${order == 1}">2</c:if><c:if test="${order == 2}">0</c:if><c:if test="${order == 0}">1</c:if>"
										<c:if test="${order > 0}"> class="active"</c:if>>
										<c:if test="${order == 2}"><img src="${pageContext.request.contextPath}/static/img/btn-price.gif" alt="价格"></c:if>
										<c:if test="${order != 2}">
										<img src="${pageContext.request.contextPath}/static/img/product-list/btn-price.gif" alt="价格"></c:if></a></li>
								</ul>
							</div>

							<div class="tab02" id="table_list">
								<table>
									<tr>
	                                  <th width="150">商品名称</th>                                  
	                                  <th width="120">规格型号</th>
	                                  <th width="120">品牌</th>
	                                  <th width="120">材质</th>
	                                  <th width="100">含税单价</th>
	                                  <th width="120">销量</th>
	                                  <th>供应商名称</th>
	                                  <th width="250">操作</th>
									</tr>
									<c:forEach var="item" items="${list}" varStatus="sta">
										<tr>
											<td class="left_align"><a target="_blank" href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}" >${fn:escapeXml(item.goodsName)}</a></td>											
											<td title="${fn:escapeXml(item.goodsModel)}">${fn:escapeXml(item.goodsModel)}</td>
											<td>${fn:escapeXml(item.brandName)}</td>
											<td>${fn:escapeXml(item.goodsStuff)}</td>
											<td class="price">${item.agreePrice}</td>
											<td>${item.saleNum }</td>
                                  <td class="special_cell">${item.supName}</td>
											<td style="text-align:right;">
												<ul class="clearfix">
													<li><button type="button" data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default table_btn cart-add-btn">
															<i class="fa fa-shopping-cart shopping"></i>加入购物车
														</button></li>
													<li><button type="button" data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default table_btn goods-compare-btn">
															<i class="fa fa-exchange"></i>比对
														</button></li>
                                      				<li><button type="button" class="btn btn-default table_btn"  onclick="professionEnquiry('${item.goodsName}','${item.supGoodsId}','${item.supId}','${item.goodsModel}','${item.agreePrice}');"><i class="fa fa-question-circle"></i>询价</button></li>
												</ul>
											</td>
										</tr>
									</c:forEach>
								</table>
							</div>
						<jsp:include page="compare.jsp" />
						<jsp:include page="../page.jsp" />
							</div>
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
	<script type="text/javascript">
		var brandHeight = $("#brand_ul").height();
		if (brandHeight > 72) {
			$("#brand_ul").height(72);
			$("#brand_ul").attr("data-org-height", brandHeight);
		}
		var supHeight = $("#sup_ul").height();
		if (supHeight > 72) {
			$("#sup_ul").height(72);
			$("#sup_ul").attr("data-org-height", supHeight);
		}
		var catHeight = $("#cat_ul").height();
		if (catHeight > 72) {
			$("#cat_ul").height(72);
			$("#cat_ul").attr("data-org-height", catHeight);
		}

		$(".breadcrumb ul li span").last().hide();
	</script>
	</body>

</html>