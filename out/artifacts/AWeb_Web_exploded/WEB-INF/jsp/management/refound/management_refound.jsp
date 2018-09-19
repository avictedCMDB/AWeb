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
    <div class="inner">
      <jsp:include page="../left_menu.jsp">
		  <jsp:param name="menu" value="refound" />
	  </jsp:include>
      
      <div id="matter_section">
      <input id="path" type="hidden" value="${pageContext.request.contextPath}">
      	<h2>�˻�����</h2>
      	<form action="" method="post" id="refoundForm">
      	<input type="hidden" id="searchRefoundStatus" name="searchRefoundStatus" value="${refound.searchRefoundStatus}"/>
      	<div class="search_area section">
          <div class="search_list clearfix">
            <dl class="clearfix">
              <dt>�˻����ڣ�</dt>
              <dd>
                <ul class="clearfix">
                <li>
                  <div class="input-group">
                    <input id="startTime" name="startTime" type="text" class="form-control special_input" value="${refound.startTime}"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  </div>
                </li>
                <li>��</li>
                <li class="last">
                  <div class="input-group">
                    <input id="endTime" name="endTime" type="text" class="form-control special_input" value="${refound.endTime}"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  </div>
                </li>
              </ul>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>�˻�����ţ�</dt>
              <dd>
                <input id="searchRefoundID" name="searchRefoundID" type="text" class="form-control" value="${refound.searchRefoundID}">
              </dd>
            </dl>
            <dl class="last clearfix">
              <dt>��Ӧ�����ƣ�</dt>
              <dd>
                <input id="searchSupName" name="searchSupName" type="text" class="form-control" value="${refound.searchSupName}">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>������ţ�</dt>
              <dd>
                <input id="searchOrderID" name="searchOrderID" type="text" class="form-control" value="${refound.searchOrderID}">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>�˻���״̬��</dt>
              <dd>
                <select id="selRefoundStatus" name="selRefoundStatus" class="form-control" onchange="selCode();">
                  <option value="" <c:if test="${empty refound.searchRefoundStatus}">selected="selected"</c:if>>ȫ��</option>
                  <c:forEach var="code" items="${codes}" varStatus="status">
                    <option <c:if test="${refound.searchRefoundStatus == code.codeValue}">selected="selected"</c:if> value="${code.codeValue}">${code.codeText}</option>
                  </c:forEach>
                </select>
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="searchRefoundOrders();">��ѯ</button></li>
              <li><button type="button" class="btn btn-default gray" onclick="clearSearch();">���</button></li>
            </ul>
          </div>
        <!--.search_area--></div>
        </form>
      	<div class="search_result section">
          <div class="state_list">
            <ul id="allStatusLi">
               
               <li id="allLi"<c:if test="${empty refound.searchRefoundStatus}">class="active"</c:if> onclick="searchByCode('');"><a href="javascript:void(0);">ȫ��</a></li>
              <%-- <c:forEach var="code" items="${codes}" varStatus="status"> --%>
              	<li id="li0" <c:if test="${refound.searchRefoundStatus == '0'}">class="active"</c:if> onclick="searchByCode('0');"><a href="javascript:void(0);">�����</a></li>
              	<li id="li1" <c:if test="${refound.searchRefoundStatus == '1'}">class="active"</c:if> onclick="searchByCode('1');"><a href="javascript:void(0);">������</a></li>
              	<li id="li2" <c:if test="${refound.searchRefoundStatus == '2'}">class="active"</c:if> onclick="searchByCode('2');"><a href="javascript:void(0);">���δͨ��</a></li>
              <%-- </c:forEach> --%>
              <li class="delete"><button type="button" class="btn btn-default gray" onclick="delRefoundOrders();">ɾ��</button></li>
            </ul>
          </div>
          <table border="0">
            <tr>
              <th width="40"><input id="checkAll" type="checkbox" onclick="checkAll();"></th>
              <th width="120">�˻������</th>
              <th width="120">�������</th>
              <th>��Ӧ������</th>
              <th width="70">�˻�����</th>
              <th width="70">���(Ԫ)</th>
              <th width="100">����ʱ��</th>
              <th width="70">״̬</th>
              <th width="150" class="last">����</th>
            </tr>
            <c:forEach var="refound" items="${refounds}" varStatus="status">
            <tr>
              <td>
              	  <c:choose>
              	  	<c:when test="${refound.refoundStatus == 0}">
              	  		<input name="checkRefoundIDs" type="checkbox" value="${refound.refoundID}">
              	  	</c:when>
              	  	<c:otherwise>
              	  		<input type="checkbox" disabled>
              	  	</c:otherwise>
              	  </c:choose>
              </td>
              <td>${refound.refoundID}</td>
              <td>${refound.orderID}</td>
              <td class="left_align">${refound.supName}</td>
              <td>${refound.refoundAmount}</td>
              <td><fmt:formatNumber value="${refound.refoundPrice}" pattern="#0.00#"/></td>
              <td>${refound.refoundDate}</td>
              <td>${refound.refoundStatusName}</td>
              <td>
              	<a href="${pageContext.request.contextPath}/management/refound/check/${refound.refoundID}">�鿴</a>
                <c:choose>
                	<c:when test="${refound.refoundStatus == 1 and refound.supID != '4'}">
                		&nbsp;|&nbsp;<a href="${pageContext.request.contextPath}/management/refound/send/${refound.refoundID}">����</a>
                	</c:when>
                	<c:when test="${refound.refoundStatus == 0 and refound.supID != '4'}">
                		&nbsp;|&nbsp;<a href="${pageContext.request.contextPath}/management/refound/del/${refound.refoundID}">ȡ��</a>
                	</c:when>
		        	<c:when test="${refound.supID == '4'}">
		        		&nbsp;|&nbsp;<a href="javascript:void(0);" onclick="services('${refound.refoundID}');">����</a>
		        	</c:when>
                </c:choose>
                
              </td>
            </tr>
            </c:forEach>
          </table>
        <!--.search_result--></div>
        <jsp:include page="../page.jsp" />
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>