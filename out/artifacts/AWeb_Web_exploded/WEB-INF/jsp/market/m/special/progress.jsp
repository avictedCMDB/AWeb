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
body.req-progress .sup .s-info {
    position: relative;
    background-color: #fff;
    padding: 8px 120px 8px 40px;
    text-overflow: ellipsis;
    overflow: hidden;
    white-space: nowrap;
}
body.req-progress .sup .s-info .p {
    color: #666;
    position: absolute;
    right: 5px;
}
body.req-progress .sup .s-prod .p {
    position: absolute;
    right: 10px;
    top: 5px;
    font-size: 14px;
    color: #f00;
}
body.req-progress .sup .s-prod .c {
    position: absolute;
    right: 10px;
    bottom: 5px;
    font-size: 14px;
    color: #666;
}
body.req-progress .sup .s-prod {
    padding: 12px 80px 12px 40px;
    background-color: #f5f5f5;
    position: relative;
}
body.req-progress .sup .s-prod .n {
    overflow: hidden;
    word-break: break-all;
    -webkit-line-clamp: 1;
    line-clamp: 1;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    line-height: 20px;
}
</style>
<body class="req-progress">
<div id="app">
    <div class="header">
        <i class="iconfont back" onclick="history.go(-1);">&#xe615;</i>
        <span>进度管理</span>
    </div>
    	
	<c:forEach var="quote" items="${quotes}" varStatus="status">
		<div class="sup margin-top-10">
	        <p class="s-info">
	            <i class="checkbox check_sup"></i>
	           	${quote.supName}
	            <a class="p">合计:<span>￥${amounts.get(status.index)}</span></a>
	        </p>
             <c:forEach var="quoteDetail" items="${quote.quoteDetails}" varStatus="status">
		        <div class="s-prod">
		            <i class="checkbox check_prod" id="i_${quote.supID}" data-id="${quote.supID}" data-param="${quote.supID},${quoteDetail.goodsID},${quoteDetail.quoteNum},${quote.id}"></i>
		            <p class="n">${quoteDetail.goodsName}</p>
		            <a class="p">￥<fmt:formatNumber value="${quoteDetail.salePrice}" pattern="#0.00#"></fmt:formatNumber></a>
		            <a class="c">X${quoteDetail.quoteNum}</a>
		        </div>
	        </c:forEach>
	    </div>
	</c:forEach>
    <p class="addToCart">加入购物车</p>
</div>

<script type="text/javascript">
$(function () {
	$('.check_prod').click(function () {
		if ($(this).hasClass('checked')) {
			$(this).removeClass('checked');
		} else {
			$(this).addClass('checked');
		}
	});
	$('.check_sup').click(function () {
		console.log($(this).parent().find('.checkbox'));
		if ($(this).hasClass('checked')) {
			$(this).parent().parent().find('.checkbox').removeClass('checked');
		} else {
			$(this).parent().parent().find('.checkbox').addClass('checked');
		}
	});
	$('.addToCart').click(function () {
		var supGoodsParams = "";
		var cs = $('.check_prod.checked');
		cs.each(function (i) {
			if (i != 0) 
				supGoodsParams += "#";
			supGoodsParams += $(this).attr('data-param');
		});
		console.log(supGoodsParams);
		if (!supGoodsParams) {
			alert('请选择商品！');
			return;
		}
		if(confirm("确认添加？")){
			$.ajax({
			     type: 'POST',
			     url: path+"/management/specialGoods/addCart",
			     dataType: 'json',
			     data:{  
			    	 specialGoodsParams : supGoodsParams
			     },  
			     success: function(data) {  
			    	if(data.status =="success" ){  
			    		alert("添加成功！"); 
			    	}  
			     },
			     error : function() {  
			    	 alert("添加失败！");  
			     } 
			});
		}
	});
});    
</script>
</body>
</html>