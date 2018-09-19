<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

    	<div id="side_navi">

    		<dl>
    		<c:forEach var="menu" items="${sessionScope.login_supervise_menu}" varStatus="status">
    			<c:if test="${menu.menuLevel == '2'}">
    				<dt class="tlt_merchandise">${menu.name}<span class="fa fa-caret-square-o-down"></span></dt>
    				<dd class="last_child">
	    				<ul>
	    					<c:forEach var="children" items="${sessionScope.login_supervise_menu}" varStatus="status">
	    						<c:if test="${menu.menuId == children.parentId}">
	    							<li <c:if test="${sessionScope.menuParam == children.menuParam and sessionScope.menuParam != null}">class="active"</c:if>><a href="${pageContext.request.contextPath}${children.href}"><span class="fa fa-caret-right"></span>${children.name}</a></li>
    							</c:if>
	    					</c:forEach>
	    				</ul>
    				</dd>
    			</c:if>
    		</c:forEach>
    		</dl>
    		</div>
    		
    		
    		
