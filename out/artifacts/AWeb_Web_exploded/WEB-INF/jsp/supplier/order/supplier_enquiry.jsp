<%@ page language="java" contentType="text/html; charset=gbk"	pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>��Ӧ�̹�������|�к��ɹ���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_enquiry.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierUtil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierEnquiry.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    	
    	<jsp:include page="../menu.jsp">
    		<jsp:param name="menu" value="enquiry" />
    	</jsp:include>
      <div id="matter_section">
      	<h2>ѯ�۹���</h2>
      	<form id="queryForm">
      	<div class="search_area section">
          <div class="search_list clearfix">
            <dl class="clearfix">
              <dt>��Ʒ���ƣ�</dt>
              <dd>
                <input type="text" class="form-control" name="goodsName" id="goodsName" value="${supplierGoodsEnquiryParam.goodsName}"/>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>ѯ��ʱ�䣺</dt>
              <dd>
                <ul class="clearfix">
                <li>
                  <div class="input-group">
                    <input type="text" class="form-control special_input" name="enquiryDateStar" id="enquiryDateStar" value="${supplierGoodsEnquiryParam.enquiryDateStar}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  </div>
                </li>
                <li>��</li>
                <li class="last">
                  <div class="input-group">
                    <input type="text" class="form-control special_input" name="enquiryDateEnd" id="enquiryDateEnd" value="${supplierGoodsEnquiryParam.enquiryDateEnd}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
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
                    <input type="text" class="form-control special_input" name="superOfferDateStar" id="superOfferDateStar" value="${supplierGoodsEnquiryParam.superOfferDateStar}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  </div>
                </li>
                <li>��</li>
                <li class="last">
                  <div class="input-group">
                    <input type="text" class="form-control special_input" name="superOfferDateEnd" id="superOfferDateEnd" value="${supplierGoodsEnquiryParam.superOfferDateEnd}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  </div>
                </li>
              </ul>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>����ͺţ�</dt>
              <dd>
                    <input type="text" class="form-control" name="goodsModel" id="goodsModel" value="${supplierGoodsEnquiryParam.goodsModel}"/>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>ѯ��״̬��</dt>
              <dd>
                <select class="form-control" name="enquiryStatus">
                  <option value="" <c:if test="${supplierGoodsEnquiry.enquiryStatus == '' or supplierGoodsEnquiry.enquiryStatus ==null}">selected="selected"</c:if>>ȫ��</option>
                  <option value="0" <c:if test="${supplierGoodsEnquiry.enquiryStatus == '0'}">selected="selected"</c:if>>����Ӧ�̱���</option>
                  <option value="1" <c:if test="${supplierGoodsEnquiry.enquiryStatus == '1'}">selected="selected"</c:if>>��Ӧ���ѱ���</option>
                  <option value="2" <c:if test="${supplierGoodsEnquiry.enquiryStatus == '2'}">selected="selected"</c:if>>��Ӧ�ܾ̾�����</option>
                </select>
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>�ɹ���λ��</dt>
              <dd>
                    <input type="text" class="form-control" name="companyname" id="companyname" value="${supplierGoodsEnquiryParam.companyname}"/>
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="queryEnquiry('${pageContext.request.contextPath}/supplier/goodsEnquiry')">��ѯ</button></li>
              <li><button type="button" class="btn btn-default gray" onclick="clearForm(this.form)">���</button></li>
            </ul>
          </div>
        <!--.search_area--></div>
        </form>
      	<div class="search_result section">
          <table border="0">
            <tr>
              <th width="80">�ɹ���λ</th>
              <th>��Ʒ����</th>
              <th width="100">��Ʒ�ͺ�</th>
              <th width="70">��������</th>
              <th width="80">ѯ��ǰ����</th>
              <th width="80">ѯ�ۺ󵥼�</th>
              <th width="100">ѯ��ʱ��</th>
              <th width="80">����ʱ��</th>
              <th width="100">ѯ�۵�״̬</th>
              <th width="90" class="last">����</th>
            </tr>
            <c:forEach var="supplierGoodsEnquiry" items="${supplierGoodsEnquiryList}" varStatus="status">
            <tr>
              <td>${supplierGoodsEnquiry.companyname}</td>
              <td>${supplierGoodsEnquiry.goodsName}</td>
              <td>${supplierGoodsEnquiry.goodsModel}</td>
              <td>${supplierGoodsEnquiry.goodsNum}</td>
              <td>${supplierGoodsEnquiry.goodsPriceBefore}</td>
              <td>${supplierGoodsEnquiry.goodsPriceAfter}</td>
              <td>${supplierGoodsEnquiry.enquiryDate}</td>
              <td>${supplierGoodsEnquiry.superOfferDate}</td>
              <td>
              	<c:if test="${supplierGoodsEnquiry.enquiryStatus == '0'}">����Ӧ�̱���</c:if>
              	<c:if test="${supplierGoodsEnquiry.enquiryStatus == '1'}">��Ӧ���ѱ���</c:if>
              	<c:if test="${supplierGoodsEnquiry.enquiryStatus == '2'}">��Ӧ�ܾ̾�����</c:if>
              </td>
              <td>
              	<c:if test="${supplierGoodsEnquiry.enquiryStatus == '1' or supplierGoodsEnquiry.enquiryStatus == '2'}">���� �ܾ�</c:if>
              	
              	<c:if test="${supplierGoodsEnquiry.enquiryStatus != '2' and supplierGoodsEnquiry.enquiryStatus!='1'}">
              		<a href="javascript:void(0)" onclick="opDialog('${pageContext.request.contextPath}/supplier/goodsEnquiry/enquiryPricePage/${supplierGoodsEnquiry.id}','900px','250px')">����</a>
              	<a href="javascript:void(0)" onclick="updateNoEnquiryStatus('${pageContext.request.contextPath}/supplier/goodsEnquiry/updateGoodsEnquiry','${supplierGoodsEnquiry.id}')">�ܾ�</a>
				</c:if>
              	
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
  <jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>