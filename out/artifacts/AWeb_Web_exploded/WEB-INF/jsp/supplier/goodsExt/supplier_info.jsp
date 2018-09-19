<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>首页|中航招标网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/supplier_common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/supplier_info.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
</head>
<body>
<div class="page-wrapper">
<jsp:include page="../header.jsp" />
  <div id="contents">
    <div class="inner">
    	
    <jsp:include page="../menu.jsp">
    <jsp:param name="menu" value="infoExt" />
    </jsp:include>
      <div id="matter_section">
      	<h2>扩展信息维护</h2>
      	<div class="info_section">
      	<form id="supplerInfoExt" method="post">
            <div class="info_mian clearfix">
                <div class="left_box">
                    <div class="img">
                    <c:if test="${supplierInfoExt.supImage == null}">
                    	<img src="${pageContext.request.contextPath}/static/img/supplier/img-profession.jpg" width="90px" height="90px"/>
                    </c:if>
                    <c:if test="${supplierInfoExt.supImage != null}">
                    	<img src="${pageContext.request.contextPath}${supplierInfoExt.supImage}" width="90px" height="90px"/>
                    </c:if>
                        
                        <input type="hidden" name="supImage" id="supImage" value="${supplierInfoExt.supImage}"/>
                        <input type="hidden" name="rootPath" id="rootPath" value="${pageContext.request.contextPath}"/>
                    </div>
                    <div class="btn_up">
                      <input type="file" style="display:none" name="uploadFile" id="uploadFile"/>
                      <script type="text/javascript">
	                  <c:if test="${ok == '1'}">
	                  alert("保存成功！");
	                  </c:if>
	                  <c:if test="${ok == '2'}">
	                  alert("图片上传成功！");
	                  </c:if>
							$('input[id=uploadFile]').change(function() {
								if ($("#uploadFile").val() == '') {
									return;
								}
								$('#supplerInfoExt').attr('enctype', 'multipart/form-data'); 
								document.getElementById("supplerInfoExt").action=$('#rootPath').val()+"/supplier/goodsInfoExt/uploadPrcture";
								document.getElementById("supplerInfoExt").submit();
							});
							function save(){
								document.getElementById("supplerInfoExt").action=$('#rootPath').val()+"/supplier/goodsInfoExt/saveInfoExt";
								document.getElementById("supplerInfoExt").submit();
							}
					  </script>
                      <div class="input-append">
                          <a class="btn btn-default gray" onclick="$('input[id=uploadFile]').click();">上传图标</a>
                      </div>
                    </div>
                </div>
                <div class="right_box">
                    <dl class="clearfix">
                        <dt>经营品类</dt>
                        <dd><input type="text" class="form-control" name="busiType" value="${supplierInfoExt.busiType}"/></dd>
                    </dl>
                    <dl class="clearfix">
                        <dt>经营品牌</dt>
                        <dd><input type="text" class="form-control" name="busiRange" value="${supplierInfoExt.busiRange}"/></dd>
                    </dl>
                </div>
            </div>
            <div class="btn_list">
                <button type="button" class="btn btn-default blue" onclick="save()">保存</button>
            </div>
            </form>
        </div>
      	
      	
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
 <jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>