<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="/WEB-INF/tlds/tag.tld" prefix="mc"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="生成订单" name="title"/>
	</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/order.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/imgbox.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/profession_order.css" rel="stylesheet">

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/imgUpload.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.imgbox.pack.js"></script>

<style>

#order_details .input-group {
width:auto;
}
#address_content li.active div.add_details,
#invoice_ul li.active div.add_details {
	background: url(${pageContext.request.contextPath}/static/img/order/icon_on.png) left top no-repeat;
}
#address_content li div.selected_icon,
#invoice_ul li div.selected_icon {
	display:none;
}

#address_content li.active div.selected_icon,
#invoice_ul li.active div.selected_icon  {
	display:block;
}
.dl-horizontal dd a {
	color:#0091dc;
}

.show-000, .hide-000, .contract-show {
	display:none;
}

.mask {
	position:fixed;
	top:0;
	left:0;
	right:0;
	bottom:0;
	z-index:20000;
	background:#000;
	opacity:0.5;
	display:none;
}
#add_address, #info_invoice {
	background:#fff;
	position:absolute;
	top:100px;
	left:0;
	right:0;
	z-index:20001;
	display:none;
}
#add_address {
	height:600px;
}
#add_address .main_inner select {
	width:160px;
}
</style>
<script type="text/javascript">
$(function () {
	$(".pay-gate").click(function () {
		$(".pay-gate.active").removeClass("active");
		$(this).addClass("active");
		
		$("#pay_gate").val($(this).attr("data-type"));
		
		if ($(this).attr("data-type") == "0000") {
			$(".show-0000").hide();
			$(".hide-0000").hide();
		} else {
			$(".show-0000").hide();
			$(".hide-0000").show();
		}
	});
	
	$(".pay-gate.active").trigger("click");
	
	$(".contract-select").click(function () {
		if ($(this).val() == 0) {
			$(".contract-show").hide();
		} else {
			$(".contract-show").show();
		}
	});
	$(".contract-select:checked").trigger("click");
	
	$(".invoice-input-flag").click(function () {
		$(".invoice-input-flag.active").removeClass("active");
		$(this).addClass("active");
		
		$("#invoice-input-flag").val($(this).attr("data-type"));
	});
	

	$("#invoice_edit").click(function () {
		
		$(".mask").show();
		$("#info_invoice").show();
	});
	
	$(".invoice-close").click(function () {

		$(".mask").hide();
		$("#info_invoice").hide();
	});
	
	$("#addr_new").click(function () {
		$(".mask").show();
		$("#add_address").show();
		$("#addr_form").get(0).reset();
		$("#area_city").removeAttr("data-sel");
		$("#area_dist").removeAttr("data-sel");
		$("#area_town").removeAttr("data-sel");
	});
	$("#addr_close").click(function () {
		$(".mask").hide();
		$("#add_address").hide();
	});
	
	
	$("#area_prov,#vat_prov").change(function () {
		var area = $(this).val();
		var $city = $("#" + $(this).attr("id").replace("prov", "city"));
		
		if (area == "") {
			$city.html("<option value=''>市</option>");
		} else {
			$city.html("<option value=''>加载中...</option>");
		}

		$city.trigger("change");

		var supId = ${supId};
		
		if ($(this).attr("id").indexOf("vat") > -1) {
			supId = 1;
		}
		
		if (area != "") {
			async('${pageContext.request.contextPath}/market/order/area', {supId:supId, parent:area}, function (msg) {
				var result = msg.result;
				$city.html("<option value=''>市</option>");
				for (var i = 0; i < result.length; i++) {
					$city.append("<option value='"+result[i].supAreaId+"'>"+result[i].supAreaName+"</option>");
				}
				if ($city.attr("data-sel")) {
					$city.val($city.attr("data-sel"));
					$city.removeAttr("data-sel");
					$city.trigger("change");
				}
			}, function () {
				$city.html("<option value=''>加载失败</option>");
			});
		}
		
	});
	
	$("#area_city,#vat_city").change(function () {
		var area = $(this).val();
		
		var $dist = $("#" + $(this).attr("id").replace("city", "dist"));
		
		if (area == "") {
			$dist.html("<option value=''>区县</option>");
		} else {
			$dist.html("<option value=''>加载中...</option>");
		}

		$dist.trigger("change");
		
		var supId = ${supId};
		
		if ($(this).attr("id").indexOf("vat") > -1) {
			supId = 1;
		}
		
		if (area != "") {
			async('${pageContext.request.contextPath}/market/order/area', {supId:supId, parent:area}, function (msg) {
				var result = msg.result;
				$dist.html("<option value=''>区县</option>");
				for (var i = 0; i < result.length; i++) {
					$dist.append("<option value='"+result[i].supAreaId+"'>"+result[i].supAreaName+"</option>");
				}
				
				if ($dist.attr("data-sel")) {
					$dist.val($dist.attr("data-sel"));
					$dist.removeAttr("data-sel");
					$dist.trigger("change");
				}
			}, function () {
				$dist.html("<option value=''>加载失败</option>");
			});
		}
		
	});
	

	$("#area_dist").change(function () {
		
		if ($("#area_town").size() == 0) return;
		var area = $(this).val();
		
		if (area == "") {
			$("#area_town").html("<option value=''>区县</option>");
		} else {
			$("#area_town").html("<option value=''>加载中...</option>");
		}

		
		if (area != "") {
			async('${pageContext.request.contextPath}/market/order/area', {supId:${supId}, parent:area}, function (msg) {
				var result = msg.result;
				$("#area_town").html("<option value=''>乡镇</option>");
				for (var i = 0; i < result.length; i++) {
					$("#area_town").append("<option value='"+result[i].supAreaId+"'>"+result[i].supAreaName+"</option>");
				}
				
				if ($("#area_town").attr("data-sel")) {
					$("#area_town").val($("#area_town").attr("data-sel"));
					$("#area_town").removeAttr("data-sel");
				}
			}, function () {
				$("#area_town").html("<option value=''>加载失败</option>");
			});
		}
		
	});
	
	$(".alias-name").click(function () {
		$("#address_alias").val($(this).text());
	});
	
	$("#address_btn").click(function () {
		var prov = $("#area_prov").val();
		var city = $("#area_city").val();
		var dist = $("#area_dist").val();
		var town = $("#area_town").val();
		var aid = $("#address_id").val();
		var detail = $.trim($("#address_detail").val());
		var zip = $.trim($("#zip_code").val());
		var name = $.trim($("#address_name").val());
		var phone = $.trim($("#address_phone").val());
		var tel = $.trim($("#address_tel").val());
		var email = $.trim($("#address_email").val());
		var alias = $.trim($("#address_alias").val());
		var supId = ${supId};
		
		var provName = $("#area_prov option:selected").text();
		var cityName = $("#area_city option:selected").text();
		var distName = $("#area_dist option:selected").text();
		var townName = $("#area_town option:selected").text();
		
		$(".form-error").text("");
		var flag = true;
		if (($("#area_town").children().size() > 1 && town == "") || dist == "") {
			$("#area_e").text("请选择所在地区");
			flag = false;
		}
		if (!town) {
			townName = "";
			town = "";
		}
		
		if (detail == "") {
			$("#address_detail_e").text("请输入详细地址");
			flag = false;
		} else if (!chklen("address_detail", "详细地址")) {
			flag = false;
		}
		
		if (name == "") {
			$("#address_name_e").text("请输入收货人姓名");
			flag = false;
		} else if (!chklen("address_name", "收货人姓名")) {
			flag = false;
		}
		
		if (zip == "") {
			$("#zip_code_e").text("请输入邮政编码");
			flag = false;
		} else if (!/^\d+$/.test(zip)) {
			$("#zip_code_e").text("请输入正确的邮政编码");
			flag = false;
		} else if (!chklen("zip_code", "邮政编码")) {
			flag = false;
		}
		
		if (phone == "" && tel == "") {
			$("#address_phone_e").text("请输入联系方式");
			flag = false;
		}
		
		if (phone != "" && !/^\d+$/.test(phone)) {
			$("#address_phone_e").text("请输入正确的手机号码");
			flag = false;
		}
		
		if (phone != "" && !chklen("address_phone", "手机号码")) {
			flag = false;
		}
		
		if (tel != "" && !/^\d+$/.test(tel)) {
			$("#address_phone_e").text("请输入正确的电话号码");
			flag = false;
		}
		if (tel != "" && !chklen("address_phone","电话号码")) {
			flag = false;
		}
		
		if (email == "") {
			$("#address_email_e").text("请输入邮箱");
			flag = false;
		} else if (!/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(email)) {
			$("#address_email_e").text("请输入正确的邮箱地址");
			flag = false;
		} else if (!chklen("address_email", "邮箱地址")) {
			flag = false;
		}
		
		if (!flag) {
			return;
		}
		
		
		async('${pageContext.request.contextPath}/market/order/address', {aid:aid, prov:prov, city:city, dist:dist, town:town, detail:detail, name:name, zip:zip, phone:phone, tel:tel, email:email, supId:supId, alias:alias}, function (msg) {


	        var dl = $("<dl>");
	        dl.attr("id", "address_" + msg.result);
	        dl.addClass("dl-horizontal");
	        
	        var dt = $("<dt>");
	        dl.append(dt);
	        
	        var a = $("<a>");
	        a.addClass("addr-name");
	        a.attr("href", "javascript:void(0);");

	        a.attr("data-id", msg.result);
	        a.attr("data-prov", prov);
	        a.attr("data-city", city);
	        a.attr("data-dist", dist);
	        a.attr("data-town", town);
	        a.attr("data-prov-name", provName);
	        a.attr("data-city-name", cityName);
	        a.attr("data-dist-name", distName);
	        a.attr("data-town-name", townName);
	        a.attr("data-detail", detail);
	        a.attr("data-name", name);
	        a.attr("data-zip", zip);
	        a.attr("data-phone", phone);
	        a.attr("data-tel", tel);
	        a.attr("data-email", email);
	        a.attr("data-alias", alias);
	        
	        a.text(alias == "" ? name : alias);
	        
	        a.click(addressClick);
	        dt.append(a);
	        
	        var dd = $("<dd>");
	        dl.append(dd);
	        
	        var span = $("<span>");
	        span.text(name);
	        dd.append(span);
	        
	        span = $("<span>");
	        span.text(cityName + distName + townName + detail);
	        dd.append(span);
	        
	        span = $("<span>");
	        span.text(phone == "" ? tel : phone);
	        dd.append(span);
	        
	        
	        var edit = $("<a>");
	        edit.attr("href", "javascript:void(0)");
	        edit.addClass("address_edit");
	        edit.text("修改");
	        dd.append(edit);
	        edit.click(addressEdit);
	        
			  $("#address_" + aid).remove();
			  $("#addr_container").prepend(dl);
			  a.trigger("click");
		});
		
	  
	  $("#addr_form").get(0).reset();
	
	  
	  $(".mask").hide();
	  $("#add_address").hide();

	});
	
	$(".address_edit").click(addressEdit);
	
	$("#invoice_save").click(function () {
		var flag = $(".invoice-input-flag.active").attr("data-val");
		var content = flag == 1 ? "" : $(".invoice-input-flag.active").text();
		var company = $.trim($("#invoice_input_company").val());
		var num = $.trim($("#invoice_input_num").val());
		
		
		if (company == "") {
			alert("请输入发票抬头");
			return;
		}

		if (num == "") {
			alert("请输入纳税人识别号");
			return;
		}

		async('${pageContext.request.contextPath}/market/order/invoice', {flag:flag, content:content, company:company, num:num}, function (msg) {
			// <span id="invoice_show_type">普通发票（纸质）</span><span id="invoice_show_name">${invoice.companyName}</span><span id="invoice_show_content"><c:if test="${invoice.invoiceFlag == 1}">明细</c:if><c:if test="${invoice.invoiceFlag != 1}">${invoice.invoiceContent}</c:if></span>
        	$("#invoice_show_type").text("增值税普通发票（纸质）");
        	$("#invoice_show_name").text(company);
        	$("#invoice_show_content").text(flag == 1 ? "明细" : content);
        	
/*
            <input type="hidden" id="invoice_type" name="invoice_type" value="1"/>
            <input type="hidden" id="invoice_flag" name="invoice_flag" value="${invoice.invoiceFlag }"/>
            <input type="hidden" id="invoice_content" name="invoice_content" value="${invoice.invoiceContent }"/>
            <input type="hidden" id="invoice_company" name="invoice_company" value="${invoice.companyName }"/>
            <input type="hidden" id="invoice_num" name="invoice_num" value=""/>
            <input type="hidden" id="vat_receive_name" name="vat_receive_name" value=""/>
            <input type="hidden" id="vat_receive_tel" name="vat_receive_tel" value=""/>
            <input type="hidden" id="vat_receive_prov" name="vat_receive_prov" value=""/>
            <input type="hidden" id="vat_receive_city" name="vat_receive_city" value=""/>
            <input type="hidden" id="vat_receive_dist" name="vat_receive_dist" value=""/>
            <input type="hidden" id="vat_receive_detail" name="vat_receive_detail" value=""/>
            
            */
            
            $("#invoice_type").val("1");
            $("#invoice_flag").val(flag);
            $("#invoice_content").val(content);
            $("#invoice_company").val(company);
            $("#invoice_num").val(num);
            $("#vat_receive_name").val("");
            $("#vat_receive_tel").val("");
            $("#vat_receive_prov").val("");
            $("#vat_receive_city").val("");
            $("#vat_receive_dist").val("");
            $("#vat_receive_detail").val("");

    		$(".mask").hide();
    		$("#info_invoice").hide();
            
		});
		
	});
	
	$(".invoice-tab").click(function () {
		if ($(this).hasClass("active")) {
			return;
		}
		
		$(".invoice-tab.active").removeClass("active");
		$(this).addClass("active");
		
		if ($(this).attr("data-type") == "2") {
			$(".private_detail").hide();
			$(".vat_detail").show();
		} else {
			$(".private_detail").show();
			$(".vat_detail").hide();
		}
		
	});
	
	$("#vat_next").click(function () {
		$(".step01").hide();
		$(".step02").show();
	});
	$("#vat_prev").click(function () {
		$(".step01").show();
		$(".step02").hide();
	});
	
	$("#vat_save").click(function () {
		var name = $.trim($("#vat_name").val());
		var phone = $.trim($("#vat_phone").val());
		var prov = $.trim($("#vat_prov").val());
		var city = $.trim($("#vat_city").val());
		var dist = $.trim($("#vat_dist").val());
		var addr = $.trim($("#vat_addr").val());
		
		if (name == "") {
			alert("请输入收票人姓名");
			return;
		}
		if (phone == "") {
			alert("请输入收票人手机");
			return;
		} else if (!/^[0-9]+$/.test(phone)) {
			alert("请输入正确的手机号码");
			return;
		}
		if (prov == "") {
			alert("请选择省份");
			return;
		}
		if (city == "") {
			alert("请选择城市");
			return;
		}
		if (dist == "") {
			alert("请选择区县");
			return;
		}
		if (addr == "") {
			alert("请输入详细地址");
			return;
		}
		



		async('${pageContext.request.contextPath}/market/order/vat', {name:name, phone:phone, prov:prov, city:city, dist:dist, addr:addr}, function (msg) {
			// <span id="invoice_show_type">普通发票（纸质）</span><span id="invoice_show_name">${invoice.companyName}</span><span id="invoice_show_content"><c:if test="${invoice.invoiceFlag == 1}">明细</c:if><c:if test="${invoice.invoiceFlag != 1}">${invoice.invoiceContent}</c:if></span>
        	$("#invoice_show_type").text("增值税专用发票");
        	$("#invoice_show_name").text("${vat.companyName}");
        	$("#invoice_show_content").text("明细");
        	
            
            $("#invoice_type").val("2");
            $("#invoice_flag").val("1");
            $("#invoice_content").val("");
            $("#invoice_company").val("");
            $("#invoice_num").val("");
            $("#vat_receive_name").val(name);
            $("#vat_receive_tel").val(phone);
            $("#vat_receive_prov").val(prov);
            $("#vat_receive_city").val(city);
            $("#vat_receive_dist").val(dist);
            $("#vat_receive_detail").val(addr);

    		$(".mask").hide();
    		$("#info_invoice").hide();
            
		});
		
	});
	
	$("#submit_btn").click(function () {
		if (!addressCheck) {
			alert("配送到当前地址的库存不足，请切换其他地址或选择其他商品下单");
			return;
		}
		
		if ($("#addr_dist").val() == "" || $("#addr_detail").val() == "" || $("#addr_name").val() == "") {
			alert("请选择地址");
			return;
		}
		
		if ($.trim($("#decide_reason_input").val()) != "" && $("#decide_reason_input").val().length > 200) {
			alert("决策理由最多200字");
			return;
		}
		
		$("#decide_reason").val($.trim($("#decide_reason_input").val()));
		
		var imgArray = new Array();

		var imgObj = $('input:hidden[name=hidden_path]');

		imgObj.each(function(i){

		         imgArray.push(imgObj[i].value);

		});
		
		if ($("#pay_gate").val() == "0000") {
			var if_contract = $(".contract-select:checked").val();
			var contract_name = $.trim($("#contract_name_input").val());
			var sup_name = $.trim($("#sup_name_input").val());
			var sign_date = $("#sign_date_input").val();
			var contract_price = $("#contract_price_input").val();
			var buy_type = $(".buy-type:checked").val();
			var remark = $.trim($("#remark_input").val());
			$("#if_contract").val(if_contract);
			if(if_contract == 1) {
				if (contract_name == "") {
					alert("请输入合同名称");
					return false;
				}
				if (sup_name == "") {
					alert("请输入供应商名称");
					return false;
				}
				if (sign_date == "") {
					alert("请选择签订时间");
					return false;
				}
				if (contract_price == "") {
					alert("请输入合同金额");
					return false;
				} else {
					var price = 0;
					try {
						price = parseFloat(contract_price);
					} catch (e) {
					}
					
					if (price && price > 0) {
					} else {
						alert("合同金额必须为正确的数字");
						return false;
					}
				}

				$("#if_contract").val(if_contract);
				$("#contract_name").val(contract_name);
				$("#sup_name").val(sup_name);
				$("#sign_date").val(sign_date);
				$("#contract_price").val(contract_price);
				$("#buy_type").val(buy_type);
				$("#remark").val(remark);
			}
		} else {
			$("#if_contract").val("0");
			$("#contract_name").val("");
			$("#sup_name").val("");
			$("#sign_date").val("");
			$("#contract_price").val("");
			$("#buy_type").val("");
			$("#remark").val("");
		}

		var imgPaths = imgArray.join(",");
		$("#imgs_hidden").val(imgPaths);
		
		$("#submit_form").submit();
	});
	
	$("#addr_container .addr-name").click(addressClick);
	
	if ($("#addr_container .dl-horizontal").size() > 0) {
		$("#addr_container .dl-horizontal").eq(0).show();
		$("#addr_container .addr-name").eq(0).trigger("click");
	}
	
	$("#addr_more").click(function () {
		$("#addr_container .dl-horizontal").show();
		$(this).remove();
	});
	
	
	var total = 0;
	$(".goods-price").each(function () {
		total += parseFloat($(this).text());
	});
	
	$("#total_price").text(total.toFixed(2));
});

var addressEdit = function () {
	var addr = $(this).parent().parent().find(".addr-name");
	$("#area_prov").val(addr.attr("data-prov"));
	$("#area_prov").trigger("change");
	$("#area_city").attr("data-sel", addr.attr("data-city"));
	$("#area_dist").attr("data-sel", addr.attr("data-dist"));
	$("#area_town").attr("data-sel", addr.attr("data-town"));
	$("#address_id").val(addr.attr("data-id"));
	$("#address_detail").val(addr.attr("data-detail"));
	$("#zip_code").val(addr.attr("data-zip"));
	$("#address_name").val(addr.attr("data-name"));
	$("#address_phone").val(addr.attr("data-phone"));
	$("#address_tel").val(addr.attr("data-tel"));
	$("#address_email").val(addr.attr("data-email"));
	$("#address_alias").val(addr.attr("data-alias"));
	$(".mask").show();
	$("#add_address").show();
};

var chklen = function (oid, label) {
	var obj = $("#" + oid);
	if (!obj.attr("maxlength")) {
		return true;
	}
	if (obj.val().length <= obj.attr("maxlength")) {
		return true;
	}
	
	$("#" + oid + "_e").text(label + "最大长度" + obj.attr("maxlength"));
	
	return false;
}

var addressCheck = true;
var supType = ${supType};
var addressClick = function () {
	
	
	if ($(this).hasClass("active")) {
		return;
	}

	$("#addr_container .addr-name.active").removeClass("active");
	$(this).addClass("active");
	
	
	var prov = $(this).attr("data-prov");
	var city = $(this).attr("data-city");
	var dist = $(this).attr("data-dist");
	var town = $(this).attr("data-town");
	var provName = $(this).attr("data-prov-name");
	var cityName = $(this).attr("data-city-name");
	var distName = $(this).attr("data-dist-name");
	var townName = $(this).attr("data-town-name");
	var detail = $(this).attr("data-detail");
	var zip = $(this).attr("data-zip");
	var name = $(this).attr("data-name");
	var phone = $(this).attr("data-phone");
	var tel = $(this).attr("data-tel");
	var email = $(this).attr("data-email");

	var supId = ${supId};


	if (supType == 0) {
		addressCheck = false;
		async('${pageContext.request.contextPath}/market/order/check', {prov:prov, city:city, dist:dist, town:town, goods:$("#ids_hidden").val(), supId:supId}, function (msg) {
			addressCheck = true;
		});
	}

	$("#address_all").html('<span>寄送至：</span>' + provName + " " + cityName + " " + distName + " " + (townName == "" ? "" : townName + " ") + " " + detail);
	$("#address_contact").html('<span>收货人：</span>' + name + " " + (phone == "" ? tel : phone));
	
	
	$("#addr_prov").val(prov);
	$("#addr_city").val(city);
	$("#addr_dist").val(dist);
	$("#addr_town").val(town);
	$("#addr_detail").val(detail);
	$("#addr_name").val(name);
	$("#addr_zip").val(zip);
	$("#addr_phone").val(phone);
	$("#addr_tel").val(tel);
	$("#addr_email").val(email);
	$("#addr_all").val(provName + " " + cityName + " " + distName + " " + (townName == "" ? "" : townName + " ") + " " + detail);
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
    <!--#nav_area--></div>
  <div id="contents">
    <div class="inner">
      <div class="breadcrumb clearfix">
        <ul>
          <li><a href="${pageContext.request.contextPath}">首页</a><span>&gt;</span></li>
          <li>生成订单</li>
        </ul>
        <!--.breadcrumb--> 
      </div>
      <div id="order_details">
        <div class="section_main pro_info">
          <h2>商品信息</h2>
          <table>
            <tr>
              <th colspan="2">商品名称</th>
              <th width="200">单价（元）</th>
              <th width="200">数量（个）</th>
              <th width="200">总价（元）</th>
            </tr>
            <c:forEach var="item" items="${goods}">
            <tr>
              <td class="left_align" width="77">
                <p class="img_pro"><a href="${pageContext.request.contextPath}/market/goods/show?sid=${item.supId}&gid=${item.supGoodsId}">
				<c:if test="${item.supType == 1}">
                <img width="60px" height="60px" alt="" src="${pageContext.request.contextPath}${item.imagePath == null ? '/static/img/img-profession.jpg' : item.imagePath}">
				</c:if>
				<c:if test="${item.supType == 0}">
                <img width="60px" height="60px" alt="" src="${item.imagePath}">
				</c:if>
                </a></p>
              </td>
              <td class="left_align"><a href="${pageContext.request.contextPath}/market/goods/show?sid=${item.supId}&gid=${item.supGoodsId}">${fn:escapeXml(item.goodsName)}<c:if test="${item.supType == 1}">（${fn:escapeXml(item.goodsModel)}）</c:if></a></td>
              <td><fmt:formatNumber value="${item.agreePrice}" pattern="#0.00#"></fmt:formatNumber></td>
              <td>
                ${item.buyNum }
              </td>
              <td class="goods-price"><fmt:formatNumber value="${item.agreePrice * item.buyNum}" pattern="#0.00#"></fmt:formatNumber></td>
            </tr>
            </c:forEach>
          </table>
        </div>
        <div class="info_list section_main">
          <h2>地址信息</h2>
          
          <div class="icon_action" id="addr_container">
          <c:if test="${!empty address}">
            <c:forEach varStatus="sta" var="item" items="${address}">
            <dl class="dl-horizontal" id="address_${item.addressId}" style="display:none;">
              <dt><a class="addr-name" href="javascript:void(0);" data-alias="${item.alias}" data-id="${item.addressId}" data-prov="${item.areaLevelOne}" data-city="${item.areaLevelTwo}" data-email="${item.email}" data-dist="${item.areaLevelThree}" data-town="${item.areaLevelFour}" data-prov-name="${item.areaLevelOneName}" data-city-name="${item.areaLevelTwoName}" data-dist-name="${item.areaLevelThreeName}" data-town-name="${item.areaLevelFourName }" data-detail="${fn:escapeXml(item.addressDetail) }" data-name="${fn:escapeXml(item.name) }" data-zip="${item.zipCode }" data-phone="${item.phone }" data-tel="${item.tel }">${item.alias == null || item.alias == "" ? item.name : item.alias}</a></dt>
              <dd><span>${item.name}</span><span>${item.areaLevelTwoName}${item.areaLevelThreeName}${item.areaLevelFourName}${fn:escapeXml(item.addressDetail)}</span><span>${item.phone == '' ? item.tel : item.phone}</span><a href="javascript:void(0);" class="address_edit">修改</a></dd>
            </dl>
            </c:forEach>
            <p class="more"><a href="javascript:void(0);" id="addr_more">更多地址<i class="fa fa-angle-double-down"></i></a></p>
          </c:if>
            <div class="add_address">
              <div class="btn_add"><a href="javascript:void(0);" id="addr_new">新增收货地址</a></div>
            </div>
          </div>
        </div>
        <c:if test="${showPay == 1}">
        <div class="info_list section_main" >
          <h2>支付方式</h2>
          <div class="icon_action list_section">
            <ul class="clearfix">
              <li><a href="javascript:void(0);" data-type="0002" class="pay-gate <c:if test="${supType == 0}">active</c:if>"><span><img src="${pageContext.request.contextPath}/static/img/icon-bank.gif" /></span>企业支付</a></li>
              <li><a href="javascript:void(0);" data-type="0001" class="pay-gate"><span><img src="${pageContext.request.contextPath}/static/img/icon-bank.gif" /></span>个人支付</a></li>
              <li><a href="javascript:void(0);" data-type="0004" class="pay-gate"><span><img src="${pageContext.request.contextPath}/static/img/icon-bank.gif" /></span>无卡支付</a></li>
              <c:if test="${supType == 1}">
              <li><a href="javascript:void(0);" data-type="0000" class="pay-gate active">线下支付</a></li>
              </c:if>
              <li><a href="javascript:void(0);" data-type="0005" class="pay-gate"><span><img src="${pageContext.request.contextPath}/static/img/icon-alipay.gif" /></span>
              支付宝</a></li>
              
            </ul>            
          </div>
        </div>
        </c:if>
        
        <div class="info_list section_main  hide-0000">
          <h2>发票信息</h2>
          <div class="icon_action">
            <div class="default_style">
            <p>
            <c:choose>
            	<c:when test="${invoice != null }">
              		<span id="invoice_show_type">增值税普通发票（纸质）</span><span id="invoice_show_name">${invoice.companyName}</span><span id="invoice_show_content"><c:if test="${invoice.invoiceFlag == 1}">明细</c:if><c:if test="${invoice.invoiceFlag != 1}">${invoice.invoiceContent}</c:if></span>
            	</c:when>
            	<c:when test="${invoice == null }">
              		<span id="invoice_show_type">增值税普通发票（纸质）</span><span id="invoice_show_name">个人</span><span id="invoice_show_content">明细</span>
            	</c:when>
            	<c:when test="${vat != null and vat.auditStatus == '0' }">
              		<span id="invoice_show_type">增值税专用发票</span><span id="invoice_show_name">${vat.companyName}</span><span id="invoice_show_content">明细</span>
            	</c:when>
            </c:choose>
            <span><a href="javascript:void(0);" id="invoice_edit">修改</a></span></p>
            </div>
          </div>
        </div>
        <c:if test="${supType == 0}">
        <div class="info_list section_main">
          <h2>附件 (支持的图片格式为jpg/jpeg/png/gif/bmp，单个图片需小于2M。)</h2>
          <mc:ImgUploadTag mark='buy'></mc:ImgUploadTag>
        </div>
        
        <div class="info_list section_main">        
          <h2>其他信息</h2>
          <dl class="dl-horizontal reason">
            <dd><textarea class="form-control" rows="3" id="decide_reason_input"></textarea><span>限200字 </span></dd>
          </dl>
        </div>
    </c:if>
  
  <form action="${pageContext.request.contextPath}/market/order/submit" method="post" id="submit_form">
        <input type="hidden" id="ids_hidden" name="ids" value="${ids}"/>
        <input type="hidden" id="imgs_hidden" name="imgs" value=""/>
        <input type="hidden" id="express_type" name="express_type" value="1"/>
        <input type="hidden" id="addr_prov" name="addr_prov" value=""/>
        <input type="hidden" id="addr_city" name="addr_city" value=""/>
        <input type="hidden" id="addr_dist" name="addr_dist" value=""/>
        <input type="hidden" id="addr_town" name="addr_town" value=""/>
        <input type="hidden" id="addr_detail" name="addr_detail" value=""/>
        <input type="hidden" id="addr_name" name="addr_name" value=""/>
        <input type="hidden" id="addr_zip" name="addr_zip" value=""/>
        <input type="hidden" id="addr_phone" name="addr_phone" value=""/>
        <input type="hidden" id="addr_tel" name="addr_tel" value=""/>
        <input type="hidden" id="addr_email" name="addr_email" value=""/>
        <input type="hidden" id="addr_all" name="addr_all" value=""/>
        <input type="hidden" id="decide_reason" name="decide_reason" value=""/>
        <input type="hidden" id="pay_gate" name="pay_gate" value="0002"/>
        
        
        
        
        <input type="hidden" id="if_contract" name="if_contract" value="0"/>
        <input type="hidden" id="contract_name" name="contract_name" value=""/>
        <input type="hidden" id="sup_name" name="sup_name" value=""/>
        <input type="hidden" id="sign_date" name="sign_date" value=""/>
        <input type="hidden" id="contract_price" name="contract_price" value=""/>
        <input type="hidden" id="buy_type" name="buy_type" value=""/>
        <input type="hidden" id="remark" name="remark" value=""/>

<c:choose>
	<c:when test="${invoice != null }">
  	
        <input type="hidden" id="invoice_type" name="invoice_type" value="1"/>
        <input type="hidden" id="invoice_flag" name="invoice_flag" value="${invoice.invoiceFlag }"/>
        <input type="hidden" id="invoice_content" name="invoice_content" value="${invoice.invoiceContent }"/>
        <input type="hidden" id="invoice_company" name="invoice_company" value="${invoice.companyName }"/>
        <input type="hidden" id="invoice_num" name="invoice_num" value="${invoice.invoiceNum }"/>
        <input type="hidden" id="vat_receive_name" name="vat_receive_name" value=""/>
        <input type="hidden" id="vat_receive_tel" name="vat_receive_tel" value=""/>
        <input type="hidden" id="vat_receive_prov" name="vat_receive_prov" value=""/>
        <input type="hidden" id="vat_receive_city" name="vat_receive_city" value=""/>
        <input type="hidden" id="vat_receive_dist" name="vat_receive_dist" value=""/>
        <input type="hidden" id="vat_receive_detail" name="vat_receive_detail" value=""/>
    </c:when>
	<c:when test="${invoice == null }">
  	
        <input type="hidden" id="invoice_type" name="invoice_type" value="1"/>
        <input type="hidden" id="invoice_flag" name="invoice_flag" value="1"/>
        <input type="hidden" id="invoice_content" name="invoice_content" value=""/>
        <input type="hidden" id="invoice_company" name="invoice_company" value="个人"/>
        <input type="hidden" id="invoice_num" name="invoice_num" value=""/>
        <input type="hidden" id="vat_receive_name" name="vat_receive_name" value=""/>
        <input type="hidden" id="vat_receive_tel" name="vat_receive_tel" value=""/>
        <input type="hidden" id="vat_receive_prov" name="vat_receive_prov" value=""/>
        <input type="hidden" id="vat_receive_city" name="vat_receive_city" value=""/>
        <input type="hidden" id="vat_receive_dist" name="vat_receive_dist" value=""/>
        <input type="hidden" id="vat_receive_detail" name="vat_receive_detail" value=""/>
	</c:when>
	<c:when test="${vat != null and vat.auditStatus == '0' }">
        <input type="hidden" id="invoice_type" name="invoice_type" value="2"/>
        <input type="hidden" id="invoice_flag" name="invoice_flag" value=""/>
        <input type="hidden" id="invoice_content" name="invoice_content" value=""/>
        <input type="hidden" id="invoice_company" name="invoice_company" value=""/>
        <input type="hidden" id="invoice_num" name="invoice_num" value=""/>
        <input type="hidden" id="vat_receive_name" name="vat_receive_name" value="${vat.vatReceiveName}"/>
        <input type="hidden" id="vat_receive_tel" name="vat_receive_tel" value="${vat.vatReceiveTel}"/>
        <input type="hidden" id="vat_receive_prov" name="vat_receive_prov" value="${vat.vatReceiveProv}"/>
        <input type="hidden" id="vat_receive_city" name="vat_receive_city" value="${vat.vatReceiveCity}"/>
        <input type="hidden" id="vat_receive_dist" name="vat_receive_dist" value="${vat.vatReceiveDist }"/>
        <input type="hidden" id="vat_receive_detail" name="vat_receive_detail" value="${vat.vatReceiveDetail }"/>
	</c:when>
</c:choose>
  </form>
        <c:if test="${supType == 1}">
        <div class="info_list section_main show-0000">
          <h2>是否续订合同</h2>
          <div class="icon_action list_section">
            <label class="checkbox-inline">
                <input type="radio" name="contract" class="contract-select" value="1">是
            </label>
            <label class="checkbox-inline special">
                <input type="radio" name="contract" class="contract-select" value="0" checked>否
            </label>
            <div class="contract clearfix contract-show">
                
                <dl class="clearfix">
                    <dt><span class="red">*</span>合同名称：</dt>
                    <dd><input type="text" class="form-control" id="contract_name_input"></dd>
                </dl>
                <dl class="clearfix">
                    <dt><span class="red">*</span>供应商名称：</dt>
                    <dd><input type="text" class="form-control" id="sup_name_input"></dd>
                </dl>
                <dl class="clearfix">
                    <dt><span class="red">*</span>签订时间：</dt>
                    <dd>
                        <div class="input-group">
                            <input class="form-control special_input" readonly="readonly" type="text" name="sign_date_input" id="sign_date_input" value="" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                            <span class="input-group-addon">
                                <i class="fa fa-calendar" onclick="$('#sign_date_input').focus()"></i>
                            </span>
                        </div>
                    </dd>
                </dl>
                <dl class="clearfix">
                    <dt><span class="red">*</span>合同金额：</dt>
                    <dd><input type="text" class="form-control" id="contract_price_input"></dd>
                </dl>
                <dl class="clearfix">
                    <dt><span class="red">*</span>采购方式：</dt>
                    <dd>
                        <label class="checkbox-inline">
                            <input type="radio" class="buy-type" name="buy_type_select" value="0" checked>比价
                        </label>
                        <label class="checkbox-inline special">
                            <input type="radio" class="buy-type" name="buy_type_select" value="1">直接采购
                        </label>
                    </dd>
                </dl>
                <dl class="clearfix last">
                    <dt>备注：</dt>
                    <dd><textarea class="form-control" rows="3" id="remark_input"></textarea></dd>
                </dl>
            </div>
          </div>
        </div>
        <div class="info_list section_main contract-show">
          <h2>合同附件</h2>
          <mc:ImgUploadTag mark='buy'></mc:ImgUploadTag>
        </div>
        </c:if>
        
        <c:if test="${supType == 0}">
        <div class="section_main clearfix price_area">
          <div class="gather_box">
            <div class="gather_inner">
              <p>
                <span>实付款：</span>
                <span class="symbol">￥</span>
                <span class="price" id="total_price">0.00</span>
               </p>
               <p id="address_all">
                 <span>寄送至：</span>
               </p>
               <p id="address_contact">
                 <span>收货人：</span>
               </p>
             </div>
           </div>
        </div>
        </c:if>
        <div class="btn_list">
          <ul class="list-inline">
            <li><button type="button" class="btn btn-default add_btn" onclick="window.location.href='${pageContext.request.contextPath}/market/cart/list';">返回购物车</button></li>
            <li><button type="button" class="btn btn-default add_btn" id="submit_btn">提交订单</button></li>
          </ul>
        </div>
      <!--.order_details--></div>
      
      
      
      <!--.inner--> 
    </div>
    <!--#contents--> 
  </div>
	<jsp:include page="../footer.jsp" />
  <!--.page-wrapper--> 
</div>

<div class="mask">
</div>
<div id="add_address">
  <div class="inner">
    <div class="add_title clearfix">新增收货地址<a href="javascript:void(0);" id="addr_close"><i class="fa fa-close"></i></a></div>
    <div class="main_inner">
    <form id="addr_form">
        <input type="hidden" class="form-control" id="address_id">
      <div class="form-group">
        <label for="name"><span class="red">*</span>收货人姓名</label>
        <input type="text" class="form-control" id="address_name" maxlength="32">
        <span class="red form-error" id="address_name_e"></span>
      </div>
      <div class="form-group">
        <label for="name"><span class="red">*</span>所在地区&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="red form-error" id="area_e"></span></label>
        
        <select class="form-control city" id="area_prov">
          <option value="">省份</option>
          <c:forEach varStatus="sta" var="item" items="${prov}">
          <option value="${item.supAreaId}">${item.supAreaName}</option>
          </c:forEach>
        </select>
        <select class="form-control city" id="area_city">
          <option value="">市</option>
        </select>
        <select class="form-control" id="area_dist">
          <option value="">县区</option>
        </select>
        <c:if test="${supType == 0 and supId > 1}">
        <select class="form-control" id="area_town">
          <option value="">乡镇</option>
        </select>
        </c:if>
      </div>
      <div class="form-group">
        <label for="name"><span class="red">*</span>详细地址</label>
        <input type="text" class="form-control detail" id="address_detail" maxlength="64">
        <span class="red form-error" id="address_detail_e"></span>
      </div>
      <div class="form-group">
        <label for="name"><span class="red">*</span>邮政编码</label>
        <input type="text" class="form-control" id="zip_code" placeholder="" maxlength="8">
         <span class="red form-error" id="zip_code_e"></span>
      </div>
      <div class="tel_area clearfix">
        <div class="form-group">
          <label for="name"><span class="red">*</span>手机号码</label>
          <input type="text" class="form-control" id="address_phone" maxlength="11">
        </div>
        <div class="form-group text">或</div>
        <div class="form-group">
          <label for="name">固定电话</label>
          <input type="text" class="form-control" id="address_tel" placeholder="" maxlength="16">
          <span class="red form-error" id="address_phone_e"></span>
        </div>
      </div>
      <div class="form-group">
        <label for="name"><span class="red">*</span>邮箱</label>
        <input type="text" class="form-control" id="address_email" placeholder="" maxlength="32">
         <span class="red form-error" id="address_email_e"></span>
      </div>
      <div class="form-group">
        <label for="name">地址别名</label>
        <input type="text" class="form-control" id="address_alias" placeholder="" maxlength="32">
        <span class="gray">建议填写常用名称</span>
        <span><a href="javascript:void(0);" class="alias-name">家里</a><a href="javascript:void(0);" class="alias-name">公司</a></span>
      </div>
      <div class="btn_list">
        <ul><button  type="button" class="btn btn-default blue" id="address_btn">保存收货地址</button></ul>
      </div>
      </form>
    </div>
  </div>
</div>
<div id="info_invoice">
  <div class="inner">
    <div class="add_title clearfix">发票信息<a href="javascript:void(0);" class="invoice-close"><i class="fa fa-close"></i></a></div>
    <div class="main_inner">
      <div class="invoice_list list_section title_list">
        <ul class="clearfix">
          <li><a href="javascript:void(0);" class="invoice-tab active" data-type="1">增值税普通发票</a></li>
          <li><a href="javascript:void(0);" class="invoice-tab" data-type="2">增值税专用发票</a></li>
        </ul>
      </div>
      <div class="private_detail">
        <form class="form-horizontal">
          <div class="form-group">
            <label for="name" class="control-label col-sm-2">发票抬头:</label>
            <input type="text" class="form-control detail col-sm-10" id="invoice_input_company" value="${invoice.companyName }" maxlength="32">
          </div>
          <div class="form-group">
            <label for="name" class="control-label col-sm-2">纳税人识别号:</label>
            <input type="text" class="form-control detail col-sm-10" id="invoice_input_num" value="${invoice.invoiceNum }" maxlength="32">
          </div>
          <div class="form-group">
            <label for="name" class="control-label col-sm-2">发票内容:</label>
            <div class="list_section col-sm-10 invoice_list">
              <ul>
                <li><a href="javascript:void(0);" class="invoice-input-flag active" data-val="1">明细</a></li>
                <!--  
                <li><a href="javascript:void(0);" class="invoice-input-flag " data-val="2">办公用品</a></li>
                <li><a href="javascript:void(0);" class="invoice-input-flag " data-val="3">电脑配件</a></li>
                <li><a href="javascript:void(0);" class="invoice-input-flag " data-val="4">耗材</a></li>
                -->
              </ul>
            </div>
          </div>
        </form>
        <div class="btn_list">
          <ul>
            <li><button  type="button" class="btn btn-default blue" id="invoice_save">保存发票信息</button></li>
            <li><button  type="button" class="btn btn-default gray invoice-close">取消</button></li>
          </ul>
        </div>
      <!--.private_detail--></div>
      <div class="vat_detail" style="display: none">
      <c:if test="${vat == null}">
        <div class="attention">
      请先在采购管理平台维护增票资质
      </div>
      </c:if>
      <c:if test="${vat != null and vat.auditStatus != '0'}">
        <div class="attention">
      该增票信息尚未审核通过，请稍后在试。
      </div>
      </c:if>
      <c:if test="${vat != null and vat.auditStatus == '0'}">
        <div class="attention">
          <p>我公司依法开具发票，如您购买的商品按照税法规定属于不得从增值税销项税额中抵扣的项目（例如集体福利或个人消费等），请您选择普通发票。</p>
        </div>
        <div class="step01">
          <div class="step_list">
            <ul class="clearfix">
              <li class="active">1.填写公司信息</li>
              <li>2.填写收票人信息</li>
            </ul>
          </div>
          <form class="form-horizontal">
            <div class="form-group">
              <label for="name" class="control-label col-sm-3"><span class="red">*</span>单位名称:</label>
              <input type="text" class="form-control detail col-sm-9" value="${vat.companyName }" readonly="readonly">
            </div>
            <div class="form-group">
              <label for="name" class="control-label col-sm-3"><span class="red">*</span>纳税人识别码:</label>
              <input type="text" class="form-control detail col-sm-9" value="${vat.taxPayerCode }" readonly="readonly">
            </div>
            <div class="form-group">
              <label for="name" class="control-label col-sm-3"><span class="red">*</span>注册地址:</label>
              <input type="text" class="form-control detail col-sm-9" value="${vat.registerPath }" readonly="readonly">
            </div>
            <div class="form-group">
              <label for="name" class="control-label col-sm-3"><span class="red">*</span>注册电话:</label>
              <input type="text" class="form-control detail col-sm-9" value="${vat.registerTel }" readonly="readonly">
            </div>
            <div class="form-group">
              <label for="name" class="control-label col-sm-3"><span class="red">*</span>开户银行:</label>
              <input type="text" class="form-control detail col-sm-9" value="${vat.bankName }" readonly="readonly">
            </div>
            <div class="form-group">
              <label for="name" class="control-label col-sm-3"><span class="red">*</span>开户账号:</label>
              <input type="text" class="form-control detail col-sm-9" value="${vat.bankAccount }" readonly="readonly">
            </div>
          </form>
          <div class="btn_list">
            <ul>
              <li><button  type="button" class="btn btn-default blue" id="vat_next">下一步</button></li>
              <li><button  type="button" class="btn btn-default gray invoice-close">取消</button></li>
            </ul>
          </div>
        </div>
        <div class="step02" style="display: none">
          <div class="step_list">
            <ul class="clearfix">
              <li>1.填写公司信息</li>
              <li class="active">2.填写收票人信息</li>
            </ul>
          </div>
          <form class="form-horizontal">
            <div class="form-group">
              <label for="name" class="control-label col-sm-3">发票内容:</label>
              <div class="list_section col-sm-9 invoice_list">
                <ul>
                  <li><a href="#" class="active">明细</a></li>
                </ul>
              </div>
            </div>
            <div class="form-group">
              <label for="name" class="control-label col-sm-3"><span class="red">*</span>收票人姓名:</label>
              <input type="text" class="form-control detail col-sm-9" id="vat_name" value="${vat.vatReceiveName }" maxlength="8">
            </div>
            <div class="form-group">
              <label for="name" class="control-label col-sm-3"><span class="red">*</span>收票人手机:</label>
              <input type="text" class="form-control detail col-sm-9" id="vat_phone" value="${vat.vatReceiveTel }" maxlength="11">
            </div>
            <div class="form-group">
              <label for="name" class="control-label col-sm-3"><span class="red">*</span>收票人省份:</label>
              <select class="form-control col-sm-3" id="vat_prov">
                <option value="">省份</option>
                <c:forEach var="item" items="${vatProv}">
                <option value="${item.supAreaId }" <c:if test="${item.supAreaId == vat.vatReceiveProv}">selected="selectted"</c:if>>${item.supAreaName }</option>
                </c:forEach>
              </select>
              <select class="form-control col-sm-3" id="vat_city">
                <option value="">市</option>
                <c:forEach var="item" items="${vatCity}">
                <option value="${item.supAreaId }" <c:if test="${item.supAreaId == vat.vatReceiveCity}">selected="selectted"</c:if>>${item.supAreaName }</option>
                </c:forEach>
              </select>
              <select class="form-control col-sm-3" id="vat_dist">
                <option value="">县区</option>
                <c:forEach var="item" items="${vatDist}">
                <option value="${item.supAreaId }" <c:if test="${item.supAreaId == vat.vatReceiveDist}">selected="selectted"</c:if>>${item.supAreaName }</option>
                </c:forEach>
              </select>
            </div>
            <div class="form-group">
              <label for="name" class="control-label col-sm-3"><span class="red">*</span>详细地址:</label>
              <input type="text" class="form-control detail col-sm-9" id="vat_addr" value="${vat.vatReceiveDetail }" maxlength="128">
            </div>
          </form>
          <div class="btn_list">
            <ul>
              <li><button  type="button" class="btn btn-default blue" id="vat_save">保存</button></li>
              <li><button  type="button" class="btn btn-default gray invoice-close">取消</button></li>
              <li class="return"><a href="javascript:void(0);" id="vat_prev">返回上一步</a></li>
            </ul>
          </div>
        </div>
        </c:if>
      <!--/vat_detail--></div>
      
    </div>
  </div>
</div>

</body>
</html>