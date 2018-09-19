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
<link href="${pageContext.request.contextPath}/static/css/supplier_address.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierAddress.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierUtil.js"></script>
</head>

<body>
<div class="return_pro inner">
	<c:if test="${processType == 'insert'}">
		<h2>�����ջ���ַ</h2>
	</c:if>
  	<c:if test="${processType == 'update'}">
		<h2>�޸��ջ���ַ</h2>
	</c:if>
<form id="supplierAddressForm"  method="post">
  <input type="hidden" value="${supplierAddress.supAddressId}" name ="supAddressId"/>
  <div class="add_details">
    <dl class="dl-horizontal clearfix">
      <dt><span class="red_remind">*</span>�ջ���������</dt>
      <dd><input type="text" class="form-control" value="${supplierAddress.supName}" name="supName" id="supName"/></dd>
    </dl>
    <dl class="dl-horizontal clearfix">
      <dt><span class="red_remind">*</span>���ڵ�����</dt>
      <dd>
        <select class="form-control" name="supAreaLevelOne" id="area" onchange="queryAreaSub('${pageContext.request.contextPath}/supplier/address/loadSubArea')">
                  <option value="">��ѡ��</option>
                  <c:forEach var="areas" items="${areasList}" varStatus="status">
				      <option value="${areas.supAreaID}" <c:if test="${areas.supAreaID == supplierAddress.supAreaLevelOne}"> selected="selected" </c:if> >${areas.supAreaName}</option>
				  </c:forEach>
        </select>
        <select class="form-control" name="supAreaLevelTwo" id="areaSub" onchange="queryAreaSubTo('${pageContext.request.contextPath}/supplier/address/loadSubArea')">
        	<c:if test="${processType == 'update'}">
        		<c:forEach var="areas" items="${areasSubList}" varStatus="status">
				      <option value="${areas.supAreaID}" <c:if test="${areas.supAreaID == supplierAddress.supAreaLevelThree}"> selected="selected" </c:if>>${areas.supAreaName}</option>
				  </c:forEach>
			</c:if>
        </select>
        <select class="form-control" name="supAreaLevelThree" id="areaLast" onchange="queryStoreNum('${pageContext.request.contextPath}/supplier/address/queryStoreNumber')">
        	<c:if test="${processType == 'update'}">
        		<c:forEach var="areas" items="${areasLastList}" varStatus="status">
				      <option value="${areas.supAreaID}" <c:if test="${areas.supAreaID == supplierAddress.supAreaLevelThree}"> selected="selected" </c:if>>${areas.supAreaName}</option>
				</c:forEach>
			</c:if>
        </select>
      </dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>��ϸ��ַ��</dt>
      <dd><input type="text" class="form-control" value="${supplierAddress.supAddressDetail}" name="supAddressDetail" id="supAddressDetail"></dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>��ϵ�绰��</dt>
      <dd><input type="text" class="form-control" value="${supplierAddress.supTel}" name="supTel" id="supTel"></dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>�ֻ����룺</dt>
      <dd><input type="text" class="form-control" value="${supplierAddress.supIphone}" name="supIphone" id="supIphone"></dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>�Ƿ�Ĭ�ϵ�ַ��</dt>
      <dd>
        <select class="form-control" name="ifDefault" id="ifDefault">
         <option value="0" <c:if test="${supplierAddress.ifDefault == '0'}"> selected="selected" </c:if>>��</option>
         <option value="1" <c:if test="${supplierAddress.ifDefault == '1'}"> selected="selected" </c:if>>��</option>
        </select>
      </dd>
    </dl>
    <div class="btn_area">
    <ul>
    	<c:if test="${processType == 'insert'}">
			<li><button type="button" class="btn btn-default red" onclick="saveAddress('${pageContext.request.contextPath}/supplier/address/insert')">����</button></li>
		</c:if>
	  	<c:if test="${processType == 'update'}">
			<li><button type="button" class="btn btn-default red" onclick="saveAddress('${pageContext.request.contextPath}/supplier/address/update')">����</button></li>
		</c:if>
      <li><button type="button" class="btn btn-default gray" onclick="history.go(-1)">ȡ��</button></li>
    </ul>
  </div>
  </div>
</form>
</div>
</body>
</html>