<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="/WEB-INF/tlds/tag.tld" prefix="mc"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<html>
<jsp:include page="../head.jsp">
	<jsp:param value="需求列表" name="title"/>
</jsp:include>
<style type="text/css">
body{
}
.list .item, .list .op{
	position: relative;
	background-color: rgb(248, 248, 248)!important;
}
.list .op:before{
	z-index: 2;
    content: ' ';
    width: 100%;
    height: 1px;
    background-color: #ccc;
    top: 0;
    left: 0;
    position: absolute;
    -webkit-transform-origin: 0 0;
    transform-origin: 0 0;
    -webkit-transform: scaleY(0.5);
    transform: scaleY(0.5);
}
.sup .s{
	border-left: 1px solid #eee;
	padding: 0 5px;
}
.sup .s:nth-of-type(1){
	border-left:none;
}
body.req-list .list .op .btn.disabled{
	background-color: #999;
    color: #fff;
}
</style>
<body class="req-list">

<div id="app">
    <div class="header">
        <i class="iconfont back" onclick="location.href = '${pageContext.request.contextPath}/management/order?order_status=-1';">&#xe615;</i>
        <span>需求管理列表</span>
    </div>
    <div class="list">
        <c:forEach var="osr" items="${offStandardRequires}" varStatus="status">
        	<div class="item">
	            <c:forEach var="imageInfo" items="${osr.auditImageInfos}" varStatus="status">
					<c:if test="${status.index == 0}">
						<img src="${pageContext.request.contextPath}${imageInfo.url}" />
					</c:if>
                </c:forEach>
                <c:if test="${empty osr.auditImageInfos}">
                	<img src="#"/>
                </c:if>
	            <p>${osr.goodsDescNew}</p>
	            <p class="info">创建时间：${osr.createDate}</p>
	        </div>
	        <p class="sup">
	            供应商列表
	            <c:forEach var="supInfo" items="${osr.supInfos}" varStatus="status">
              		<span class="s">${supInfo.supName}</span>
              	</c:forEach>
	        </p>
	        <div class="op" onclick="">
	            <c:if test="${osr.status eq '1'}">
	            	<a class="btn" data-link="${osr.ID}">查看进度</a>
              	</c:if> 
              	<c:if test="${osr.status eq '0'}">
	            	<a class="btn disabled">查看进度</a>
              	</c:if> 
	        </div>
        </c:forEach>
    </div>
</div>

<script type="text/javascript">
var hasMore = ${pages == 1 ? 'false' : 'true'}, page = 1;
$(function () {
	$(window).scroll(function(){
	　　var scrollTop = $(this).scrollTop();
	　　var scrollHeight = $(document).height();
	　　var windowHeight = $(this).height();
	　　if(scrollTop + windowHeight == scrollHeight && hasMore){
			page ++;
			$.get('${pageContext.request.contextPath}/${pageAction}'.replace('%PAGE%', page), function (res) {
				var ls = $(res).find('.list');
				$('.list').append(ls);
				if (${pages} == page) {
					hasMore = false;
				} 
			});
	　　}
	});
	$(document).on('click', '.op a[data-link]', function () {
		location.href = '${pageContext.request.contextPath}/management/specialGoods/specialCheck?requireID=' + $(this).attr('data-link');;
	});
});
</script>
</body>
</html>