<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../meta.jsp" >
	<jsp:param value="增值税发票审核" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/supervise_vat.css" rel="stylesheet"/>
<script type="text/javascript">
function clearForm(objE){//objE为form表单  
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
      	<h2>增票审核</h2>
      	<form id="queryForm" method="post">
	      	<div class="search_area section">
	          <div class="search_list clearfix">
	            <dl class="clearfix">
	              <dt>单位名称：</dt>
	              <dd>
	                <input type="text" class="form-control" value="${vatInfoParam.companyName}" name="companyName"/>
	              </dd>
	            </dl>
	            <dl class="clearfix special">
	              <dt>纳税人识别码：</dt>
	              <dd>
	                <input type="text" class="form-control" value="${vatInfoParam.taxpayerCode}" name="taxpayerCode"/>
	              </dd>
	            </dl>
	            <dl class="clearfix last address">
	              <dt>注册地址：</dt>
	              <dd>
	                <input type="text" class="form-control" value="${vatInfoParam.registerPath}" name="registerPath"/>
	                
	              </dd>
	            </dl>
	            <dl class="clearfix">
	              <dt>注册电话：</dt>
	              <dd>
	                <input type="text" class="form-control" value="${vatInfoParam.registerTel}" name="registerTel"/>
	              </dd>
	            </dl>
	            <dl class="clearfix special">
	              <dt>开户银行：</dt>
	              <dd>
	                <input type="text" class="form-control" value="${vatInfoParam.bankName}" name="bankName"/>
	              </dd>
	            </dl>
	            <dl class="clearfix">
	              <dt>银行账号：</dt>
	              <dd>
	                <input type="text" class="form-control" value="${vatInfoParam.bankAccount}" name="bankAccount"/>
	              </dd>
	            </dl>
	            <dl class="clearfix state last">
	              <dt>审核状态：</dt>
	              <dd>
	                <select class="form-control" name="auditStatus">
	                  <option value="">请选择</option>
	                  <option value="2" <c:if test="${vatInfoParam.auditStatus == '2'}"> selected="selected" </c:if>>待审核</option>
	                  <option value="0" <c:if test="${vatInfoParam.auditStatus == '0'}"> selected="selected" </c:if>>通过</option>
	                  <option value="1" <c:if test="${vatInfoParam.auditStatus == '1'}"> selected="selected" </c:if>>拒绝</option>
	                </select>
	              </dd>
	            </dl>
	          </div>
	          
	          <div class="btn_list">
	            <ul>
	              <li><button type="button" class="btn btn-default red" onclick="query('${pageContext.request.contextPath}/supervise/invoice/valueAddedList')">查询</button></li>
	              <li><button type="button" class="btn btn-default gray" onclick="clearForm(this.form)">清空</button></li>
	            </ul>
	          </div>
	        </div>
        </form>
        <div class="search_result clearfix"> 
          <table>
            <tr>
              <th width="120">单位名称</th>
              <th width="90">纳税人识别码</th>
              <th>注册地址</th>
              <th width="90">注册电话</th>
              <th width="70">开户银行</th>
              <th width="110">银行账户</th>
              <th width="70">审核状态</th>
              <th width="110">提交时间</th>
              <th width="70" class="last">操作</th>
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
					        <td>待审核</td>
					   </c:when>
					   <c:when test="${vat.auditStatus == '0'}">  
					        <td>通过</td>
					   </c:when>
					    <c:when test="${vat.auditStatus == '1'}">  
					        <td>拒绝</td>
					   </c:when>
					   <c:otherwise> 
					    	<td></td>
					   </c:otherwise>
				  </c:choose>
	              <td>${vat.createDate}</td>
	              <td>
	              <a href="javascript:void(0)" onclick="opDialog('${pageContext.request.contextPath}/supervise/invoice/valueAddedPage/${vat.id}','750px','700px')">
	              	<c:if test="${vat.auditStatus != '2'}"> 查看</c:if>
	              	<c:if test="${vat.auditStatus == '2'}"> 审核 </c:if>
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
