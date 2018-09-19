<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="��Ʒ����" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/supervise_order.css" rel="stylesheet">

	<script type="text/javascript">
	var loading = false;
		$(function() {
			$(".small_pic").click(function() {
				$("#big_pic").attr("src", $(this).attr("src"));
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
			
			
			
			$("#trade_btn").click(function () {
				if ($("#tab03").find("table").size() == 0) {
					loadTradeRecord("${pageContext.request.contextPath}/supervise/order/goods/trade?sid=${goods.supId}&gid=${goods.supGoodsId}&page=1");
				}
			});
			
		});
		
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
					alert("����ʧ�ܣ�������");
				}
			});
		}
	</script>
</head>

<body>
<div class="page-wrapper">
<jsp:include page="../header.jsp" />
  
  <div id="contents">
			<div class="inner">

				<div id="product_main">
					<div id="product_intro" class="clearfix">
						<div id="preview">
							<div class="photo">
							<c:if test="${goods.supType == 1}">
			                <img width="350px" height="350px" id="big_pic" src="${pageContext.request.contextPath}${goods.imagePath == null ? '/static/img/img-profession.jpg' : goods.imagePath}">
							</c:if>
							<c:if test="${goods.supType == 0}">
			                <img width="350px" height="350px" id="big_pic" src="${goods.imagePath}">
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
									<dt>�г���</dt>
									<dd class="general">
										��<span>${goods.salePrice}</span>
									</dd>
									<dt>�вɼ�</dt>
              <c:if test="${t == '1'}">
									<dd class="preferential">��${goods.businessPrice}</dd>
              </c:if>
              <c:if test="${t != '1'}">
									<dd class="preferential">��${goods.agreePrice}</dd>
              </c:if>
								</dl>
								<dl id="comment_count" class="clearfix">
									<dt>�۸��Ż��ʣ�</dt>
									<dd class="font-color-red">
										<fmt:formatNumber value="${1-goods.agreePrice/goods.salePrice }" type="percent" />
									</dd>
								</dl>
								<dl id="choose" class="clearfix">
									<dt>Ʒ �ƣ�</dt>
									<dd>${goods.brandName == null ? '-' : goods.brandName }</dd>
									<dt>�� �ţ�</dt>
									<dd>${goods.goodsModel == null ? '-' : goods.goodsModel }</dd>
									<dt>���أ�</dt>
									<dd>${goods.productArea == null ? '-' : goods.productArea }</dd>
									
								</dl>
							</div>
						</div>
						<div id="ext_info">
							<h2>${sup.supName}</h2>
							<dl id="contact">
								<dt class="font-16 font-color-red">�ͷ��绰</dt>
								<dd>${sup.contactNum}</dd>
							</dl>
							<dl id="other_shop">
								<dt class="font-16">��Ӫ����Ʒ�������̻�</dt>
								<dd>
									<ul>
										<li><a href="#">����Ʒ��</a></li>
										<li><a href="#">����Ʒ��</a></li>
										<li><a href="#">����Ʒ��</a></li>
									</ul>
								</dd>
							</dl>
						</div>
						<!--#product_intro-->
					</div>
					<div id="product_detail" class="clearfix">
						<div id="menu_list" class="clearfix">
							<ul>
								<li class="select" data-tab="tab01"><a href="javascript:void(0);">��Ʒ����</a></li>
								<li data-tab="tab02"><a href="javascript:void(0);">��Ʒ����</a></li>
								<li data-tab="tab03"><a href="javascript:void(0);" id="trade_btn">��Ʒ�ɽ��۸�</a></li>
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
							<div id="data_empty" style="text-align:center;">������...</div>
							<!--#tab03-->
						</div>
						<!--#product_detail-->
					</div>
					<!--#product_main-->
				</div>
				<!--.inner-->
			</div>
			<!--#contents-->
		</div>
<jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>