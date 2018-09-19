<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="/WEB-INF/tlds/tag.tld" prefix="mc"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<html>
<jsp:include page="../head.jsp">
	<jsp:param value="��Ʒ���󷢲�" name="title"/>
</jsp:include>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/imgUpload.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.imgbox.pack.js"></script>
<style type="text/css">
body.pub-req .req-info .sup-list:before{
	content: 'ѡ��Ӧ��';
}
.sup-name .item{
    display: inline-block;
    padding: 10px 5px;
}
.sup-name{
    padding: 5px 0;
}
.sup-name .item a{
    background-color: #fff;
    font-size: 14px;
    padding: 5px 10px;
    position: relative;
    border: 1px solid #eee;
}
.sup-name .item a span.delete:after{
    font-family: iconfont;
    position: absolute;
    content: '\e633';
    background-color: #067cca;
    color: #fff;
    width: 16px;
    height: 16px;
    text-align: center;
    font-size: 12px;
    line-height: 16px;
    border-radius: 8px;
    right: -8px;
    top: -8px;
}
#imgbox-loading, #imgbox-overlay, #fileUploadForm{
	display: none!important;
}
</style>
<body class="pub-req">

    <div id="app">
        <div class="header">
            <i class="iconfont back" onclick="location.href = '${pageContext.request.contextPath}/market/goods/prof/index';">&#xe615;</i>
            <span>������Ʒ����</span>
        </div>
        <div class="req-info margin-top-10">
            <textarea rows="3" id="goods_desc_new" placeholder="��Ʒ����"></textarea>
            <div class="line"></div>
            <p class="desc">��Ʒͼֽ <span>֧�ֵ�ͼƬ��ʽΪjpg/jpge/png/gif/pdf ����ͼƬ��С��2M</span></p>
            <div class="atta">
                <div>
                    <img src="${pageContext.request.contextPath}/static/image/add_pic.jpg" id="addPic"/>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="sup-list">
                <div class="sup">
					<c:if test="${isShowBtn1 == 1}">
                    	<a data-type="1">������Ӧ��</a>
                    </c:if>
                    <a data-type="2">ƽ̨������Ӧ��</a>
                </div>
            </div>
            <div class="sup-name">
            </div>
        </div>
        <div class="op-button">
            <a class="cancel" onclick="history.go(-1);">ȡ��</a>
            <a class="submit" onclick="doSave('${pageContext.request.contextPath}');">�ύ</a>
        </div>
    </div>
<input type="hidden" id="sup_id" name="sup_id" value=""/>
<input type="hidden" id="new_sup_id" name="new_sup_id" value=""/>
<mc:ImgUploadTag mark='ask'></mc:ImgUploadTag>

<iframe src="" style="position: fixed; top: 0; width: 100%; left: 0; bottom: 0; height: 100%; z-index: 999; display: none;" id="i"></iframe>
<script type="text/javascript">
$(function () {
	$(document).on('click', '.sup-name .item .delete', function () {
		$('.sup-name .item[data-id="' + $(this).attr('data-id') + '"]').remove();
	});
	$('.sup a').click(function () {
		$('#i').attr('src', '${pageContext.request.contextPath}/management/specialGoods/supSelect?o=' + $(this).attr('data-type'))
		$('#i').show();
	});
	$('#addPic').click(function () {
		$('input[id=file]').click();
	});
	$('.btn.btn-default.red[type=text]');
	$('input[id=file]').change(function () {
		$('#uploadButton').click();
	});
	$(document).on('DOMNodeInserted', '#imgUl', function () {
		$('.atta .item').remove();
		$(this).find('a.preview').each(function (i) {
			$('.atta').prepend($('<div class="item" onclick="" id="img_' + (i+1) + '"><img src="' + $(this).attr('href') + '"/><span '
					+'class="delete" onclick="" data-delete-index="' + (i+1) + '"></span></div>'));
		});
	});
	$(document).on('click', 'span[data-delete-index]', function () {
		var imgSort = $(this).attr('data-delete-index');
		$('#imgli_'+imgSort).remove();
		$('#img_' + imgSort).remove();
		var realCount = Number($("#realCount").val());
		if(realCount>0){
			realCount = realCount-1;
			$("#realCount").val(realCount);
		}
		$('#imgUl').toggle('DOMNodeInserted');
	});
});
function close(ls) {
	$('#i').hide();
	$('.sup-name').empty();
	for (var i = 0; i < ls.length; i++) {
		var l = ls[i];
		$('.sup-name').append('<div class="item" onclick="" data-id="' + l['id'] + '"><a> <span class="delete" data-id="' + l['id'] + '"></span>' + l['name'] + '</a></div>');
	}	
	
}
function doSave(path){
	var goods_desc_new = $('#goods_desc_new').val();
	if(goods_desc_new == null || goods_desc_new == ''){
		alert('��������Ʒ����');
		$('#goods_desc_new').focus();
		return;
	}
	var ss = [];
	$('.sup-name .item').each(function () {
		ss.push($(this).attr('data-id'));
	});
	var supIds = ss.join(',');
	if(supIds == null || supIds == ''){
		alert('��ѡ��Ӧ��');
		return;
	}
	
	var imgArray = new Array();
	var imgObj = $('input:hidden[name=hidden_path]');
	imgObj.each(function(i){
		imgArray.push(imgObj[i].value);
	});
	var imgPaths = imgArray.join(",");
	$.ajax({
	    url: path+"/management/specialGoods/doSave?goods_desc_new="+encodeURI(encodeURI(goods_desc_new))
	    	+"&sup_id="+supIds+"&imgCount="+$('#realCount').val()+"&imgPaths="+imgPaths,
	    type: "POST",
	    contentType : 'application/json;charset=gbk',
	    dataType:"json",
	    success: function(data){
	    	if(data.result=='ok'){
	    		window.location.href=path+"/management/specialGoods/offStandardRequirePage";
	    	}else{
	    		alert('����ʧ�ܣ�');
	    	}
	    },
	    error: function(res){
            alert('�������');
        }
	});
}
</script>
</body>
</body>