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
<script type="text/javascript">
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
function query(action){
	
	document.getElementById("queryForm").action=action;
	document.getElementById("queryForm").submit();
	
}
function opDialog(action,dialogWidth,dialogHeight) {
	var result = window.showModalDialog(action,"1","edge: Raised; center: Yes; help: Yes; resizable: Yes; status: Yes; dialogWidth="+dialogWidth+";dialogHeight="+dialogHeight);
	if(result != "" && result != null && result != undefined){
		window.location.href=window.location.href;
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
    		<jsp:param value="valueAddedInvoice" name="menu"/>
    	</jsp:include>
      <div id="matter_section">
      	<h2>��Ʊ���</h2>
      	<form id="queryForm" method="post">
	      	<div class="search_area section">
	          <div class="search_list clearfix">
	            <dl class="clearfix">
	              <dt>��λ���ƣ�</dt>
	              <dd>
	                <input type="text" class="form-control" value="${vatInfoParam.companyName}" name="companyName"/>
	              </dd>
	            </dl>
	            <dl class="clearfix special">
	              <dt>��˰��ʶ���룺</dt>
	              <dd>
	                <input type="text" class="form-control" value="${vatInfoParam.taxpayerCode}" name="taxpayerCode"/>
	              </dd>
	            </dl>
	            <dl class="clearfix last address">
	              <dt>ע���ַ��</dt>
	              <dd>
	                <input type="text" class="form-control" value="${vatInfoParam.registerPath}" name="registerPath"/>
	                
	              </dd>
	            </dl>
	            <dl class="clearfix">
	              <dt>ע��绰��</dt>
	              <dd>
	                <input type="text" class="form-control" value="${vatInfoParam.registerTel}" name="registerTel"/>
	              </dd>
	            </dl>
	            <dl class="clearfix special">
	              <dt>�������У�</dt>
	              <dd>
	                <input type="text" class="form-control" value="${vatInfoParam.bankName}" name="bankName"/>
	              </dd>
	            </dl>
	            <dl class="clearfix">
	              <dt>�����˺ţ�</dt>
	              <dd>
	                <input type="text" class="form-control" value="${vatInfoParam.bankAccount}" name="bankAccount"/>
	              </dd>
	            </dl>
	            <dl class="clearfix state last">
	              <dt>���״̬��</dt>
	              <dd>
	                <select class="form-control" name="auditStatus">
	                  <option value="">��ѡ��</option>
	                  <option value="2" <c:if test="${vatInfoParam.auditStatus == '2'}"> selected="selected" </c:if>>�����</option>
	                  <option value="0" <c:if test="${vatInfoParam.auditStatus == '0'}"> selected="selected" </c:if>>ͨ��</option>
	                  <option value="1" <c:if test="${vatInfoParam.auditStatus == '1'}"> selected="selected" </c:if>>�ܾ�</option>
	                </select>
	              </dd>
	            </dl>
	          </div>
	          
	          <div class="btn_list">
	            <ul>
	              <li><button type="button" class="btn btn-default red" onclick="query('${pageContext.request.contextPath}/supervise/invoice/valueAddedList')">��ѯ</button></li>
	              <li><button type="button" class="btn btn-default gray" onclick="clearForm(this.form)">���</button></li>
	            </ul>
	          </div>
	        </div>
        </form>
        <div class="search_result clearfix"> 
          <table>
            <tr>
              <th width="120">��λ����</th>
              <th width="90">��˰��ʶ����</th>
              <th>ע���ַ</th>
              <th width="90">ע��绰</th>
              <th width="70">��������</th>
              <th width="110">�����˻�</th>
              <th width="70">���״̬</th>
              <th width="110">�ύʱ��</th>
              <th width="70" class="last">����</th>
            </tr>
            <c:forEach var="vat" items="${vatList}" varStatus="status">
	            <tr>
	              <td class="company">${vat.companyName}</td>
	              <td>${vat.taxpayerCode}</td>
	              <td class="company">${vat.registerPath}</td>
	              <td>${vat.registerTel}</td>
	              <td>${vat.bankName}</td>
	              <td>${vat.bankAccount}</td>
	              	<c:choose>
	              		<c:when test="${vat.auditStatus == '2'}">  
					        <td>�����</td>
					   </c:when>
					   <c:when test="${vat.auditStatus == '0'}">  
					        <td>ͨ��</td>
					   </c:when>
					    <c:when test="${vat.auditStatus == '1'}">  
					        <td>�ܾ�</td>
					   </c:when>
					   <c:otherwise> 
					    	<td></td>
					   </c:otherwise>
				  </c:choose>
	              <td>${vat.createDate}</td>
	              <td>
	              <a href="javascript:void(0)" onclick="opDialog('${pageContext.request.contextPath}/supervise/invoice/valueAddedPage/${vat.id}','750px','700px')">
	              	<c:if test="${vat.auditStatus != '2'}"> �鿴</c:if>
	              	<c:if test="${vat.auditStatus == '2'}"> ��� </c:if>
	              </a>
	              </td>
	            </tr>
            </c:forEach>
          </table>
        </div>
       <jsp:include page="../page.jsp" />
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>