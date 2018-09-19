<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>�ɹ����ƽ̨|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/supervise_common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/supervise_recommend.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierRecommend.js"></script>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../../header.jsp" />
  <div id="header">
    <%-- <div class="inner clearfix">
      <div class="logo">
        <img src="${pageContext.request.contextPath}/static/img/supervise/logo-supervise.png" alt="�к��б���" />
      </div>
      <div class="search">
        <img src="${pageContext.request.contextPath}/static/img/supplier/bnr-supplier.jpg" />
      </div>
    <!--.inner--></div> --%>
  <!--#header--></div>
  
  <input id="path" type="hidden" value="${pageContext.request.contextPath}"/>
  <div id="contents">
    <div class="inner">
    	<jsp:include page="../../left.jsp">
    		<jsp:param value="supplierRecommend" name="menu"/>
    	</jsp:include>
      <div id="matter_section">
      	<h2>��Ӧ���Ƽ�</h2>
      	<div class="search_area section">
          <div class="search_list clearfix">
            <form action="${pageContext.request.contextPath}/supplier/supplierRecommend" id="supplierRecommendForm" method="post">
            <dl class="clearfix">
              <dt>��Ӧ�����ƣ�</dt>
              <dd>
                <input type="text" id="supName" name="supName" class="form-control" value="${searchSupplierRecommend.supName}"/>
              </dd>
            </dl>
            <dl class="clearfix date_list">
              <dt>�Ƽ�ʱ�䣺</dt>
              <dd>
                <ul class="clearfix">
                  <li>
                    <div class="input-group">
                      <input type="text" id="beginDate" name="beginDate" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${searchSupplierRecommend.beginDate}"/>
                      <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                  </li>
                  <li>��</li>
                  <li class="last">
                    <div class="input-group">
                      <input type="text" id="endDate" name="endDate" class="form-control special_input"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${searchSupplierRecommend.endDate}"/>
                      <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                  </li>
                </ul>
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>�Ƿ��Ƽ���</dt>
              <dd>
                <select class="form-control" id="ifRecommend" name="ifRecommend">
                    <option <c:if test="${empty searchSupplierRecommend.ifRecommend}">selected="selected"</c:if> value="">ȫ��</option>
                    <option <c:if test="${searchSupplierRecommend.ifRecommend == '0'}">selected="selected"</c:if>value="0">��</option>
                    <option <c:if test="${searchSupplierRecommend.ifRecommend == '1'}">selected="selected"</c:if>value="1">��</option>
                </select>
              </dd>
            </dl>
            </form>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="search();">��ѯ</button></li>
            </ul>
          </div>
        </div>
        <div class="search_result">
          <table>
            <tr>
              <th>��Ӧ������</th>
              <th width="200">�Ƽ�ʱ��</th>
              <th>��Ӧ��ͼƬ</th>
              <th width="180" class="last">����</th>
            </tr>
            <c:forEach var="supplierRecommend" items="${supplierRecommends}" varStatus="status">
	            <tr>
	              <td width="300">${supplierRecommend.supName}</td>
	              <td width="200">
	                  <c:if test="${supplierRecommend.beginDate!=null && supplierRecommend.beginDate!='' && supplierRecommend.endDate!=null && supplierRecommend.endDate!=''}">
	                  	${supplierRecommend.beginDate}��${supplierRecommend.endDate}
	                  </c:if>
	              	 <c:if test="${supplierRecommend.beginDate==null || supplierRecommend.beginDate==''||supplierRecommend.endDate==null || supplierRecommend.endDate==''}">
	                  	--��--
	                  </c:if>
	              </td>
	              <c:choose>
	                <c:when  test="${supplierRecommend.supImage != null}">
	                	<td width="180"><img src="${pageContext.request.contextPath}${supplierRecommend.supImage}" width="129" height="92" alt="" /></td>
	                </c:when>
	              	<c:otherwise>
	              		<td width="180"></td>
	              	</c:otherwise>
	              </c:choose>
	              
	              
	              <c:choose>
	                <c:when  test="${supplierRecommend.ifRecommend == 1}">
	                	<td width="90" class="last">
	                		<a href="javascript:void(0);" onclick="setRecommendPage(${supplierRecommend.supID});">�Ƽ�</a><!-- |
	                		<a href="javascript:void(0);" onclick="showCompany('${supplierRecommend.supID}')">�鿴������λ</a> -->
	                	</td>
	                </c:when>
	              	<c:otherwise>
	              		<td width="90" class="last">
	              			<a href="javascript:void(0);" onclick="cancleRecommend(${supplierRecommend.supID});">ȡ���Ƽ�</a><!--|
	              			<a href="javascript:void(0);" onclick="showCompany('${supplierRecommend.supID}')">�鿴������λ</a>-->
	              		</td>
	              	</c:otherwise>
	              </c:choose>
	              
	            </tr>
            </c:forEach>
          </table>
        </div>
        <jsp:include page="../../page.jsp" />
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>