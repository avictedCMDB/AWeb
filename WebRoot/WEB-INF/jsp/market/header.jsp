<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
function setCartNum(num) {
	$("#cart_num").text("(" + num + ")");
}

	$(function() {
		var uri = window.location.href;
		var nav = "market";
		if (uri.indexOf("market/home") > 0) {
			nav = "home";
		} else if (uri.indexOf("goods/prof") > 0) {
			nav = "prof";
		} else if (uri.indexOf("market/bid") > 0) {
			nav = "bid";
		} else if (uri.indexOf("market/help") > 0) {
			nav = "help";
		}
		
		if (nav == "market" || nav == "prof") {
			$(".search_area").addClass("search_shopping");
			$(".index_buy").show();
		}
		
		$("#kw_bid").keydown(function (e) {
			if (e.keyCode == 13) {
				$("#btn_bid").trigger("click");
			}
		});
		
		$("#btn_bid").click(function () {
			var kw = $("#kw_bid").val();
			window.location.href = "${pageContext.request.contextPath}/market/bid/index?q=" + encodeURIComponentGBK(kw);
		});
		
		$("#kw_goods").keydown(function (e) {
			if (e.keyCode == 13) {
				$("#btn_goods").trigger("click");
			}
		});
		
		$("#btn_goods").click(function () {
			var kw = $("#kw_goods").val();
			window.location.href = "${pageContext.request.contextPath}/market/goods/search?q=" + encodeURIComponentGBK(kw);
		});
		
		$("#kw_req").keydown(function (e) {
			if (e.keyCode == 13) {
				$("#btn_req").trigger("click");
			}
		});
		
		$("#btn_req").click(function () {
			var kw = $("#kw_req").val();
			window.location.href = "${pageContext.request.contextPath}/market/goods/prof?q=" + encodeURIComponentGBK(kw);
		});
	});
</script>
<div id="header_top">
		    <div class="inner">
		       <ul class="social-links clearfix">
       <c:if test="${sessionScope.login_user != null}">
		       <ul class="social-links clearfix">
		        <li class="mem_login">��ӭ����${sessionScope.login_user.userNameCN}</li>
		        <li class="mem_login"><a href="${pageContext.request.contextPath}/passport/login/logout">�˳�</a></li>
		</c:if>
		        <li><a href="${pageContext.request.contextPath}/passport/redirect"><span class="fa fa-user"></span>�ɹ���������</a><span>|</span></li>
<c:if test="${sessionScope.login_user == null}">
		        <li><a href="${pageContext.request.contextPath}/passport/login">��¼</a><span>|</span></li>
		       </c:if>
		        <li><a href="#">�ͻ�����</a><span>|</span></li>
		        <li><a href="#">��վ����${nav}</a><span>|</span></li>
		       </ul>
		    <!--.inner--></div>
		<!--#header_top--></div>
		<div id="header">
			<div id="logo" class="clearfix">
				<div class="inner">
					<h1><img src="${pageContext.request.contextPath}/static/img/index_top/img-logo.png" alt="�к��б���"></h1>
					<!-- ������ -->
					<div class="search_area ">
						<div class="tab_search">
							<ul id="invite_tenders" class="nav nav-tabs">
								<li class="active"><a href="#shop_search" data-toggle="tab">����ֱ��</a></li>
								<li><a href="#bid_search" data-toggle="tab">���Ӿ���</a></li>
								<li class="last"><a href="#goods_search" data-toggle="tab">רҵ�г�</a></li>
							</ul>
						</div>
						<div class="input-group">
							<div id="invite_tenders_content" class="tab-content">
								<!-- ���� -->
								<div class="tab-pane active" id="shop_search">
									<input type="text" id="kw_goods" class="form-control" placeholder="��������Ʒ����">
									<span class="input-group-addon" id="btn_goods">����</span>
								</div>
								<div class="tab-pane" id="bid_search">
									<input type="text" id="kw_bid" class="form-control" placeholder="�����뾺����Ŀ����">
									<span class="input-group-addon" id="btn_bid">����</span>
								</div>
								<div class="tab-pane" id="goods_search">
									<input type="text" id="kw_req" class="form-control" placeholder="��������Ʒ����">
									<span class="input-group-addon" id="btn_req">����</span>
								</div>
							</div>
							
						</div>
					</div>
					<div class="buy index_buy" style="display:none;">
				        <button class="btn btn-default" type="button" onclick="window.location.href='${pageContext.request.contextPath}/market/cart/list';"><i class="fa fa-shopping-cart shopping"></i>�ҵĹ��ﳵ<b style="font-weight:normal;" id="cart_num"><c:if test="${sessionScope.login_user != null}">(${dataCache.cartNum(pageContext.session)})</c:if></b><i class="fa fa-angle-right arrow-right"></i></button>
				      </div>
				</div>
			</div>
			<!-- ���� -->
			<div id="nav">
				<div class="inner">
					<ul class="clearfix"> 
        <li><a href="${pageContext.request.contextPath}/">��ҳ</a></li>
        <li><a href="http://xtcg.verylaw.net.cn:90/" target="_blank">Э�鹩��</a></li>
        <li><a href="${pageContext.request.contextPath}/market/index">����ֱ��</a></li>
        <li><a href="${pageContext.request.contextPath}/market/bid/index">���Ӿ���</a></li>
        <li><a href="${pageContext.request.contextPath}/market/goods/prof/index">רҵ�г�</a></li>
        <li><a href="${pageContext.request.contextPath}/market/help/indexHelpInfo?type=1">��������</a></li>
					</ul>
				</div>
			</div>
		<!-- #header --></div>