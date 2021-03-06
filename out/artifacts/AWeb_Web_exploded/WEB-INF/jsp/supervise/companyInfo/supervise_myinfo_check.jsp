<%@ page language="java" contentType="text/html; charset=gbk"	pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../meta.jsp" >
	<jsp:param value="企业资料管理" name="title"/>
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
            <li class="selected"><a href="#"><span class="num">1</span><span class="text">完善企业基本信息</span></a></li>
            <li><a href="${pageContext.request.contextPath}/supervise/companyMyInfo?witchPage=2""><span class="num">2</span><span class="text">上传企业证件</span></a></li>
            <li><a href="javascript:void(0);" <c:if test="${!empty companyMyInfo.ifCheck}">onclick="window.location.href='${pageContext.request.contextPath}/supervise/companyMyInfo?witchPage=3'"</c:if>><span class="num">3</span><span class="text">查看审核状态</span></a></li>          
          </ul>
            <div class="line"></div>
        </div> --%>
        <div class="section_inner clearfix">
          <div class="title">
            <h2>完善企业基本信息<span>（带*为必填项）</span></h2>
          </div>
          
          <div class="input_area">
            <dl class="clearfix role">
              <dt>用户身份</dt>
              <dd class="role_area">
                <div class="role_list clearfix">
                  <ul>
                  	<c:if test="${companyMyInfo.companyType=='1'}">
                  		<li class="active"><a href="javascript:void(0);">投标人/供应商</a></li>
                  	</c:if>
                    <c:if test="${companyMyInfo.companyType=='2'}">
                   	 <li class="active"><a href="javascript:void(0);">招标人/采购人</a></li>
                    </c:if>
                  </ul>
                </div>
                <div class="attention">
                  <ul>
                  	<c:if test="${companyMyInfo.companyType=='1'}">
                    	<li>1、投标人/供应商：您可以利用平台在线参与招标项目/供应链采购(企业采购)项目。</li>
                    </c:if>
                    <c:if test="${companyMyInfo.companyType=='2'}">
                    	<li>1、招标人/采购人：您可以利用平台发布招标/采购信息，规范管理单位的招标/采购业务。</li>
                    </c:if>
                  </ul>
                </div>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>企业名称</dt>
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="请输入企业名称" maxlength="64" id="companyName" name="companyName" value="${companyMyInfo.companyName}"><span class="red remind" id="errorCompanyName">请输入正确的用户名</span></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>单位类型</dt>
              <dd>
                <select class="form-control" id="companyModel" name="companyModel" disabled="disabled">
                  <c:forEach var="companyCode" items="${companyCodes}" varStatus="status">
                  	 <option value="${companyCode.codeValue}" <c:if test="${companyMyInfo.companyModel== companyCode.codeValue}">selected = "selected"</c:if>>${companyCode.codeText}</option>
                  </c:forEach>
                 
                </select>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>用户类型</dt>
              <dd>
              	<c:forEach var="userType" items="${userTypeCodes}" varStatus="status">
                	<label class="checkbox-inline"><input type="checkbox"  disabled="disabled" <c:if test="${fn:contains(companyMyInfo.userType, userType.codeValue)}">checked="checked"</c:if> id="inlineCheckbox${status.index}" name="userTypes" value="${userType.codeValue}">${userType.codeText}</label>
                </c:forEach>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>所在地区</dt>
              <dd>
                <div class="province" id="areaDD">
                  <select class="form-control" disabled="disabled" id="regAddrProvince" name="regAddrProvince" onchange="checkCity();">
                    <option value="" <c:if test="${empty companyMyInfo.regAddrProvince}">selected = "selected"</c:if>>请选择</option>
                    
                    <c:forEach var="area" items="${areas}" varStatus="status">
                  	 <option value="${area.supAreaID}" <c:if test="${companyMyInfo.regAddrProvince== area.supAreaID}">selected = "selected"</c:if>>${area.supAreaName}</option>
                    </c:forEach>
                  </select>
                </div>
                <div class="city">
                  <select class="form-control" disabled="disabled" id="regAddrCity" name="regAddrCity">
                    <option value="" selected="selected">请选择</option>
                  </select>
                </div>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>企业网址</dt>
              <dd>
                <input type="text" class="form-control" readonly="readonly" placeholder="请输入企业网址" maxlength="500" id="companyWebsite" name="companyWebsite" value="${companyMyInfo.companyWebsite}">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>单位地址</dt>
              <dd>
                <input type="text" class="form-control" readonly="readonly" placeholder="请输入单位地址" maxlength="128" id="address" name="address" value="${companyMyInfo.address}">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>经营模式</dt>
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
            <h2>联系人信息</h2>
          </div>
          
          <div class="input_area">
            <dl class="clearfix">
              <dt><span class="red">*</span>联系人</dt>
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="请输入联系人" maxlength="50" id="contactPerson" name="contactPerson" value="${companyMyInfo.contactPerson}"><!-- <span class="red remind" id="errorContactPerson">请输入正确的联系人</span> --></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>固定电话</dt>
              <dd><input type="text" class="form-control" readonly="readonly"  placeholder="请输入固定电话"  maxlength="20"  id="contactTel" name="contactTel" value="${companyMyInfo.contactTel}"></dd>
            </dl>
            <dl class="clearfix role tel_area">
              <dt><span class="red">*</span>手机号码</dt>
              <dd>
                <div class="input-group">
                    <!-- <div class="input-group-btn tel_num">
                      <label>中国 0086</label>
                      <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <b class="caret"></b>
                      </a>
                      <ul class="dropdown-menu">
                        <li><a href="#">中国 +86</a></li>
                        <li><a>台湾 +886</a> </li>
                        <li><a>香港 +852</a> </li>
                        <li><a>马来西亚 +60</a> </li>
                        <li><a>新加坡 +65</a> </li>
                        <li><a>日本 +81</a> </li>
                        <li><a>韩国 +82</a> </li>
                        <li><a>美国 +1</a> </li>
                        <li><a>加拿大 +1</a> </li>
                        <li><a>澳大利亚 +61</a> </li>
                        <li><a>新西兰 +64</a> </li>
                        <li><a>阿联酋 +791</a> </li>
                        <li><a>安哥拉 +244</a> </li>
                        <li><a>澳门 +853</a> </li>
                        <li><a>巴西 +55</a> </li>
                        <li><a>丹麦 +45</a> </li>
                        <li><a>德国 +49</a> </li>
                        <li><a>俄罗斯 +7</a> </li>
                        <li><a>法国 +33</a> </li>
                        <li><a>菲律宾 +63</a> </li>
                        <li><a>芬兰 +358</a> </li>
                        <li><a>荷兰 +31</a> </li>
                        <li><a>捷克 +420</a> </li>
                        <li><a>瑞士 +41</a> </li>
                        <li><a>瑞典 +46</a> </li>
                        <li><a>泰国 +66</a> </li>
                        <li><a>委内瑞拉 +58</a> </li>
                        <li><a>西班牙 +34</a> </li>
                        <li><a>意大利 +39</a> </li>
                        <li><a>印度 +91</a> </li>
                        <li><a>印度尼西亚 +62</a> </li>
                        <li><a>英国 +44</a> </li>
                        <li><a>越南 +84</a> </li>
                      </ul>
                    </div> -->
                    <input type="text" class="form-control" readonly="readonly" maxlength="20" placeholder="请填写手机号码" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" id="contactIphone" name="contactIphone" value="${companyMyInfo.contactIphone}">
                   
                </div>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>电子邮箱</dt>
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="建议使用常用邮编" maxlength="20"  id="contactEmail" name="contactEmail" value="${companyMyInfo.contactEmail}"></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>联系人地址</dt>
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="联系人地址"  maxlength="200" id="contactAddress" name="contactAddress" value="${companyMyInfo.contactAddress}"></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>法定代表人</dt>
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="法定代表人" maxlength="50" id="corporationName" name="corporationName" value="${companyMyInfo.corporationName}"></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>邮政编码</dt>
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="邮政编码" maxlength="10" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" id="companyPostcode" name="companyPostcode" value="${companyMyInfo.companyPostcode}"></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>法定代表人手机</dt>
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="法定代表人手机" maxlength="20" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" id="corporationIphone" name="corporationIphone" value="${companyMyInfo.corporationIphone}"></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>法定代表人单位电话</dt>
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="法定代表人单位电话" maxlength="20" id="corporationTel" name="corporationTel" value="${companyMyInfo.corporationTel}"></dd>
            </dl>
          </div>
        <!-- .section --></div>
        <div class="section_inner clearfix">
          <div class="title">
            <h2>财务负责人/采购负责人信息</h2>
          </div>
          
          <div class="input_area">
            <dl class="clearfix">
              <dt>财务负责人</dt>
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="财务负责人" maxlength="50" id="financeName" name="financeName" value="${companyMyInfo.financeName}"></dd>
            </dl>
            <dl class="clearfix">
              <dt>财务负责人联系方式</dt>
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="财务负责人联系方式" maxlength="20" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" id="financeMobile" name="financeMobile" value="${companyMyInfo.financeMobile}"></dd>
            </dl>
            <dl class="clearfix">
              <dt>业务负责人</dt>
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="业务负责人" maxlength="200" id="responsibleName" name="responsibleName" value="${companyMyInfo.responsibleName}"></dd>
            </dl>
            <dl class="clearfix">
              <dt>业务负责人联系方式</dt>
              <dd><input type="text" class="form-control" readonly="readonly" placeholder="业务负责人联系方式" maxlength="20" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" id="responsibleMobile" name="responsibleMobile" value="${companyMyInfo.responsibleMobile}"></dd>
            </dl>
          </div>
        </div>
        </form>
        <div class="btn_area">
          <button class="btn btn-default blue" type="button" onclick="back();">返回</button>
          <button class="btn btn-default blue" type="button" onclick="next('${companyMyInfo.id}');">下一步</button>
        </div>
      </div>
    </div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>