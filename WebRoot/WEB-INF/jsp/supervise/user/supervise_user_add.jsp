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
<title>添加用户|中航采购网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supervise_user.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function doUserExchange(action){
	var passwordOld = '';
	if($('#type').val() != '1'){
		passwordOld = $('#passwordOld').val();
	}
	var re = /[`~!@#$%^&*()_+<>?:"{},.\/;'[\]]/im,
        re = /[·！#￥（——）：；“”‘、，|《。》？、【】[\]]/im;
	if ($('#userName').val() == '') {
		alert('用户名不能为空！');
		return false;
	}
	if(re.test($('#userName').val())){
		alert('用户名不能包含特殊字符！');
		return false;
	}
	
	if ($('#password').val() == '') {
		alert('密码不能为空！');
		return false;
	}
	if ($('#contactNum').val() != '') {
        if(isNaN($('#contactNum').val())){
            alert('电话号码输入有误,请重新输入!');
            return false;
        }
	}
	if ($('#contactFax').val() != '') {
            if(isNaN($('#contactFax').val())){
            alert('传真输入有误,请重新输入!');
            return false;
	    }
	}
	$.ajax({

	     type: 'POST',

	     url: action ,

	    data: {
			'type' : $('#type').val(),
			'userName' : $('#userName').val(),
			'password' : $('#password').val(),
			'passwordOld' : passwordOld,
			'contactPerson' : $('#contactPerson').val(),
			'contactNum' : $('#contactNum').val(),
			'contactFax' : $('#contactFax').val(),
			'companyName' : $('#companyName').val()
		}  ,

	    success: function (data){
	    	if (data == '1') {
				alert('用户名重复，请重新输入');
			}else{
		    	window.opener.reloadWindows(null);
		    	window.close();
			}
	    } ,
	    dataType: 'json',
	    
	    cache:false,
	});
}
</script>
</head>
<div id="vat_info" class="special">
<input class="form-control" type="hidden" name="type" id="type" value="${type}"/>
  <div class="inner">
    <div class="add_title clearfix"><c:if test="${type == '1'}"> 增加 </c:if>
    	<c:if test="${type == '2'}"> 修改</c:if>用户</div>
    <div class="main_inner">
      <div class="up_area clearfix">
        <dl class="clearfix date_list">
          <dt><span>*</span>用户名：</dt>
          <dd>
            <input class="form-control" type="text" name="userName" id="userName" value="${user.userName}" <c:if test="${type == '2'}"> readonly="readonly" </c:if> />
          </dd>
        </dl>
        <dl class="clearfix">
          <dt><span>*</span>密码：</dt>
          <dd>
            <c:if test="${type == '1'}"> <input class="form-control" type="password" id="password" name="password" value=""></c:if>
          	<c:if test="${type == '2'}"> <input class="form-control" type="password" name="password" id="password" value="******"></c:if>
            <input class="form-control" type="hidden" name="passwordOld" id="passwordOld" value="${user.password}">
          </dd>
        </dl>
        <dl class="clearfix last">
          <dt>联系人：</dt>
          <dd>
            <input class="form-control" type="text" name="contactPerson" id="contactPerson" value="${user.contactPerson}">
          </dd>
        </dl>
        <dl class="clearfix">
          <dt>联系电话：</dt>
          <dd class="special">
            <input class="form-control" type="text" name="contactNum" id="contactNum" value="${user.contactNum}">
          </dd>
        </dl>
        <dl class="clearfix">
          <dt>联系人传真：</dt>
          <dd class="special">
            <input class="form-control" type="text" name="contactFax" id="contactFax" value="${user.contactFax}">
          </dd>
        </dl>
        <dl class="clearfix last">
          <dt>组织机构名称：</dt>
          <dd>
            <select class="form-control" name="companyName" id="companyName" >
            	<c:forEach var="company" items="${companyList}" varStatus="status">
				    <option value="${company.companyCode}|${company.companyName}" <c:if test="${company.companyCode == user.companyId}"> selected="selected"</c:if>>${company.companyName}</option>
				</c:forEach>
            </select>
          </dd>
        </dl>           
      </div>
      <div class="btn_list">
          <ul>
            <li><button type="button" class="btn btn-default red" onclick="doUserExchange('${pageContext.request.contextPath}/supervise/supplierUser/doUserExchange')">确定</button></li>
            <li><button type="button" class="btn btn-default gray" onclick="window.close();">关闭</button></li>
          </ul>
        </div> 
    </div>
  </div>
</div>
</body>
</html>