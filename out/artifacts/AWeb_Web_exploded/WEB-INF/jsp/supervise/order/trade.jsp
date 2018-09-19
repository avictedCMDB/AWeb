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
<c:if test="${pages > 0}">
	<div id="flip" class="clearfix" style="padding-left:0; float:right;">
		<ul>
			<c:if test="${page > 1}">
				<li><a href="${pageContext.request.contextPath}/${fn:escapeXml(fn:replace(pageAction, '%PAGE%', page - 1))}">上一页</a></li>
			</c:if>

			<c:set var="minPage" value="${page - 3}"></c:set>
			<c:set var="maxPage" value="${page + 3}"></c:set>

			<c:if test="${minPage < 1 }">
				<c:set var="minPage" value="1"></c:set>
			</c:if>

			<c:if test="${maxPage > pages}">
				<c:set var="maxPage" value="${pages}"></c:set>
			</c:if>

			<c:if test="${minPage > 1}">
				<li><a href="${pageContext.request.contextPath}/${fn:escapeXml(fn:replace(pageAction, '%PAGE%', 1))}">1</a></li>
			</c:if>

			<c:if test="${minPage > 2}">

				<li class="select"><a href="#">...</a></li>
			</c:if>
			<c:forEach varStatus="i" begin="${minPage}" end="${maxPage}" step="1">

				<c:set var="idx" value="${i.count + minPage - 1}"></c:set>

				<c:choose>
					<c:when test="${idx == page}">
						<li class="select font-color-red">
					</c:when>
					<c:otherwise>
						<li>
					</c:otherwise>
				</c:choose>

				<a href="${pageContext.request.contextPath}/${fn:escapeXml(fn:replace(pageAction, '%PAGE%', idx))}">${idx}</a>
				</li>
			</c:forEach>

			<c:if test="${maxPage < pages - 1}">
				<li class="select"><a href="#">...</a></li>
			</c:if>
			<c:if test="${maxPage < pages}">
				<li><a href="${pageContext.request.contextPath}/${fn:escapeXml(fn:replace(pageAction, '%PAGE%', pages))}">${pages}</a></li>
			</c:if>

			<c:if test="${page < pages}">
				<li><a href="${pageContext.request.contextPath}/${fn:escapeXml(fn:replace(pageAction, '%PAGE%', page + 1))}">下一页</a></li>
			</c:if>

		</ul>
		<!--#flip-->
	</div>
	<div class="clearfix"></div>
</c:if>