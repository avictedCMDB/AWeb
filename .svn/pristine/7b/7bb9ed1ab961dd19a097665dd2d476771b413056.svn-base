<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<!-- <script type="text/javascript">
var ele;
	function clickMenu(m){
		debugger;
		if(ele!=null){
			ele.removeClass("active");
		}
		ele = $(m);
		$(m).addClass("active");
		
	}
</script> -->
<title>中航招标网</title>
</head>
<body>
<div class="page-wrapper">
	<div id="side_navi">
   		<dl>
   			 <c:forEach  var="menu" items="${sessionScope.login_user.menus}" varStatus="status">
	   			<dt class="tlt_merchandise">${menu.name}<span class="fa fa-caret-square-o-down"></span></dt>
	   			<dd class="last_child">
	   				<ul>
	   				   <c:forEach  var="childMenu" items="${menu.childMenus}" varStatus="status">
	   				    	<li <c:if test="${sessionScope.menuParam == childMenu.menuID}">class="active"</c:if> onclick="clickMenu(this);"><a href="${pageContext.request.contextPath}${childMenu.href}?menuParam=${childMenu.menuID}"><span class="fa fa-caret-right"></span>${childMenu.name}</a></li>
	   				    </c:forEach>
	   				</ul>
	   			</dd>
   			</c:forEach>
   		</dl>
   		<!--#side_navi-->
   	</div>
</div><!--.page-wrapper-->
</body>
</html>