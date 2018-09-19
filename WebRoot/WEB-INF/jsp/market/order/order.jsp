<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="/WEB-INF/tlds/tag.tld" prefix="mc"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="���ɶ���" name="title"/>
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
			$city.html("<option value=''>��</option>");
		} else {
			$city.html("<option value=''>������...</option>");
		}

		$city.trigger("change");

		var supId = ${supId};
		
		if ($(this).attr("id").indexOf("vat") > -1) {
			supId = 1;
		}
		
		if (area != "") {
			async('${pageContext.request.contextPath}/market/order/area', {supId:supId, parent:area}, function (msg) {
				var result = msg.result;
				$city.html("<option value=''>��</option>");
				for (var i = 0; i < result.length; i++) {
					$city.append("<option value='"+result[i].supAreaId+"'>"+result[i].supAreaName+"</option>");
				}
				if ($city.attr("data-sel")) {
					$city.val($city.attr("data-sel"));
					$city.removeAttr("data-sel");
					$city.trigger("change");
				}
			}, function () {
				$city.html("<option value=''>����ʧ��</option>");
			});
		}
		
	});
	
	$("#area_city,#vat_city").change(function () {
		var area = $(this).val();
		
		var $dist = $("#" + $(this).attr("id").replace("city", "dist"));
		
		if (area == "") {
			$dist.html("<option value=''>����</option>");
		} else {
			$dist.html("<option value=''>������...</option>");
		}

		$dist.trigger("change");
		
		var supId = ${supId};
		
		if ($(this).attr("id").indexOf("vat") > -1) {
			supId = 1;
		}
		
		if (area != "") {
			async('${pageContext.request.contextPath}/market/order/area', {supId:supId, parent:area}, function (msg) {
				var result = msg.result;
				$dist.html("<option value=''>����</option>");
				for (var i = 0; i < result.length; i++) {
					$dist.append("<option value='"+result[i].supAreaId+"'>"+result[i].supAreaName+"</option>");
				}
				
				if ($dist.attr("data-sel")) {
					$dist.val($dist.attr("data-sel"));
					$dist.removeAttr("data-sel");
					$dist.trigger("change");
				}
			}, function () {
				$dist.html("<option value=''>����ʧ��</option>");
			});
		}
		
	});
	

	$("#area_dist").change(function () {
		
		if ($("#area_town").size() == 0) return;
		var area = $(this).val();
		
		if (area == "") {
			$("#area_town").html("<option value=''>����</option>");
		} else {
			$("#area_town").html("<option value=''>������...</option>");
		}

		
		if (area != "") {
			async('${pageContext.request.contextPath}/market/order/area', {supId:${supId}, parent:area}, function (msg) {
				var result = msg.result;
				$("#area_town").html("<option value=''>����</option>");
				for (var i = 0; i < result.length; i++) {
					$("#area_town").append("<option value='"+result[i].supAreaId+"'>"+result[i].supAreaName+"</option>");
				}
				
				if ($("#area_town").attr("data-sel")) {
					$("#area_town").val($("#area_town").attr("data-sel"));
					$("#area_town").removeAttr("data-sel");
				}
			}, function () {
				$("#area_town").html("<option value=''>����ʧ��</option>");
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
			$("#area_e").text("��ѡ�����ڵ���");
			flag = false;
		}
		if (!town) {
			townName = "";
			town = "";
		}
		
		if (detail == "") {
			$("#address_detail_e").text("��������ϸ��ַ");
			flag = false;
		} else if (!chklen("address_detail", "��ϸ��ַ")) {
			flag = false;
		}
		
		if (name == "") {
			$("#address_name_e").text("�������ջ�������");
			flag = false;
		} else if (!chklen("address_name", "�ջ�������")) {
			flag = false;
		}
		
		if (zip == "") {
			$("#zip_code_e").text("��������������");
			flag = false;
		} else if (!/^\d+$/.test(zip)) {
			$("#zip_code_e").text("��������ȷ����������");
			flag = false;
		} else if (!chklen("zip_code", "��������")) {
			flag = false;
		}
		
		if (phone == "" && tel == "") {
			$("#address_phone_e").text("��������ϵ��ʽ");
			flag = false;
		}
		
		if (phone != "" && !/^\d+$/.test(phone)) {
			$("#address_phone_e").text("��������ȷ���ֻ�����");
			flag = false;
		}
		
		if (phone != "" && !chklen("address_phone", "�ֻ�����")) {
			flag = false;
		}
		
		if (tel != "" && !/^\d+$/.test(tel)) {
			$("#address_phone_e").text("��������ȷ�ĵ绰����");
			flag = false;
		}
		if (tel != "" && !chklen("address_phone","�绰����")) {
			flag = false;
		}
		
		if (email == "") {
			$("#address_email_e").text("����������");
			flag = false;
		} else if (!/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(email)) {
			$("#address_email_e").text("��������ȷ�������ַ");
			flag = false;
		} else if (!chklen("address_email", "�����ַ")) {
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
	        edit.text("�޸�");
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
			alert("�����뷢Ʊ̧ͷ");
			return;
		}

		if (num == "") {
			alert("��������˰��ʶ���");
			return;
		}

		async('${pageContext.request.contextPath}/market/order/invoice', {flag:flag, content:content, company:company, num:num}, function (msg) {
			// <span id="invoice_show_type">��ͨ��Ʊ��ֽ�ʣ�</span><span id="invoice_show_name">${invoice.companyName}</span><span id="invoice_show_content"><c:if test="${invoice.invoiceFlag == 1}">��ϸ</c:if><c:if test="${invoice.invoiceFlag != 1}">${invoice.invoiceContent}</c:if></span>
        	$("#invoice_show_type").text("��ֵ˰��ͨ��Ʊ��ֽ�ʣ�");
        	$("#invoice_show_name").text(company);
        	$("#invoice_show_content").text(flag == 1 ? "��ϸ" : content);
        	
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
			alert("��������Ʊ������");
			return;
		}
		if (phone == "") {
			alert("��������Ʊ���ֻ�");
			return;
		} else if (!/^[0-9]+$/.test(phone)) {
			alert("��������ȷ���ֻ�����");
			return;
		}
		if (prov == "") {
			alert("��ѡ��ʡ��");
			return;
		}
		if (city == "") {
			alert("��ѡ�����");
			return;
		}
		if (dist == "") {
			alert("��ѡ������");
			return;
		}
		if (addr == "") {
			alert("��������ϸ��ַ");
			return;
		}
		



		async('${pageContext.request.contextPath}/market/order/vat', {name:name, phone:phone, prov:prov, city:city, dist:dist, addr:addr}, function (msg) {
			// <span id="invoice_show_type">��ͨ��Ʊ��ֽ�ʣ�</span><span id="invoice_show_name">${invoice.companyName}</span><span id="invoice_show_content"><c:if test="${invoice.invoiceFlag == 1}">��ϸ</c:if><c:if test="${invoice.invoiceFlag != 1}">${invoice.invoiceContent}</c:if></span>
        	$("#invoice_show_type").text("��ֵ˰ר�÷�Ʊ");
        	$("#invoice_show_name").text("${vat.companyName}");
        	$("#invoice_show_content").text("��ϸ");
        	
            
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
			alert("���͵���ǰ��ַ�Ŀ�治�㣬���л�������ַ��ѡ��������Ʒ�µ�");
			return;
		}
		
		if ($("#addr_dist").val() == "" || $("#addr_detail").val() == "" || $("#addr_name").val() == "") {
			alert("��ѡ���ַ");
			return;
		}
		
		if ($.trim($("#decide_reason_input").val()) != "" && $("#decide_reason_input").val().length > 200) {
			alert("�����������200��");
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
					alert("�������ͬ����");
					return false;
				}
				if (sup_name == "") {
					alert("�����빩Ӧ������");
					return false;
				}
				if (sign_date == "") {
					alert("��ѡ��ǩ��ʱ��");
					return false;
				}
				if (contract_price == "") {
					alert("�������ͬ���");
					return false;
				} else {
					var price = 0;
					try {
						price = parseFloat(contract_price);
					} catch (e) {
					}
					
					if (price && price > 0) {
					} else {
						alert("��ͬ������Ϊ��ȷ������");
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
	
	$("#" + oid + "_e").text(label + "��󳤶�" + obj.attr("maxlength"));
	
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

	$("#address_all").html('<span>��������</span>' + provName + " " + cityName + " " + distName + " " + (townName == "" ? "" : townName + " ") + " " + detail);
	$("#address_contact").html('<span>�ջ��ˣ�</span>' + name + " " + (phone == "" ? tel : phone));
	
	
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
          <li><a href="${pageContext.request.contextPath}">��ҳ</a><span>&gt;</span></li>
          <li>���ɶ���</li>
        </ul>
        <!--.breadcrumb--> 
      </div>
      <div id="order_details">
        <div class="section_main pro_info">
          <h2>��Ʒ��Ϣ</h2>
          <table>
            <tr>
              <th colspan="2">��Ʒ����</th>
              <th width="200">���ۣ�Ԫ��</th>
              <th width="200">����������</th>
              <th width="200">�ܼۣ�Ԫ��</th>
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
              <td class="left_align"><a href="${pageContext.request.contextPath}/market/goods/show?sid=${item.supId}&gid=${item.supGoodsId}">${fn:escapeXml(item.goodsName)}<c:if test="${item.supType == 1}">��${fn:escapeXml(item.goodsModel)}��</c:if></a></td>
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
          <h2>��ַ��Ϣ</h2>
          
          <div class="icon_action" id="addr_container">
          <c:if test="${!empty address}">
            <c:forEach varStatus="sta" var="item" items="${address}">
            <dl class="dl-horizontal" id="address_${item.addressId}" style="display:none;">
              <dt><a class="addr-name" href="javascript:void(0);" data-alias="${item.alias}" data-id="${item.addressId}" data-prov="${item.areaLevelOne}" data-city="${item.areaLevelTwo}" data-email="${item.email}" data-dist="${item.areaLevelThree}" data-town="${item.areaLevelFour}" data-prov-name="${item.areaLevelOneName}" data-city-name="${item.areaLevelTwoName}" data-dist-name="${item.areaLevelThreeName}" data-town-name="${item.areaLevelFourName }" data-detail="${fn:escapeXml(item.addressDetail) }" data-name="${fn:escapeXml(item.name) }" data-zip="${item.zipCode }" data-phone="${item.phone }" data-tel="${item.tel }">${item.alias == null || item.alias == "" ? item.name : item.alias}</a></dt>
              <dd><span>${item.name}</span><span>${item.areaLevelTwoName}${item.areaLevelThreeName}${item.areaLevelFourName}${fn:escapeXml(item.addressDetail)}</span><span>${item.phone == '' ? item.tel : item.phone}</span><a href="javascript:void(0);" class="address_edit">�޸�</a></dd>
            </dl>
            </c:forEach>
            <p class="more"><a href="javascript:void(0);" id="addr_more">�����ַ<i class="fa fa-angle-double-down"></i></a></p>
          </c:if>
            <div class="add_address">
              <div class="btn_add"><a href="javascript:void(0);" id="addr_new">�����ջ���ַ</a></div>
            </div>
          </div>
        </div>
        <c:if test="${showPay == 1}">
        <div class="info_list section_main" >
          <h2>֧����ʽ</h2>
          <div class="icon_action list_section">
            <ul class="clearfix">
              <li><a href="javascript:void(0);" data-type="0002" class="pay-gate <c:if test="${supType == 0}">active</c:if>"><span><img src="${pageContext.request.contextPath}/static/img/icon-bank.gif" /></span>��ҵ֧��</a></li>
              <li><a href="javascript:void(0);" data-type="0001" class="pay-gate"><span><img src="${pageContext.request.contextPath}/static/img/icon-bank.gif" /></span>����֧��</a></li>
              <li><a href="javascript:void(0);" data-type="0004" class="pay-gate"><span><img src="${pageContext.request.contextPath}/static/img/icon-bank.gif" /></span>�޿�֧��</a></li>
              <c:if test="${supType == 1}">
              <li><a href="javascript:void(0);" data-type="0000" class="pay-gate active">����֧��</a></li>
              </c:if>
              <li><a href="javascript:void(0);" data-type="0005" class="pay-gate"><span><img src="${pageContext.request.contextPath}/static/img/icon-alipay.gif" /></span>
              ֧����</a></li>
              
            </ul>            
          </div>
        </div>
        </c:if>
        
        <div class="info_list section_main  hide-0000">
          <h2>��Ʊ��Ϣ</h2>
          <div class="icon_action">
            <div class="default_style">
            <p>
            <c:choose>
            	<c:when test="${invoice != null }">
              		<span id="invoice_show_type">��ֵ˰��ͨ��Ʊ��ֽ�ʣ�</span><span id="invoice_show_name">${invoice.companyName}</span><span id="invoice_show_content"><c:if test="${invoice.invoiceFlag == 1}">��ϸ</c:if><c:if test="${invoice.invoiceFlag != 1}">${invoice.invoiceContent}</c:if></span>
            	</c:when>
            	<c:when test="${invoice == null }">
              		<span id="invoice_show_type">��ֵ˰��ͨ��Ʊ��ֽ�ʣ�</span><span id="invoice_show_name">����</span><span id="invoice_show_content">��ϸ</span>
            	</c:when>
            	<c:when test="${vat != null and vat.auditStatus == '0' }">
              		<span id="invoice_show_type">��ֵ˰ר�÷�Ʊ</span><span id="invoice_show_name">${vat.companyName}</span><span id="invoice_show_content">��ϸ</span>
            	</c:when>
            </c:choose>
            <span><a href="javascript:void(0);" id="invoice_edit">�޸�</a></span></p>
            </div>
          </div>
        </div>
        <c:if test="${supType == 0}">
        <div class="info_list section_main">
          <h2>���� (֧�ֵ�ͼƬ��ʽΪjpg/jpeg/png/gif/bmp������ͼƬ��С��2M��)</h2>
          <mc:ImgUploadTag mark='buy'></mc:ImgUploadTag>
        </div>
        
        <div class="info_list section_main">        
          <h2>������Ϣ</h2>
          <dl class="dl-horizontal reason">
            <dd><textarea class="form-control" rows="3" id="decide_reason_input"></textarea><span>��200�� </span></dd>
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
        <input type="hidden" id="invoice_company" name="invoice_company" value="����"/>
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
          <h2>�Ƿ�������ͬ</h2>
          <div class="icon_action list_section">
            <label class="checkbox-inline">
                <input type="radio" name="contract" class="contract-select" value="1">��
            </label>
            <label class="checkbox-inline special">
                <input type="radio" name="contract" class="contract-select" value="0" checked>��
            </label>
            <div class="contract clearfix contract-show">
                
                <dl class="clearfix">
                    <dt><span class="red">*</span>��ͬ���ƣ�</dt>
                    <dd><input type="text" class="form-control" id="contract_name_input"></dd>
                </dl>
                <dl class="clearfix">
                    <dt><span class="red">*</span>��Ӧ�����ƣ�</dt>
                    <dd><input type="text" class="form-control" id="sup_name_input"></dd>
                </dl>
                <dl class="clearfix">
                    <dt><span class="red">*</span>ǩ��ʱ�䣺</dt>
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
                    <dt><span class="red">*</span>��ͬ��</dt>
                    <dd><input type="text" class="form-control" id="contract_price_input"></dd>
                </dl>
                <dl class="clearfix">
                    <dt><span class="red">*</span>�ɹ���ʽ��</dt>
                    <dd>
                        <label class="checkbox-inline">
                            <input type="radio" class="buy-type" name="buy_type_select" value="0" checked>�ȼ�
                        </label>
                        <label class="checkbox-inline special">
                            <input type="radio" class="buy-type" name="buy_type_select" value="1">ֱ�Ӳɹ�
                        </label>
                    </dd>
                </dl>
                <dl class="clearfix last">
                    <dt>��ע��</dt>
                    <dd><textarea class="form-control" rows="3" id="remark_input"></textarea></dd>
                </dl>
            </div>
          </div>
        </div>
        <div class="info_list section_main contract-show">
          <h2>��ͬ����</h2>
          <mc:ImgUploadTag mark='buy'></mc:ImgUploadTag>
        </div>
        </c:if>
        
        <c:if test="${supType == 0}">
        <div class="section_main clearfix price_area">
          <div class="gather_box">
            <div class="gather_inner">
              <p>
                <span>ʵ���</span>
                <span class="symbol">��</span>
                <span class="price" id="total_price">0.00</span>
               </p>
               <p id="address_all">
                 <span>��������</span>
               </p>
               <p id="address_contact">
                 <span>�ջ��ˣ�</span>
               </p>
             </div>
           </div>
        </div>
        </c:if>
        <div class="btn_list">
          <ul class="list-inline">
            <li><button type="button" class="btn btn-default add_btn" onclick="window.location.href='${pageContext.request.contextPath}/market/cart/list';">���ع��ﳵ</button></li>
            <li><button type="button" class="btn btn-default add_btn" id="submit_btn">�ύ����</button></li>
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
    <div class="add_title clearfix">�����ջ���ַ<a href="javascript:void(0);" id="addr_close"><i class="fa fa-close"></i></a></div>
    <div class="main_inner">
    <form id="addr_form">
        <input type="hidden" class="form-control" id="address_id">
      <div class="form-group">
        <label for="name"><span class="red">*</span>�ջ�������</label>
        <input type="text" class="form-control" id="address_name" maxlength="32">
        <span class="red form-error" id="address_name_e"></span>
      </div>
      <div class="form-group">
        <label for="name"><span class="red">*</span>���ڵ���&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="red form-error" id="area_e"></span></label>
        
        <select class="form-control city" id="area_prov">
          <option value="">ʡ��</option>
          <c:forEach varStatus="sta" var="item" items="${prov}">
          <option value="${item.supAreaId}">${item.supAreaName}</option>
          </c:forEach>
        </select>
        <select class="form-control city" id="area_city">
          <option value="">��</option>
        </select>
        <select class="form-control" id="area_dist">
          <option value="">����</option>
        </select>
        <c:if test="${supType == 0 and supId > 1}">
        <select class="form-control" id="area_town">
          <option value="">����</option>
        </select>
        </c:if>
      </div>
      <div class="form-group">
        <label for="name"><span class="red">*</span>��ϸ��ַ</label>
        <input type="text" class="form-control detail" id="address_detail" maxlength="64">
        <span class="red form-error" id="address_detail_e"></span>
      </div>
      <div class="form-group">
        <label for="name"><span class="red">*</span>��������</label>
        <input type="text" class="form-control" id="zip_code" placeholder="" maxlength="8">
         <span class="red form-error" id="zip_code_e"></span>
      </div>
      <div class="tel_area clearfix">
        <div class="form-group">
          <label for="name"><span class="red">*</span>�ֻ�����</label>
          <input type="text" class="form-control" id="address_phone" maxlength="11">
        </div>
        <div class="form-group text">��</div>
        <div class="form-group">
          <label for="name">�̶��绰</label>
          <input type="text" class="form-control" id="address_tel" placeholder="" maxlength="16">
          <span class="red form-error" id="address_phone_e"></span>
        </div>
      </div>
      <div class="form-group">
        <label for="name"><span class="red">*</span>����</label>
        <input type="text" class="form-control" id="address_email" placeholder="" maxlength="32">
         <span class="red form-error" id="address_email_e"></span>
      </div>
      <div class="form-group">
        <label for="name">��ַ����</label>
        <input type="text" class="form-control" id="address_alias" placeholder="" maxlength="32">
        <span class="gray">������д��������</span>
        <span><a href="javascript:void(0);" class="alias-name">����</a><a href="javascript:void(0);" class="alias-name">��˾</a></span>
      </div>
      <div class="btn_list">
        <ul><button  type="button" class="btn btn-default blue" id="address_btn">�����ջ���ַ</button></ul>
      </div>
      </form>
    </div>
  </div>
</div>
<div id="info_invoice">
  <div class="inner">
    <div class="add_title clearfix">��Ʊ��Ϣ<a href="javascript:void(0);" class="invoice-close"><i class="fa fa-close"></i></a></div>
    <div class="main_inner">
      <div class="invoice_list list_section title_list">
        <ul class="clearfix">
          <li><a href="javascript:void(0);" class="invoice-tab active" data-type="1">��ֵ˰��ͨ��Ʊ</a></li>
          <li><a href="javascript:void(0);" class="invoice-tab" data-type="2">��ֵ˰ר�÷�Ʊ</a></li>
        </ul>
      </div>
      <div class="private_detail">
        <form class="form-horizontal">
          <div class="form-group">
            <label for="name" class="control-label col-sm-2">��Ʊ̧ͷ:</label>
            <input type="text" class="form-control detail col-sm-10" id="invoice_input_company" value="${invoice.companyName }" maxlength="32">
          </div>
          <div class="form-group">
            <label for="name" class="control-label col-sm-2">��˰��ʶ���:</label>
            <input type="text" class="form-control detail col-sm-10" id="invoice_input_num" value="${invoice.invoiceNum }" maxlength="32">
          </div>
          <div class="form-group">
            <label for="name" class="control-label col-sm-2">��Ʊ����:</label>
            <div class="list_section col-sm-10 invoice_list">
              <ul>
                <li><a href="javascript:void(0);" class="invoice-input-flag active" data-val="1">��ϸ</a></li>
                <!--  
                <li><a href="javascript:void(0);" class="invoice-input-flag " data-val="2">�칫��Ʒ</a></li>
                <li><a href="javascript:void(0);" class="invoice-input-flag " data-val="3">�������</a></li>
                <li><a href="javascript:void(0);" class="invoice-input-flag " data-val="4">�Ĳ�</a></li>
                -->
              </ul>
            </div>
          </div>
        </form>
        <div class="btn_list">
          <ul>
            <li><button  type="button" class="btn btn-default blue" id="invoice_save">���淢Ʊ��Ϣ</button></li>
            <li><button  type="button" class="btn btn-default gray invoice-close">ȡ��</button></li>
          </ul>
        </div>
      <!--.private_detail--></div>
      <div class="vat_detail" style="display: none">
      <c:if test="${vat == null}">
        <div class="attention">
      �����ڲɹ�����ƽ̨ά����Ʊ����
      </div>
      </c:if>
      <c:if test="${vat != null and vat.auditStatus != '0'}">
        <div class="attention">
      ����Ʊ��Ϣ��δ���ͨ�������Ժ����ԡ�
      </div>
      </c:if>
      <c:if test="${vat != null and vat.auditStatus == '0'}">
        <div class="attention">
          <p>�ҹ�˾�������߷�Ʊ�������������Ʒ����˰���涨���ڲ��ô���ֵ˰����˰���еֿ۵���Ŀ�����缯�帣����������ѵȣ�������ѡ����ͨ��Ʊ��</p>
        </div>
        <div class="step01">
          <div class="step_list">
            <ul class="clearfix">
              <li class="active">1.��д��˾��Ϣ</li>
              <li>2.��д��Ʊ����Ϣ</li>
            </ul>
          </div>
          <form class="form-horizontal">
            <div class="form-group">
              <label for="name" class="control-label col-sm-3"><span class="red">*</span>��λ����:</label>
              <input type="text" class="form-control detail col-sm-9" value="${vat.companyName }" readonly="readonly">
            </div>
            <div class="form-group">
              <label for="name" class="control-label col-sm-3"><span class="red">*</span>��˰��ʶ����:</label>
              <input type="text" class="form-control detail col-sm-9" value="${vat.taxPayerCode }" readonly="readonly">
            </div>
            <div class="form-group">
              <label for="name" class="control-label col-sm-3"><span class="red">*</span>ע���ַ:</label>
              <input type="text" class="form-control detail col-sm-9" value="${vat.registerPath }" readonly="readonly">
            </div>
            <div class="form-group">
              <label for="name" class="control-label col-sm-3"><span class="red">*</span>ע��绰:</label>
              <input type="text" class="form-control detail col-sm-9" value="${vat.registerTel }" readonly="readonly">
            </div>
            <div class="form-group">
              <label for="name" class="control-label col-sm-3"><span class="red">*</span>��������:</label>
              <input type="text" class="form-control detail col-sm-9" value="${vat.bankName }" readonly="readonly">
            </div>
            <div class="form-group">
              <label for="name" class="control-label col-sm-3"><span class="red">*</span>�����˺�:</label>
              <input type="text" class="form-control detail col-sm-9" value="${vat.bankAccount }" readonly="readonly">
            </div>
          </form>
          <div class="btn_list">
            <ul>
              <li><button  type="button" class="btn btn-default blue" id="vat_next">��һ��</button></li>
              <li><button  type="button" class="btn btn-default gray invoice-close">ȡ��</button></li>
            </ul>
          </div>
        </div>
        <div class="step02" style="display: none">
          <div class="step_list">
            <ul class="clearfix">
              <li>1.��д��˾��Ϣ</li>
              <li class="active">2.��д��Ʊ����Ϣ</li>
            </ul>
          </div>
          <form class="form-horizontal">
            <div class="form-group">
              <label for="name" class="control-label col-sm-3">��Ʊ����:</label>
              <div class="list_section col-sm-9 invoice_list">
                <ul>
                  <li><a href="#" class="active">��ϸ</a></li>
                </ul>
              </div>
            </div>
            <div class="form-group">
              <label for="name" class="control-label col-sm-3"><span class="red">*</span>��Ʊ������:</label>
              <input type="text" class="form-control detail col-sm-9" id="vat_name" value="${vat.vatReceiveName }" maxlength="8">
            </div>
            <div class="form-group">
              <label for="name" class="control-label col-sm-3"><span class="red">*</span>��Ʊ���ֻ�:</label>
              <input type="text" class="form-control detail col-sm-9" id="vat_phone" value="${vat.vatReceiveTel }" maxlength="11">
            </div>
            <div class="form-group">
              <label for="name" class="control-label col-sm-3"><span class="red">*</span>��Ʊ��ʡ��:</label>
              <select class="form-control col-sm-3" id="vat_prov">
                <option value="">ʡ��</option>
                <c:forEach var="item" items="${vatProv}">
                <option value="${item.supAreaId }" <c:if test="${item.supAreaId == vat.vatReceiveProv}">selected="selectted"</c:if>>${item.supAreaName }</option>
                </c:forEach>
              </select>
              <select class="form-control col-sm-3" id="vat_city">
                <option value="">��</option>
                <c:forEach var="item" items="${vatCity}">
                <option value="${item.supAreaId }" <c:if test="${item.supAreaId == vat.vatReceiveCity}">selected="selectted"</c:if>>${item.supAreaName }</option>
                </c:forEach>
              </select>
              <select class="form-control col-sm-3" id="vat_dist">
                <option value="">����</option>
                <c:forEach var="item" items="${vatDist}">
                <option value="${item.supAreaId }" <c:if test="${item.supAreaId == vat.vatReceiveDist}">selected="selectted"</c:if>>${item.supAreaName }</option>
                </c:forEach>
              </select>
            </div>
            <div class="form-group">
              <label for="name" class="control-label col-sm-3"><span class="red">*</span>��ϸ��ַ:</label>
              <input type="text" class="form-control detail col-sm-9" id="vat_addr" value="${vat.vatReceiveDetail }" maxlength="128">
            </div>
          </form>
          <div class="btn_list">
            <ul>
              <li><button  type="button" class="btn btn-default blue" id="vat_save">����</button></li>
              <li><button  type="button" class="btn btn-default gray invoice-close">ȡ��</button></li>
              <li class="return"><a href="javascript:void(0);" id="vat_prev">������һ��</a></li>
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