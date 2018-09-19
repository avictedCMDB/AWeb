<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../meta.jsp" >
	<jsp:param value="��ֵ˰��Ʊ���" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/supervise_vat.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/imgbox.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.imgbox.pack.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	<c:forEach var="image1" items="${vatInfo.imgOne}" varStatus="status">
		$("#img_${status.index}_1").imgbox();
	</c:forEach>
	<c:forEach var="image2" items="${vatInfo.imgTwo}" varStatus="status">
		$("#img_${status.index}_2").imgbox();
	</c:forEach>
	<c:forEach var="image3" items="${vatInfo.imgThree}" varStatus="status">
	$("#img_${status.index}_3").imgbox();
	</c:forEach>

	});
function valueAddedConfirm(action,id,auditStatus){
	$.ajax({

	     type: 'POST',

	     url: action ,

		    data : {
			'id' : id,
			'auditStatus' : auditStatus,
			'auditContent' : $('#auditContentText').val()
		} ,

	    success: function (data){
	    	window.returnValue = "reload";
	    	window.close();
	    } ,

	    dataType: 'json',
	    contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
	    cache:false,
	});
}
</script>
</head>
<body>
<div id="vat_info">
  <div class="inner">
    <div class="add_title clearfix">��Ʊ���</div>
    <div class="main_inner">
      <div class="up_area">
        <form class="form-horizontal">
          <div class="form-group">
            <label for="name" class="control-label">��λ����:</label>
            <input type="text" class="form-control detail" value="${vatInfo.companyName}" name="companyName" disabled="disabled"/>
          </div>
          <div class="form-group">
            <label for="name" class="control-label">��˰ʶ����:</label>
            <input type="text" class="form-control detail" value="${vatInfo.taxpayerCode}" name="taxpayerCode" disabled="disabled"/>
          </div>
          <div class="form-group">
            <label for="name" class="control-label">ע���ַ:</label>
            <input type="text" class="form-control detail" value="${vatInfo.registerPath}" name="registerPath" disabled="disabled"/>
          </div>
          <div class="form-group">
            <label for="name" class="control-label">ע��绰:</label>
            <input type="text" class="form-control detail" value="${vatInfo.registerTel}" name="registerTel" disabled="disabled"/>
          </div>
          <div class="form-group">
            <label for="name" class="control-label">��������:</label>
            <input type="text" class="form-control detail" value="${vatInfo.bankName}" name="bankName" disabled="disabled"/>
          </div>
          <div class="form-group">
            <label for="name" class="control-label">�����˺�:</label>
            <input type="text" class="form-control detail" value="${vatInfo.bankAccount}" name="bankAccount" disabled="disabled"/>
          </div>
          <div class="form-group clearfix">
            <label for="name" class="control-label">˰��ǼǸ���:</label>
            <div class="up_img_list">
              <ul class="clearfix">
              <c:forEach var="image1" items="${vatInfo.imgOne}" varStatus="status">
					<li>
					<a id="img_${status.index}_1" href="${pageContext.request.contextPath}${image1.url}"><img src="${pageContext.request.contextPath}${image1.url}" width="55px" height="55px"/></a>
					</li>
			  </c:forEach>
              </ul>
            </div>
          </div>
          <div class="form-group clearfix">
            <label for="name" class="control-label">һ����˰��֤��:</label>
            <div class="up_img_list">
              <ul class="clearfix">
                <c:forEach var="image2" items="${vatInfo.imgTwo}" varStatus="status">
					<li>
					<a id="img_${status.index}_2" href="${pageContext.request.contextPath}${image2.url}"><img src="${pageContext.request.contextPath}${image2.url}" width="55px" height="55px"/></a>
					</li>
			  </c:forEach>
              </ul>
            </div>
          </div>
          <div class="form-group clearfix">
            <label for="name" class="control-label">��Ʊ��Ȩί����:</label>
            <div class="up_img_list">
              <ul class="clearfix">
                <c:forEach var="image3" items="${vatInfo.imgThree}" varStatus="status">
					<li>
					<a id="img_${status.index}_3" href="${pageContext.request.contextPath}${image3.url}"><img src="${pageContext.request.contextPath}${image3.url}" width="55px" height="55px"/></a>
					</li>
			  </c:forEach>
              </ul>
            </div>
          </div>
          <div class="form-group">
            <label for="name" class="control-label">������:</label>
            <textarea class="form-control" rows="3" id="auditContentText" <c:if test="${vatInfo.auditStatus != '2'}"> disabled="disabled"</c:if> >${vatInfo.auditContent}</textarea>
          </div>
        </form>
        <div class="btn_list">
          <ul class="clearfix">
          	<c:if test="${vatInfo.auditStatus == '2'}">
          		 <li><button  type="button" class="btn btn-default blue" onclick="valueAddedConfirm('${pageContext.request.contextPath}/supervise/invoice/valueAddedConfirm','${vatInfo.id}','0')">ͨ��</button></li>
            	<li><button  type="button" class="btn btn-default gray" onclick="valueAddedConfirm('${pageContext.request.contextPath}/supervise/invoice/valueAddedConfirm','${vatInfo.id}','1')">�ܾ�</button></li>
          	</c:if>
          </ul>
        </div>
        </div>
        
    </div>
  </div>
</div>
</body>
</html>