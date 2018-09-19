<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>ѯ�۹���|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/management_enquiry.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/managementEnterprise.js"></script>
</head>

<body>
<input type="hidden" id="path" value="${pageContext.request.contextPath}"/>
<div class="page-wrapper">
	<jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    	<jsp:include page="../left_menu.jsp">
		  <jsp:param name="menu" value="enterprise" />
	  	</jsp:include>
      
      <div id="matter_section">
      	<h2>ѯ�۹���</h2>
      	<form action="${pageContext.request.contextPath}/management/enterprise" method="post" id="enterpriseForm">
      	<div class="search_area section">
          <div class="search_list clearfix">
            <dl class="clearfix">
              <dt>��Ʒ���ƣ�</dt>
              <dd>
                <input id="goodsName" name="goodsName" type="text" class="form-control" value="${enterprise.goodsName}"/>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>ѯ��ʱ�䣺</dt>
              <dd>
                <ul class="clearfix">
                <li>
                  <div class="input-group">
                    <input id="startDate1" name="startDate1" type="text" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${enterprise.startDate1}"/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  </div>
                </li>
                <li>��</li>
                <li class="last">
                  <div class="input-group">
                    <input id="endDate1" name="endDate1" type="text" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${enterprise.endDate1}"/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  </div>
                </li>
              </ul>
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>�������ڣ�</dt>
              <dd>
                <ul class="clearfix">
                <li>
                  <div class="input-group">
                    <input id="startDate2" name="startDate2" type="text" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${enterprise.startDate2}"/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  </div>
                </li>
                <li>��</li>
                <li class="last">
                  <div class="input-group">
                    <input id="endDate2" name="endDate2" type="text" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${enterprise.endDate2}"/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  </div>
                </li>
              </ul>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>��Ӧ�̣�</dt>
              <dd>
                <input id="supName" name="supName" type="text" class="form-control" value="${enterprise.supName}"/>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>ѯ��״̬��</dt>
              <dd>
                <select class="form-control" id="enquiryStatus" name="enquiryStatus">
                  <option value="" <c:if test="${empty enterprise.enquiryStatus}">selected="selected"</c:if>>ȫ��</option>
                  <option value="0" <c:if test="${enterprise.enquiryStatus == '0'}">selected="selected"</c:if>>����Ӧ�̱���</option>
                  <option value="1" <c:if test="${enterprise.enquiryStatus == '1'}">selected="selected"</c:if>>��Ӧ���ѱ���</option>
                  <option value="2" <c:if test="${enterprise.enquiryStatus == '2'}">selected="selected"</c:if>>��Ӧ�ܾ̾�����</option>
                  <option value="3" <c:if test="${enterprise.enquiryStatus == '3'}">selected="selected"</c:if>>����</option>
                </select>
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="search();">��ѯ</button></li>
              <li><button type="button" class="btn btn-default gray" onclick="clearSearchParam();">���</button></li>
            </ul>
          </div>
        <!--.search_area--></div>
        </form>
      	<div class="search_result section">
          <table border="0">
            <tr>
              <th>��Ʒ����</th>
              <th width="60">��������</th>
              <th width="100">ѯ��ǰ��Ʒ����</th>
              <th width="100">ѯ�ۺ���Ʒ����</th>
              <th width="100">�۸���Чʱ��</th>
              <th width="100">ѯ��ʱ��</th>
              <th width="100">��Ӧ�̱���ʱ��</th>
              <th width="100">��Ӧ��</th>
              <th width="100">ѯ�۵�״̬</th>
              <th width="140" class="last">����</th>
            </tr>
            <c:forEach var="enterprise" items="${enterprises}" varStatus="status">
            <tr>
              <td>${enterprise.goodsName}��${enterprise.goodsModel}��</td>
              <td>${enterprise.goodsNum}</td>
              <td>${enterprise.goodsPriceBefore}</td>
              <td>${enterprise.goodsPriceAfter}</td>
              <td>${enterprise.priceValidDate}</td>
              <td>${enterprise.enquiryDate}</td>
              <td>${enterprise.superOfferDate}</td>
              <td>${enterprise.supName}</td>
              <c:if test="${enterprise.enquiryStatus == '0'}">
              	<td>����Ӧ�̱���</td>
              </c:if>
              <c:if test="${enterprise.enquiryStatus == '1'}">
              	<td>��Ӧ���ѱ���</td>
              </c:if>
              <c:if test="${enterprise.enquiryStatus == '2'}">
              	<td>��Ӧ�ܾ̾�����</td>
              </c:if>
              <c:if test="${enterprise.enquiryStatus == '3'}">
              	<td>����</td>
              </c:if>
             
              <td>
              <c:if test="${enterprise.enquiryStatus == '1'}">
              	<a href="javascript:void(0);" onclick="addCart('${enterprise.supID}','${enterprise.goodsID}','${enterprise.goodsNum}');">���ӹ��ﳵ</a>
              </c:if>
              	
              	<a href="javascript:void(0);" onclick="delEnterprise('${enterprise.id}');">ɾ��</a>
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