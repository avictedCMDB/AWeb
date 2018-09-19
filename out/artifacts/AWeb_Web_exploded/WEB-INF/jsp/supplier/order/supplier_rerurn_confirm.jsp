<%@ page language="java" contentType="text/html; charset=gbk"	pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>��Ӧ�̹�������|�к��ɹ���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_return.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierUtil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierOrderReturn.js"></script>
</head>

<body>
<div class="return_pro inner">
  <h2>ȷ���˻���</h2>
  <div class="main_list search_result">
    <div class="inner_main">
      <h3>�˻���Ʒ��ϸ</h3>
      <table class="details">
        <tr>
          <th width="40">���</th>
          <th colspan="2">��Ʒ��Ϣ</th>
          <th width="70">����(Ԫ)</th>
          <th width="70">�˻�����</th>
          <th width="70">�ܽ��(Ԫ)</th>
          <th width="120">�˻�ԭ��</th>
        </tr>
        <c:forEach var="supplierReturn" items="${supplierReturnList}" varStatus="status">
          <tr>
	          <td>${supplierReturn.rn}</td>
	          <td width="77" class="right_none"><p class="img_pro"><a href="#"><img src="${supplierReturn.imagePath}" width="44px" height="44px"/></a></p></td>
	          <td class="left_none"><a href="#">${supplierReturn.goodsName}</a></td>
	          <td class="price"><fmt:formatNumber value="${supplierReturn.agreePrice}" pattern="#0.00#"/></td>
	          <td>${supplierReturn.refoundNum}</td>
	          <td class="price"><fmt:formatNumber value="${supplierReturn.sumRefoundPrice}" pattern="#0.00#"/></td>
	          <td>${supplierReturn.refoundReason}</td>
          </tr>
        </c:forEach>
      </table>
      <h3>�����Ϣ</h3>
      <dl class="dl-horizontal">
        <dt>��˽����</dt>
        <dd>
          <label class="checkbox-inline">
            <input type="radio" name="optionsRadiosinline" id="optionsRadios3" value="1" checked/>ͬ��
          </label>
          <label class="checkbox-inline">
            <input type="radio" name="optionsRadiosinline" id="optionsRadios4" value="2"/>��ͬ��
          </label>
        </dd>
      </dl>
      <dl class="dl-horizontal">
        <dt>��������</dt>
        <dd>
          <textarea class="form-control" name="supCheckInfo" id="supCheckInfo"></textarea>
        </dd>
      </dl>
      <h3>�ջ���ַ</h3>
      <dl class="dl-horizontal">
        <dt>Ĭ�ϵ�ַ��</dt>
        <dd>
          <div class="radio">
            <c:forEach var="supplierAddress" items="${supplierAddressList}" varStatus="status">
          	<div class="radio">
	            <label>
	              <input type="radio" name="optionsRadios" id="optionsRadios2" value="${supplierAddress.supAddressId}" <c:if test="${supplierAddress.ifDefault == '1'}"> checked </c:if>/>
	              ${supplierAddress.supName} ${supplierAddress.supAreaLevelOne} ${supplierAddress.supAreaLevelTwo} ${supplierAddress.supAreaLevelThree} ${supplierAddress.supAddressDetail} ${supplierAddress.supTel} 
	            </label>
          	</div>
          </c:forEach>
          </div>
          <input type="hidden" id="addressPath" value="${pageContext.request.contextPath}/supplier/address/insertPage"/>
        </dd>
      </dl>
    </div>
  </div>

  <div class="btn_area">
    <ul>
      <li><button type="button" class="btn btn-default red" onclick="updateReturnStatus('${pageContext.request.contextPath}/supplier/return/returnConfirm','${refoundId}')">�ύ</button></li>
      <li><button type="button" class="btn btn-default gray" onclick="window.close()">ȡ��</button></li>
    </ul>
  </div>
</div>
</body>
</html>