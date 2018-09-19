<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>����|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/service.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management_invoice.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/services.js"></script>
</head>
<body>
<input id="path" type="hidden" value="${pageContext.request.contextPath}">
<input id="exchangeOrRefound" type="hidden" name="exchangeOrRefound" value="${service.exchangeOrRefound}"/>
<input id="typeID" name="typeID" value="${service.typeID}" type="hidden">
<div id="vat_info">
  <div class="inner">
    <div class="add_title clearfix">������Ϣ<a href="#"><i class="fa fa-close"></i></a></div>
    <div class="main_inner">
      <div class="up_area clearfix">
          <dl class="clearfix date_list">
              <dt>����ID��</dt>
              <dd>
                <input id="servicesID" name="servicesID" value="${service.servicesID}" type="text" class="form-control">
              </dd>
      	  </dl>
          <dl class="clearfix date_list">
              <dt>����״̬��</dt>
              <dd>
                <select class="form-control" id="serviceStatus" name="serviceStatus">
                    <option value="" <c:if test="${empty service.servicesStatus}">selected='selected'</c:if>>��ѡ��</option>
                    <option <c:if test="${service.servicesStatus=='10'}">selected='selected'</c:if> value="10">����׶�</option>
                    <option <c:if test="${service.servicesStatus=='20'}">selected='selected'</c:if> value="20">��˲�ͨ��</option>
                    <option <c:if test="${service.servicesStatus=='21'}">selected='selected'</c:if> value="21">�ͷ����</option>
                    <option <c:if test="${service.servicesStatus=='22'}">selected='selected'</c:if> value="22">�̼����</option>
                    <option <c:if test="${service.servicesStatus=='31'}">selected='selected'</c:if> value="31">�����ջ�</option>
                    <option <c:if test="${service.servicesStatus=='32'}">selected='selected'</c:if> value="32">�̼��ջ�</option>
                    <option <c:if test="${service.servicesStatus=='33'}">selected='selected'</c:if> value="33">��������</option>
                    <option <c:if test="${service.servicesStatus=='34'}">selected='selected'</c:if> value="34">�̼Ҵ���</option>
                    <option <c:if test="${service.servicesStatus=='40'}">selected='selected'</c:if> value="40">�û�ȷ��</option>
                    <option <c:if test="${service.servicesStatus=='50'}">selected='selected'</c:if> value="50">���</option>
                    <option <c:if test="${service.servicesStatus=='60'}">selected='selected'</c:if> value="60">ȡ��</option>
                </select>
              </dd>
      	  </dl>
            
      </div>
      <div class="btn_list">
          <button class="btn btn-default blue" onclick="search();">��ѯ</button>
      </div>
      <div class="result">
          <table class="company_list">
            <tr>
                <th>���񶩵�ID</th>
                <th width="100">��Ʒ����</th>
                <th width="100">��������</th>
                <th width="100">����״̬</th>
                <th width="100">��������ʱ��</th>
                <th width="70" class="last">����</th>
            </tr>
            <c:forEach var="s" items="${services}" varStatus="status">
            <tr>
                <td>${s.servicesID}</td>
                <td>${s.goodsName}</td>
                <td>${s.servicesType}</td>
                <td>${s.servicesStatus}</td>
                <td>${s.afsApplyTime}</td>
                
                 <c:choose>
                	<c:when test="${s.ifCancel==0}">
                	    <c:choose>
                	    	<c:when test="${service.exchangeOrRefound=='1'}">
                	    		<td class="last"><a href="javascript:void(0);" onclick="auditCancle('${s.servicesID}','${s.goodsPrice}','${s.goodsPriceInit}','${s.exchangeNum}','${s.supID}','${s.typeID}','${s.supGoodsID}','${orderID}');">ȡ��  </a></td>
                	    	</c:when>
                	    	<c:when test="${service.exchangeOrRefound=='2'}">
                	    		<td class="last"><a href="javascript:void(0);" onclick="auditCancle('${s.servicesID}','${s.goodsPrice}','${s.goodsPriceInit}','${s.refoundNum}','${s.supID}','${s.typeID}','${s.supGoodsID}','${s.orderID}');");">ȡ��</a></td>
                	    	</c:when>
                	    </c:choose>                		
                	</c:when>
                    <c:otherwise>
                             <td class="last"><a style="color:#ccc;" onclick="javascript:void(0);" href="#">ȡ��</a>
                    </c:otherwise>
                </c:choose>

            </tr>
            </c:forEach>
        </table>
         <jsp:include page="../page.jsp" />
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<!--.page-wrapper--></div>
</body>
</html>