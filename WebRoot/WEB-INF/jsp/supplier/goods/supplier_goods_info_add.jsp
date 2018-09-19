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
<base target="_self"/>
</head>
<script type="text/javascript">
<c:if test="${ok == '1'}">
	alert("�ϴ����ļ�Ϊ���ļ��������ʺ������ϴ���");
</c:if>
<c:if test="${ok == '2'}">
alert("�ϴ����ļ�����ʧ�ܣ���ʹ��ָ����ģ���ļ���");
</c:if>
<c:if test="${ok == '3'}">
alert("�ϴ��ɹ���");
window.opener.reloadWindows(null);
</c:if>
window.name = "curWindow";
</script>
<body>
<div id="goods_info">
<form id="supplierGoodsInfoQueryForm" method="post" target="curWindow">
  <div class="inner">
    <div class="add_title clearfix">������Ʒ</div>
    <div class="main_inner">
      <div class="up_area">
        <input type="file" class="form-control" name="uploadFile" id="uploadFile" accept=".xls,.xlsx" value="" style="display:none"/>
          <div class="input-append"> 
            <input id="photoCover" class="input-large form-control" type="text" style="height:30px;"/> 
            <a class="btn btn-default red" onclick="$('input[id=uploadFile]').click();">����ļ�</a>
            <button type="button" class="btn btn-default red" id="uploadButton" onclick="uploadFiles('${pageContext.request.contextPath}/supplier/goodsInfo/uploadFiles')">����</button>
          </div>
          <script type="text/javascript"> 
            $('input[id=uploadFile]').change(function() { 
              $('#photoCover').val($(this).val()); 
              window.returnValue = "reload";
            });
          </script>
        </div>
        <p class="download_link">
        	<i class="fa fa-download">
        	</i>
        		<a href="${pageContext.request.contextPath}/supplier/goodsInfo/download?type=1" target="blank">���߹�װ����ģ������</a> &nbsp;
        		<i class="fa fa-download"></i> <a href="${pageContext.request.contextPath}/supplier/goodsInfo/download?type=3" target="blank">��������ģ������</a>
        	</p>
        <div class="list_area">
          <h2>������Ʒ����</h2>
          <p>
          	<c:if test="${ok != null}">
	          	������������${count} �ɹ�������${sussCount}  ʧ��������${errCount}<br/> 
	          	<c:if test="${errMsg != ''}">
	          		����������${errMsg}
	          	</c:if>
          	</c:if>
          </p>
        </div>
    </div>
  </div>
  </form>
</div>
</body>
</html>