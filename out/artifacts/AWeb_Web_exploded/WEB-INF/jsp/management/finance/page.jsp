<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:if test="${pages > 0}">
	<div class="page">
		<ul class="pagination">
			<c:if test="${page > 1}">
				<li><a href="${pageContext.request.contextPath}/${fn:escapeXml(fn:replace(pageAction, '%PAGE%', page - 1))}">&laquo;</a></li>
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

				<li>...</li>
			</c:if>
			<c:forEach varStatus="i" begin="${minPage}" end="${maxPage}" step="1">

				<c:set var="idx" value="${i.count + minPage - 1}"></c:set>

				<c:choose>
					<c:when test="${idx == page}">
						<li class="active">
				<a href="javascript:void(0);">${idx}</a>
				</li>
					</c:when>
					<c:otherwise>
						<li>
				<a href="${pageContext.request.contextPath}/${fn:escapeXml(fn:replace(pageAction, '%PAGE%', idx))}">${idx}</a>
				</li>
					</c:otherwise>
				</c:choose>

			</c:forEach>

			<c:if test="${maxPage < pages - 1}">
				<li>...</li>
			</c:if>
			<c:if test="${maxPage < pages}">
				<li><a href="${pageContext.request.contextPath}/${fn:escapeXml(fn:replace(pageAction, '%PAGE%', pages))}">${pages}</a></li>
			</c:if>

			<c:if test="${page < pages}">
				<li><a href="${pageContext.request.contextPath}/${fn:escapeXml(fn:replace(pageAction, '%PAGE%', page + 1))}">&raquo;</a></li>
			</c:if>

		</ul>
	</div>
	<div class="clearfix"></div>
</c:if>