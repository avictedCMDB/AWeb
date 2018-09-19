<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="tableStyle02" width="1018" border="0">
	<tr>
		<th width="160">买家</th>
		<th width="160">成交价格</th>
		<th width="356">成交时间</th>
		<th width="160">成交数量</th>
	</tr>
	<c:forEach varStatus="sta" var="item" items="${list}">
	<tr>
		<td>${item.userName}</td>
		<td><fmt:formatNumber value="${item.goodsPrice}" pattern="#0.00#"></fmt:formatNumber></td>
		<td><fmt:formatDate value="${item.orderTime}" pattern="yyyy年MM月dd日 HH:mm"/></td>
		<td>${item.buyNum}</td>
	</tr>
	</c:forEach>
	<c:if test="${empty list}">
	<tr>
		<td colspan="4">暂无交易</td>
	</tr>
	</c:if>
</table>
<jsp:include page="../page.jsp" />