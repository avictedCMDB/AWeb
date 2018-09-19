<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ɫ����|�к��ɹ���</title>
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

function query(action){
	
	document.getElementById("queryForm").action=action;
	document.getElementById("queryForm").submit();
	
}
function clearForm(objE){//objEΪform����  
    $(objE).find(':input').each(  
        function(){  
            switch(this.type){  
                case 'passsword':  
                case 'select-multiple':  
                case 'select-one':  
                case 'text':  
                case 'textarea':  
                    $(this).val('');  
                    break;  
                case 'checkbox':  
                case 'radio':  
                    this.checked = false;  
            }  
        }     
    );  
}
function opDialog(action,dialogWidth,dialogHeight) {
	var iTop = (parseInt(window.screen.availHeight)-30-parseInt(dialogHeight))/2;       //��ô��ڵĴ�ֱλ��;
	var iLeft = (parseInt(window.screen.availWidth)-10-parseInt(dialogWidth))/2;           //��ô��ڵ�ˮƽλ��;
	window.open(action, 'newwindow', 'height='+dialogHeight+', width='+dialogWidth+', top='+iTop+', left='+iLeft+', toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no,modal=yes');
}
function reloadWindows(action){
	if (action ==null) {
		window.location.href=window.location.href;
	}else{
		window.location.href = action;
	}
		
}
function deleteRole(roleId,action){
	if(confirm("�Ƿ�ɾ���ý�ɫ��")){
		$.ajax({
		     type: 'POST',
		     url: action ,
		    data: {
				'roleId' : roleId
			}  ,
		    success: function (data){
		    	if(data == '0'){
		    		alert("ɾ���ɹ�");
			    	window.location.href=window.location.href;
		    	}else{
		    		alert('ɾ��ʧ�ܣ����ȳ������а󶨸ý�ɫ���û���');
		    	}
		    	
		    } ,
		    error: function(XMLHttpRequest, textStatus, errorThrown) {
		    	 alert(XMLHttpRequest.status);
		    	 alert(XMLHttpRequest.readyState);
		    	 alert(textStatus);
		    	   },
		    dataType: 'json',
		    cache:false,
		});
	}
}
</script>
</head>
<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" /> 
  <div id="contents">
    <div class="inner">
    	<jsp:include page="../left.jsp">
		  <jsp:param name="menu" value="role" />
	  </jsp:include>
      <div id="matter_section">
      	<h2>��ɫ����</h2>
      	<form id="queryForm" method="post">
      	<div class="search_area section">
          <div class="search_list clearfix">
            <dl class="clearfix first">
              <dt>��ɫ���ƣ�</dt>
              <dd>
                <input type="text" class="form-control" name="roleName" value="${roleParam.roleName}">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>״̬��</dt>
              <dd>
                <select class="form-control" name="isUseable" id="isUseable">
                  <option value="" <c:if test="${roleParam.isUseable == ''}"> selected="selected" </c:if>>ȫ��</option>
	              <option value="1" <c:if test="${roleParam.isUseable == '1'}"> selected="selected"</c:if>>����</option>
	              <option value="0" <c:if test="${roleParam.isUseable == '0'}"> selected="selected"</c:if>>����</option>
	            </select>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>ƽ̨��</dt>
              <dd>
                <select class="form-control" name="systemFlag" id="systemFlag">
                  <option value="" <c:if test="${role.systemFlag == ''}"> selected="selected"</c:if>>ȫ��</option>
	              <option value="0" <c:if test="${roleParam.systemFlag == '0'}"> selected="selected"</c:if>>����ƽ̨</option>
	              <option value="1" <c:if test="${roleParam.systemFlag == '1'}"> selected="selected"</c:if>>�ɹ�ƽ̨</option>
	            </select>
              </dd>
            </dl>
            <dl class="last clearfix">
              <dt>֧����ɫ��</dt>
              <dd>
                <select class="form-control" name="ifPayRole" id="ifPayRole">
                  <option value="" <c:if test="${role.ifPayRole == ''}"> selected="selected"</c:if>>ȫ��</option>
	              <option value="0" <c:if test="${roleParam.ifPayRole == '0'}"> selected="selected"</c:if>>��</option>
	              <option value="1" <c:if test="${roleParam.ifPayRole == '1'}"> selected="selected"</c:if>>��</option>
	            </select>
              </dd>
            </dl>
            <div class="btn_list">
                <ul>
                  <li><button type="button" class="btn btn-default red" onclick="query('${pageContext.request.contextPath}/supervise/superviseRole')">��ѯ</button></li>
                  <c:if test="${companyCode == 'system'}">
                  <li><button type="button" class="btn btn-default red" onclick="opDialog('${pageContext.request.contextPath}/supervise/superviseRole/roleAddPage?type=1','800px','400px')">����</button></li>
                  </c:if>
                </ul>
            </div>
          </div>
        <!--.search_area--></div>
        </form>
      	<div class="search_result section">
          <table border="0">
            <tr>
              <th width="100">��ɫ����</th>
              <th width="70">ƽ̨</th>
              <th width="70">֧����ɫ</th>
              <th width="100">������</th>
              <th width="150">����ʱ��</th>
              <th width="100">�޸���</th>
              <th width="150">�޸�ʱ��</th>
              <th width="50">״̬</th>
              <c:if test="${companyCode == 'system'}"><th width="150" class="last">����</th></c:if>
            </tr>
            <c:forEach var="role" items="${roleList}" varStatus="status">
            <tr>
               <td>${role.roleName}</td>
               <td>
               	<c:if test="${role.systemFlag == '0'}"> ����ƽ̨
               		</c:if>
               		<c:if test="${role.systemFlag == '1'}"> �ɹ�ƽ̨
               		</c:if>
               </td>
                <td>
               	<c:if test="${role.ifPayRole == '0'}"> ��
               		</c:if>
               		<c:if test="${role.ifPayRole == '1'}"> ��
               		</c:if>
               </td>
               <td>${role.createUser}</td>
               <td>${role.createDate}</td>
               <td>${role.updateUser}</td>
               <td>${role.updateDate}</td>
                              <td>
               	<c:if test="${role.isUseable == '0'}"> ������
               		</c:if>
               		<c:if test="${role.isUseable == '1'}"> ����
               		</c:if>
               </td>
               <c:if test="${companyCode == 'system'}">
               <td><a href="javascript:void(0)" onclick="opDialog('${pageContext.request.contextPath}/supervise/superviseRole/roleUpdatePage?type=2&roleId=${role.id}','800px','400px')">�޸�</a>
               <a href="javascript:void(0)" onclick="deleteRole('${role.id}','${pageContext.request.contextPath}/supervise/superviseRole/deleteRole')">ɾ��</a>
               <a href="javascript:void(0)" onclick="opDialog('${pageContext.request.contextPath}/supervise/superviseRole/deployUserRolePage?roleId=${role.id}&systemFlag=${role.systemFlag}','800px','600px')">����˵�</a></td>
            </c:if>
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