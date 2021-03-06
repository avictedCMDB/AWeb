<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="商品详情" name="title" />
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/product-detail.css" rel="stylesheet">

	<script type="text/javascript">
		$(function() {
			$(".small_pic").click(function() {
				$("#big_pic").attr("src", $(this).attr("src"));
			});
			
			$(".btn_reduce").click(function () {
				var num = $("#q_num").text();
				if (num > 1) {
					num --;
					$("#q_num").text(num);
					
					if (num == 1) {
						$(this).css("color", "#cdccca");
					}
				}
			});
			
			$(".btn_add").click(function () {
				var num = $("#q_num").text();
					num ++;
					if (num < 1000000) {
						$("#q_num").text(num);
					}
					
					if (num > 1) {
						$(".btn_reduce").css("color", "#3a3c39");
					}
			});
			
			$("#product_detail #menu_list ul li").click(function () {
				var selected = $("#product_detail #menu_list ul .select");
				selected.removeClass("select");
				$("#" + selected.attr("data-tab")).hide();
				$(this).addClass("select");
				var tab = $(this).attr("data-tab");
				$("#" + tab).show();
				
			});
			
			$("#tab02 table.Ptable").addClass("tableStyle01");
			$("#tab02 table.Ptable").width(1018);
			
			

			$("#goods_compare").click(function () {
				compareAdd(${goods.supId}, '${goods.supGoodsId}');
			});
			

			$("#cart_btn").click(function () {
				
				async('${pageContext.request.contextPath}/market/cart/add', {sid:${goods.supId}, gid:'${goods.supGoodsId}', num:$("#q_num").text()}, function (msg) {
					setCartNum(msg.result);
					alert("添加购物车成功");
				});
			});
			
			$("#order_btn").click(function () {
				window.location.href="${pageContext.request.contextPath}/market/order/confirm?type=1&ids=" + "${goods.supId}_${goods.supGoodsId}_" + $("#q_num").text();
			});
			
			$("#trade_btn").click(function () {
				if ($("#tab03").find("table").size() == 0) {
					loadTradeRecord("${pageContext.request.contextPath}/market/goods/trade?sid=${goods.supId}&gid=${goods.supGoodsId}&page=1");
				}
			});
			

			<c:if test="${error != null}">
			alert("${error}");
			</c:if>
			
			<c:if test="${warning != null}">
			if(confirm("${warning}")){
				window.location.href="${pageContext.request.contextPath}/market/order/confirm?type=1&warning=1&ids=" + "${goods.supId}_${goods.supGoodsId}_" + $("#q_num").text();				
			}
		</c:if>
		
			//$(".stock-address").hover(function () {$(this).find(".address_inner").addClass("open");}, function () {$(this).find(".address_inner").removeClass("open");});
			$(".stock-address").click(function (e) {$(".stock-address .address_inner").addClass("open"); e.stopPropagation();});
			$(".stock-address .address_inner .fa-angle-up").click(function (e) {$(".stock-address .address_inner").removeClass("open"); e.stopPropagation();});
			$(".stock-address .address_inner .address_tab li a").click(function () {
				var target = $(this).attr("data-href");
				$(target).siblings().removeClass("in active");
				$(target).addClass("in active");
				
				$(this).parent().siblings().removeClass("active");
				$(this).parent().addClass("active");
			});
			$(document).click(function () {$(".stock-address .address_inner").removeClass("open")});
			$("#province li a").click(areaClick);
			$("#city li a").click(areaClick);
			$("#district li a").click(areaClick);
			$("#country li a").click(areaClick);
			
			loadStock('${areaOne}', '${areaTwo}', '${areaThree}', '${areaFour}');
		});
		
		var areaClick = function (e) {
			var areaId = $(this).attr("data-id");
			var level = $(this).attr("data-level");
			
			$("#link_" + level).text($(this).text());
			
			if (level == "country") {
				$("#country").attr("data-sel", areaId);
				$("#country").attr("data-name",  $(this).text());
				areaCallback(e);
			} else if (level == "province") {
				$("#tab_city,#tab_district,#tab_country").hide();
				$("#province").attr("data-sel", areaId);
				$("#province").attr("data-name", $(this).text());
				$("#city").attr("data-sel", "");
				$("#city").attr("data-name", "");
				$("#district").attr("data-sel", "");
				$("#district").attr("data-name", "");
				$("#country").attr("data-sel", "");
				$("#country").attr("data-name", "");
				
				loadArea(areaId, 'city');
			} else if (level == "city") {
				$("#tab_district,#tab_country").hide();
				$("#city").attr("data-sel", areaId);
				$("#city").attr("data-name", $(this).text());
				$("#district").attr("data-sel", "");
				$("#district").attr("data-name", "");
				$("#country").attr("data-sel", "");
				$("#country").attr("data-name", "");
				
				loadArea(areaId, 'district');
			} else if (level == "district") {
				$("#tab_country").hide();
				$("#district").attr("data-sel", areaId);
				$("#district").attr("data-name", $(this).text());
				$("#country").attr("data-sel", "");
				$("#country").attr("data-name", "");
				
				loadArea(areaId, 'country');
			}
		}
		
		var areaCallback = function (e) {
			$(".stock-address .address_inner").removeClass("open");
			var areaOne = $("#province").attr("data-sel");
			var areaOneName = $("#province").attr("data-name");
			var areaTwo = $("#city").attr("data-sel");
			var areaTwoName = $("#city").attr("data-name");
			var areaThree = $("#district").attr("data-sel");
			var areaThreeName = $("#district").attr("data-name");
			var areaFour = $("#country").attr("data-sel");
			var areaFourName = $("#country").attr("data-name");
			
			$("#addr_text").html("<em>" + areaOneName + "</em><em>" + areaTwoName + "</em><em>" + areaThreeName + "</em>" + (areaFour == "" ? "" : "<em>" + areaFourName + "</em>"));
			
			loadStock(areaOne, areaTwo, areaThree, areaFour);
			if (e)
			e.stopPropagation();
		}
		
		var loadStock = function (one, two, three, four) {
			var sid = '${sup.supId}';
			var gid = '${goods.supGoodsId}';
			$("#stock_num").text("加载中...");
			$.ajax({
				url:"${pageContext.request.contextPath}/market/goods/stock",
				type:"POST",
				data:{
					sid:sid,
					gid:gid,
					one:one,
					two:two,
					three:three,
					four:four
				},
				success:function (msg) {
					var stock = msg.result;
					if (stock == 9999) {
						$("#stock_num").text("有货");
					} else if (stock == -1) {
						$("#stock_num").text("预定");
					} else if (stock == 0) {
						$("#stock_num").text("无货");
					} else {
						$("#stock_num").text(stock);
					}
					
				},
				error:function () {
					$("#stock_num").text("库存读取失败");
				}
			});
		};
		
		var loadArea = function (parent, target) {
			if (loading) return;
			loading = true;
			$.ajax({
				url:"${pageContext.request.contextPath}/market/goods/area?sid=${sup.supId}&parent=" + parent,
				type:"GET",
				success:function (msg) {
					loading = false;
					var con = $("#" + target + " ul");
					con.empty();
					if (msg.result && msg.result.length > 0) {
						for (var i = 0; i < msg.result.length; i++) {
							var item = msg.result[i];
							var li = $("<li>");
							// <li><a href="javascript:;" data-level="prov" data-id="${item.supAreaId }">${item.supAreaName}</a></li>
							
							var link = $("<a>");
							link.attr("href", "javascript:;");
							link.attr("data-level", target);
							link.attr("data-id", item.supAreaId);
							link.text(item.supAreaName);
							li.append(link);
							
							con.append(li);
							
							link.click(areaClick);
						}
						$("#tab_" + target).show();
						$("#link_" + target).text("请选择");
						$("#link_" + target).trigger("click");
					} else {
						areaCallback();
					}
					
				},
				error:function () {
					loading = false;
					alert("操作失败，请重试");
				}
			});
		};
		
		var loadTradeRecord = function (url) {
			if (loading) return;
			$("#tab03").find("table").remove();
			$("#tab03").find("#flip").remove();
			$("#data_empty").show();
			loading = true;
			$.ajax({
				url:url,
				type:"GET",
				success:function (msg) {
					loading = false;
					$("#data_empty").hide();
					$("#tab03").find("table").remove();
					$("#tab03").append(msg);
					$("#tab03 #flip ul li a").each(function () {
						$(this).attr("data-url", $(this).attr("href"));
						$(this).attr("href", "javascript:void(0);");
						$(this).click(function () {
							var url = $(this).attr("data-url");
							loadTradeRecord(url);
						});
					});
					
				},
				error:function () {
					loading = false;
					alert("操作失败，请重试");
				}
			});
		}
	</script>
</head>

<body>
	<div class="page-wrapper">
		<jsp:include page="../header.jsp" />
		<div id="nav_area">
			<div class="inner clearfix">
				<jsp:include page="../categorys.jsp" />
			</div>
			<!--#nav_area-->
		</div>
		<div id="contents">
			<div class="inner">
				<div class="breadcrumb">
					<ul>
						<li><a href="${pageContext.request.contextPath}/">首页</a><span>&gt;</span></li>
							<c:if test="${sup.supType == 1}">
						<li><a href="${pageContext.request.contextPath}/market/goods/prof">专业市场</a><span></span></li>
							</c:if>
							<c:if test="${sup.supType == 0}">
						<li><a href="${pageContext.request.contextPath}/market/goods/search?cat=${cat1}">${dataCache.getCategoryName(cat1)}</a><span>&gt;</span></li>
						<li><a href="${pageContext.request.contextPath}/market/goods/search?cat=${cat2}">${dataCache.getCategoryName(cat2)}</a><span>&gt;</span></li>
						<li><a href="${pageContext.request.contextPath}/market/goods/search?cat=${cat3}">${dataCache.getCategoryName(cat3)}</a><span></span></li>
							</c:if>
					</ul>
					<!--.breadcrumb-->
				</div>

				<div id="product_main">
					<div id="product_intro" class="clearfix">
						<div id="preview">
							<div class="photo">
							<c:if test="${sup.supType == 1}">
								<img src="${pageContext.request.contextPath}${goods.imagePath == null ? '/static/img/img-profession.jpg' : goods.imagePath}" alt="" width="350px" height="350px" id="big_pic">
							</c:if>
							<c:if test="${sup.supType == 0}">
								<img src="${goods.imagePath}" alt="" width="350px" height="350px" id="big_pic">
							</c:if>
							</div>
							<div class="spec_list">
								<ul class="clearfix">
									<c:forEach var="item" items="${goods.images}" varStatus="sta">
										<li style="cursor:pointer;" <c:if test="${sta.last}">class="last"</c:if>><img class="small_pic" src="${item}" alt="" width="44px" height="44px"></li>
									</c:forEach>
								</ul>
							</div>
						</div>
						<div id="item_info">
							<h1 style="margin-right:60px; word-break:break-all; word-wrap:break-word;">${fn:escapeXml(goods.goodsName) }</h1>
							<div id="summary">
								<dl id="summary_price" class="clearfix">
									<dt>招采价</dt>
									<dd class="preferential">￥${goods.agreePrice}</dd>
								</dl>
								<dl id="comment_count" class="clearfix">
									<dt>价格优惠率：</dt>
									<dd class="font-color-red">
										<fmt:formatNumber value="${1-goods.agreePrice/goods.salePrice }" type="percent" />
									</dd>
								</dl>
								<dl id="choose" class="clearfix">
									<dt>商品编码：</dt>
									<dd>${goods.supGoodsId }</dd>
									<dt>品牌：</dt>
									<dd>${goods.brandName == null ? '-' : goods.brandName }</dd>
									<dt>型号：</dt>
									<dd>${goods.goodsModel == null ? '-' : goods.goodsModel }</dd>
									<dt>材质：</dt>
									<dd>${goods.goodsStuff == null ? '-' : goods.goodsStuff }</dd>
									<dt>产地：</dt>
									<dd>${goods.productArea == null ? '-' : goods.productArea }</dd>
									<c:if test="${sup.supType == 0}">
									<dt class="address">配送至：</dt>
									<dd class="address">
				                      <div class="stock-address">
				                        <!-- open控制下拉框的样式 -->
				                        <div class="address_inner">
				                          <div class="address_head">
				                            <span class="text address_link" id="addr_text"><em>${areaOneName}</em><em>${areaTwoName}</em><em>${areaThreeName}</em><c:if test="${areaFour != '' }">${areaFourName}</c:if></span>
				                            <span class="arrow address_link"><i></i></span>
				                          </div>
				                          <div class="address_content">
				                            <div class="normal_address">
				                              <span>选择新地址</span>
				                              <span class="arrow"><i class="fa fa-angle-up"></i></span>
				                            </div>
				                            <div class="address_list">
				                              <ul class="address_tab nav nav-tabs" id="address_list">
				                                <li class="active"><a href="javascript:;" data-href="#province" id="link_province" >${areaOneName}</a></li>
				                                <li id="tab_city"><a href="javascript:;" data-href="#city" id="link_city" >${areaTwoName}</a></li>
				                                <li id="tab_district"><a href="javascript:;" data-href="#district" id="link_district">${areaThreeName}</a></li>
				                                
				                                <li id="tab_country" <c:if test="${areaFour == '' }">style="display:none;"</c:if>><a href="javascript:;" data-href="#country" id="link_country">${areaFourName}</a></li>
				                                
				                              </ul>
				                              <div class="tab-con tab-content">
				                                <div id="province" class="tab-pane fade in active" data-sel="${areaOne}" data-name="${areaOneName}">
				                                  <ul class="clearfix ul-address">
													<c:forEach var="item" items="${provs}" varStatus="sta">														
				                                    	<li><a href="javascript:;" data-level="province" data-id="${item.supAreaId }">${item.supAreaName}</a></li>
													</c:forEach>
				                                  </ul>
				                                </div>
				                                <div id="city" class="tab-pane fade" data-sel="${areaTwo}" data-name="${areaTwoName}">
				                                  <ul class="clearfix ul-address">
													<c:forEach var="item" items="${citys}" varStatus="sta">														
				                                    	<li><a href="javascript:;" data-level="city" data-id="${item.supAreaId }">${item.supAreaName}</a></li>
													</c:forEach>
				                                  </ul>
				
				                                </div>
				                                <div id="district" class="tab-pane fade" data-sel="${areaThree}" data-name="${areaThreeName}">
				                                  <ul class="clearfix ul-address">
													<c:forEach var="item" items="${dists}" varStatus="sta">														
				                                    	<li><a href="javascript:;" data-level="district" data-id="${item.supAreaId }">${item.supAreaName}</a></li>
													</c:forEach>
				                                  </ul>
				                                </div>
				                                <div id="country" class="tab-pane fade" data-sel="${areaFour}" data-name="${areaFourName}">
				                                  <ul class="clearfix ul-address ul-address_special ">
													<c:forEach var="item" items="${countrys}" varStatus="sta">														
				                                    	<li><a href="javascript:;" data-level="country" data-id="${item.supAreaId }">${item.supAreaName}</a></li>
													</c:forEach>
				                                  </ul>
				                                </div>
				                              </div>
				                            </div>
				                          </div>
				                        </div>
				                      </div>
				                    <div class="stock-num">
				                      	<span class="stock-num-title">库存：</span>
				                      	<span class="stock-num-inner" id="stock_num"></span>
				                      </div>
				                    </dd>
				                    </c:if>
									<dt class="pt-10">购买数量：</dt>
									<dd>
										<p id="quantity">
											<a href="javascript:void(0);"><span class="btn_reduce">-</span></a><b style="font-weight:normal;" id="q_num">1</b><a href="javascript:void(0);"><span class="btn_add">+</span></a>
										</p>
									</dd>				                    
								</dl>
								<ul id="btn_list" class="clearfix">
									<li><a href="#" id="order_btn"><img src="${pageContext.request.contextPath}/static/img/product-detail/btn-order.gif" alt="立即下单"></a></li>
									<li><a href="javascript:void(0);" id="cart_btn"><img src="${pageContext.request.contextPath}/static/img/product-detail/btn-shopping-cart.gif" alt="加入购物车"></a></li>
								</ul>
								<ul id="other" class="clearfix">
									<li><img src="${pageContext.request.contextPath}/static/img/product-detail/icon-star.gif" alt="">收藏商品<!-- （20938人气）  --></li>
									<li><img src="${pageContext.request.contextPath}/static/img/product-detail/icon-report.gif" alt="">举报</li>
								</ul>
								<div id="compare_map">
									<a href="javascript:void(0);" id="goods_compare"><img src="${pageContext.request.contextPath}/static/img/product-detail/btn-compare-min.gif" alt="对比"></a>
								</div>
							</div>
						</div>
						<div id="ext_info">
							<h2>${sup.supName}</h2>
							<dl id="contact">
								<dt class="font-16 font-color-red">客服电话</dt>
								<dd>${sup.contactNum}</dd>
							</dl>
							<dl id="other_shop">
								<dt class="font-16">经营此商品的其它商户</dt>
								<dd>
									<ul>
										<li><a href="#">其他品牌</a></li>
										<li><a href="#">其他品牌</a></li>
										<li><a href="#">其他品牌</a></li>
									</ul>
								</dd>
							</dl>
						</div>
						<!--#product_intro-->
					</div>
					<div id="product_detail" class="clearfix">
						<div id="menu_list" class="clearfix">
							<ul>
								<li class="select" data-tab="tab01"><a href="javascript:void(0);">商品详情</a></li>
								<li data-tab="tab02"><a href="javascript:void(0);">商品参数</a></li>
								<li data-tab="tab03"><a href="javascript:void(0);" id="trade_btn">商品成交价格</a></li>
							</ul>
						</div>
						<div id="tab01">
							${goods.goodsDesc }
							<!--#tab01-->
						</div>
						<div id="tab02">
							${goods.goodsParam }
							<!--#tab02-->
						</div>
						<div id="tab03">
							<div id="data_empty" style="text-align:center;">加载中...</div>
							<!--#tab03-->
						</div>
						<jsp:include page="compare.jsp" />
						<!--#product_detail-->
					</div>
					<!--#product_main-->
				</div>
				<!--.inner-->
			</div>
			<!--#contents-->
		</div>
		<jsp:include page="../footer.jsp" />
		<!--.page-wrapper-->
	</div>
</body>

</html>