<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="������Ʊ" name="title"/>
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
				alert("����д��Ʊ̧ͷ");
				return false;
			}
			if (invoiceReceiveName == '') {
				alert("����д��Ʊ��");
				return false;
			}
			if (invoiceReceiveTel == '') {
				alert("����д�绰");
				return false;
			} else if (!/^\d{7,12}$/.test(invoiceReceiveTel)) {
				alert("����д��ȷ�ĵ绰����");
				return false;
			}
			if (invoiceReceiveDetail == '') {
				alert("����д��ַ");
				return false;
			}
			if (invoiceExpressName == '') {
				alert("����д��ݹ�˾");
				return false;
			}
			if (invoiceExpressCode == '') {
				alert("����д��ݵ���");
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
				alert("����д��Ʊ������");
				return false;
			}
			if (vatReceiveTel == '') {
				alert("����д��Ʊ���ֻ�");
				return false;
			}
			if (vatReceiveProv == '') {
				alert("��ѡ����Ʊ��ʡ��");
				return false;
			}
			if (vatReceiveCity == '') {
				alert("��ѡ����Ʊ�˳���");
				return false;
			}
			if (vatReceiveDist == '') {
				alert("��ѡ����Ʊ������");
				return false;
			}
			if (vatReceiveDetail == '') {
				alert("����д��ϸ��ַ");
				return false;
			}
			if (vatExpressName == '') {
				alert("����д��ݹ�˾");
				return false;
			}
			if (vatExpressCode == '') {
				alert("����д��ݵ���");
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
			alert("��Ʊ���");
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
      <h2>������Ʊ</h2>
      <div id="info_invoice">
        <div class="main_inner">
          <div class="invoice_list list_section title_list">
            <ul class="clearfix invoice-type">
              <li><a data-invoice-type="1" href="javascript:void(0);" <c:if test="${invoice.invoiceStatus == '0' or invoice.invoiceType == 1}">class="active"</c:if>>��ͨ��Ʊ</a></li>
              <li><a data-invoice-type="2" href="javascript:void(0);" <c:if test="${invoice.invoiceStatus == '1' and invoice.invoiceType == 2}">class="active"</c:if>>��ֵ˰ר�÷�Ʊ</a></li>
            </ul>
          </div>
          <div class="private_detail" <c:if test="${invoice.invoiceStatus == '1' and invoice.invoiceType == 2}">style="display:none;"</c:if>>
            <form class="form-horizontal">
              <div class="form-group">
                <label for="name" class="control-label"><span class="red">*</span>��Ʊ̧ͷ:</label>
                <input type="text" class="form-control detail" id="invoice_company" value="${invoice.invoiceCompany}">
              </div>
              <div class="form-group">
                <label for="name" class="control-label col-sm-2">��Ʊ����:</label>
                <div class="list_section invoice_list">
                  <ul class="clearfix">
                    <li><a href="javascript:void(0);" class="active">��ϸ</a></li>
                  </ul>
                </div>
              </div>
              <div class="form-group">
                <label for="name" class="control-label"><span class="red">*</span>��Ʊ��:</label>
                <input type="text" class="form-control detail" id="invoice_receive_name" value="${invoice.addrName}">
              </div>
              <div class="form-group">
                <label for="name" class="control-label"><span class="red">*</span>�绰:</label>
                <input type="text" class="form-control detail" id="invoice_receive_tel" value="${invoice.addrPhone != null ? invoice.addrPhone : invoice.addrTel}">
              </div>
              <div class="form-group">
                <label for="name" class="control-label"><span class="red">*</span>��ַ:</label>
                <input type="text" class="form-control detail" id="invoice_receive_detail" value="${invoice.invoiceReceiveDetail}">
              </div>
              <div class="form-group">
                <label for="name" class="control-label"><span class="red">*</span>��ݹ�˾:</label>
                <input type="text" class="form-control detail" id="invoice_express_name" value="${invoice.expressName}">
              </div>
              <div class="form-group">
                <label for="name" class="control-label"><span class="red">*</span>��ݵ���:</label>
                <input type="text" class="form-control detail" id="invoice_express_code" value="${invoice.expressCode}">
              </div>
            </form>
            <div class="btn_list">
              <ul>
                <li><button  type="button" class="btn btn-default blue invoice-submit">��Ʊ</button></li>
                <li><button  type="button" class="btn btn-default gray" onclick="history.go(-1);">ȡ��</button></li>
              </ul>
            </div>
          <!--.private_detail--></div>
          <div class="vat_detail" <c:if test="${invoice.invoiceStatus == '0' or invoice.invoiceType == 1}">style="display: none;"</c:if>>
          <c:if test="${!empty vat}">
            <div class="step01">
              <div class="step_list">
                <ul class="clearfix">
                  <li class="active">1.��д��˾��Ϣ</li>
                  <li>2.��д��Ʊ����Ϣ</li>
                </ul>
              </div>
              <form class="form-horizontal">
                <div class="form-group">
                  <label for="name" class="control-label"><span class="red">*</span>��λ����:</label>
                  <input type="text" class="form-control detail" value="${vat.companyName }" readonly="readonly">
                </div>
                <div class="form-group">
                  <label for="name" class="control-label"><span class="red">*</span>��˰��ʶ����:</label>
                  <input type="text" class="form-control detail" value="${vat.taxpayerCode }" readonly="readonly">
                </div>
                <div class="form-group">
                  <label for="name" class="control-label"><span class="red">*</span>ע���ַ:</label>
                  <input type="text" class="form-control detail" value="${vat.registerPath }" readonly="readonly">
                </div>
                <div class="form-group">
                  <label for="name" class="control-label"><span class="red">*</span>ע��绰:</label>
                  <input type="text" class="form-control detail" value="${vat.registerTel }" readonly="readonly">
                </div>
                <div class="form-group">
                  <label for="name" class="control-label"><span class="red">*</span>��������:</label>
                  <input type="text" class="form-control detail" value="${vat.bankName }" readonly="readonly">
                </div>
                <div class="form-group">
                  <label for="name" class="control-label"><span class="red">*</span>�����˺�:</label>
                  <input type="text" class="form-control detail" value="${vat.bankAccount }" readonly="readonly">
                </div>
              </form>
              <div class="btn_list">
                <ul>
                  <li><button  type="button" class="btn btn-default blue invoice-next">��һ��</button></li>
                  <li><button  type="button" class="btn btn-default gray" onclick="history.go(-1);">ȡ��</button></li>
                </ul>
              </div>
            </div>
            <div class="step02" style="display: none;">
              <div class="step_list">
                <ul class="clearfix">
                  <li>1.��д��˾��Ϣ</li>
                  <li class="active">2.��д��Ʊ����Ϣ</li>
                </ul>
              </div>
              <form class="form-horizontal">
                <div class="form-group">
                  <label for="name" class="control-label">��Ʊ����:</label>
                  <div class="list_section invoice_list">
                    <ul>
                      <li><a href="#" class="active">��ϸ</a></li>
                    </ul>
                  </div>
                </div>
                <div class="form-group">
                  <label for="name" class="control-label"><span class="red">*</span>��Ʊ������:</label>
                  <input type="text" class="form-control detail" id="vat_receive_name" value="${invoice.vatReceiveName}">
                </div>
                <div class="form-group">
                  <label for="name" class="control-label"><span class="red">*</span>��Ʊ���ֻ�:</label>
                  <input type="text" class="form-control detail" id="vat_receive_tel" value="${invoice.vatReceiveTel }">
                </div>
                <div class="form-group">
                  <label for="name" class="control-label"><span class="red">*</span>��Ʊ��ʡ��:</label>
                  <select class="form-control" id="vat_receive_prov">
                    <option>ʡ��</option>
	                <c:forEach var="item" items="${vatProv}">
	                <option value="${item.supAreaId }" <c:if test="${item.supAreaId == invoice.vatReceiveProv}">selected="selectted"</c:if>>${item.supAreaName }</option>
	                </c:forEach>
                  </select>
                  <select class="form-control" id="vat_receive_city">
                    <option>��</option>
	                <c:forEach var="item" items="${vatCity}">
	                <option value="${item.supAreaId }" <c:if test="${item.supAreaId == invoice.vatReceiveCity}">selected="selectted"</c:if>>${item.supAreaName }</option>
	                </c:forEach>
                  </select>
                  <select class="form-control" id="vat_receive_dist">
                    <option>����</option>
	                <c:forEach var="item" items="${vatDist}">
	                <option value="${item.supAreaId }" <c:if test="${item.supAreaId == invoice.vatReceiveDist}">selected="selectted"</c:if>>${item.supAreaName }</option>
	                </c:forEach>
                  </select>
                </div>
                <div class="form-group">
                  <label for="name" class="control-label"><span class="red">*</span>��ϸ��ַ:</label>
                  <input type="text" class="form-control detail" id="vat_receive_detail" value="${invoice.vatReceiveDetail}">
                </div>
              <div class="form-group">
                <label for="name" class="control-label"><span class="red">*</span>��ݹ�˾:</label>
                <input type="text" class="form-control detail" id="vat_express_name" value="${invoice.expressName}">
              </div>
              <div class="form-group">
                <label for="name" class="control-label"><span class="red">*</span>��ݵ���:</label>
                <input type="text" class="form-control detail" id="vat_express_code" value="${invoice.expressCode}">
              </div>
              </form>
              <div class="btn_list">
                <ul>
                  <li><button  type="button" class="btn btn-default blue invoice-submit">��Ʊ</button></li>
                  <li><button  type="button" class="btn btn-default gray" onclick="history.go(-1);">ȡ��</button></li>
                  <li class="return"><a href="javascript:void(0);" class="invoice-prev">������һ��</a></li>
                </ul>
              </div>
            </div>
          </c:if>
          <c:if test="${empty vat}">
          û��ά����Ʊ��Ϣ
          </c:if>
          <!--/vat_detail--></div>
        </div>
        <div class="search_result make_table">
            <p class="price">���ۼ۸�<span class="red"><fmt:formatNumber value="${total}" pattern="#0.00#"></fmt:formatNumber></span> �ɹ���<span class="red"><fmt:formatNumber value="${totalInit}" pattern="#0.00#"></fmt:formatNumber></span></p>
            <table>
               <tr>
                 <th width="170">�������</th>
                 <th>��Ʒ����</th>
	             <th width="80">���ۼ۸�</th>
	             <th width="80">�ɹ����</th>
                 <th width="90" class="last">��Ʒ����</th>
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