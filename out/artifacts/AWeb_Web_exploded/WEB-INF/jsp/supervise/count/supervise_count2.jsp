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
<title>ͳ�Ʒ���|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supervise_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supervise_count.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/count.js"></script>
</head>
<body>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/echarts-all.js" charset="UTF-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/echarts.js" charset="UTF-8"></script>
<input type="hidden" id="path" value="${pageContext.request.contextPath}"/>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  <div id="contents">
    <div class="inner">
    	<jsp:include page="../left.jsp">
    		<jsp:param value="companyCount" name="menu"/>
    	</jsp:include>
    	
      <div id="matter_section">
      	<h2>�ɹ���λͳ�Ʒ���</h2>
      	<div class="search_area section">
          <div class="search_list clearfix">
            <dl class="clearfix">
              <dt>��ʼʱ�䣺</dt>
              <dd>
                <ul class="clearfix">
                  <li>
                    <div class="input-group">
                      <input id="startTime" name="startTime" type="text" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                      <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                  </li>
                </ul>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>����ʱ�䣺</dt>
              <dd>
                <ul class="clearfix">
                  <li>
                    <div class="input-group">
                      <input id="endTime" name="endTime" type="text" class="form-control special_input"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                      <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                  </li>
                </ul>
              </dd>
            </dl>
            <dl class="clearfix last">
              <dd>
                 <label class="checkbox-inline"><input type="radio" name="optionsRadiosinline" id="optionsRadios1" value="1" checked>��</label>
                 <label class="checkbox-inline"><input type="radio" name="optionsRadiosinline" id="optionsRadios2" value="2">��</label>
                  <label class="checkbox-inline"><input type="radio" name="optionsRadiosinline" id="optionsRadios3" value="3">��</label>
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>�ɹ���λ��</dt>
              <dd>
                <select class="form-control" id="companyID">
                   <option value="-1">ȫ��</option>
                   <c:forEach var="company" items="${companies}" varStatus="status">
                   		<option value="${company.companyID}">${company.companyName}</option>
                   </c:forEach>
                </select>
              </dd>
            </dl>
          </div>
          
        </div>
        <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="loadCompanyChart();">��ѯ</button></li>
              <li><button type="button" class="btn btn-default gray" onclick="clear2();">���</button></li>
            </ul>
          </div>
        <div class="search_result" id="countChartDiv" style="width:800px;height:500px">
          
        
        </div>
        
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
 
  <jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>