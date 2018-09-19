<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="��Ʒ����" name="title" />
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/product-list.css" rel="stylesheet">
<style>
.add_btn {
    background: #0091dc;
    color: #fff;
    height: 28px;
    border: none;
    line-height: 28px;
    padding-top: 0;
    padding-bottom: 0;
}
#brands_price .brands .special_value {
    width: 180px;
    float: left;
    margin-left: 10px;
    height: 28px;
    margin-right: 5px;
}
#brands_price .brands .special_value .special_input {
    width: 75px;
    display: inline-block;
    margin: 0 5px;
    height: 28px;
    line-height: 28px;
    padding-bottom: 0;
    padding-top: 0;
}
</style>
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

			$(".cat-li").hover(function () {
				$(this).addClass("hover");
			}, function () {
				$(this).removeClass("hover");
			});		
			
			
			
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
					alert("���ӹ��ﳵ�ɹ�");
				});
			});
			

			$("#filter_btn").click(function () {
				var price1 = $("#price_start").val();
				var price2 = $("#price_end").val();
				
				if (price1 == "") {
					price1 = "0";
				}
				if (price2 == "") {
					price2 = "0";
				}
				
				
				
				var link = $(this).attr("data-link");
				
				window.location.href = link + "&price=" + price1 + "," + price2;
			});
		});
	</script>
	<style>
	#menu_cate ul li.hover a.cate_list {
	    border: 1px solid #db4340;
	    border-bottom: 1px solid #fff;
    }
	#menu_cate ul li div.details {
		display:none;
	}
	#menu_cate ul li.hover div.details {
		display:block;
    }
    #menu_cate .details ul li {
    	width:auto;
    }
    #brands_price .brands .sl_key {
    	width:46px;
    }
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
			<div id="contents">
				<div class="inner">
				<div class="breadcrumb">
					<ul>
						<li><a href="${pageContext.request.contextPath}/">��ҳ</a><span>&gt;</span></li>
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
							<li><a href="${pageContext.request.contextPath}/market/goods/search?cat=${cat}&q=${fn:escapeXml(searchKeyword)}">������${fn:escapeXml(searchKeyword)}��</a><span>&gt;</span></li>
						</c:if>
					</ul>
					<!--.breadcrumb-->
				</div>

					<div id="product_list" class="clearfix">
					<c:if test="${!empty hot}">
                       <div id="hotsale" class="clearfix">
                         <div class="title_hot">
                           �����Ƽ�
                         </div>
                         <div class="hot_list clearfix">
                         <c:forEach varStatus="sta" var="item" items="${hot}">
                           <dl class="dl-horizontal">
                             <dt style="margin-top:8px;"><a target="_blank" href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}"><img src="${item.imagePath}" width="96px" height="78px" /></a></dt>
                             <dd>
                               <div class="name"><a target="_blank" style="height:35px; display:block; overflow:hidden;" href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}">${item.goodsName}</a></div>
                               <div class="price">��${item.agreePrice }</div>
                               <div class="btn_list"><button type="button" data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default cart-add-btn">���빺�ﳵ</button></div>
                             </dd>
                           </dl>
                         </c:forEach>
                         </div>
                       </div>
                       </c:if>
                       <c:if test="${cat > 0}">
                       <div id="menu_cate">
                         <ul class="clearfix">
                           <li><a class="cate_title" href="javascript:void(0);">${dataCache.getCategoryName(cat1)}</a><i class="fa fa-angle-right arrow-right"></i></li>
                           <li class="cat-li" style="z-index:3;"><a class="cate_list" style="line-height:27px; " href="javascript:void(0);">${cat2 > 0 ? dataCache.getCategoryName(cat2) : '��ѡ��'}</a><i class="fa fa-angle-right arrow-right"></i>
                             <div class="details">
                               <ul>
                               <c:forEach varStatus="sta" var="item" items="${dataCache.getSubCategoryList(cat1)}">
                                 <li><a href="${pageContext.request.contextPath}/market/goods/search?q=${fn:escapeXml(searchKeyword)}&cat=${item.sysCatId}&o=${order}&view=${view}">${item.sysCatName}</a></li>
                               </c:forEach>
                               </ul>
                             </div>
                           </li>
                           <c:if test="${cat2 > 0}">
                           <li class="cat-li"><a class="cate_list" href="javascript:void(0);" style="line-height:27px; ">${cat3 > 0 ? dataCache.getCategoryName(cat3) : '��ѡ��'}</a><i class="fa fa-angle-right arrow-right"></i>
                             <div class="details">
                               <ul>
                               <c:forEach varStatus="sta" var="item" items="${dataCache.getSubCategoryList(cat2)}">
                                 <li><a href="${pageContext.request.contextPath}/market/goods/search?q=${fn:escapeXml(searchKeyword)}&cat=${item.sysCatId}&o=${order}&view=${view}">${item.sysCatName}</a></li>
                               </c:forEach>
                               </ul>
                             </div>
                           
                           </li>
                           </c:if>
                         </ul>
                       </div>
                       </c:if>
						<div id="contact_main">
							<p>
							������<strong class="font-color-red font-16">${total}</strong>�������Ʒ
							</p>
							<div id="brands_price">
								<c:if test="${!empty supList}">
								<div class="brands clearfix">
									<div class="sl_key">��Ӧ��</div>
									<div class="sl_value clearfix">
										<ul style="overflow:hidden;" id="sup_ul">
											<c:forEach var="item" items="${supList}" varStatus="sta">
											<c:if test="${item.supType == 0}">
												<li style=" width:auto;" <c:if test="${item.supId == sup}">class="active"</c:if>><a
													href="${pageContext.request.contextPath}/market/goods/search?q=${fn:escapeXml(searchKeyword)}&cat=${cat}&price=${price}&brand=${fn:escapeXml(searchBrand)}&sup=${item.supId == sup ? '' : item.supId}&o=${order}&view=${view}">${fn:escapeXml(item.supName)}</a></li>
											</c:if>
											</c:forEach>
										</ul>
										<div class="clearfix"></div>
										<div class="btn_more">
											<a href="javascript:void(0);"><img src="${pageContext.request.contextPath}/static/img/product-list/btn-more.gif" alt=""></a>
										</div>
									</div>
								</div>
								</c:if>
								<c:if test="${!empty brandList}">
								<div class="brands clearfix">
									<div class="sl_key">Ʒ��</div>
									<div class="sl_value clearfix">
										<ul style="overflow:hidden;" id="brand_ul">
											<c:forEach var="item" items="${brandList}" varStatus="sta">
												<li style=" width:auto;" <c:if test="${item == searchBrand}">class="active"</c:if>><a
													href="${pageContext.request.contextPath}/market/goods/search?q=${fn:escapeXml(searchKeyword)}&cat=${cat}&price=${price}&brand=${item == searchBrand ? '' : fn:escapeXml(item)}&sup=${sup}&o=${order}&view=${view}">${fn:escapeXml(item)}</a></li>
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
								<div class="sl_key special_ksy">�۸�</div>	
								<div class="sl_value clearfix">
									<ul>
										<li <c:if test="${price == '0,99'}">class="active"</c:if> style="width:auto;"><a
											href="${pageContext.request.contextPath}/market/goods/search?q=${fn:escapeXml(searchKeyword)}&cat=${cat}&price=${price == '0,99' ? '' : '0,99'}&brand=${fn:escapeXml(searchBrand)}&sup=${sup}&o=${order}&view=${view}">0-99</a></li>
										<li <c:if test="${price == '100,999'}">class="active"</c:if> style="width:auto;"><a
											href="${pageContext.request.contextPath}/market/goods/search?q=${fn:escapeXml(searchKeyword)}&cat=${cat}&price=${price == '100,999' ? '' : '100,999'}&brand=${fn:escapeXml(searchBrand)}&sup=${sup}&o=${order}&view=${view}">100-999</a></li>
										<li <c:if test="${price == '1000,4999'}">class="active"</c:if> style="width:auto;"><a
											href="${pageContext.request.contextPath}/market/goods/search?q=${fn:escapeXml(searchKeyword)}&cat=${cat}&price=${price == '1000,4999' ? '' : '1000,4999'}&brand=${fn:escapeXml(searchBrand)}&sup=${sup}&o=${order}&view=${view}">1000-4999</a></li>
										<li <c:if test="${price == '5000,0'}">class="active"</c:if> style="width:auto;"><a
											href="${pageContext.request.contextPath}/market/goods/search?q=${fn:escapeXml(searchKeyword)}&cat=${cat}&price=${price == '5000,0' ? '' : '5000,0'}&brand=${fn:escapeXml(searchBrand)}&sup=${sup}&o=${order}&view=${view}">5000����</a></li>
									</ul>
									<div class="sl_value special_value clearfix" style="margin-top:5px;">
										<input class="form-control special_input" id="price_start" type="text" value="${price1 > 0 ? price1 : ''}">-<input class="form-control special_input" type="text" id="price_end" value="${price2 > 0 ? price2 : ''}">
									</div>
	                                <div class="sl_key special_ksy" style="margin-top:5px;"><button type="button" class="btn btn-default add_btn" data-link="${pageContext.request.contextPath}/market/goods/search?q=${fn:escapeXml(searchKeyword)}&cat=${cat}&brand=${fn:escapeXml(searchBrand)}&sup=${sup}&o=${order}&view=${view}" id="filter_btn">����</button></div>
									
								</div>
								
								
							</div>
								<!--#brands-->
							</div>
							<div id="sort_row">
								<ul class="clearfix">
									<li><a href="${pageContext.request.contextPath}/market/goods/search?q=${fn:escapeXml(searchKeyword)}&cat=${cat}&price=${price}&brand=${fn:escapeXml(searchBrand)}&sup=${sup}&o=${order}&view=list"
										<c:if test="${view == 'list'}"> class="active"</c:if>><img src="${pageContext.request.contextPath}/static/img/product-list/btn-list.gif" alt="�б�"></a></li>
									<li><a href="${pageContext.request.contextPath}/market/goods/search?q=${fn:escapeXml(searchKeyword)}&cat=${cat}&price=${price}&brand=${fn:escapeXml(searchBrand)}&sup=${sup}&o=${order}&view=pic"
										<c:if test="${view == 'pic'}"> class="active"</c:if>><img src="${pageContext.request.contextPath}/static/img/product-list/btn-preview.gif" alt="��ͼ"></a></li>
									<li><a
										href="${pageContext.request.contextPath}/market/goods/search?q=${fn:escapeXml(searchKeyword)}&cat=${cat}&price=${price}&brand=${fn:escapeXml(searchBrand)}&sup=${sup}&o=<c:if test="${order == 1}">2</c:if><c:if test="${order == 2}">0</c:if><c:if test="${order == 0}">1</c:if>&view=${view}"
										<c:if test="${order > 0}"> class="active"</c:if>>
										<c:if test="${order == 2}"><img src="${pageContext.request.contextPath}/static/img/btn-price.gif" alt="�۸�"></c:if>
										<c:if test="${order != 2}">
										<img src="${pageContext.request.contextPath}/static/img/product-list/btn-price.gif" alt="�۸�"></c:if></a></li>
								</ul>
							</div>

						<c:if test="${view != 'list'}">
							<div id="items">
								<ul class="clearfix">
								
								
									<c:forEach var="item" items="${list}" varStatus="sta">
										<c:choose>
											<c:when test="${sta.index % 5 == 4}">
												<li class="none">
											</c:when>
											<c:otherwise>
												<li>
											</c:otherwise>
										</c:choose>
										<div class="photo">
											<a target="_blank" href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}"> <img src="${item.imagePath}" alt="" width="210px" height="190px"></a>
										</div>
										<div class="price">��${item.agreePrice }</div>
										<div class="volume">������${item.saleNum }</div>
										<a target="_blank" href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}" class="describe" style="height:35px; display:block; overflow:hidden;">��${dataCache.getSupplierName(item.supId)}��${fn:escapeXml(item.goodsName)}</a>
										<ul class="btn_list clearfix">
											<li><a href="javascript:void(0);" data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default red cart-add-btn">���빺�ﳵ</a></li>
											<li style="visibility: hidden;"><a href="javascript:void(0);" class="btn btn-default">�ղ�</a></li>
											<li class="none"><a href="javascript:void(0);" data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default goods-compare-btn">�Ա�</a></li>
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
										<th width="300">��Ʒ����</th>
										<th>Ʒ��</th>
										<th>�вɼ�</th>
										<th>����</th>
										<th>��Ӧ��</th>
										<th width="250">����</th>
									</tr>
									<c:forEach var="item" items="${list}" varStatus="sta">
										<tr>
											<td class="left_align"><a target="_blank" href="${pageContext.request.contextPath}/market/goods/show?gid=${item.supGoodsId}&sid=${item.supId}">${fn:escapeXml(item.goodsName)}</a></td>
											<td>${fn:escapeXml(item.brandName)}</td>
											<td class="price">${item.agreePrice}</td>
											<td>${item.saleNum }</td>
											<td>${dataCache.getSupplierName(item.supId)}</td>
											<td style="text-align:right;">
												<ul class="clearfix">
													<li><button type="button" data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default table_btn cart-add-btn">
															<i class="fa fa-shopping-cart shopping"></i>���빺�ﳵ
														</button></li>
														<!-- 
													<li><button type="button" class="btn btn-default table_btn">
															<i class="fa fa-heart"></i>�ղ�
														</button></li>
														 -->
													<li><button type="button" data-sid="${item.supId}" data-gid="${item.supGoodsId}" class="btn btn-default table_btn goods-compare-btn">
															<i class="fa fa-exchange"></i>�ȶ�
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
		</div>
	<script type="text/javascript">
		var brandHeight = $("#brand_ul").height();
		if (brandHeight > 72) {
			$("#brand_ul").height(72);
			$("#brand_ul").attr("data-org-height", brandHeight);
		}

		$(".breadcrumb ul li span").last().hide();
		/*
		function top_search() {
			var kw = $.trim($("#search_keyword").val());
			window.location.href = "${pageContext.request.contextPath}/market/goods/search?cat=${cat}&view=${view}&q=" + kw;
		}
		*/
	</script>
	</body>

</html>