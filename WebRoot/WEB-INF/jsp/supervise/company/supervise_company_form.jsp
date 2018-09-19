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
<title>��ҳ|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/supervise_company.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/companyForm.js"></script>
</head>

<body>
<input type="hidden" id="path" value="${pageContext.request.contextPath}"/>
<div id="vat_info">
  <div class="inner">
    <div class="add_title clearfix">�ɹ���λ</div>
    <div class="main_inner">
      <div class="up_area clearfix">
        <dl class="clearfix first">
          <dt>�����ɹ���λ��</dt>
          <dd>
            <ul class="clearfix supplier">
	            <c:forEach  var="cooperateCompany" items="${cooperateCompanys}" varStatus="status">
	            	<li>${cooperateCompany.companyName}<a href="${pageContext.request.contextPath}/supervise/company/delCompany?companyMappingID=${cooperateCompany.companyMappingID}&supID=${company.supID}"><img src="${pageContext.request.contextPath}/static/img/icon-close_blue.png" /></a></li>
	            </c:forEach>
            </ul>
          </dd>
        </dl>
        <dl class="clearfix date_list">
          <dt>�ɹ���λ���ƣ�</dt>
          <dd>
            <ul class="clearfix company">
              <li><input class="form-control" type="text" id="companyName" name="companyName" value="${company.companyName}"/></li>
              <li class="btn_search"><button class="btn btn-default blue" onclick="searchCompany(${company.supID});">��ѯ</button></li>
            </ul>
          </dd>
        </dl>
        <table class="company_list">
            <tr>
                <th>�ɹ���λ</th>
                <th width="200">��ϵ�绰</th>
                <th width="130" class="last">����</th>
            </tr>
             <c:forEach  var="noCooperateCompany" items="${noCooperateCompanys}" varStatus="status">
	            <tr>
	                <td>${noCooperateCompany.companyName}</td>
	                <td>${noCooperateCompany.contactNum}</td>
	                <td class="last"><a href="${pageContext.request.contextPath}/supervise/company/addCompany?companyID=${noCooperateCompany.companyID}&supID=${company.supID}">����</a></td>
	            </tr>
            </c:forEach>
        </table>    
      </div>
      
    </div>
  </div>
 
</div>


</body>
</html>