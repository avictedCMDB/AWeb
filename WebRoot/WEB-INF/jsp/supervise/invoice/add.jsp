<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="新增发票" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/supervise_invoice.css" rel="stylesheet">
<script type="text/javascript">
$(function () {

	$(".invoice-submit").click(function () {
		var invoiceType = $(".invoice-type li a.active").attr("data-invoice-type");
		var invoiceCompany = $.trim($("#invoice_company").val());
		var invoiceNum = $.trim($("#invoiceNum").val());
		var invoiceFlag = 1;
		var invoiceContent = "";
		var invoiceExpressName = $.trim($("#invoice_express_name").val());
		var invoiceExpressCode = $.trim($("#invoice_express_code").val());
		var invoiceReceiveDetail = $.trim($("#invoice_receive_detail").val());
		var invoiceReceiveName = $.trim($("#invoice_receive_name").val());
		var invoiceReceiveTel = $.trim($("#invoice_receive_tel").val());
		
		
		var vatReceiveName = $.trim($("#vat_receive_name").val());
		var vatReceiveTel = $.trim($("#vat_receive_tel").val());
		var vatReceiveProv = $.trim($("#vat_receive_prov").val());
		var vatReceiveCity = $.trim($("#vat_receive_city").val());
		var vatReceiveDist = $.trim($("#vat_receive_dist").val());
		var vatReceiveDetail = $.trim($("#vat_receive_detail").val());
		var vatExpressName = $.trim($("#vat_express_name").val());
		var vatExpressCode = $.trim($("#vat_express_code").val());
		
		var expressName = "";
		var expressCode = "";
		
		var orderId = $("#order_id").val();
		
		if (invoiceType == 1) {
			if (invoiceCompany == '') {
				alert("请填写发票抬头");
				return false;
			}
			if (invoiceReceiveName == '') {
				alert("请填写收票人");
				return false;
			}
			if (invoiceReceiveTel == '') {
				alert("请填写电话");
				return false;
			} else if (!/^\d{7,12}$/.test(invoiceReceiveTel)) {
				alert("请填写正确的电话号码");
				return false;
			}
			if (invoiceReceiveDetail == '') {
				alert("请填写地址");
				return false;
			}
			if (invoiceExpressName == '') {
				alert("请填写快递公司");
				return false;
			}
			if (invoiceExpressCode == '') {
				alert("请填写快递单号");
				return false;
			}
			expressName = invoiceExpressName;
			expressCode = invoiceExpressCode;
			vatReceiveDetail = invoiceReceiveDetail;
			vatReceiveName = "";
			vatReceiveTel = "";
			vatReceiveProv = "0";
			vatReceiveCity = "0";
			vatReceiveDist = "0";
			vatReceiveName = invoiceReceiveName;
			vatReceiveTel = invoiceReceiveTel;
		} else {
			if (vatReceiveName == '') {
				alert("请填写收票人姓名");
				return false;
			}
			if (vatReceiveTel == '') {
				alert("请填写收票人手机");
				return false;
			}
			if (vatReceiveProv == '') {
				alert("请选择收票人省份");
				return false;
			}
			if (vatReceiveCity == '') {
				alert("请选择收票人城市");
				return false;
			}
			if (vatReceiveDist == '') {
				alert("请选择收票人区县");
				return false;
			}
			if (vatReceiveDetail == '') {
				alert("请填写详细地址");
				return false;
			}
			if (vatExpressName == '') {
				alert("请填写快递公司");
				return false;
			}
			if (vatExpressCode == '') {
				alert("请填写快递单号");
				return false;
			}
			expressName = vatExpressName;
			expressCode = vatExpressCode;
			invoiceCompany = "";
		}
		
		async('${pageContext.request.contextPath}/supervise/invoice/add/submit', {
			orderId:'${orderId}',
			invoiceType:invoiceType,
			invoiceCompany:invoiceCompany,
			invoiceNum:"",
			invoiceFlag:"1",
			invoiceContent:"",
			expressName:expressName,
			expressCode:expressCode,
			vatReceiveName:vatReceiveName,
			vatReceiveTel:vatReceiveTel,
			vatReceiveProv:vatReceiveProv,
			vatReceiveCity:vatReceiveCity,
			vatReceiveDist:vatReceiveDist,
			vatReceiveDetail:vatReceiveDetail,
		}, function (msg) {
			alert("开票完成");
			window.location.href="${referer}";
		});
		
	});
	
	$(".invoice-type li a").click(function () {
		if ($(this).hasClass("active")) {
			return;
		}
		$(".invoice-type").find(".active").removeClass("active");
		$(this).addClass("active");
		
		if ($(this).attr("data-invoice-type") == "2") {
			$(".private_detail").hide();
			$(".vat_detail").show();
		} else {
			$(".private_detail").show();
			$(".vat_detail").hide();
		}
	});
	
	$(".invoice-next").click(function () {
		$(".step01").hide();
		$(".step02").show();
	});
	$(".invoice-prev").click(function () {
		$(".step02").hide();
		$(".step01").show();
	});
});
</script>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  <input type="hidden" id="order_id" value="${orderId}"/>
  <div id="contents">
    <div class="inner details">
      <h2>新增发票</h2>
      <div id="info_invoice">
        <div class="main_inner">
          <div class="invoice_list list_section title_list">
            <ul class="clearfix invoice-type">
              <li><a data-invoice-type="1" href="javascript:void(0);" <c:if test="${invoice.invoiceStatus == '0' or invoice.invoiceType == 1}">class="active"</c:if>>普通发票</a></li>
              <li><a data-invoice-type="2" href="javascript:void(0);" <c:if test="${invoice.invoiceStatus == '1' and invoice.invoiceType == 2}">class="active"</c:if>>增值税专用发票</a></li>
            </ul>
          </div>
          <div class="private_detail" <c:if test="${invoice.invoiceStatus == '1' and invoice.invoiceType == 2}">style="display:none;"</c:if>>
            <form class="form-horizontal">
              <div class="form-group">
                <label for="name" class="control-label"><span class="red">*</span>发票抬头:</label>
                <input type="text" class="form-control detail" id="invoice_company" value="${invoice.invoiceCompany}">
              </div>
              <div class="form-group">
                <label for="name" class="control-label col-sm-2">发票内容:</label>
                <div class="list_section invoice_list">
                  <ul class="clearfix">
                    <li><a href="javascript:void(0);" class="active">明细</a></li>
                  </ul>
                </div>
              </div>
              <div class="form-group">
                <label for="name" class="control-label"><span class="red">*</span>收票人:</label>
                <input type="text" class="form-control detail" id="invoice_receive_name" value="${invoice.addrName}">
              </div>
              <div class="form-group">
                <label for="name" class="control-label"><span class="red">*</span>电话:</label>
                <input type="text" class="form-control detail" id="invoice_receive_tel" value="${invoice.addrPhone != null ? invoice.addrPhone : invoice.addrTel}">
              </div>
              <div class="form-group">
                <label for="name" class="control-label"><span class="red">*</span>地址:</label>
                <input type="text" class="form-control detail" id="invoice_receive_detail" value="${invoice.invoiceReceiveDetail}">
              </div>
              <div class="form-group">
                <label for="name" class="control-label"><span class="red">*</span>快递公司:</label>
                <input type="text" class="form-control detail" id="invoice_express_name" value="${invoice.expressName}">
              </div>
              <div class="form-group">
                <label for="name" class="control-label"><span class="red">*</span>快递单号:</label>
                <input type="text" class="form-control detail" id="invoice_express_code" value="${invoice.expressCode}">
              </div>
            </form>
            <div class="btn_list">
              <ul>
                <li><button  type="button" class="btn btn-default blue invoice-submit">开票</button></li>
                <li><button  type="button" class="btn btn-default gray" onclick="history.go(-1);">取消</button></li>
              </ul>
            </div>
          <!--.private_detail--></div>
          <div class="vat_detail" <c:if test="${invoice.invoiceStatus == '0' or invoice.invoiceType == 1}">style="display: none;"</c:if>>
          <c:if test="${!empty vat}">
            <div class="step01">
              <div class="step_list">
                <ul class="clearfix">
                  <li class="active">1.填写公司信息</li>
                  <li>2.填写收票人信息</li>
                </ul>
              </div>
              <form class="form-horizontal">
                <div class="form-group">
                  <label for="name" class="control-label"><span class="red">*</span>单位名称:</label>
                  <input type="text" class="form-control detail" value="${vat.companyName }" readonly="readonly">
                </div>
                <div class="form-group">
                  <label for="name" class="control-label"><span class="red">*</span>纳税人识别码:</label>
                  <input type="text" class="form-control detail" value="${vat.taxpayerCode }" readonly="readonly">
                </div>
                <div class="form-group">
                  <label for="name" class="control-label"><span class="red">*</span>注册地址:</label>
                  <input type="text" class="form-control detail" value="${vat.registerPath }" readonly="readonly">
                </div>
                <div class="form-group">
                  <label for="name" class="control-label"><span class="red">*</span>注册电话:</label>
                  <input type="text" class="form-control detail" value="${vat.registerTel }" readonly="readonly">
                </div>
                <div class="form-group">
                  <label for="name" class="control-label"><span class="red">*</span>开户银行:</label>
                  <input type="text" class="form-control detail" value="${vat.bankName }" readonly="readonly">
                </div>
                <div class="form-group">
                  <label for="name" class="control-label"><span class="red">*</span>开户账号:</label>
                  <input type="text" class="form-control detail" value="${vat.bankAccount }" readonly="readonly">
                </div>
              </form>
              <div class="btn_list">
                <ul>
                  <li><button  type="button" class="btn btn-default blue invoice-next">下一步</button></li>
                  <li><button  type="button" class="btn btn-default gray" onclick="history.go(-1);">取消</button></li>
                </ul>
              </div>
            </div>
            <div class="step02" style="display: none;">
              <div class="step_list">
                <ul class="clearfix">
                  <li>1.填写公司信息</li>
                  <li class="active">2.填写收票人信息</li>
                </ul>
              </div>
              <form class="form-horizontal">
                <div class="form-group">
                  <label for="name" class="control-label">发票内容:</label>
                  <div class="list_section invoice_list">
                    <ul>
                      <li><a href="#" class="active">明细</a></li>
                    </ul>
                  </div>
                </div>
                <div class="form-group">
                  <label for="name" class="control-label"><span class="red">*</span>收票人姓名:</label>
                  <input type="text" class="form-control detail" id="vat_receive_name" value="${invoice.vatReceiveName}">
                </div>
                <div class="form-group">
                  <label for="name" class="control-label"><span class="red">*</span>收票人手机:</label>
                  <input type="text" class="form-control detail" id="vat_receive_tel" value="${invoice.vatReceiveTel }">
                </div>
                <div class="form-group">
                  <label for="name" class="control-label"><span class="red">*</span>收票人省份:</label>
                  <select class="form-control" id="vat_receive_prov">
                    <option>省份</option>
	                <c:forEach var="item" items="${vatProv}">
	                <option value="${item.supAreaId }" <c:if test="${item.supAreaId == invoice.vatReceiveProv}">selected="selectted"</c:if>>${item.supAreaName }</option>
	                </c:forEach>
                  </select>
                  <select class="form-control" id="vat_receive_city">
                    <option>市</option>
	                <c:forEach var="item" items="${vatCity}">
	                <option value="${item.supAreaId }" <c:if test="${item.supAreaId == invoice.vatReceiveCity}">selected="selectted"</c:if>>${item.supAreaName }</option>
	                </c:forEach>
                  </select>
                  <select class="form-control" id="vat_receive_dist">
                    <option>县区</option>
	                <c:forEach var="item" items="${vatDist}">
	                <option value="${item.supAreaId }" <c:if test="${item.supAreaId == invoice.vatReceiveDist}">selected="selectted"</c:if>>${item.supAreaName }</option>
	                </c:forEach>
                  </select>
                </div>
                <div class="form-group">
                  <label for="name" class="control-label"><span class="red">*</span>详细地址:</label>
                  <input type="text" class="form-control detail" id="vat_receive_detail" value="${invoice.vatReceiveDetail}">
                </div>
              <div class="form-group">
                <label for="name" class="control-label"><span class="red">*</span>快递公司:</label>
                <input type="text" class="form-control detail" id="vat_express_name" value="${invoice.expressName}">
              </div>
              <div class="form-group">
                <label for="name" class="control-label"><span class="red">*</span>快递单号:</label>
                <input type="text" class="form-control detail" id="vat_express_code" value="${invoice.expressCode}">
              </div>
              </form>
              <div class="btn_list">
                <ul>
                  <li><button  type="button" class="btn btn-default blue invoice-submit">开票</button></li>
                  <li><button  type="button" class="btn btn-default gray" onclick="history.go(-1);">取消</button></li>
                  <li class="return"><a href="javascript:void(0);" class="invoice-prev">返回上一步</a></li>
                </ul>
              </div>
            </div>
          </c:if>
          <c:if test="${empty vat}">
          没有维护增票信息
          </c:if>
          <!--/vat_detail--></div>
        </div>
        <div class="search_result make_table">
            <p class="price">销售价格：<span class="red"><fmt:formatNumber value="${total}" pattern="#0.00#"></fmt:formatNumber></span> 采购金额：<span class="red"><fmt:formatNumber value="${totalInit}" pattern="#0.00#"></fmt:formatNumber></span></p>
            <table>
               <tr>
                 <th width="170">订单编号</th>
                 <th>商品名称</th>
	             <th width="80">销售价格</th>
	             <th width="80">采购金额</th>
                 <th width="90" class="last">商品数量</th>
               </tr>
               <c:forEach var="item" items="${goods}">
               <c:if test="${item.buyNum > 0}">
               <tr>
                 <td>${item.orderId}</td>
                 <td class="company">${item.goodsName}</td>
                 <td><fmt:formatNumber value="${item.goodsPrice}" pattern="#0.00#"></fmt:formatNumber></td>
                 <td><fmt:formatNumber value="${item.goodsPriceInit}" pattern="#0.00#"></fmt:formatNumber></td>
                 <td>${item.buyNum}</td>
               </tr>
               </c:if>
               </c:forEach>
            </table>
          </div>
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>
