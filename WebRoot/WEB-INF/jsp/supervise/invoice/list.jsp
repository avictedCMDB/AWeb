<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../meta.jsp" >
	<jsp:param value="��Ʊ����" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/supervise_invoice.css" rel="stylesheet">
<script type="text/javascript">
$(function () {
	$("#clear").click(function () {
		$("#timeStart").val("");
		$("#timeEnd").val("");
		$("#companyId").val("");
		$("#orderId").val("");
		$("#invoiceStatus").val("");
	});
	

	$("#chx_all").click(function () {
		var chx = this.checked;
		$(".chxbox").each(function () {
			if (!this.disabled) {
				this.checked = chx;
			}
		});
	});
	
	$(".chxbox").click(function () {
		if (!this.disabled) {
			var flag = true;
			$(".chxbox").each(function () {
				if (!this.disabled) {
					if (!this.checked) {
						flag = false;
					}
				}
			});
			
			$("#chx_all").get(0).checked = flag;
		}
	});
	
	$("#batch_btn").click(function () {
		var orders = [];
		var cmp = false;
		var flag = false;
		var addr = false;
		var name = false;
		var tel = false;
		var flagAddr = false;
		var flagName = false;
		var flagTel = false;
		
		$(".chxbox:checked").each(function () {
			orders.push($(this).attr("data-id"));
			if (!cmp) {
				cmp = $(this).attr("data-company");
			} else if (cmp != $(this).attr("data-company")) {
				flag = true;
			}
			
			if (!addr) {
				addr = $(this).attr("data-addr");
			} else if (addr != $(this).attr("data-addr")) {
				flagAddr = true;
			}
			
			if (!name) {
				name = $(this).attr("data-name");
			} else if (name != $(this).attr("data-name")) {
				flagName = true;
			}
			
			if (!tel) {
				tel = $(this).attr("data-tel");
			} else if (tel != $(this).attr("data-tel")) {
				flagTel = true;
			}
		});
		
		if (orders.length == 0) {
			alert("��ѡ��Ҫ��Ʊ�Ķ���");
			return false;
		}
		
		if (flag) {
			alert("������Ʊֻ��ѡ����ͬ�ɹ���λ�Ķ���");
			return false;
		}
		
		if (flagAddr || flagName || flagTel) {
			alert("������Ʊֻ��ѡ����ͬ�ջ���ַ���������绰�Ķ���");
			return false;
		}
		
		window.location.href = "${pageContext.request.contextPath}/supervise/invoice/add?o=" + orders.join(",");
	});
	
});
	function doNoInvoice(o){
		var url = "${pageContext.request.contextPath}/supervise/invoice/doNoInvoice?o="+o;
		var params = '&orderId='+$('#orderId').val()+'&timeStart='+$('#timeStart').val()
			+'&timeEnd='+$('#timeEnd').val()+'&companyId='+$('#companyId').val()+'&invoiceStatus='+$('#invoiceStatus').val();
		window.location.href = url+params;
	}
</script>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  
  <div id="contents">
    <div class="inner">
    	<jsp:include page="../left.jsp">
    		<jsp:param value="invoice" name="menu"/>
    	</jsp:include>
      <div id="matter_section">
      	<h2>��Ʊ����</h2>
      	<div class="search_area section">
      	<form action="${pageContext.request.contextPath}/supervise/invoice/list" method="get">
          <div class="search_list clearfix">
            <dl class="clearfix">
              <dt>֧��ʱ�䣺</dt>
              <dd>
                <ul class="clearfix">
                  <li>
                    <div class="input-group">
                      <input type="text" class="form-control special_input" id="timeStart" name="timeStart" value="${timeStart}" readonly="readonly" style="cursor:pointer;background-color: #ffffff;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                      <span class="input-group-addon"><i class="fa fa-calendar" onclick="$('#timeStart').focus()"></i></span>
                    </div>
                  </li>
                  <li>��</li>
                  <li class="last">
                    <div class="input-group">
                      <input type="text" class="form-control special_input" id="timeEnd" name="timeEnd" value="${timeEnd}" readonly="readonly" style="cursor:pointer;background-color: #ffffff;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                      <span class="input-group-addon"><i class="fa fa-calendar" onclick="$('#timeEnd').focus()"></i></span>
                    </div>
                  </li>
                </ul>
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>������ţ�</dt>
              <dd>
                <input type="text" class="form-control" name="orderId" id="orderId" value="${orderId}">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>�ɹ���λ��</dt>
              <dd>
                <select class="form-control" name="companyId" id="companyId">
                  <option value="">ȫ��</option>
					<c:forEach var="item" varStatus="sta" items="${companys}">
					<option value="${item.companyId}" <c:if test="${companyId == item.companyId}">selected="selected"</c:if>>${item.companyName }</option>
					</c:forEach>
                </select>
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>��Ʊ״̬��</dt>
              <dd>
                <select class="form-control" name="invoiceStatus" id="invoiceStatus">
                  <option value="">ȫ��</option>
                  <option value="0" <c:if test="${invoiceStatus == '0'}">selected="selected"</c:if>>δ��</option>
                  <option value="1" <c:if test="${invoiceStatus == '1'}">selected="selected"</c:if>>�ѿ�</option>
                  <option value="2" <c:if test="${invoiceStatus == '2'}">selected="selected"</c:if>>����Ʊ</option>
                </select>
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="submit" class="btn btn-default red">��ѯ</button></li>
              <li><button type="button" id="clear" class="btn btn-default gray">���</button></li>
            </ul>
          </div>
        </div>
        </form>
        <div class="search_result">
          <div class="state_list">
            <button class="btn btn-default red" id="batch_btn" type="button">������Ʊ</button>
            <a href="${pageContext.request.contextPath}/supervise/invoice/export?timeStart=${timeStart}&timeEnd=${timeEnd}&orderId=${orderId}&companyId=${companyId}&invoiceStatus=${invoiceStatus}" class="btn btn-default red" target="_blank" id="export_btn" type="button">����</a>
          </div>
          <div class="state_list">
          �ѿ���<span style="color:red;"><fmt:formatNumber value="${i1 == null ? 0 : i1}" pattern="#0.00#"></fmt:formatNumber></span> 
          δ����<span style="color:red;"><fmt:formatNumber value="${i0 == null ? 0 : i0}" pattern="#0.00#"></fmt:formatNumber></span> 
          ������<span style="color:red;"><fmt:formatNumber value="${i2 == null ? 0 : i2}" pattern="#0.00#"></fmt:formatNumber></span> 
          </div>
          <table>
            <tr>
              <th width="40"><input type="checkbox" id="chx_all"></th>
              <th width="100">�������</th>
              <th width="90">�ɹ���λ</th>
              <th width="80">���ۼ۸�</th>
              <th width="80">�ɹ����</th>
              <th width="80">�ɹ�����</th>
              <th width="80">��Ʊ����</th>
              <th width="70">״̬</th>
              <th width="70">��ݹ�˾</th>
              <th width="110">��ݵ���</th>
              <th width="130" class="last">����</th>
            </tr>
            <c:forEach var="item" varStatus="sta" items="${list}">
            <tr>
              <td><input type="checkbox" data-addr="${item.addrAll}" data-name="${item.addrName}" data-tel="${item.addrPhone}${item.addrTel}" data-id="${item.orderId}" data-company="${item.companyId}" class="chxbox" <c:if test="${item.invoiceStatus == '1' or item.refunding > 0}">disabled="disabled"</c:if>></td>
              <td><a href="${pageContext.request.contextPath}/supervise/order/list?orderId=${item.orderId}">${item.orderId }</a></td>
              <td>${item.companyName}</td>
              <td class="price"><fmt:formatNumber value="${item.orderAmount}" pattern="#0.00#"></fmt:formatNumber></td>
              <td class="price"><fmt:formatNumber value="${item.orderAmountInit}" pattern="#0.00#"></fmt:formatNumber></td>
              <td>${item.goodsNum }</td>
              <td>
              	<c:choose>
              		<c:when test="${item.invoiceType == '2'}">��Ʊ</c:when>
              		<c:when test="${item.invoiceType == '1'}">��Ʊ</c:when>
              		<c:when test="${item.invoiceType == '0'}">��</c:when>
           		</c:choose>
       		  </td>
              <td>
              	<c:choose>
              		<c:when test="${item.invoiceStatus == '2'}">����Ʊ</c:when>
              		<c:when test="${item.invoiceStatus == '1'}">�ѿ�</c:when>
              		<c:when test="${item.invoiceStatus == '0'}">δ��</c:when>
           		</c:choose>
       		  </td>
              <td class="company">${fn:escapeXml(item.expressName) }</td>
              <td>${fn:escapeXml(item.expressCode) }</td>
              <td>
              <c:if test="${item.refunding == 0}">
	              <c:if test="${item.invoiceStatus == '0'}">
	              <a href="${pageContext.request.contextPath}/supervise/invoice/add?o=${item.orderId}">��Ʊ</a>
	              <a href="javascript:void(0);" onclick="doNoInvoice('${item.orderId}')">����Ʊ</a>
	              </c:if>
	              <c:if test="${item.invoiceStatus == '1'}">
	              <a href="${pageContext.request.contextPath}/supervise/invoice/add?o=${item.orderId}">�޸�</a>
	              </c:if>
              </c:if>
              <c:if test="${item.refunding > 0}">
              ���˿�δ���
              </c:if>
              </td>
            </tr>
            </c:forEach>
          </table>
        
        </div>
<jsp:include page="../page.jsp" />
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>