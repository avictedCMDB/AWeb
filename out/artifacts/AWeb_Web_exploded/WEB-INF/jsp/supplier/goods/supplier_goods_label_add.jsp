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
<title>��Ӧ�̹�������|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_goods_label.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
</head>

<body>
<div class="return_pro inner">
  <h2>���ӱ�ǩ</h2>
  <div class="add_details">
    <dl class="dl-horizontal clearfix">
      <dt>��ǩ���ƣ�</dt>
      <dd><input type="text" class="form-control"></dd>
    </dl>
    
    <dl class="dl-horizontal">
      <dt>������Ʒ��š���Ʒ����������Ʒ��</dt>
      <dd>
        <div class="input-group">
          <input type="text" class="form-control">
          <span class="input-group-btn">
            <button class="btn btn-default red" type="button">
            ����
            </button>
          </span>
        </div>
      </dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>��Ʒ���ƣ�</dt>
      <dd>
        <select class="form-control">
         <option>ȫ����Ʒ</option>
         <option>ȫ����Ʒ</option>
        </select>
      </dd>
    </dl>
    <div class="btn_area">
    <ul>
      <li><button type="button" class="btn btn-default red">����</button></li>
      <li><button type="button" class="btn btn-default red">���沢����</button></li>
      <li><button type="button" class="btn btn-default gray">����</button></li>
    </ul>
  </div>
  </div>

</div>
</body>
</html>
