<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<jsp:include page="../head.jsp">
	<jsp:param value="专业市场" name="title"/>
</jsp:include>
<style type="text/css">
body.pro .pro-brand .sup-list .row .item img{
	max-width: 110px;
	max-height: 35px;
}
</style>
<body class="index pro include-footer">
    <div id="app">
        <div class="search-wrapper">
            <img src="${pageContext.request.contextPath}/static/image/pro-index.jpg">
            <div class="search">
                <span class="iconfont">&#xe60b;</span>
                <input type="search" placeholder="路由器" readonly="readonly" onclick="location.href = '${pageContext.request.contextPath}/market/goods/prof';"/>
            </div>
        </div>

        <div class="nav">
            <div class="type-list">
                <div class="item">
                    <a href="${pageContext.request.contextPath}/market/goods/prof?cat1=P1">标准产品</a>
                </div>
                <div class="item">
                    <a href="${pageContext.request.contextPath}/market/goods/prof?cat1=P3">非标准产品</a>
                </div>
                <div class="item">
                    <a href="${pageContext.request.contextPath}/market/goods/prof?cat1=P2">其他商品</a>
                </div>
            </div>
            <img class="tip" src="${pageContext.request.contextPath}/static/image/pro-tip.png"/>
        </div>

        <div class="pro-brand margin-top-10">
            <img src="${pageContext.request.contextPath}/static/image/pro-brand.png" class="hd"/>
            <div class="sup-list">
            	<c:forEach var="item" items="${brands}" varStatus="s">
                	<c:if test="${s.index % 3 == 0}">
                		<c:if test="${!s.first}">
                			</div>
                		</c:if>
                		<div class="row">
                	</c:if>
                	<div class="item" onclick="location.href = '${pageContext.request.contextPath}/market/goods/prof?brand=${item.brandName}&from=brand';">
                        <img src="${pageContext.request.contextPath}${item.brandImage}">
                    </div>
                    <c:if test="${s.last}">
                    	<c:if test="${s.last}">
                    		<c:forEach begin="1" end="${2 - (s.index % 3)}">
                    			<div class="item"></div>
                    		</c:forEach>
                    	</c:if>
                    	</div>
                	</c:if>
                </c:forEach>
            </div>
        </div>

        <img src="${pageContext.request.contextPath}/static/image/select-sup.png" onclick="location.href = '${pageContext.request.contextPath}/management/specialGoods';" class="select-sup margin-top-10"/>

        <div class="pro-latest margin-top-10">
            <img src="${pageContext.request.contextPath}/static/image/latest-join.png" class="hd"/>
            <div class="sup-list">
                <c:forEach var="item" items="${newSup}">   
                	<p class="sup" onclick="location.href = '${pageContext.request.contextPath}/market/goods/prof?sup=${item.supId}&from=sup';">${item.supName}<span><fmt:formatDate value="${item.enterDate}" pattern="yyyy-MM-dd"/>入驻</span></p>                         
               </c:forEach>
            </div>
        </div>
        <div class="high-sup margin-top-10">
            <img src="${pageContext.request.contextPath}/static/image/high-sup.png" class="hd"/>
            <div class="sup-list">
                <c:forEach var="item" items="${recSup}">
                    <div class="item" onclick="location.href = '${pageContext.request.contextPath}/market/goods/prof?sup=${item.supId}&from=sup';">
	                    <img src="${pageContext.request.contextPath}${item.supImage}"/>
	                    <div class="i">
	                        <p class="name">${item.supName}</p>
	                        <p class="type">供应品类：${item.busiType}</p>
	                        <p class="info">主营品牌信息：${item.busiRange}</p>
	                    </div>
	                </div>
                </c:forEach>
            </div>
        </div>
        <img src="${pageContext.request.contextPath}/static/image/pro-banner.png" class="margin-top-10" style="display: block;width: 100%;"/>
        <div style="height: 60px; opacity: 0;"></div>
        <jsp:include page="../foot.jsp"/>
    </div>
<script type="text/javascript">
    var app = new Vue({
        el  : '#app',
        data: {
        	cartCount	: 0
        }
    });
</script>
</body>
</html>