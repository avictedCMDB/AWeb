<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
  <div id="header_top">
    <div class="inner">
       <ul class="social-links clearfix">
        <li class="first"><a href="#"><span class="fa fa-user"></span>${sessionScope.supUsernamecn}</a><span>|</span></li>
        <li><a href="${pageContext.request.contextPath}/supplier/index">�������� </a><span>|</span></li>
        <li><a href="${pageContext.request.contextPath}/passport/login/logout">�˳�</a><span>|</span></li>
        <li><a href="#">����</a><span>|</span></li>
       </ul>
    <!--.inner--></div>
  <!--#header_top--></div>
  <div id="header">
    <div class="inner clearfix">
      <div class="logo">
        <img src="${pageContext.request.contextPath}/static/img/supplier/logo_supplier.png" alt="�к��б���" />
      </div>
      <div class="search">
        <img src="${pageContext.request.contextPath}/static/img/supplier/bnr-supplier.jpg" />
      </div>
    <!--.inner--></div>
  <!--#header--></div>