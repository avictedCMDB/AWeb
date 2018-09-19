<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">


var compareAdd = function (sid, gid) {
	async('${pageContext.request.contextPath}/market/goods/compare/add', {sid:sid, gid:gid}, function (msg) {
		compareShow(msg.result);
	}, function (msg) {
		if (msg.status == 10) {
			alert("ֻ��ͬ����Ʒ���бȶ�");
			compareShow(msg.result);
		} else if (msg.status == 20) {
			alert("�Ա�������");
			compareShow(msg.result);
		} else {
			alert(msg.result);
		}
	});
}

var compareShow = function (result) {

	var lis = $("#compare #compare_main ul li");
	var i = 0;
	if (result != null) {
		for (; i < result.length; i++) {
			var item = result[i];
			
			var li = lis.eq(i);
			li.html("");
			var img = $("<img>");
			img.width(60);
			img.height(60);
			if (item.supType == 1) {
				img.attr("src", '${pageContext.request.contextPath}' + (item.imagePath ? item.imagePath : '/static/img/img-profession.jpg'));
			} else{
				img.attr("src", item.imagePath);
			}
			var p = $("<p>");
			p.append(img);
			li.append(p);

			var dl = $("<dl>");
			dl.css("paddingTop", "6px");
			var dt = $("<dt>");
			dt.text(item.goodsName);
			dt.css({height:"34px", overflow:"hidden", wordBreak:"break-all"});
			var dd = $("<dd>");
			dd.addClass("font-color-red");
			dd.text("��" + item.agreePrice);
			dl.append(dt);
			dl.append(dd);
			li.append(dl);
			
			/*
			<div class="close_goods">
              <span><a href="javascript:;"><i class="fa fa-close"></i></a></span>
            </div>
			*/
			
			var close = $("<div>");
			close.addClass("close_goods");
			close.attr("data-sid", item.supId);
			close.attr("data-gid", item.supGoodsId);
			close.click(function () {

				var sid = $(this).attr("data-sid");
				var gid = $(this).attr("data-gid");
				
				async('${pageContext.request.contextPath}/market/goods/compare/remove', {sid:sid, gid:gid}, function (msg) {
					compareShow(msg.result);
				});
			});
			
			li.append(close);
			
			close.html('<span><a href="javascript:;"><i class="fa fa-close"></i></a></span>');

			$("#sid_" + i).val(item.supId);
			$("#gid_" + i).val(item.supGoodsId);
		}
	}

	for (var j = i; j < 4; j++) {

		var li = lis.eq(j);
		li.html("");
		var img = $("<img>");
		img.width(60);
		img.height(60);
		img.attr("src", "${pageContext.request.contextPath}/static/img/product-detail/img-compare0" + (j + 1) + ".jpg");
		var p = $("<p>");
		p.append(img);
		li.append(p);
		
		p = $("<p>");
		p.addClass("txt");
		p.text("�������Լ������");
		li.append(p);
		$("#sid_" + i).val("");
		$("#gid_" + i).val("");
	}
	if ($("#product_detail").size() > 0) {
		
	} else {
		$("#compare").css({position:"fixed", left:($(document.body).width() - 1206) / 2 + "px"});
	}
	$("#compare").show();
}
$(function () {
	$("#compare h2 img").click(function () {
		$("#compare").hide();
	});
	
	$("#compare_clear").click(function () {
		async('${pageContext.request.contextPath}/market/goods/compare/clear', null, function (msg) {
			compareShow(null);
		});
	});


	$("#compare_next").click(function () {
		if ($("#sid_2").val() == "") {
			alert("�Ա���Ҫ����������Ʒ");
			return false;
		}
		
		$("#rtn_url").val(window.location.href);
		$("#compare_form").submit();
		
		return false;
	});
});
</script>
<div id="compare" style="display:none;">
	<h2>
		�Ա���<span><img src="${pageContext.request.contextPath}/static/img/product-detail/btn-close.gif" style="cursor:pointer;" alt=""></span>
	</h2>
	<div id="compare_main" class="clearfix">
		<ul>
			<li>
				<p>
					<img src="${pageContext.request.contextPath}/static/img/product-detail/img-compare01.jpg" alt="">
				</p>
				<p class="txt">�������Լ������</p>
			</li>
			<li>
				<p>
					<img src="${pageContext.request.contextPath}/static/img/product-detail/img-compare02.jpg" alt="">
				</p>
				<p class="txt">�������Լ������</p>
			</li>
			<li>
				<p>
					<img src="${pageContext.request.contextPath}/static/img/product-detail/img-compare03.jpg" alt="">
				</p>
				<p class="txt">�������Լ������</p>
			</li>
			<li>
				<p>
					<img src="${pageContext.request.contextPath}/static/img/product-detail/img-compare04.jpg" alt="">
				</p>
				<p class="txt">�������Լ������</p>
			</li>
			<li class="compare_btn">
				<div>
					<a href="#" id="compare_next"><img src="${pageContext.request.contextPath}/static/img/product-detail/btn-compare.gif" alt="�Ա�"></a>
				</div>
				<div class="mt-5">
					<a href="javascript:void(0);" id="compare_clear">��նԱ���</a>
				</div>
			</li>
		</ul>
	</div>
	<form action="${pageContext.request.contextPath}/management/compare/detail" method="post" id="compare_form">
		<input type="hidden" name="supOneID" id="sid_0">
		<input type="hidden" name="supGoodsOneID" id="gid_0">
		<input type="hidden" name="supTwoID" id="sid_1">
		<input type="hidden" name="supGoodsTwoID" id="gid_1">
		<input type="hidden" name="supThreeID" id="sid_2">
		<input type="hidden" name="supGoodsThreeID" id="gid_2">
		<input type="hidden" name="supFourID" id="sid_3">
		<input type="hidden" name="supGoodsFourID" id="gid_3">
		<input type="hidden" name="returnUrl" id="rtn_url">
	</form>
</div>