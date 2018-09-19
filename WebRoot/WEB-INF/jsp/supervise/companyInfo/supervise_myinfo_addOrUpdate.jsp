<%@ page language="java" contentType="text/html; charset=gbk"	pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../meta.jsp" >
	<jsp:param value="��ҵ���Ϲ���" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supervise_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supervise_myinfo.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/superviseCompanyMyInfo.js"></script>
</head>

<body>
<input type="hidden" id="path" value="${pageContext.request.contextPath}"/>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
		<jsp:include page="../left.jsp">
    		<jsp:param name="menu" value="myinfo" />
    	</jsp:include>
      <div id="matter_section">
      <form action="" method="post" id="submitCompanyMyInfoForm">
      	<input type="hidden" id="id" name=id value="${companyMyInfo.id}"/>
      	<input type="hidden" id="userType" name="userType" value=""/>
        <input type="hidden" id="managementType" name="managementType" value=""/>
        <input type="hidden" id="witchPage" name="witchPage" value="1"/>
        <input type="hidden" id="arseaLebelOne" name="arseaLebelOne" value=""/>
        <input type="hidden" id="arseaLebelTwo" name="arseaLebelTwo" value="${companyMyInfo.regAddrCity}"/>
        <input type="hidden" id="flg" name="flg" value="${flg}"/>
        
        
        <input type="hidden" id="companyType" name="companyType" value="${companyMyInfo.companyType}"/>
        <%-- <div id="step">
          <ul class="image_list clearfix">
            <li class="selected"><a href="#"><span class="num">1</span><span class="text">������ҵ������Ϣ</span></a></li>
            <li><a href="${pageContext.request.contextPath}/supervise/companyMyInfo?witchPage=2""><span class="num">2</span><span class="text">�ϴ���ҵ֤��</span></a></li>
            <li><a href="javascript:void(0);" <c:if test="${!empty companyMyInfo.ifCheck}">onclick="window.location.href='${pageContext.request.contextPath}/supervise/companyMyInfo?witchPage=3'"</c:if>><span class="num">3</span><span class="text">�鿴���״̬</span></a></li>          
          </ul>
            <div class="line"></div>
        </div> --%>
        <div class="section_inner clearfix">
          <div class="title">
            <h2>������ҵ������Ϣ<span>����*Ϊ�����</span></h2>
          </div>
          
          <div class="input_area">
            <dl class="clearfix role">
              <dt>�û�����</dt>
              <dd class="role_area">
                <div class="role_list clearfix">
                  <ul>
                    <li id="companyTypeLi1" <c:if test="${companyMyInfo.companyType == '1'}"> class="active"</c:if>><a href="javascript:void(0);" onclick="changeCompanyType('1');">Ͷ����/��Ӧ��</a></li>
                    <li id="companyTypeLi2" <c:if test="${companyMyInfo.companyType == '2'}"> class="active"</c:if>><a href="javascript:void(0);" onclick="changeCompanyType('2');">�б���/�ɹ���</a></li>
                  </ul>
                </div>
                <div class="attention">
                  <ul>
                    <li id="companyTypeDescLi1">Ͷ����/��Ӧ�̣�����������ƽ̨���߲����б���Ŀ/��Ӧ���ɹ�(��ҵ�ɹ�)��Ŀ��</li>
                    <li id="companyTypeDescLi2">�б���/�ɹ��ˣ�����������ƽ̨�����б�/�ɹ���Ϣ���淶������λ���б�/�ɹ�ҵ��</li>
                  </ul>
                </div>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>��ҵ����</dt>
              <dd><input type="text" class="form-control" placeholder="��������ҵ����" maxlength="64" id="companyName" name="companyName" value="${companyMyInfo.companyName}"><span class="red remind" id="errorCompanyName">��������ȷ���û���</span></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>��λ����</dt>
              <dd>
                <select class="form-control" id="companyModel" name="companyModel">
                  <c:forEach var="companyCode" items="${companyCodes}" varStatus="status">
                  	 <option value="${companyCode.codeValue}" <c:if test="${companyMyInfo.companyModel== companyCode.codeValue}">selected = "selected"</c:if>>${companyCode.codeText}</option>
                  </c:forEach>
                 
                </select>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>�û�����</dt>
              <dd>
              	<c:forEach var="userType" items="${userTypeCodes}" varStatus="status">
                	<label class="checkbox-inline"><input type="checkbox"<c:if test="${fn:contains(companyMyInfo.userType, userType.codeValue)}">checked="checked"</c:if> id="inlineCheckbox${status.index}" name="userTypes" value="${userType.codeValue}">${userType.codeText}</label>
                </c:forEach>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>���ڵ���</dt>
              <dd>
                <div class="province" id="areaDD">
                  <select class="form-control" id="regAddrProvince" name="regAddrProvince" onchange="checkCity();">
                    <option value="" <c:if test="${empty companyMyInfo.regAddrProvince}">selected = "selected"</c:if>>��ѡ��</option>
                    
                    <c:forEach var="area" items="${areas}" varStatus="status">
                  	 <option value="${area.supAreaID}" <c:if test="${companyMyInfo.regAddrProvince== area.supAreaID}">selected = "selected"</c:if>>${area.supAreaName}</option>
                    </c:forEach>
                  </select>
                </div>
                <div class="city">
                  <select class="form-control" id="regAddrCity" name="regAddrCity">
                    <option value="" selected="selected">��ѡ��</option>
                  </select>
                </div>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>��ҵ��ַ</dt>
              <dd>
                <input type="text" class="form-control" placeholder="��������ҵ��ַ" maxlength="500" id="companyWebsite" name="companyWebsite" value="${companyMyInfo.companyWebsite}">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>��λ��ַ</dt>
              <dd>
                <input type="text" class="form-control" placeholder="�����뵥λ��ַ" maxlength="128" id="address" name="address" value="${companyMyInfo.address}">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>��Ӫģʽ</dt>
              <dd>
                <c:forEach var="managementTypeCode" items="${managementTypeCodes}" varStatus="status">
                	<label class="checkbox-inline"><input type="checkbox" <c:if test="${fn:contains(companyMyInfo.managementType, managementTypeCode.codeValue)}"> checked="checked"</c:if>name="managementTypeCodes" value="${managementTypeCode.codeValue}">${managementTypeCode.codeText}</label>
                </c:forEach>
              </dd>
            </dl>
          </div>
        </div>
        <div class="section_inner clearfix">
          <div class="title">
            <h2>��ϵ����Ϣ</h2>
          </div>
          
          <div class="input_area">
            <dl class="clearfix">
              <dt><span class="red">*</span>��ϵ��</dt>
              <dd><input type="text" class="form-control" placeholder="��������ϵ��" maxlength="50" id="contactPerson" name="contactPerson" value="${companyMyInfo.contactPerson}"><!-- <span class="red remind" id="errorContactPerson">��������ȷ����ϵ��</span> --></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>�̶��绰</dt>
              <dd><input type="text" class="form-control" placeholder="������̶��绰"  maxlength="20"  id="contactTel" name="contactTel" value="${companyMyInfo.contactTel}"></dd>
            </dl>
            <dl class="clearfix role tel_area">
              <dt><span class="red">*</span>�ֻ�����</dt>
              <dd>
                <div class="input-group">
                    <input type="text" class="form-control" maxlength="20" placeholder="����д�ֻ�����" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" id="contactIphone" name="contactIphone" value="${companyMyInfo.contactIphone}">
                   
                </div>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>��������</dt>
              <dd><input type="text" class="form-control" placeholder="����ʹ�ó����ʱ�" maxlength="20"  id="contactEmail" name="contactEmail" value="${companyMyInfo.contactEmail}"></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>��ϵ�˵�ַ</dt>
              <dd><input type="text" class="form-control" placeholder="��ϵ�˵�ַ"  maxlength="200" id="contactAddress" name="contactAddress" value="${companyMyInfo.contactAddress}"></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>����������</dt>
              <dd><input type="text" class="form-control" placeholder="����������" maxlength="50" id="corporationName" name="corporationName" value="${companyMyInfo.corporationName}"></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>��������</dt>
              <dd><input type="text" class="form-control" placeholder="��������" maxlength="10" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" id="companyPostcode" name="companyPostcode" value="${companyMyInfo.companyPostcode}"></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>�����������ֻ�</dt>
              <dd><input type="text" class="form-control" placeholder="�����������ֻ�" maxlength="20" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" id="corporationIphone" name="corporationIphone" value="${companyMyInfo.corporationIphone}"></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>���������˵�λ�绰</dt>
              <dd><input type="text" class="form-control" placeholder="���������˵�λ�绰" maxlength="20" id="corporationTel" name="corporationTel" value="${companyMyInfo.corporationTel}"></dd>
            </dl>
          </div>
        <!-- .section --></div>
        <div class="section_inner clearfix">
          <div class="title">
            <h2>��������/�ɹ���������Ϣ</h2>
          </div>
          
          <div class="input_area">
            <dl class="clearfix">
              <dt>��������</dt>
              <dd><input type="text" class="form-control" placeholder="��������" maxlength="50" id="financeName" name="financeName" value="${companyMyInfo.financeName}"></dd>
            </dl>
            <dl class="clearfix">
              <dt>����������ϵ��ʽ</dt>
              <dd><input type="text" class="form-control" placeholder="����������ϵ��ʽ" maxlength="20" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" id="financeMobile" name="financeMobile" value="${companyMyInfo.financeMobile}"></dd>
            </dl>
            <dl class="clearfix">
              <dt>ҵ������</dt>
              <dd><input type="text" class="form-control" placeholder="ҵ������" maxlength="200" id="responsibleName" name="responsibleName" value="${companyMyInfo.responsibleName}"></dd>
            </dl>
            <dl class="clearfix">
              <dt>ҵ��������ϵ��ʽ</dt>
              <dd><input type="text" class="form-control" placeholder="ҵ��������ϵ��ʽ" maxlength="20" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" id="responsibleMobile" name="responsibleMobile" value="${companyMyInfo.responsibleMobile}"></dd>
            </dl>
          </div>
        </div>
        </form>
        <div class="btn_area">
          <button class="btn btn-default gray" type="button" onclick="goBack();">����</button>
          <button class="btn btn-default blue" type="button" onclick="nextPageForEdit(${addOrUpdate});">���沢��һ��</button>
        </div>
      </div>
    </div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>