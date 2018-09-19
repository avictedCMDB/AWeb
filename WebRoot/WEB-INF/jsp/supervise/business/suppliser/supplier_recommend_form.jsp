<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>首页|中航招标网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/supervise_recommend.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierRecommend.js"></script>
</head>

<body>
<input id="path" type="hidden" value="${pageContext.request.contextPath}"/>
<div id="vat_info">
  <div class="inner">
    <div class="add_title clearfix">推荐时间<a href="#"><i class="fa fa-close"></i></a></div>
    <div class="main_inner">
      <div class="up_area clearfix">
      <form action="" method="post" id="supplierRecommendSubmitForm">
	    <!-- 供应商图片 -->
	    <input id="supImage" name="supImage" type="hidden" value="${supplierRecommend.supImage}"/>
	    <input id="supImageAfter" name="supImageAfter" type="hidden" value=""/>
	    <input id="supID" name="supID" type="hidden" value="${supplierRecommend.supID}"/>
        <dl class="clearfix date_list">
              <dt>推荐时间：</dt>
              <dd>
                <ul class="clearfix">
                  <li class="input_box">
                    <div class="input-group">
                      <input id="beginDate" name="beginDate" type="text" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${supplierRecommend.beginDate}"/>
                      <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                  </li>
                  <li>至</li>
                  <li class="input_box">
                    <div class="input-group">
                      <input id="endDate" name="endDate" type="text" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${supplierRecommend.endDate}"/>
                      <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                  </li>
                  
                </ul>
              </dd>
           </dl>
          </form>
            <dl>
	      	<dt>上传图片：</dt>
	      	<dd>
              <input id="lefile" name="file" type="file" style="display:none" onchange="ajaxFileUpload('lefile');"/>
              <div class="input-append"> 
                <!-- <input id="photoCover" class="input-large form-control" type="text" style="height:28px; width:370px;"/>  -->
                <a class="btn btn-default red" onclick="$('input[id=lefile]').click();" style="height:28px; line-height:28px; padding-top:0px;padding-bottom:0px; border:none;">浏览文件</a>
                <!-- <button type="button" class="btn btn-default blue" onclick="ajaxFileUpload('lefile');">开始上传</button> -->
              </div>
              <script type="text/javascript"> 
			    $('input[id=lefile]').change(function() { 
				  $('#photoCover').val($(this).val()); 
				});
		      </script>
              <p class="attention">只能上传jpg，大小为2mb的图片</p>
              <div class="img_list">
                  <p id="imgP" class="img">
                  <c:if test="${supplierRecommend.supImage != null && supplierRecommend.supImage != ''}">
                  	<img id="supPicImg" width='180' height='57' src="${pageContext.request.contextPath}${supplierRecommend.supImage}" />
                  </c:if>
                  <c:if test="${supplierRecommend.supImage == null || supplierRecommend.supImage == ''}">
                  	<img id="supPicImg" width='180' height='57' src="" />
                  </c:if>	
                  </p>
                  <p><a href="javascript:void(0);" onclick="delImage('supPicImg');"><img src="${pageContext.request.contextPath}/static/img/icon-close_blue.png" /></a></p>
              </div>
           </dd>
      	</dl>
        </div>
      <div class="btn_list">
          <button class="btn btn-default blue" onclick="setRecommend();">保存</button>
          <button class="btn btn-default blue" onclick="cancle();">返回</button>
      </div>
    </div>
    
  </div>
</div>


</body>
</html>