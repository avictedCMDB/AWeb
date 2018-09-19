<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>֧��ʧ��|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/payment.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
</head>

<body>
<div class="page-wrapper">
  <div id="header_top">
    <div class="inner">
       <ul class="social-links clearfix">
        <li><a href="javascript:void(0);"><span class="fa fa-user"></span>${sessionScope.login_user.userNameCN}</a><span>|</span></li>
        <li><a href="${pageContext.request.contextPath}/management/finance/index">�ɹ���������</a><span>|</span></li>
        <li><a href="${pageContext.request.contextPath}">ƽ̨��ҳ </a><span>|</span></li>
        <li><a href="${pageContext.request.contextPath}/passport/login/logout">�˳�</a><span>|</span></li>
        <li><a href="#">�ͻ�����</a><span>|</span></li>
        <li><a href="#">��վ����</a><span>|</span></li>
       </ul>
    <!--.inner--></div>
  <!--#header_top--></div>
  <div id="header">
    <div class="inner clearfix">
      <div class="logo">
        <img src="${pageContext.request.contextPath}/static/img/management/logo-management.png" alt="�к��б���" />
      </div>
      <div class="search">
        <div class="input-group">
          <input type="text" class="form-control"><span class="input-group-btn"><button class="btn btn-default" type="button">����</button></span>
        </div>
      </div>
      <div class="buy">
        <button class="btn btn-default" type="button" onclick="window.location.href='${pageContext.request.contextPath}/market/cart/list';"><i class="fa fa-shopping-cart shopping"></i>�ҵĹ��ﳵ<i class="fa fa-angle-right arrow-right"></i></button></div>
    <!--.inner--></div>
  <!--#header--></div>
  
  <div id="contents">
    <div class="inner">
      <div id="payment_details">
        <p class="success">
          <span class="img"><img src="${pageContext.request.contextPath}/static/img/order/icon-fail.png" /></span>
          <span>${error}���뷵��֧���б�����</span>
        </p>
        <div class="section_details btn_list">
          <ul>
            <li><button type="button" class="btn btn-default red" onclick="window.location.href='${pageContext.request.contextPath}/management/finance/list?orderStatus=15'">����֧���б�</button></li>
          </ul>
        </div>
        
        
        
        
      <!--.order_details--></div>
      
      
      
      <!--.inner--> 
    </div>
    <!--#contents--> 
  </div>
  <div id="footer">
    <div class="inner">
      <div class="section clearfix">
        <div class="tel"><img src="${pageContext.request.contextPath}/static/img/img-tel.png" alt="" /></div>
        <div class="customer_service clearfix">
          <dl>
            <dt class="icon_shopping">����ָ��</dt>
            <dd>
              <ul>
                <li><a href="#">���Ͼ��۲ɹ�</a></li>
                <li><a href="#">����ֱ�Ӳɹ�</a></li>
                <li><a href="#">֧������</a></li>
              </ul>
            </dd>
          </dl>
          <dl>
            <dt class="icon-delivery">���Ͱ���</dt>
            <dd>
              <ul>
                <li><a href="#">���ͽ��Ȳ�ѯ</a></li>
                <li><a href="#">���ͷ�Χ���˷�</a></li>
              </ul>
            </dd>
          </dl>
          <dl>
            <dt class="icon-other">��������</dt>
            <dd>
              <ul>
                <li><a href="#">��ͼ����</a></li>
                <li><a href="#">�ͻ�����</a></li>
                <li><a href="#">��������</a></li>
              </ul>
            </dd>
          </dl>
        </div>
      </div>
    </div>
    <!--#footer--> 
  </div>
  <div id="copy_right">
    <div class="inner">
      <p>��Ȩ��Ϣ����ʾ��Ȩ��Ϣ��������</p>
    </div>
  </div>
  <!--.page-wrapper--> 
</div>
</body>
</html>