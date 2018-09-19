<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="退货退款管理" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/supervise_return.css" rel="stylesheet">
<script type="text/javascript">
$(function () {
	$("#clear").click(function () {
		$("#timeStart").val("");
		$("#timeEnd").val("");
		$("#refundId").val("");
		$("#orderId").val("");
		$("#supId").val("");
		$("#refundStatus").val("");
	});
	
	$(".refund-btn").click(function () {
		var r = $(this).attr("data-id");
		if (confirm("是否确定退款？")) {
				async('${pageContext.request.contextPath}/supervise/refund/submit', {r:$(this).attr("data-id")}, function (msg) {
					if(msg.result == '2'){
						//跳转到支付宝退款
						$("#refund"+r).after("退款中..");
						$("#refund"+r).remove();
						showAlipayDiv(r);
						
					}else{
						if (msg.result == '1') {
							alert("退款成功，自采订单的退款金额请与采购方线下联系！");
						} else {
							alert("退款成功，支付的金额将在3个工作日内原路退回到支付的银行卡中。");
						}
						window.location.reload();
					}
				});
		}
		
		return false;
	});
});

var form_check = function () {
	var timeStart = $("#timeStart").val();
	var timeEnd = $("#timeEnd").val();
	
	if (timeStart != "" && timeEnd != "") {
		var a = parseInt(timeStart.replace("-", ""));
		var b = parseInt(timeEnd.replace("-", ""));
		
		if (a > b) {
			alert("开始时间不能大于结束时间");
			return false;
		}
	}
	
	return true;
}

function showAlipayDiv(r){
	var url ="${pageContext.request.contextPath}/supervise/refund/alipayrefund?r="+r;
	window.open(url);
	
}
</script>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    	<jsp:include page="../left.jsp">
    		<jsp:param value="refund" name="menu"/>
    	</jsp:include>
      <div id="matter_section">
      	<h2>退货退款管理</h2>
      	<div class="search_area section">
      	<form action="${pageContext.request.contextPath}/supervise/refund/list" method="get" onsubmit="return form_check();">
          <div class="search_list clearfix">
            <dl class="clearfix date_list">
              <dt>退货日期：</dt>
              <dd>
                <ul class="clearfix">
                  <li>
                    <div class="input-group">
                      <input type="text" class=" form-control special_input" name="timeStart" id="timeStart" value="${timeStart}" readonly="readonly" style="background-color: #ffffff;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                      <span class="input-group-addon"><i class="fa fa-calendar" onclick="$('#timeStart').focus()"></i></span>
                    </div>
                  </li>
                  <li>至</li>
                  <li class="last">
                    <div class="input-group">
                      <input type="text" class=" form-control special_input" name="timeEnd" id="timeEnd" value="${timeEnd}" readonly="readonly" style="background-color: #ffffff;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                      <span class="input-group-addon"><i class="fa fa-calendar" onclick="$('#timeEnd').focus()"></i></span>
                    </div>
                  </li>
                </ul>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>退货单编号：</dt>
              <dd>
                <input type="text" class="form-control" name="refundId" id="refundId" value="${refundId}">
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>供应商名称：</dt>
              <dd>
                <select class="form-control" name="supId" id="supId">
                	<option value="">全部</option>
					<c:forEach var="item" varStatus="sta" items="${sups}">
					<option value="${item.supId}" <c:if test="${supId == item.supId}">selected="selected"</c:if>>${item.supName }</option>
					</c:forEach>
                </select>
              </dd>
            </dl>
            <dl class="clearfix date_list">
              <dt>订单编号：</dt>
              <dd>
                <input type="text" class="form-control" name="orderId" id="orderId" value="${orderId}">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>退货状态：</dt>
              <dd>
                <select class="form-control" name="refundStatus" id="refundStatus">
                    <option value="">全部</option>
                    <option value="4" <c:if test="${refundStatus == '4'}">selected="selected"</c:if>>未退款</option>
                    <option value="5" <c:if test="${refundStatus == '5'}">selected="selected"</c:if>>已退款</option>
                </select>
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="submit" class="btn btn-default red">查询</button></li>
              <li><button type="button" id="clear" class="btn btn-default gray">清空</button></li>
            </ul>
          </div></form>
        </div>
        <div class="search_result">
          <div class="state_list">
            <div style="float:right;">退货金额合计：<span class="price"><fmt:formatNumber value="${stat.refundPrice == null ? 0 : stat.refundPrice}" pattern="#0.00#"></fmt:formatNumber></span> 
            </div>
          </div>
          <table>
            <tr>
              <th width="110">退货单编号</th>
              <th width="110">订单编号</th>
              <th>供应商名称</th>
              <th>采购单位名称</th>
              <th width="70">退货数量</th>
              <th width="70">支付方式</th>
              <th width="70">金额(元)</th>
              <th width="70">申请时间</th>
              <th width="120">状态</th>
              <th width="110" class="last">操作</th>
            </tr>
            <c:forEach var="item" varStatus="sta" items="${list}">
            <tr>
              <td><a href="${pageContext.request.contextPath}/supervise/refund/detail?r=${item.refundId}">${item.refundId }</a></td>
              <td><a href="${pageContext.request.contextPath}/supervise/order/list?orderId=${item.orderId}">${item.orderId }</a></td>
              <td>${item.supName }</td>
              <td>${item.companyName }</td>
              <td>${item.refundAmount }</td>
              <td>
               ${item.pay_gate}
              </td>
              <td class="price"><fmt:formatNumber value="${item.refundPrice}" pattern="#0.00#"></fmt:formatNumber></td>
              <td><fmt:formatDate pattern="yyyy-MM-dd" value="${item.refundDate}" /></td>
              <td>
				<c:choose>
					<c:when test="${item.refundStatus == '4'}">未退款</c:when>
					<c:when test="${item.refundStatus == '5'}">已退款</c:when>
				</c:choose>
			  </td>
              <td><a href="${pageContext.request.contextPath}/supervise/refund/detail?r=${item.refundId}">查看</a>
              <c:if test="${item.refundStatus == '4'}">
              <a href="javascript:void(0);" id="refund${item.refundId}" data-id="${item.refundId}" class="refund-btn">退款</a>
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
