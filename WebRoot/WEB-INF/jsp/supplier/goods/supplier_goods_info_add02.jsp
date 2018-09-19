<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="/WEB-INF/tlds/tag.tld" prefix="mc"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>��ҳ|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/supplier_goods_info.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierInfo.js"></script>
<!-- ͼƬ�ϴ� -->
<link href="${pageContext.request.contextPath}/static/css/imgbox.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/imgUpload.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.imgbox.pack.js"></script>
<!-- END -->
<script type="text/javascript">
<c:if test="${supplierGoodsValue.imagePath != ''}">
$(document).ready(function(){
		$("#updateImg").imgbox();

	});
</c:if>
</script>
<base target="_self"/>
</head>

<body>
<div id="goods_info">
  <div class="inner">
    <div class="add_title clearfix">�޸���Ʒ</div>
    <div class="main_inner">
      <div class="up_area">
      <div class="form-horizontal">
      <!-- 	<form id="supplierGoodsInfoUpdateForm" method="post" enctype="multipart/form-data" class="form-horizontal"> -->
      	<input type="hidden" value="${supplierGoodsValue.supGoodsId}" name="supGoodsId" id="supGoodsId"/>
          <div class="form-group">
            <label for="name" class="control-label">��Ʒ����:</label>
            <input type="text" class="form-control detail" id="goodsName" name="goodsName" value="${supplierGoodsValue.goodsName}"/>
          </div>
          <div class="form-group">
            <label for="name" class="control-label">��Ʒ����:</label>
            <textarea class="form-control detail" name="goodsDesc" id="goodsDesc">${supplierGoodsValue.goodsDesc}</textarea>
          </div>
          <div class="form-group">
            <label for="name" class="control-label">��Ʒ����:</label>
            <textarea  class="form-control detail" name="goodsParam" id="goodsParam">${supplierGoodsValue.goodsParam}</textarea>
          </div>
          <div class="form-group">
             <label for="name" class="control-label">ͼƬ��ַ:</label>
             <input id="imgPath" type="hidden" value="${pageContext.request.contextPath}"/>
            <!--<input id="lefile" type="file" style="display:none"/>
              <div class="input-append"> 
                <input id="photoCover" class="input-large form-control" type="text" style="height:30px;"/> 
                <a class="btn btn-default red" onclick="$('input[id=lefile]').click();">����ļ�</a>
                <button type="button" class="btn btn-default red" >����</button>
              </div>
              <script type="text/javascript"> 
                $('input[id=lefile]').change(function() { 
                  $('#photoCover').val($(this).val()); 
                });
              </script>
              <div class="up_img_list">
                <ul class="clearfix">
                  <li><img src="${supplierGoodsValue.imagePath}" width="44px" height="44px" id="updateImg"/><a href="#"><img src="${pageContext.request.contextPath}/static/img/icon-close_blue.png" /></a></li>
                </ul>
              </div> -->
              <mc:ImgUploadTag mark='sup'></mc:ImgUploadTag>
              <c:if test="${supplierGoodsValue.imagePath != null}">
	                <a id="updateImg" href="${supplierGoodsValue.imagePath}" style="padding-left:130px;"><img src="${supplierGoodsValue.imagePath}" width="80px" height="80px"/></a>
	          </c:if>
          </div>
          <div class="form-group">
            <label for="name" class="control-label">Ʒ��:</label>
            <input type="text" class="form-control detail" name="brandName" id="brandName" value="${supplierGoodsValue.brandName}"/>
          </div>
          <div class="form-group">
            <label for="name" class="control-label">�ͺ�:</label>
            <input type="text" class="form-control detail" name="goodsModel" id="goodsModel" value="${supplierGoodsValue.goodsModel}"/>
          </div>
          <div class="form-group">
            <label for="name" class="control-label">����:</label>
            <input type="text" class="form-control detail" name="goodsWeight" id="goodsWeight" value="${supplierGoodsValue.goodsWeight}"/>
          </div>
          <div class="form-group">
            <label for="name" class="control-label">��Ʒ�ۼ�:</label>
            <input type="text" class="form-control detail" name="salePrice" id="salePrice" value="${supplierGoodsValue.salePrice}"/>
          </div>
          <div class="form-group">
            <label for="name" class="control-label">����:</label>
            <input type="text" class="form-control detail" name="productArea" id="productArea" value="${supplierGoodsValue.productArea}"/>
          </div>
          <div class="form-group">
            <label for="name" class="control-label">���۵�λ:</label>
            <input type="text" class="form-control detail" name="goodsUnit" id="goodsUnit" value="${supplierGoodsValue.goodsUnit}"/>
          </div>
          <div class="form-group">
            <label for="name" class="control-label">�ۺ����:</label>
            <input type="text" class="form-control detail" name="goodsService" id="goodsService" value="${supplierGoodsValue.goodsService}"/>
          </div>
          <div class="form-group">
            <label for="name" class="control-label">����:</label>
            <input type="text" class="form-control detail" name="goodsCode" id="goodsCode" value="${supplierGoodsValue.goodsCode}"/>
          </div>
        <div class="btn_list">
          <ul class="clearfix">
            <li><button  type="button" class="btn btn-default blue" onclick="updateGoods('${pageContext.request.contextPath}/supplier/goodsInfo/updateGoods')">ȷ��</button></li>
            <li><button  type="button" class="btn btn-default gray" onclick="window.close();">ȡ��</button></li>
          </ul>
        </div>
        </div>
     <!--   </form>-->
        </div>
    </div>
  </div>
</div>

</body>
</html>