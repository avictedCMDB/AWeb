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
<title>���ӽ�ɫ|�к��ɹ���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supervise_role.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function doRoleExchange(action){
	if ($('#roleName').val() == '') {
		alert('��ɫ������Ϊ�գ�');
		return false;
	}
	$.ajax({

	     type: 'POST',

	     url: action ,

	    data: {
			'type' : $('#type').val(),
			'roleId' : $('#roleId').val(),
			'roleName' : $('#roleName').val(),
			'isUseable' : $('#isUseable').val(),
			'remarks' : $('#remarks').val(),
			'ifPayRole' : $('#ifPayRole').val(),
			'systemFlag':$('#systemFlag').val()
		}  ,

	    success: function (data){
			alert('�����ɹ�');
	    	window.opener.reloadWindows(null);
	    	window.close();
	    } ,
	    dataType: 'json',
	    
	    cache:false,
	});
}
function updateSystemFlag(){
	if($('#systemFlag').val() == '1'){
		$('#ifPayRole').val('0');
		$("#ifPayRole").removeAttr("disabled");
	}else{
		$('#ifPayRole').val('1');
		$('#ifPayRole').attr("disabled","disabled");
	}
}
</script>
<body>
<div id="vat_info">
  <div class="inner">
    <div class="add_title clearfix">����/ɾ����ɫ<a href="#"><i class="fa fa-close"></i></a></div>
    <div class="main_inner">
      <div class="up_area clearfix">
        <dl class="clearfix date_list">
          <dt>��ɫ���ƣ�</dt>
          <dd>
          	<input class="form-control" type="hidden" value="${type}" id="type">
          	<input class="form-control" type="hidden" value="${role.id}" id="roleId">
            <input class="form-control" type="text" value="${role.roleName}" id="roleName">
          </dd>
        </dl>
        <dl class="clearfix">
          <dt>״̬��</dt>
          <dd>
            <select class="form-control" name="isUseable" id="isUseable">
	          <option value="1" <c:if test="${role.isUseable == '1'}"> selected="selected"</c:if>>����</option>
	          <option value="0" <c:if test="${role.isUseable == '0'}"> selected="selected"</c:if>>����</option>
	        </select>
          </dd>
        </dl>
        <dl class="clearfix">
          <dt>ƽ̨��</dt>
          <dd>
            <select class="form-control" name="systemFlag" id="systemFlag" onchange="updateSystemFlag()">
            	<c:forEach var="code" items="${codeList}" varStatus="status">
            		<option value="${code.codeValue}" <c:if test="${role.systemFlag == code.codeValue}"> selected="selected"</c:if>>${code.codeText}</option>
            	</c:forEach>
	        </select>
          </dd>
        </dl>
        <dl class="clearfix">
          <dt>֧����ɫ��</dt>
          <dd>
            <select class="form-control" name="ifPayRole" id="ifPayRole"  <c:if test="${type == '1' and isFlag == '1'}"> disabled="disabled"</c:if> <c:if test="${role.systemFlag == '0'}"> disabled="disabled"</c:if>>
              <option value="0" <c:if test="${role.ifPayRole == '0'}"> selected="selected"</c:if>>��</option>
              <option value="1" <c:if test="${role.ifPayRole == '1'}"> selected="selected"</c:if> <c:if test="${type == '1' and isFlag == '1'}"> selected="selected"</c:if>>��</option>
	        </select>
          </dd>
        </dl>
        <dl class="clearfix">
          <dt>��ע��</dt>
          <dd>
            <textarea class="form-control" rows="3" id="remarks">${role.remarks}</textarea>
          </dd>
        </dl>
        <div class="btn_list">
          <ul>
            <li><button type="button" class="btn btn-default red" onclick="doRoleExchange('${pageContext.request.contextPath}/supervise/superviseRole/doRoleExchange')">ȷ��</button></li>
            <li><button type="button" class="btn btn-default gray" onclick="window.close();">�ر�</button></li>
          </ul>
        </div>    
      </div>
    </div>
  </div>
</div>
</html>