<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
 <head>
  <title></title>
 </head>

 <body>
 <script type="text/javascript">

 var result = "${result}";
 var fail = "${fail}";
 var url = "${url}";
 var data = "";
 <c:if test="${data != null and data != ''}">
 data = ${data};
 </c:if>

 if (parent._uploadCallback) {
	parent._uploadCallback(result, url, fail, data);
 }
 
 </script>
 </body>
</html>
