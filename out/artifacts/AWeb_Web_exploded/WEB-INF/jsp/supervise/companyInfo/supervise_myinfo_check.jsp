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
<input type="hidden" id="flg" name="flg" value="${flg}"/>
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
        
        <input type="hidden" id="arseaLebelTwo" name="arseaLebelTwo" value="${companyMyInfo.regAddrCity}"/>
      
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
                  	<c:if test="${companyMyInfo.companyType=='1'}">
                  		<li class="active"><a href="javascript:void(0);">Ͷ����/��Ӧ��</a></li>
                  	</c:if>
                    <c:if test="${companyMyInfo.companyType=='2'}">
                   	 <li class="active"><a href="javascript:void(0);">�б���/�ɹ���</a></li>
                    </c:if>
                  </ul>
                </div>
                <div class="attention">
                  <ul>
                  	<c:if test="${companyMyInfo.companyType=='1'}">
                    	<li>1��Ͷ����/��Ӧ�̣�����������ƽ̨���߲����б���Ŀ/��Ӧ���ɹ�(��ҵ�ɹ�)��Ŀ��</li>
                    </c:if>
                    <c:if test="${companyMyInfo.companyType=='2'}">
                    	<li>1���б���/�ɹ��ˣ�����������ƽ̨�����б�/�ɹ���Ϣ���淶������λ���б�/�ɹ�ҵ��</li>
                    </c:if>
                  </ul>
                </div>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>��ҵ����</dt>
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="��������ҵ����" maxlength="64" id="companyName" name="companyName" value="${companyMyInfo.companyName}"><span class="red remind" id="errorCompanyName">��������ȷ���û���</span></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>��λ����</dt>
              <dd>
                <select class="form-control" id="companyModel" name="companyModel" disabled="disabled">
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
                	<label class="checkbox-inline"><input type="checkbox"  disabled="disabled" <c:if test="${fn:contains(companyMyInfo.userType, userType.codeValue)}">checked="checked"</c:if> id="inlineCheckbox${status.index}" name="userTypes" value="${userType.codeValue}">${userType.codeText}</label>
                </c:forEach>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>���ڵ���</dt>
              <dd>
                <div class="province" id="areaDD">
                  <select class="form-control" disabled="disabled" id="regAddrProvince" name="regAddrProvince" onchange="checkCity();">
                    <option value="" <c:if test="${empty companyMyInfo.regAddrProvince}">selected = "selected"</c:if>>��ѡ��</option>
                    
                    <c:forEach var="area" items="${areas}" varStatus="status">
                  	 <option value="${area.supAreaID}" <c:if test="${companyMyInfo.regAddrProvince== area.supAreaID}">selected = "selected"</c:if>>${area.supAreaName}</option>
                    </c:forEach>
                  </select>
                </div>
                <div class="city">
                  <select class="form-control" disabled="disabled" id="regAddrCity" name="regAddrCity">
                    <option value="" selected="selected">��ѡ��</option>
                  </select>
                </div>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>��ҵ��ַ</dt>
              <dd>
                <input type="text" class="form-control" readonly="readonly" placeholder="��������ҵ��ַ" maxlength="500" id="companyWebsite" name="companyWebsite" value="${companyMyInfo.companyWebsite}">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>��λ��ַ</dt>
              <dd>
                <input type="text" class="form-control" readonly="readonly" placeholder="�����뵥λ��ַ" maxlength="128" id="address" name="address" value="${companyMyInfo.address}">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>��Ӫģʽ</dt>
              <dd>
                <c:forEach var="managementTypeCode" items="${managementTypeCodes}" varStatus="status">
                	<label class="checkbox-inline"><input type="checkbox" disabled="disabled" <c:if test="${fn:contains(companyMyInfo.managementType, managementTypeCode.codeValue)}"> checked="checked"</c:if>name="managementTypeCodes" value="${managementTypeCode.codeValue}">${managementTypeCode.codeText}</label>
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
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="��������ϵ��" maxlength="50" id="contactPerson" name="contactPerson" value="${companyMyInfo.contactPerson}"><!-- <span class="red remind" id="errorContactPerson">��������ȷ����ϵ��</span> --></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>�̶��绰</dt>
              <dd><input type="text" class="form-control" readonly="readonly"  placeholder="������̶��绰"  maxlength="20"  id="contactTel" name="contactTel" value="${companyMyInfo.contactTel}"></dd>
            </dl>
            <dl class="clearfix role tel_area">
              <dt><span class="red">*</span>�ֻ�����</dt>
              <dd>
                <div class="input-group">
                    <!-- <div class="input-group-btn tel_num">
                      <label>�й� 0086</label>
                      <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <b class="caret"></b>
                      </a>
                      <ul class="dropdown-menu">
                        <li><a href="#">�й� +86</a></li>
                        <li><a>̨�� +886</a> </li>
                        <li><a>��� +852</a> </li>
                        <li><a>�������� +60</a> </li>
                        <li><a>�¼��� +65</a> </li>
                        <li><a>�ձ� +81</a> </li>
                        <li><a>���� +82</a> </li>
                        <li><a>���� +1</a> </li>
                        <li><a>���ô� +1</a> </li>
                        <li><a>�Ĵ����� +61</a> </li>
                        <li><a>������ +64</a> </li>
                        <li><a>������ +791</a> </li>
                        <li><a>������ +244</a> </li>
                        <li><a>���� +853</a> </li>
                        <li><a>���� +55</a> </li>
                        <li><a>���� +45</a> </li>
                        <li><a>�¹� +49</a> </li>
                        <li><a>����˹ +7</a> </li>
                        <li><a>���� +33</a> </li>
                        <li><a>���ɱ� +63</a> </li>
                        <li><a>���� +358</a> </li>
                        <li><a>���� +31</a> </li>
                        <li><a>�ݿ� +420</a> </li>
                        <li><a>��ʿ +41</a> </li>
                        <li><a>��� +46</a> </li>
                        <li><a>̩�� +66</a> </li>
                        <li><a>ί������ +58</a> </li>
                        <li><a>������ +34</a> </li>
                        <li><a>����� +39</a> </li>
                        <li><a>ӡ�� +91</a> </li>
                        <li><a>ӡ�������� +62</a> </li>
                        <li><a>Ӣ�� +44</a> </li>
                        <li><a>Խ�� +84</a> </li>
                      </ul>
                    </div> -->
                    <input type="text" class="form-control" readonly="readonly" maxlength="20" placeholder="����д�ֻ�����" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" id="contactIphone" name="contactIphone" value="${companyMyInfo.contactIphone}">
                   
                </div>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>��������</dt>
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="����ʹ�ó����ʱ�" maxlength="20"  id="contactEmail" name="contactEmail" value="${companyMyInfo.contactEmail}"></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>��ϵ�˵�ַ</dt>
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="��ϵ�˵�ַ"  maxlength="200" id="contactAddress" name="contactAddress" value="${companyMyInfo.contactAddress}"></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>����������</dt>
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="����������" maxlength="50" id="corporationName" name="corporationName" value="${companyMyInfo.corporationName}"></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>��������</dt>
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="��������" maxlength="10" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" id="companyPostcode" name="companyPostcode" value="${companyMyInfo.companyPostcode}"></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>�����������ֻ�</dt>
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="�����������ֻ�" maxlength="20" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" id="corporationIphone" name="corporationIphone" value="${companyMyInfo.corporationIphone}"></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>���������˵�λ�绰</dt>
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="���������˵�λ�绰" maxlength="20" id="corporationTel" name="corporationTel" value="${companyMyInfo.corporationTel}"></dd>
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
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="��������" maxlength="50" id="financeName" name="financeName" value="${companyMyInfo.financeName}"></dd>
            </dl>
            <dl class="clearfix">
              <dt>����������ϵ��ʽ</dt>
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="����������ϵ��ʽ" maxlength="20" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" id="financeMobile" name="financeMobile" value="${companyMyInfo.financeMobile}"></dd>
            </dl>
            <dl class="clearfix">
              <dt>ҵ������</dt>
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="ҵ������" maxlength="200" id="responsibleName" name="responsibleName" value="${companyMyInfo.responsibleName}"></dd>
            </dl>
            <dl class="clearfix">
              <dt>ҵ��������ϵ��ʽ</dt>
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="ҵ��������ϵ��ʽ" maxlength="20" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" id="responsibleMobile" name="responsibleMobile" value="${companyMyInfo.responsibleMobile}"></dd>
            </dl>
          </div>
        </div>
        </form>
        <div class="btn_area">
          <button class="btn btn-default blue" type="button" onclick="back();">����</button>
          <button class="btn btn-default blue" type="button" onclick="next('${companyMyInfo.id}');">��һ��</button>
        </div>
      </div>
    </div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>