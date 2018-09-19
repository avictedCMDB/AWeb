<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>	
	
	
	<div class="footer">
        <a class="item <c:if test='${param.tab == "��ҳ"}'>active</c:if>" href="${pageContext.request.contextPath}/market/index"> 
            <span class="iconfont">&#xe60d;</span>
            <span>��ҳ</span>
        </a>
        <a class="item <c:if test='${param.tab == "����"}'>active</c:if>" href="${pageContext.request.contextPath}/market/goods/cate">
            <span class="iconfont">&#xe601;</span>
            <span>����</span>
        </a>
        <a class="item <c:if test='${param.tab == "���ﳵ"}'>active</c:if>" href="${pageContext.request.contextPath}/market/cart/list">
            <span class="c-count" v-show="cartCount ? cartCount : '<c:if test="${sessionScope.login_user != null}">${dataCache.cartNum(pageContext.session)}</c:if>'" >{{cartCount ? cartCount : '<c:if test="${sessionScope.login_user != null}">${dataCache.cartNum(pageContext.session)}</c:if>'}}</span>
            <span class="iconfont">&#xe726;</span>
            <span>���ﳵ</span>
        </a>
        <a class="item <c:if test='${param.tab == "�ҵ�"}'>active</c:if>" href="${pageContext.request.contextPath}/management/order?order_status=-1">
            <span class="iconfont">&#xe6b3;</span>
            <span>�ҵ�</span>
        </a>
    </div>