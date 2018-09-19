<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<title>${param.title}|中航采购网</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/encodeurigbk.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript">
var loading = false;

var async = function (url, param, callback, failed, skipCheck) {
	if (!skipCheck) {
		if (loading) return;
		loading = true;
	}
	$.ajax({
		url:url,
		type:"POST",
		data:param,
		dataType:"json",
		success:function (msg) {
			if (!skipCheck) {
			loading = false;
			}
			if (msg.hasOwnProperty('status')) {
				if (msg.status === 0) {
					if (callback) {
						callback(msg);
					}
				} else if (msg.status === -100) {
					window.location.href = '${pageContext.request.contextPath}/passport/login';
				} else if (msg.status === -200) {
					alert("您没有使用此功能的权限");
					return;
				} else {
					if (failed) {
						failed(msg);
					} else {
						alert(msg.result);
					}
				}
			} else {
				this.error();
			}
		},
		error:function () {
			if (!skipCheck) {
			loading = false;
			}
			alert("操作失败，请重试");
		}
	});
}

var paging = function (obj, pages, page, callback) {
	$(obj).empty();
	if (pages > 0) {
		var mli = function (html, p) {
			var li = $("<li>");
			if (html == page) {
				li.addClass("active");
			}

			var link = $("<a>");
			link.attr("href", "javascript:;");
			link.html(html);
			link.attr("data-page", p);
			link.click(callback);
			li.append(link);
			
			return li;
		}
		
		var ul = $("<ul>");
		ul.addClass("pagination");
		if (page > 1) {
			// <li><a href="${pageContext.request.contextPath}/${fn:escapeXml(fn:replace(pageAction, '%PAGE%', page - 1))}">&laquo;</a></li>
			
			ul.append(mli("&laquo;", page - 1));
		}
		
		var min = page - 3;
		var max = page + 3;
		if (min < 1) {
			min = 1;
		}
		if (max > pages) {
			max = pages;
		}
		
		if (min > 1) {
			ul.append(mli("1", 1));
		}
		
		if (min > 2) {
			ul.append("<li>...</li>");
		}
		
		for (var i = min; i <= max; i++) {
			ul.append(mli(i, i));
		}
		
		if (max < pages - 1) {
			ul.append("<li>...</li>");
		}
		
		if (max < pages) {
			ul.append(mli(pages, pages));
		}
		
		if (page < pages) {
			ul.append(mli("&raquo;", page - 0 + 1));
		}
		
		$(obj).append(ul);
	}
}
</script>