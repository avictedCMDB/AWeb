<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<jsp:include page="../../market/m/head.jsp">
	<jsp:param value="µÇÂ¼" name="title"/>
</jsp:include>
<style type="text/css">
body.login .wrapper .row:after{
	bottom: 0;
}
</style>
<body class="login">

    <div id="app">
        <div class="header">
            <i class="iconfont back" onclick="history.go(-1)">&#xe615;</i>
            <span>µÇÂ¼</span>
        </div>
        <div class="wrapper">
            <form action="${pageContext.request.contextPath}/passport/login/submit" enctype="application/x-www-form-urlencoded" method="post" id="f">
            	<div class="row">
	                <span>ÕËºÅ</span>
	                <input type="text" placeholder="ÓÊÏä/ÊÖ»úºÅÂë/ÓÃ»§Ãû" v-model="username" name="f_name"/>
	            </div>
	            <div class="row">
	                <span>ÃÜÂë</span>
	                <input type="password" placeholder="6-20Î»Êý×Ö¡¢×ÖÄ¸ºÍ·ûºÅ×éºÏ" v-model="password" name="f_pass">
	            </div>
            </form>
        </div>
        <p class="login" @click="login()">µÇÂ¼</p>
        <p class="op">
            <a href="" class="reg">Á¢¼´×¢²á</a>
            <a href="">Íü¼ÇÃÜÂë</a>
        </p>
    </div>

    <script type="text/javascript">
        var app = new Vue({
            el      : '#app',
            data    : {
                username    : '',
                password    : ''
            },
            methods : {
                login   : function () {
                    document.getElementById('f').submit();
                }
            }
        });
        if ('${error}') {
        	alert('${error}');
        }
    </script>
</body>
</html>