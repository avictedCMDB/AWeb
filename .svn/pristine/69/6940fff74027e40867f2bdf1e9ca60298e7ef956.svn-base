<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="结算单查看" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/supervise.css" rel="stylesheet">
<script type="text/javascript">
$(function () {
	
	$(".eff-btn").click(function () {
		var ids = [];
		ids.push($(this).attr("data-id"))
		submit_eff(ids);
		
		return false;
	});
});

var submit_eff = function (ids) {
	if (confirm("是否确定生效当前选定结算单？")) {
		
		async('${pageContext.request.contextPath}/supervise/settle/effective/submit', {ids:ids.join(",")}, function (msg) {
			alert(msg.result);
			window.location.reload();
		});
	}
}
</script>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    	<h2>结算单基本信息</h2>
    	<h3 class="title_h3">结算单基本信息</h3>
        <div class="info_detail">
          <div class="txt_area">
            <div class="section_info">
              <label>结算单编号：</label>
              <span>${record.settleId}</span>
              <label>供应商：</label>
              <span>${record.supName}</span>
              <label>结算金额：</label>
              <span><fmt:formatNumber value="${record.settleAmount}" pattern="#0.00#"></fmt:formatNumber>元</span>
              <label>结算周期：</label>
              <span>${record.dateStart}至${record.dateEnd}</span>
            </div>
            
          </div>
      </div>
      <h3 class="title_h3">商品明细信息</h3>
      <div class="search_result">
        <table class="details">
          <tr>
            <th width="70">顺序</th>
            <th width="120">业务编号</th>
            <th width="120">业务类型</th>
            <th width="120">下单日期</th>
            <th>采购单位</th>
            <th width="90">总数量</th>
            <th width="90">总金额</th>
            <th class="last" width="90">操作</th>
          </tr>
          <c:forEach varStatus="sta" var="item" items="${items}">
          <tr>
            <td>${sta.index + 1}</td>
            <td>
				<c:if test="${item.busiType == 1}">
              		<a href="${pageContext.request.contextPath}/supervise/order/detail?o=${item.busiId}&t=1">
              	</c:if>
				<c:if test="${item.busiType == 2}">
              		<a href="${pageContext.request.contextPath}/supervise/refund/detail?r=${item.busiId}&t=1">
              	</c:if>
              	${item.busiId}</a>
            </td>
            <td>
				<c:if test="${item.busiType == 1}">订单</c:if>
				<c:if test="${item.busiType == 2}">退款</c:if>
			</td>
            <td><fmt:formatDate pattern="yyyy-MM-dd" value="${item.createTime}" /></td>
            <td>${item.companyName }</td>
            <td>${item.totalNum}</td><td><c:if test="${item.busiType == 2}">-</c:if><fmt:formatNumber value="${item.settleAmount}" pattern="#0.00#"></fmt:formatNumber></td>
              <td>
				<c:if test="${item.busiType == 1}">
              		<a href="${pageContext.request.contextPath}/supervise/order/detail?o=${item.busiId}&t=1">
              	</c:if>
				<c:if test="${item.busiType == 2}">
              		<a href="${pageContext.request.contextPath}/supervise/refund/detail?r=${item.busiId}&t=1">
              	</c:if>查看</a></td>
          </tr>
          </c:forEach>
        </table>
        <p class="sum">结算总金额：<span><fmt:formatNumber value="${record.settleAmount}" pattern="#0.00#"></fmt:formatNumber>元</span></p>
        <div class="btn_area">
        <c:if test="${record.settleStatus == 1}">
        <button type="button" class="btn btn-default red eff-btn" data-id="${record.settleId}">生效</button>
        </c:if>
        <button type="button" class="btn btn-default red" onclick="history.go(-1);">关闭</button>
        </div>
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>
