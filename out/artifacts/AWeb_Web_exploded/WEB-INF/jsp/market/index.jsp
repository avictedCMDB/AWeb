<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<jsp:include page="meta.jsp">
	<jsp:param value="首页" name="title" />
</jsp:include>
<script src="${pageContext.request.contextPath}/static/js/jquery-1.8.3.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery.luara.0.0.1.min.js"></script>

<link href="${pageContext.request.contextPath}/static/css/index.css" rel="stylesheet">

	<script type="text/javascript">
		$(function() {

		});
	</script>
</head>

<body>
	<div class="page-wrapper">
		<jsp:include page="header.jsp">
			<jsp:param value="index" name="page" />
		</jsp:include>

		<div id="nav_area">
			<div class="inner clearfix">
				<jsp:include page="categorys.jsp">
					<jsp:param value="true" name="show" />
				</jsp:include>
			</div>
			<!--#nav_area-->
		</div>
		<div id="top_area">
			<div class="inner clearfix">
				<div class="banner_list">
					<ul>
						<li><img src="${pageContext.request.contextPath}/static/img/0.jpg" alt="" /></li>
						<li><img src="${pageContext.request.contextPath}/static/img/1.jpg" alt="" /></li>
						<li><img src="${pageContext.request.contextPath}/static/img/2.jpg" alt="" /></li>
						<li><img src="${pageContext.request.contextPath}/static/img/3.jpg" alt="" /></li>
					</ul>
					<!-- 
					<a href="javascript:void(0);" style="position:absolute; bottom:5px; left:19px;"></a>
					<div style="position:absolute; bottom:5px; left:34px; width:740px; height:72px; overflow:hidden;">
						<ol style="left:0; top:0; bottom:0;">
							<li></li>
							<li></li>
							<li></li>
							<li></li>
						</ol>
					</div>
					<a href="javascript:void(0);" style="position:absolute; bottom:5px; left:724px;"></a>
					<!--.banner_list-->
					
			        <div class="sliderbox clearfix">
				        <div class="btn_arrow left_btn">
				        </div>
				        <ol>
				          <li></li>
				          <li></li>
				          <li></li>
				          <li></li>
				        </ol>
				        <div class="btn_arrow right_btn">
				        </div>
			        </div>
				</div>
				<!-- 
				<div class="right_box">
		        <div class="img"><img src="${pageContext.request.contextPath}/static/img/bnr-right.jpg" alt="" /></div>
		        <div class="btn_list">
		          <ul class="clearfix">
		            <li><a href="${pageContext.request.contextPath}/supplier/login"><img src="${pageContext.request.contextPath}/static/img/btn-supplier.png" alt="" /></a></li>
		            <li><a href="${pageContext.request.contextPath}/supervise/login"><img src="${pageContext.request.contextPath}/static/img/btn-platform.png" alt="" /></a></li>
		          </ul>
		        </div>
		      </div>
		       -->
    </div>
				<!--#top_area-->
			</div>
		<div id="contents">
			<div class="inner">
				<div class="cate_list clearfix section">
					<ul>
						<li class="first"><a href="#"><img src="${pageContext.request.contextPath}/static/banner/img-cate01.jpg" alt="" /></a></li>
						<li><a href="${pageContext.request.contextPath}/market/goods/search?q=&cat=3&brand=TP-LINK"><img src="${pageContext.request.contextPath}/static/banner/img-cate02.jpg" alt="" /></a></li>
						<li><a href="#"><img src="${pageContext.request.contextPath}/static/banner/img-cate03.jpg" alt="" /></a></li>
						<li><a href="${pageContext.request.contextPath}/market/goods/search?q=&cat=2&brand=%BC%D1%C4%DC"><img src="${pageContext.request.contextPath}/static/banner/img-cate04.jpg" alt="" /></a></li>
					</ul>
				</div>
				<div class="section clearfix">
					<div class="item_area item_left">
						<div class="sidebar">
							<h2>
								<img src="${pageContext.request.contextPath}/static/img/title-floor01.png" />
							</h2>
							<div class="hot_list">
								<h3>热门TOP</h3>
								<ul>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=10103">桌面文具</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=10104">本册/便签</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=10107">软木板/白板</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=10205">照片纸</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=10202">打印纸</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=10204">多用途纸</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=10201">复印纸</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=10304">色带</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=10302">硒鼓</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=10301">墨粉</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=10403">学生套装</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=10401">办公套装</a>
								</ul>
							</div>
							<!--sidebar-->
						</div>
						<div class="goods_list">
							<div class="top_list clearfix">
								<div class="photo_list item_left">
									<img src="${pageContext.request.contextPath}/static/img/img-computer_product01.jpg" />
								</div>
								<div class="product_list item_left">
									<ul>
										<li><a href="${pageContext.request.contextPath}/market/goods/show?gid=1100010263EA&sid=2"><img src="${pageContext.request.contextPath}/static/img/goods01.jpg" /></a></li>
										<li><a href="${pageContext.request.contextPath}/market/goods/show?gid=1036522&sid=1"><img src="${pageContext.request.contextPath}/static/img/goods02.jpg" /></a></li>
									</ul>
								</div>
							</div>
							<div class="middle_list clearfix">
								<ul>
									<li><a href="${pageContext.request.contextPath}/market/goods/show?gid=1100000501EA&sid=2"><img src="${pageContext.request.contextPath}/static/img/goods03.jpg" /></a></li>
									<li><a href="${pageContext.request.contextPath}/market/goods/show?gid=1100006258EA&sid=2"><img src="${pageContext.request.contextPath}/static/img/goods04.jpg" /></a></li>
								</ul>
							</div>
							<div class="logo_list">
								<ul class="clearfix">
									<li><a href="${pageContext.request.contextPath}/market/goods/search?cat=1&brand=%BD%F0%D1%C5"><img src="${pageContext.request.contextPath}/static/img/logo01.jpg" /></a></li>
									<li><a href="${pageContext.request.contextPath}/market/goods/search?cat=1&brand=%D0%C0%B8%F1"><img src="${pageContext.request.contextPath}/static/img/logo02.jpg" /></a></li>
									<li><a href="${pageContext.request.contextPath}/market/goods/search?cat=1&brand=%CC%EC%CD%FE"><img src="${pageContext.request.contextPath}/static/img/logo03.jpg" /></a></li>
								</ul>
							</div>
							<!--.goods_list-->
						</div>
						<!--.iteam_area-->
					</div>
					<div class="item_area item_right">
						<div class="sidebar">
							<h2>
								<img src="${pageContext.request.contextPath}/static/img/title-floor02.png" />
							</h2>
							<div class="hot_list">
								<h3>热门TOP</h3>
								<ul>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=20101">标签机</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=20201">激光传真机</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=20307">条码打印机</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=20402">激光一体机</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=20502">复印机</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=20506">印刷机</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=20601">考勤机</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=20801">平板扫描仪</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=20901">投影机</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=20602">门禁设备</a>
								</ul>
							</div>
							<!--sidebar-->
						</div>
						<div class="goods_list">
							<div class="top_list clearfix">
								<div class="photo_list item_left">
									<img src="${pageContext.request.contextPath}/static/img/img-computer_product02.jpg" />
								</div>
								<div class="product_list item_left">
									<ul>
										<li><a href="${pageContext.request.contextPath}/market/goods/show?gid=1100149679EA&sid=2"><img src="${pageContext.request.contextPath}/static/img/goods05.jpg" /></a></li>
										<li><a href="${pageContext.request.contextPath}/market/goods/show?gid=1100153070EA&sid=2"><img src="${pageContext.request.contextPath}/static/img/goods06.jpg" /></a></li>
									</ul>
								</div>
							</div>
							<div class="middle_list clearfix">
								<ul>
									<li><a href="${pageContext.request.contextPath}/market/goods/show?gid=1050020&sid=1"><img src="${pageContext.request.contextPath}/static/img/goods07.jpg" /></a></li>
									<li><a href="${pageContext.request.contextPath}/market/goods/show?gid=1042905&sid=1"><img src="${pageContext.request.contextPath}/static/img/goods08.jpg" /></a></li>
								</ul>
							</div>
							<div class="logo_list">
								<ul class="clearfix">
									<li><a href="${pageContext.request.contextPath}/market/goods/search?cat=2&brand=%BC%D1%C4%DC"><img src="${pageContext.request.contextPath}/static/img/logo04.jpg" /></a></li>
									<li><a href="${pageContext.request.contextPath}/market/goods/search?cat=2&brand=%C8%FD%C4%BE"><img src="${pageContext.request.contextPath}/static/img/logo05.jpg" /></a></li>
									<li><a href="${pageContext.request.contextPath}/market/goods/search?cat=2&brand=%D0%D6%B5%DC"><img src="${pageContext.request.contextPath}/static/img/logo06.jpg" /></a></li>
								</ul>
							</div>
							<!--.goods_list-->
						</div>
						<!--.iteam_area-->
					</div>
					<!--.section-->
				</div>
				<div class="section clearfix">
					<div class="item_area item_left">
						<div class="sidebar">
							<h2>
								<img src="${pageContext.request.contextPath}/static/img/title-floor03.png" />
							</h2>
							<div class="hot_list">
								<h3>热门TOP</h3>
								<ul>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=70105">湿巾纸</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=70202">清洁剂</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=70302">洗手液</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=70301">沐浴/香皂</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=70401">一次性餐具</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=70501">水杯/保温杯</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=70601">电池/充电器</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=70707">手提袋</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=70901">垃圾袋</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=70902">垃圾桶</a>
								</ul>
							</div>
							<!--sidebar-->
						</div>
						<div class="goods_list">
							<div class="top_list clearfix">
								<div class="photo_list item_left">
									<img src="${pageContext.request.contextPath}/static/img/img-computer_product03.jpg" />
								</div>
								<div class="product_list item_left">
									<ul>
										<li><a href="${pageContext.request.contextPath}/market/goods/show?gid=1100168174EA&sid=2"><img src="${pageContext.request.contextPath}/static/img/goods09.jpg" /></a></li>
										<li><a href="${pageContext.request.contextPath}/market/goods/show?gid=1100013900EA&sid=2"><img src="${pageContext.request.contextPath}/static/img/goods10.jpg" /></a></li>
									</ul>
								</div>
							</div>
							<div class="middle_list clearfix">
								<ul>
									<li><a href="${pageContext.request.contextPath}/market/goods/show?gid=1048420&sid=1"><img src="${pageContext.request.contextPath}/static/img/goods11.jpg" /></a></li>
									<li><a href="${pageContext.request.contextPath}/market/goods/show?gid=355022&sid=1"><img src="${pageContext.request.contextPath}/static/img/goods12.jpg" /></a></li>
								</ul>
							</div>
							<div class="logo_list">
								<ul class="clearfix">
									<li><a href="#"><img src="${pageContext.request.contextPath}/static/img/logo07.jpg" /></a></li>
									<li><a href="#"><img src="${pageContext.request.contextPath}/static/img/logo08.jpg" /></a></li>
									<li><a href="#"><img src="${pageContext.request.contextPath}/static/img/logo09.jpg" /></a></li>
								</ul>
							</div>
							<!--.goods_list-->
						</div>
						<!--.iteam_area-->
					</div>
					<div class="item_area item_right">
						<div class="sidebar">
							<h2>
								<img src="${pageContext.request.contextPath}/static/img/title-floor04.png" />
							</h2>
							<div class="hot_list">
								<h3>热门TOP</h3>
								<ul>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=30101">台式电脑</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=30102">笔记本电脑</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=30103">平板电脑</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=30201">U盘</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=30202">内存条</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=30304">摄像头</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=30505">显示器</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=30602">交换机</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=30603">路由器</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=30605">无线网卡</a>
									<a href="${pageContext.request.contextPath}/market/goods/search?cat=30606">机柜</a>
								</ul>
							</div>
							<!--sidebar-->
						</div>
						<div class="goods_list">
							<div class="top_list clearfix">
								<div class="photo_list item_left">
									<img src="${pageContext.request.contextPath}/static/img/img-computer_product04.jpg" />
								</div>
								<div class="product_list item_left">
									<ul>
										<li><a href="${pageContext.request.contextPath}/market/goods/show?gid=1100004785EA&sid=2"><img src="${pageContext.request.contextPath}/static/img/goods13.jpg" /></a></li>
										<li><a href="${pageContext.request.contextPath}/market/goods/show?gid=1100173861EA&sid=2"><img src="${pageContext.request.contextPath}/static/img/goods14.jpg" /></a></li>
									</ul>
								</div>
							</div>
							<div class="middle_list clearfix">
								<ul>
									<li><a href="${pageContext.request.contextPath}/market/goods/show?gid=1052495&sid=1"><img src="${pageContext.request.contextPath}/static/img/goods15.jpg" /></a></li>
									<li><a href="${pageContext.request.contextPath}/market/goods/show?gid=1042263&sid=1"><img src="${pageContext.request.contextPath}/static/img/goods16.jpg" /></a></li>
								</ul>
							</div>
							<div class="logo_list">
								<ul class="clearfix">
									<li><a href="${pageContext.request.contextPath}/market/goods/search?cat=3&brand=%B4%F7%B6%FB"><img src="${pageContext.request.contextPath}/static/img/logo10.jpg" /></a></li>
									<li><a href="${pageContext.request.contextPath}/market/goods/search?cat=3&brand=TP-LINK"><img src="${pageContext.request.contextPath}/static/img/logo11.jpg" /></a></li>
									<li><a href="#"><img src="${pageContext.request.contextPath}/static/img/logo12.jpg" /></a></li>
								</ul>
							</div>
							<!--.goods_list-->
						</div>
						<!--.iteam_area-->
					</div>
					<!--.section-->
				</div>
				<div class="section shop_list">
					<h2>
						<img src="${pageContext.request.contextPath}/static/img/title-shop_list.gif" alt="" />
					</h2>
					<ul class="clearfix">
						<li><a href="http://bid.aited.cn/" target="_blank"><img src="${pageContext.request.contextPath}/static/img/logo-shop_avic.gif" alt="" /></a></li>
						<li><a href="http://www.jd.com" target="_blank"><img src="${pageContext.request.contextPath}/static/img/logo-shop02.gif" alt="" /></a></li>
						<li><a href="http://www.suning.com" target="_blank"><img src="${pageContext.request.contextPath}/static/img/logo-shop07.gif" alt="" /></a></li>
						<li><a href="http://www.yibiaotang.com" target="_blank"><img src="${pageContext.request.contextPath}/static/img/logo-shop13.gif" alt="" /></a></li>
						<li><a href="http://www.mg-pen.com/" target="_blank"><img src="${pageContext.request.contextPath}/static/img/logo-shop_mg.gif" alt="" /></a></li>
						<li class="last"><a href="http://www.staples.cn" target="_blank"><img src="${pageContext.request.contextPath}/static/img/logo-shop_staples.gif" alt="" /></a></li>
					</ul>
				</div>
				<!--.inner-->
			</div>
			<!--#contents-->
		</div>
		<jsp:include page="footer.jsp" />
		<!--.page-wrapper-->
	</div>
	<script>
		$('.photo_box').each(function() {
			$(this).luara({
				width : "520",
				height : "272",
				interval : 4500,
				selected : "seleted",
				deriction : "left"
			});
		});

		$(".banner_list").luara({
			width : "989",
			height : "441",
			interval : 4500,
			selected : "seleted",
			deriction : "left"
		});

		$(".banner_list").find("ol li").each(function(idx) {
			$(this).append('<img src="${pageContext.request.contextPath}/static/img/' + (idx) + 's.jpg" width="185px" height="72px" alt="" />');
		});


		$(".banner_list .left_btn").eq(0).append('<img src="${pageContext.request.contextPath}/static/img/icon_left.png" alt="" />').click(function() {
			/*
			var ol = $(".banner_list ol");
			var left = parseInt(ol.css("left"));
			left -= 185;
			var max = ol.width() - 685;

			if (max < 0) {
				return;
			}

			if (left < -max) {
				left = -max;
			}

			ol.animate({
				left : left + "px"
			});
			*/
		});
		$(".banner_list .right_btn").eq(0).append('<img src="${pageContext.request.contextPath}/static/img/icon_right.png" alt="" />').click(function() {
			/*
			var ol = $(".banner_list ol");
			var left = parseInt(ol.css("left"));
			left += 185;

			if (left > 0) {
				left = 0;
			}

			ol.animate({
				left : left + "px"
			});
			*/
		});
		/*
		<a class="arrow"><img src="${pageContext.request.contextPath}/static/img/icon_left.png" alt="" /></a>
		<li><img src="${pageContext.request.contextPath}/static/img/bnr_list_small.jpg" alt="" /></li>
		<li><img src="${pageContext.request.contextPath}/static/img/bnr_list_small.jpg" alt="" /></li>
		<li><img src="${pageContext.request.contextPath}/static/img/bnr_list_small.jpg" alt="" /></li>
		<li><img src="${pageContext.request.contextPath}/static/img/bnr_list_small.jpg" alt="" /></li>
		<li><img src="${pageContext.request.contextPath}/static/img/bnr_list_small.jpg" alt="" /></li>
		<a class="arrow"><img src="${pageContext.request.contextPath}/static/img/icon_right.png" alt="" /></a>
		 */
		 /*


		$(".banner_list ol").width($(".banner_list").find("ol li").size() * 138);
		*/
	</script>
</body>
</html>
