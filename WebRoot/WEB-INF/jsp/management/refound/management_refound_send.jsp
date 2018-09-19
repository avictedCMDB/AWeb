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
<title>�˻�����|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management_exchange.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/refound.js"></script>
</head>
<body>
<div class="page-wrapper">
    <jsp:include page="../header.jsp" />  
 
  <div id="contents">
    <div class="inner details">
    <input id="path" type="hidden" value="${pageContext.request.contextPath}">
      <h2>�˻�����</h2>
      <div class="section">
        <h3>�˻���������Ϣ</h3>
        <div class="section_info">
          <!-- <label>��������ţ�</label>
          <span></span> -->
          <label>������ţ�</label>
          <span><a href="#">${refound.orderID}</a></span>
          <label>�˻�����ţ�</label>
          <span>${refound.refoundID}</span>
          <label>�˻���������</label>
          <span>${refound.refoundAmount}</span>
          <label>��Ӧ�����ƣ�</label>
          <span>${refound.supName}</span>
        </div>
        <div class="section_info">
          <label>��Ӧ����ϵ��ַ��</label>
          <span>${refound.areaOne}${refound.areaTwo}${refound.areaThree}${refound.areaFour}${refound.supAddressDetail}</span>
        </div>
        <div class="section_info">
          <label>��ע��</label>
          <span>${refound.remark}</span>
        </div>
        <!-- <div class="section_info">
          <label>������</label>
          <span></span>
        </div> -->
      </div>
      <div class="section detail_exchange">
        <h3>�˻�����ϸ��Ϣ</h3>
        <table border="0">
          <tr>
            <th width="40">���</th>
            <th colspan="2">��Ʒ��Ϣ</th>	
            <th width="110">����(Ԫ)</th>
            <th width="110">�˻�����</th>
            <th width="110">�˻����</th>
            <th width="200">�˻�ԭ��</th>
          </tr>
          <c:forEach var="orderSnapshot" items="${refound.orderSnapshots}" varStatus="status">
	           <tr>
	            <td>${status.index+1}</td>
	            <td class="right_none" width="57"><p class="img_pro"><a href="#"><img src="${orderSnapshot.imagePath}" width="55px" height="55px"/></a></p></td>
	            <td class="left_none"><a href="#">${orderSnapshot.goodsName}</a></td>
	            <td class="price">${orderSnapshot.goodsPrice}</td>
	            <td>${orderSnapshot.buyNum}</td>
	            <td>${orderSnapshot.goodsPrice*orderSnapshot.buyNum}</td>
	            <td>${orderSnapshot.refoundReason}</td>
	          </tr>
          </c:forEach>
        </table>
      </div>
      <div class="section">
        <h3>������Ϣ</h3>
        <form class="form-inline special" method="post" action="" id="updateExpressForm">
          <input type="hidden" value="${refound.refoundID}" name="refoundID" id="refoundID"/>
          <div>
            <input type="radio" name="expressType" value="0" checked onclick="expressHide();"><label>��Ӧ������</label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" name="expressType" value="1" onclick="expressShow();"><label>���</label>
          </div>
          <div class="form-group" id="expressNameDiv">
            <label><!-- <span class="red">*</span> -->��ݹ�˾��</label>
            <input id="refoundExpressName" name="refoundExpressName" type="text" class="form-control">
          </div>
          <div class="form-group" id="expressCodeDiv">
            <label><!-- <span class="red">*</span> -->��ݱ�ţ�</label>
            <input id="refoundExpressCode" name="refoundExpressCode" type="text" class="form-control">
          </div>
        </form>
      </div>
      <div class="btn_close">
        <ul class="clearfix">
          <li><button type="button" class="btn btn-default red" onclick="orderRefoundSend();">����</button></li>
          <li><button type="button" class="btn btn-default gray" onclick="closeRefound();">�ر�</button></li>
        </ul>
      </div>
      
      
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>