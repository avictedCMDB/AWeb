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
<title>��Ӧ�̹�������|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/supplier_common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/supplier_nonstandard.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/viewer/Viewer.min.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierUtil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/viewer/viewer.min.js"></script>
<script type="text/javascript">
function query(action){
	document.getElementById("queryForm").action=action;
	document.getElementById("queryForm").submit();
}
</script>
</head>

<body>
<input id="listCounts" type="hidden" value="${fn:length(supplierOffStandRequireList)}"/>
<div class="page-wrapper">
 <jsp:include page="../header.jsp" /> 
  <div id="contents">
    <div class="inner">
    	<jsp:include page="../menu.jsp">
    		<jsp:param name="menu" value="nonstandard" />
    	</jsp:include>
      <div id="matter_section">
    	<form id="queryForm">
      	<h2>��Ʒ�������</h2>
      	<div class="search_area section">
          <div class="search_list clearfix">
            <dl class="clearfix">
              <dt>�������ƣ�</dt>
              <dd>
                <input type="text" class="form-control" name="goodsName" id="goodsName" value="${supplierOffStandRequire.goodsName}"/>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>����������</dt>
              <dd>
                <input type="text" class="form-control" name="goodsDescNew" id="goodsDescNew" value="${supplierOffStandRequire.goodsDescNew}"/>
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>״̬��</dt>
              <dd>
                <select class="form-control" name="status">
                  <option value=""></option>
                  <option value="0" <c:if test="${supplierOffStandRequire.status == '0'}"> selected="selected" </c:if>>����Ӧ��ȷ��</option>
                  <option value="1" <c:if test="${supplierOffStandRequire.status == '1'}"> selected="selected" </c:if>>��Ӧ�����ṩ</option>
                  <option value="3" <c:if test="${supplierOffStandRequire.status == '3'}"> selected="selected" </c:if>>������</option>
                </select>
              </dd>
            </dl>
          </div>
          <dl class="clearfix">
              <dt>����ʱ�䣺</dt>
              <dd>
                <ul class="clearfix">
                <li>
                  <div class="input-group">
                    <input type="text" class="form-control special_input" name="createDateStar" value="${supplierOffStandRequire.createDateStar}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  </div>
                </li>
                <li>��</li>
                <li class="last">
                  <div class="input-group">
                    <input type="text" class="form-control special_input" name="createDateEnd" value="${supplierOffStandRequire.createDateEnd}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
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
                    <input type="text" class="form-control special_input" name="closeDateStar" value="${supplierOffStandRequire.closeDateStar}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  </div>
                </li>
                <li>��</li>
                <li class="last">
                  <div class="input-group">
                    <input type="text" class="form-control special_input" name="closeDateEnd" value="${supplierOffStandRequire.closeDateEnd}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  </div>
                </li>
              </ul>
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>�Ƿ񹫿���</dt>
              <dd>
                <select class="form-control" name="isRelease">
                  <option value=""></option>
                  <option value="0" <c:if test="${supplierOffStandRequire.isRelease == '0'}"> selected="selected" </c:if>>������</option>
                  <option value="1" <c:if test="${supplierOffStandRequire.isRelease == '1'}"> selected="selected" </c:if>>����</option>
                </select>
              </dd>
            </dl>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="query('${pageContext.request.contextPath}/supplier/offStandRequire')">��ѯ</button></li>
              <li><button type="button" class="btn btn-default gray" onclick="clearForm(this.form)">���</button></li>
            </ul>
          </div>
        <!--.search_area--></div>
        </form>
      	<div class="search_result section">
          <table border="0">
            <tr>
              <th width="100">�ɹ���λ</th>
              <th width="100">��������</th>
              <th width="100">��������</th>
              <th width="135">����</th>
              <th width="100">����ʱ��</th>
              <th width="100">��������</th>
              <th width="100">�Ƿ񹫿�</th>
              <th width="100">״̬</th>
              <th width="120" class="last">����</th>
            </tr>
            <c:forEach var="supplierOffStandRequireItem" items="${supplierOffStandRequireList}" varStatus="status">
	            <tr>
	            	<td>${supplierOffStandRequireItem.companyname}</td>
	            	<td>${supplierOffStandRequireItem.goodsName}</td>
	            	<td>${supplierOffStandRequireItem.goodsDescNew}</td>
	            	<td class="img_list">
	                  <ul id="imageul_${status.index}">
	                  	  <c:forEach var="image" items="${supplierOffStandRequireItem.imageList}" varStatus="status">
	                  	  	     <li>
	                      				<c:choose>
	                      					<c:when test="${fn:contains(image.url.toLowerCase(),'.jpg')}">
	                      						<div id="img_${supplierOffStandRequireItem.id}_${status.index}"><img src="${pageContext.request.contextPath}${image.url}" data-original="${pageContext.request.contextPath}${image.url}" width="80px" height="80px"/></div>
	                      					</c:when>
	                      					<c:when test="${fn:contains(image.url.toLowerCase(),'.png')}">
	                      						<div id="img_${supplierOffStandRequireItem.id}_${status.index}"><img src="${pageContext.request.contextPath}${image.url}" data-original="${pageContext.request.contextPath}${image.url}" width="80px" height="80px"/></div>
	                      					</c:when>
	                      					<c:when test="${fn:contains(image.url.toLowerCase(),'.bmp')}">
	                      						<div id="img_${supplierOffStandRequireItem.id}_${status.index}"><img src="${pageContext.request.contextPath}${image.url}" data-original="${pageContext.request.contextPath}${image.url}" width="80px" height="80px"/></div>
	                      					</c:when>
	                      					<c:when test="${fn:contains(image.url.toLowerCase(),'.jpeg')}">
	                      						<div id="img_${supplierOffStandRequireItem.id}_${status.index}"><img src="${pageContext.request.contextPath}${image.url}" data-original="${pageContext.request.contextPath}${image.url}" width="80px" height="80px"/></div>
	                      					</c:when>
	                      					<c:when test="${fn:contains(image.url.toLowerCase(),'.gif')}">
	                      						<div id="img_${supplierOffStandRequireItem.id}_${status.index}"><img src="${pageContext.request.contextPath}${image.url}" data-original="${pageContext.request.contextPath}${image.url}" width="80px" height="80px"/></div>
	                      					</c:when>
	                      					<c:otherwise>
	                      						<a href="${pageContext.request.contextPath}/supplier/order/downloadContract?downFile=${image.url}" class="download">${image.fileName}</a>
	                      					</c:otherwise>
	                      				</c:choose>
	                      			</li>
	                      </c:forEach>
	                  </ul>
	                </td>
	                <td>${supplierOffStandRequireItem.createDate}</td>
	                <td>${supplierOffStandRequireItem.closeDate}</td>
	                <td>${supplierOffStandRequireItem.isReleaseName}</td>
	                <td>
	                	<c:if test="${supplierOffStandRequireItem.status == '0'}"> ����Ӧ��ȷ�� </c:if>
	                	<c:if test="${supplierOffStandRequireItem.status == '1'}"> ��Ӧ�����ṩ </c:if>
	                	<c:if test="${supplierOffStandRequireItem.status == '3'}"> ������ </c:if>
	                </td>
	                <td>
	                	<c:if test="${supplierOffStandRequireItem.status == '0'}"><a href="${pageContext.request.contextPath}/supplier/offStandRequire/queryDetailed/${supplierOffStandRequireItem.id}?type=1">�ṩ</a></c:if>
	                	<c:if test="${supplierOffStandRequireItem.status == '1' or supplierOffStandRequireItem.status == '3'}"><a href="${pageContext.request.contextPath}/supplier/offStandRequire/queryDetailed/${supplierOffStandRequireItem.id}?type=2">�鿴</a></c:if>
	                </td>
	            </tr>
            </c:forEach>
          </table>
        <!--.search_result--></div>
			<jsp:include page="../page.jsp"/>
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
<script>
	var listCounts = $("#listCounts").val();
	 var options = {
		        url: 'data-original',
		        scalable:true
		      };
	for ( var i = 0; i < listCounts; i++) {
		$("#imageul_"+i).viewer(options);
	}
</script>
</body>
</html>