<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="/WEB-INF/tlds/tag.tld" prefix="mc"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<html>
<jsp:include page="../head.jsp">
	<jsp:param value="选择供应商" name="title"/>
</jsp:include>
<style type="text/css">
body.select-sup .search input{
	padding: 9px 10px;
}
#sup_name{
	width: 100%;
    height: 34px;
    border: 1px solid #eee;
    border-radius: 3px;
}
.op-button {
    display: flex;
    height: 46px;
    position: fixed;
    width: 100%;
    bottom: 0;
    line-height: 46px;
    z-index: 5;
}
.op-button a {
    flex: 1;
    text-align: center;
    color: #fff;
}
.op-button a.cancel {
    background-color: #aaa;
}
.op-button a.submit {
    background-color: #067cca;
}
</style>
<body class="select-sup">
    <div id="app">
        <div class="header">
            <i class="iconfont back" onclick="top.close([]);">&#xe615;</i>
            <span>供应商选择</span>
        </div>
        <div class="search margin-top-10">
            <form action="" id="f" onsubmit="return false;">
            	<input type="search" value="${sup_name}" id="sup_name"/>
            </form>
        </div>
        <div class="sup-list margin-top-10">
            
        </div>
        
        <div style="opacity: 0; width: 100%; height: 46px;"></div>
    </div>
	<div class="op-button">
		<a class="cancel" onclick="top.close([]);">取消</a>
		<a class="submit" onclick="">完成</a>
	</div>
  <input type="hidden" id="sup_type" name="sup_type" value="${sup_type}">
<script type="text/javascript">
$(function () {
	doInit();
	$('#f').on('submit', function () {
		doInit();
	});
	$('.sup-list').click(function (e) {
		var target = $(e.target);
		var s = target.hasClass('sup') ? target.find('.checkbox') : target.parents('.sup').find('.checkbox');
		if (s.hasClass('checked')) {
			s.removeClass('checked');
		} else {
			s.addClass('checked');
		}
	});
	$('.submit').click(function () {
		var ls = [];
		$('.checkbox.checked').each(function () {
			ls.push({
				id	: $(this).attr('data-id'),
				name: $(this).attr('data-name')
			});
		});
		top.close(ls);
	});
});

function doInit(){
	var sup_type = $('#sup_type').val();
	var sup_name = $('#sup_name').val();
	var url= "${pageContext.request.contextPath}/management/specialGoods/supSelectData?o="+sup_type+"&sup_name="+sup_name;

	$.ajax({
	    url: url,
	    type: "POST",
	    contentType : 'application/json;charset=gbk',
	    dataType:"json",
	    success: function(data){
    		$('.sup-list').empty();
	    	if (data && data.length != 0) {
	    		for (var i = 0; i < data.length; i++) {
	    			$('.sup-list').append('<p class="sup"><i class="checkbox" data-id="' + data[i]['sup_id'] + '" data-name="' + data[i]['sup_name'] + '"></i>' + data[i]['sup_name'] + '</p>');
	    		}
	    	}
			
	    },
	    error: function(res){
            alert('网络错误，请稍后再试！');
        }
	});
}
</script>
</body>
</html>