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
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    	
    	<jsp:include page="../menu.jsp">
    	<jsp:param name="menu" value="return" />
    	</jsp:include>
      <div id="matter_section">
      	<h2>�˻�����</h2>
      	<div class="search_area section">
      	<form id="queryForm" method="post">
          <div class="search_list clearfix">
            <dl class="clearfix">
              <dt>�˻�����</dt>
              <dd>
                <ul class="clearfix">
                  <li>
                    <div class="input-group">
                      <input type="text" name="refoundDateStar" value="${orderQuery.refoundDateStar}" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                      <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                  </li>
                  <li>��</li>
                  <li class="last">
                    <div class="input-group">
                      <input type="text" name="refoundDateEnd" value="${orderQuery.refoundDateEnd}" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                      <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                  </li>
                </ul>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>�˻�����</dt>
              <dd>
                <input type="text" class="form-control" name="refoundId" value="${orderQuery.refoundId}"/>
              </dd>
            </dl>
            <dl class="last clearfix">
              <dt>�ɹ���λ</dt>
              <dd>
                <input type="text" class="form-control" name="companyname" value="${orderQuery.companyname}"/>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>�������</dt>
              <dd>
                <input type="text" class="form-control" name="orderId" value="${orderQuery.orderId}"/>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>�˻�״̬</dt>
              <dd>
                <select class="form-control" name="refoundStatus" id="refoundStatus">
                  <option value="">ȫ��</option>
                  <c:forEach var="ordersStatus" items="${ordersStatusList}" varStatus="status">
				      <option value="${ordersStatus.codevalue}" <c:if test="${ordersStatus.codevalue == orderQuery.refoundStatus}"> selected="selected" </c:if>>${ordersStatus.codetext}</option>
				  </c:forEach>
                </select>
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="query('${pageContext.request.contextPath}/supplier/return')">��ѯ</button></li>
              <li><button type="button" class="btn btn-default gray" onclick="clearForm(this.form)">���</button></li>
            </ul>
          </div>
          </form>
        <!--.search_area--></div>
      	<div class="search_result">
          <div class="state_list">
            <ul>
              <li <c:if test="${orderQuery.refoundStatus == ''}"> class="active" </c:if>><a href="javascript:void(0)" onclick="queryFast('${pageContext.request.contextPath}/supplier/return','')">ȫ��</a></li>
              <li <c:if test="${orderQuery.refoundStatus == '0'}"> class="active" </c:if>><a href="javascript:void(0)" onclick="queryFast('${pageContext.request.contextPath}/supplier/return','0')">�����</a></li>
              <li <c:if test="${orderQuery.refoundStatus == '3'}"> class="active" </c:if>><a href="javascript:void(0)" onclick="queryFast('${pageContext.request.contextPath}/supplier/return','3')">���ջ�</a></li>
            </ul>
          </div>
          <table border="0">
            <tr>
              <th width="100">�˻�����</th>
              <th width="100">�������</th>
              <th>�ɹ���λ</th>
              <th width="70">�˻�����</th>
              <th width="70">���(Ԫ)</th>
              <th width="140">�˻�����</th>
              <th width="70">�˻�״̬</th>
              <th width="140" class="last">����</th>
            </tr>
            <c:forEach var="returnOrder" items="${ordersList}" varStatus="status">
	            <tr>
	              <td>${returnOrder.refoundId}</td>
	              <td>${returnOrder.orderId}</td>
	              <td class="company">${returnOrder.companyname}</td>
	              <td>${returnOrder.refoundAmount}</td>
	              <td class="price"><fmt:formatNumber value="${returnOrder.refoundPrice}" pattern="#0.00#"/></td>
	              <td>${returnOrder.refoundDate}</td>
	              <td>${returnOrder.refoundStatusName}</td>
	              <c:if test="${returnOrder.refoundStatus == '0'}"> <td><a href="javascript:void(0)" onclick="openConfirmPage('${returnOrder.refoundStatus}','${pageContext.request.contextPath}/supplier/return/returnConfirmPage/${returnOrder.refoundId}')">���</a> <a href="javascript:void(0)" onclick="openDetailed('${pageContext.request.contextPath}/supplier/return/returnDetailedPage/${returnOrder.refoundId}')">�鿴����</a></td> </c:if>
	              <c:if test="${returnOrder.refoundStatus == '3'}"> <td><a href="javascript:void(0)" onclick="confirmDeliveryStatus('${pageContext.request.contextPath}/supplier/return/returnDelivery','${returnOrder.refoundStatus}','${returnOrder.refoundId}')">ȷ���ջ�</a><a href="javascript:void(0)" onclick="openDetailed('${pageContext.request.contextPath}/supplier/return/returnDetailedPage/${returnOrder.refoundId}')">�鿴����</a></td> </c:if>
	              <c:if test="${returnOrder.refoundStatus != '0' and returnOrder.refoundStatus != '3'}"> <td><a href="javascript:void(0)" onclick="openDetailed('${pageContext.request.contextPath}/supplier/return/returnDetailedPage/${returnOrder.refoundId}')">�鿴����</a></td> </c:if>
	            </tr>
            </c:forEach>
          </table>
        <!--.search_result--></div>
      	<jsp:include page="../page.jsp" />
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>