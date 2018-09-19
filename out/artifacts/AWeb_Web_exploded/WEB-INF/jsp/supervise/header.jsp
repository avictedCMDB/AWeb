<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="now" value="<%=new java.util.Date()%>" />
<div id="header_top">
    <div class="inner">
       <ul class="social-links clearfix">
        <li class="mem_login">欢迎来到企业管理中心！</li>
        <li class="mem_login gray">当前系统时间：<span><fmt:formatDate pattern="yyyy年MM月dd日" 
            value="${now}" /></span></li>
        <li class="special"><a href="${pageContext.request.contextPath}/">平台首页 </a><span>|</span></li>
        <li class="special"><a href="${pageContext.request.contextPath}/passport/login/logout">退出</a><span>|</span></li>
        
       </ul>
    <!--.inner--></div>
  <!--#header_top--></div>
  <div id="header">
    <div class="inner clearfix">
      <div class="logo">
        <img src="${pageContext.request.contextPath}/static/img/supervise/logo-supervise.png" alt="中航招标网" />
      </div>
      <div class="search">
        <img src="${pageContext.request.contextPath}/static/img/supplier/bnr-supplier.jpg" />
      </div>
    <!--.inner--></div>
  <!--#header--></div>