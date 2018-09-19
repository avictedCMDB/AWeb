<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="商品同步" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/supervise_synchronization.css" rel="stylesheet">
<script type="text/javascript">
$(function () {

	$("#sync_btn").click(function () {
		var sup = $.trim($("#sup_id").val());
		var skus = $.trim($("#skus").val());
		if (sup == "") {
			alert("请选择供应商");
			return;
		}
		
		if (skus == "") {
			alert("请输入商品池和SKU");
			return;
		}

		$(".result_area ul").empty().append("<li>同步中....</li>");
		async('${pageContext.request.contextPath}/supervise/sync/submit', {
			sup:sup,
			skus:skus
		}, function (msg) {
			var data = msg.result;
			$(".result_area ul").empty();
			
			for (var i = 0; i < data.length; i ++) {
				$(".result_area ul").append("<li>商品（" + data[i].code + "），同步" + (data[i].result == "0" ? "成功" : ("失败，原因：" + data[i].msg)) + "</li>");
			}
		});
		
	});
	
});
</script>
<style>
#matter_section .search_area dl dt {width:85px}
span.attention {display:block; margin-top:5px;}
</style>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  <input type="hidden" id="order_id" value="${orderId}"/>
  <div id="contents">
    <div class="inner details">
      <jsp:include page="../left.jsp">
      	<jsp:param value="sync" name="menu"/>
      </jsp:include>	
      <div id="matter_section">
      	<h2>商品数据同步</h2>
      	<div class="search_area section">
          <div class="search_list clearfix">
            <dl class="clearfix first">
              <dt>商品池和SKU：</dt>
              <dd>
                <textarea class="form-control" rows="2" id="skus"></textarea><span class="attention">格式：池编号1|SKU1,池编号2|SKU2 ...</span>
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>供应商：</dt>
              <dd>
                <select class="form-control" id="sup_id">
                  	<option value="" selected="selected">请选择</option>
					<c:forEach var="item" varStatus="sta" items="${sups}">
					<c:if test="${item.supType == 0}">
					<option value="${item.supId}" >${item.supName }</option>
					</c:if>
					</c:forEach>
                </select>
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="button" id="sync_btn" class="btn btn-default red">同步</button></li>
            </ul>
          </div>
        <!--.search_area--></div>
      	<div class="search_result section">
          <p>同步结果：</p>
          <div class="result_area">
              <ul>
              </ul>
          </div>
        <!--.search_result--></div>
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>
