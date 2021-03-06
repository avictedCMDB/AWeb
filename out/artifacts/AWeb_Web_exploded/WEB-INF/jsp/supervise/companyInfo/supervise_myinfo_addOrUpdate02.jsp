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
<link href="${pageContext.request.contextPath}/static/css/viewer/Viewer.min.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/superviseCompanyMyInfo.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/viewer/viewer.min.js"></script>
<script type="text/javascript">
function changeRadio(radio){
	if (radio.value == 1) {
		$("#noArea").hide();
		$("#yesArea").show();
		$("#ifCreditCode").val("1");
	}else{
		$("#yesArea").hide();
		$("#noArea").show();
		$("#socialCreditCode").val("");
		$("#ifCreditCode").val("2");
	}
}

</script>
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
    <form action="" method="post" id="submitCompanyMyInfoForm2">
    	<input type="hidden" id="witchPage" name="witchPage" value="3"/>
    	<input type="hidden" id="id" name=id value="${companyMyInfo.id}"/>
    	<input type="hidden" id="fileTye" name="fileType" value=""/>
    	<input type="hidden" id="licenceName" name="licenceName" value="${companyMyInfo.licenceName}"/>
    	<input type="hidden" id="licenceFile" name="licenceFile" value="${companyMyInfo.licenceFile}"/>
    	<input type="hidden" id="organizationName" name="organizationName" value="${companyMyInfo.organizationName}"/>
    	<input type="hidden" id="organizationFile" name="organizationFile" value="${companyMyInfo.organizationFile}"/>
    	<input type="hidden" id="taxName" name="taxName" value="${companyMyInfo.taxName}"/>
    	<input type="hidden" id="taxFile" name="taxFile" value="${companyMyInfo.taxFile}"/>
    	<input type="hidden" id="bankFileName" name="bankFileName" value="${companyMyInfo.bankFileName}"/>
    	<input type="hidden" id="bankFile" name="bankFile" value="${companyMyInfo.bankFile}"/>
    	<input type="hidden" id="quFileName" name="quFileName" value="${companyMyInfo.quFileName}"/>
    	<input type="hidden" id="quFile" name="quFile" value="${companyMyInfo.quFile}"/>
    	<input type="hidden" id="securityFileName" name="securityFileName" value="${companyMyInfo.securityFileName}"/>
    	<input type="hidden" id="securityFile" name="securityFile" value="${companyMyInfo.securityFile}"/>
    	<input type="hidden" id="importAndExportFileName" name="importAndExportFileName" value="${companyMyInfo.importAndExportFileName}"/>
    	<input type="hidden" id="importAndExportFile" name="importAndExportFile" value="${companyMyInfo.importAndExportFile}"/>
    	<input type="hidden" id="businessFileName" name="businessFileName" value="${companyMyInfo.businessFileName}"/>
    	<input type="hidden" id="businessFile" name="businessFile" value="${companyMyInfo.businessFile}"/>
    	
    	<input type="hidden" id="companyDetail" name="companyDetail" value="${companyMyInfo.companyDetail}"/>
    	<input type="hidden" id="regFund" name="regFund" value="${companyMyInfo.regFund}"/>
    	<input type="hidden" id="ifCreditCode" name="ifCreditCode" value="${companyMyInfo.ifCreditCode}"/>
    
    
      <div id="matter_section">
       <%--  <div id="step">
          <ul class="image_list clearfix">
            <li><a href="${pageContext.request.contextPath}/supervise/companyMyInfo"><span class="num">1</span><span class="text">完善企业基本信息</span></a></li>
            <li class="selected"><a href="#"><span class="num">2</span><span class="text">上传企业证件</span></a></li>
            <li><a href="javascript:void(0);" <c:if test="${!empty companyMyInfo.ifCheck}">onclick="window.location.href='${pageContext.request.contextPath}/supervise/companyMyInfo?witchPage=3'"</c:if>><span class="num">3</span><span class="text">查看审核状态</span></a></li>          
          </ul>
          <div class="line"></div>      
        </div> --%>
        <div class="attention02">
          <p>扫描件上传说明</p>
          <ul>
            <li>1. 企业证件需上传<span class="red">彩色原件</span></li>
            <li>2. 请确保您注册的<span class="red">企业名称与上传证件的名称一致</span></li>
            <li>3. 扫描件支持JPG,PNG,BMP,JPEG式，文件最大不超过5M。</li>
            <li>4. 请保证扫描件内容的清晰度，能够正常识别。</li>
          </ul>
        </div>
        <div class="section_inner clearfix section_step">
          <div class="title">
            <h2>上传企业三证<span>（带*为必填项）</span></h2>
          </div>
          <div class="input_area">
            <dl class="clearfix">
              <dt><span class="red">*</span>是否统一社会信用代码</dt>
              <dd class="role_area">
                <label class="checkbox-inline">
                  <input type="radio" name="optionsRadiosinline" value="1" <c:if test="${empty companyMyInfo.ifCreditCode || companyMyInfo.ifCreditCode == '1'}">checked="checked"</c:if>  onchange="changeRadio(this)"/>是
                </label>
                <label class="checkbox-inline">
                  <input type="radio" name="optionsRadiosinline" value="2"<c:if test="${companyMyInfo.ifCreditCode == '2'}">checked="checked"</c:if> onchange="changeRadio(this)"/>否
                </label>
              </dd>
            </dl>
            <!-- 选择是显示的内容 -->
            <div class="yes_area" id="yesArea">
              <dl class="clearfix">
                <dt><span class="red">*</span>统一社会信用代码</dt>
                <dd><input type="text" class="form-control" maxlength="50" placeholder="统一社会信用代码" onkeyup="this.value=this.value.replace(/[^\w\.\/]/ig,'')"  onafterpaste="this.value=this.value.replace(/[^\w\.\/]/ig,'')" id="socialCreditCode" name="socialCreditCode" value="${companyMyInfo.socialCreditCode}"><!-- <span class="red remind">统一社会信用代码</span> --></dd>
              </dl>
              <dl class="clearfix">
                <dt><span class="red">*</span>注册资金</dt>
                <dd>
                  <div class="money_input"><input type="text" class="form-control" maxlength="50" onkeyup="if(isNaN(value))execCommand('undo')"  onafterpaste="if(isNaN(value))execCommand('undo')" id="regFund1" name="regFund1" value="${companyMyInfo.regFund}"></div>
                  <div class="unit">
                    <select class="form-control" id="yuan1" name="yuan1">
                      <option value="1">元</option>
                      <!-- <option value="2">万元</option> -->
                    </select>
                  </div>
                  <div class="unit">
                    <select class="form-control" id="ut1">
                      <option value="1">人民币</option>
                      <!-- <option value="2">美元</option>
                      <option value="3">欧元</option>
                      <option value="4">日元</option>
                      <option value="5">港币</option>
                      <option value="6">台币</option> -->
                    </select>
                  </div>
                  <div class="nothing">
                    <label class="checkbox-inline"><input type="checkbox" id="noRegFund1" value="noRegFund1" onclick="clearRegFund('1');">无注册资金</label>
                  </div>
                </dd>
              </dl>
              <dl class="clearfix">
                <dt><span class="red">*</span>经营范围</dt>
                <dd>
                  <textarea class="form-control" rows="3" maxlength="2000" id="companyDetail1" name="companyDetail1">${companyMyInfo.companyDetail}</textarea>
                </dd>
              </dl>
                <dl class="clearfix">
                  <dt><span class="red">*</span>营业执照扫描件</dt>
                  <dd>
                    <div class="up_button" id="uploadLicenceFileDiv1" <c:if test="${!empty companyMyInfo.licenceName}"> style="display: none;"</c:if>>
                      <a href="javascript:void(0);">上传<input class="form-control" type="file" id="licenceFileUpload1" name="file" onchange="ajaxFileUpload('1','licenceFileUpload1');"></a>
                    </div>
                    <div class="diplay_area" <c:if test="${empty companyMyInfo.licenceName}"> style="display: none;"</c:if> id="showLicenceFileDiv">
                      <span id="licenceSpan">
                      	<img id="licenceViewerImg1" height="50" width="50" data-original="${pageContext.request.contextPath}${companyMyInfo.licenceFile}" src="${pageContext.request.contextPath}${companyMyInfo.licenceFile}" alt="">
                      </span>
                      <input style="display:none" type="file" id="licenceFileUpload2" name="file" onchange="ajaxFileUpload('1','licenceFileUpload2');">
                      <!-- <a href="javascript:void(0);" onclick="showFile('1');">查看</a> --><a href="javascript:void(0);" onclick="$('input[id=licenceFileUpload2]').click();">修改</a><a href="javascript:void(0);" onclick="delFile('1');">删除</a>
                    </div>
                  </dd>
                </dl>
            </div>
            <!-- 选择否显示的内容 -->
            <div class="no_area" id="noArea" style="display:none;">
              <div class="paper clearfix">
                <dl class="clearfix">
                  <dt><span class="red">*</span>组织机构代码证</dt>
                  <dd><input type="text" class="form-control" maxlength="50" onkeyup="this.value=this.value.replace(/[^\w\.\/]/ig,'')"  onafterpaste="this.value=this.value.replace(/[^\w\.\/]/ig,'')" id="organizationCode" name="organizationCode" value="${companyMyInfo.organizationCode}"></dd>
                </dl>
                <dl class="clearfix">
                  <dt><span class="red">*</span>组织机构代码证扫描件</dt>
                  <dd>
                    <div class="up_button"  id="uploadOrganizationFileDiv" <c:if test="${!empty companyMyInfo.organizationName}"> style="display: none;"</c:if>>
                      <a href="javascript:void(0);">上传<input class="form-control" type="file" id="organizationFileUpload1" name="file" onchange="ajaxFileUpload('2','organizationFileUpload1');"></a>
                    </div>
                    <div class="diplay_area"  id="showOrganizationFileDiv" <c:if test="${empty companyMyInfo.organizationName}"> style="display: none;"</c:if>>
                      <span id="organizationSpan">
                      	<img id="organizationViewerImg" height="50" width="50" data-original="${pageContext.request.contextPath}${companyMyInfo.organizationFile}" src="${pageContext.request.contextPath}${companyMyInfo.organizationFile}" alt="">
                      </span>
                      <input style="display:none" type="file" name="file" id="organizationFileUpload2" onchange="ajaxFileUpload('2','organizationFileUpload2');">
                      <!-- <a href="javascript:void(0);" onclick="showFile('2');">查看</a> --><a href="javascript:void(0);" onclick="$('input[id=organizationFileUpload2]').click();">修改</a><a href="javascript:void(0);" onclick="delFile('2');">删除</a>
                    </div>
                  </dd>
                </dl>
              </div>
              <div class="paper clearfix">
                <dl class="clearfix">
                  <dt><span class="red">*</span>营业执照号码</dt>
                  <dd><input type="text" class="form-control" max="50" onkeyup="this.value=this.value.replace(/[^\w\.\/]/ig,'')"  onafterpaste="this.value=this.value.replace(/[^\w\.\/]/ig,'')" id="licenceCode" name="licenceCode" value="${companyMyInfo.licenceCode}"></dd>
                </dl>
                <dl class="clearfix">
                  <dt><span class="red">*</span>注册资金</dt>
                  <dd>
                    <div class="money_input"><input type="text" class="form-control" maxlength="50" onkeyup="if(isNaN(value))execCommand('undo')"  onafterpaste="if(isNaN(value))execCommand('undo')" id="regFund2" name="regFund2" value="${companyMyInfo.regFund}"></div>
                    <div class="unit">
                      <select class="form-control" id="yuan2">
                        <option value="1">元</option>
                        <option value="2">万元</option>
                      </select>
                    </div>
                    <div class="unit">
                      <select class="form-control" id="ut2">
                        <option value="1">人民币</option>
                        <!-- <option value="2">美元</option>
                        <option value="3">欧元</option>
                        <option value="4">日元</option>
                        <option value="5">港币</option>
                        <option value="6">台币</option> -->
                      </select>
                    </div>
                    <div class="nothing">
                      <label class="checkbox-inline"><input type="checkbox" id="noRegFund2" value="noRegFund2" onclick="clearRegFund('2');">无注册资金</label>
                    </div>
                  </dd>
                </dl>
                <dl class="clearfix">
                  <dt><span class="red">*</span>经营范围</dt>
                  <dd>
                    <textarea class="form-control" rows="3" maxlength="2000" id="companyDetail2" name="companyDetail2">${companyMyInfo.companyDetail}</textarea>
                  </dd>
                </dl>
                <dl class="clearfix">
                  <dt><span class="red">*</span>营业执照扫描件</dt>
                  <dd>
                    <div class="up_button" id="uploadLicenceFileDiv2" <c:if test="${!empty companyMyInfo.licenceName}"> style="display: none;"</c:if>>
                      <a href="javascript:void(0);">上传<input class="form-control" type="file" id="licenceFileUpload" name="file" onchange="ajaxFileUpload('1','licenceFileUpload');"></a>
                    </div>
                    <div class="diplay_area" <c:if test="${empty companyMyInfo.licenceName}"> style="display: none;"</c:if> id="showLicenceFileDiv2">
                      <span id="licenceSpan2">
                      	<img id="licenceViewerImg2" height="50" width="50" data-original="${pageContext.request.contextPath}${companyMyInfo.licenceFile}" src="${pageContext.request.contextPath}${companyMyInfo.licenceFile}" alt="">
                      </span>
                      <input style="display:none" type="file" id="licenceFileUpload3" name="file" onchange="ajaxFileUpload('1','licenceFileUpload3');">
                      <!-- <a href="javascript:void(0);" onclick="showFile('1');">查看</a> --><a href="javascript:void(0);" onclick="$('input[id=licenceFileUpload3]').click();">修改</a><a href="javascript:void(0);" onclick="delFile('1');">删除</a>
                    </div>
                  </dd>
                </dl>
              </div>
              <div class="paper clearfix paper_last">
                <dl class="clearfix">
                  <dt><span class="red">*</span>税务登记证号码</dt>
                  <dd><input type="text" class="form-control" maxlength="50" onkeyup="this.value=this.value.replace(/[^\w\.\/]/ig,'')"  onafterpaste="this.value=this.value.replace(/[^\w\.\/]/ig,'')" id="taxCode" name="taxCode" value="${companyMyInfo.taxCode}"></dd>
                </dl>
                <dl class="clearfix">
                  <dt><span class="red">*</span>税务登记证号码扫描件</dt>
                  <dd>
                    <div class="up_button" id="uploadTaxFileDiv" <c:if test="${!empty companyMyInfo.taxName}"> style="display: none;"</c:if>>
                      <a href="javascript:void(0);">上传<input class="form-control"  type="file" id="taxFileUpload" name="file" onchange="ajaxFileUpload('3','taxFileUpload');"></a>
                    </div>
                    <div class="diplay_area" id="showTaxFileDiv" <c:if test="${empty companyMyInfo.taxName}"> style="display: none;"</c:if>>
                      <span id="taxSpan">
                      	<img id="taxViewerImg" height="50" width="50" data-original="${pageContext.request.contextPath}${companyMyInfo.taxFile}" src="${pageContext.request.contextPath}${companyMyInfo.taxFile}" alt="">
                      </span>
                      <input style="display:none" type="file" id="taxFileUpload2" name="file" onchange="ajaxFileUpload('3','taxFileUpload2');">
                      <!-- <a href="javascript:void(0);">查看</a> --><a href="javascript:void(0);" onclick="$('input[id=taxFileUpload2]').click();">修改</a><a href="javascript:void(0);" onclick="delFile('3');">删除</a>
                    </div>
                  </dd>
                </dl>
              </div>
            </div>
          </div>
        </div>
        <div class="section_inner clearfix section_step">
          <div class="title">
            <h2>开户许可证</h2>
          </div>
          <div class="input_area">
            <dl class="clearfix">
              <dt><span class="red">*</span>开户银行</dt>
              <dd><input type="text" class="form-control" maxlength="100" id="bankName" name="bankName" value="${companyMyInfo.bankName}"></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>银行基本户账号</dt>
              <dd><input type="text" class="form-control" maxlength="50" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" id="bankCode" name="bankCode" value="${companyMyInfo.bankCode}"></dd>
            </dl>
            <dl class="clearfix">
              <dt><span class="red">*</span>开户许可证扫描件</dt>
              <dd>
                <div class="up_button" id="uploadBankFileDiv" <c:if test="${!empty companyMyInfo.bankFileName}"> style="display: none;"</c:if>>
                  <a href="javascript:void(0);">上传<input class="form-control" type="file" id="bankFileUpload" name="file" onchange="ajaxFileUpload('4','bankFileUpload');"></a>
                </div>
                <div class="diplay_area" id="showBankFileDiv" <c:if test="${empty companyMyInfo.bankFileName}"> style="display: none;"</c:if>>
                  <span id="bankSpan">
                  	<img id="bankViewerImg" height="50" width="50" data-original="${pageContext.request.contextPath}${companyMyInfo.bankFile}" src="${pageContext.request.contextPath}${companyMyInfo.bankFile}" alt="">
                  </span>
                  <input style="display:none" type="file" id="bankFileUpload2" name="file" onchange="ajaxFileUpload('4','bankFileUpload2');">
                    <!-- <a href="javascript:void(0);">查看</a> --><a href="javascript:void(0);" onclick="$('input[id=bankFileUpload2]').click();">修改</a><a href="javascript:void(0);" onclick="delFile('4');">删除</a>
                </div>
              </dd>
            </dl>
            
          </div>
        <!-- .section --></div>
        <div class="section_inner clearfix section_step">
          <div class="title">
            <h2>资信证书<span>（资信等级是银行等单位开具的信用等级证明，如没有可以不用上传。）</span></h2>
          </div>
          <div class="input_area">
            <dl class="clearfix">
              <dt>资信等级</dt>
              <dd><input type="text" class="form-control" maxlength="100" onkeyup="this.value=this.value.replace(/[^\w\.\/]/ig,'')"  onafterpaste="this.value=this.value.replace(/[^\w\.\/]/ig,'')" id="quLevel" name="quLevel" value="${companyMyInfo.quLevel}"></dd>
            </dl>
            <dl class="clearfix">
              <dt>资信证书颁发单位</dt>
              <dd><input type="text" class="form-control" maxlength="200" id="quCompany" name="quCompany" value="${companyMyInfo.quCompany}"></dd>
            </dl>
            <dl class="clearfix">
              <dt>资信证书扫描件</dt>
              <dd>
                <div class="up_button" id="uploadQuFileDiv" <c:if test="${!empty companyMyInfo.quFileName}"> style="display: none;"</c:if>>
                  <a href="javascript:void(0);">上传<input class="form-control" type="file" id="quFileUpload" name="file" onchange="ajaxFileUpload('5','quFileUpload');"></a>
                </div>
                <div class="diplay_area" id="showQuFileDiv" <c:if test="${empty companyMyInfo.quFileName}"> style="display: none;"</c:if>>
                  <span id="quSpan">
                  	<img id="quViewerImg" height="50" width="50" data-original="${pageContext.request.contextPath}${companyMyInfo.quFile}" src="${pageContext.request.contextPath}${companyMyInfo.quFile}" alt="">
                  </span>
                  	<input style="display:none" type="file" id="quFileUpload2" name="file" onchange="ajaxFileUpload('5','quFileUpload2');">
                    <!-- <a href="javascript:void(0);">查看</a> --><a href="javascript:void(0);" onclick="$('input[id=quFileUpload2]').click();">修改</a><a href="javascript:void(0);" onclick="delFile('5');">删除</a>
                </div>
              </dd>
            </dl>
            
          </div>
        <!-- .section --></div>
        <div class="section_inner clearfix section_step">
          <div class="title">
            <h2>其他证件<span>（工程类企业必须上传安全生产许可证）</span></h2>
          </div>
          <div class="input_area">
            <dl class="clearfix">
              <dt>安全生产许可证扫描件</dt>
              <dd>
                <div class="up_button" id="uploadSecurityFileDiv" <c:if test="${!empty companyMyInfo.securityFileName}"> style="display: none;"</c:if>>
                  <a href="javascript:void(0);">上传<input class="form-control" type="file" id="securityFileUpload" name="file" onchange="ajaxFileUpload('6','securityFileUpload');"></a>
                </div>
                <div class="diplay_area" id="showSecurityFileDiv" <c:if test="${empty companyMyInfo.securityFileName}"> style="display: none;"</c:if>>
                  <span id="securitySpan">
                  	<img id="securityViewerImg" height="50" width="50" data-original="${pageContext.request.contextPath}${companyMyInfo.securityFile}" src="${pageContext.request.contextPath}${companyMyInfo.securityFile}" alt="">
                  </span>
                  <input style="display:none"  type="file" id="securityFileUpload2" name="file" onchange="ajaxFileUpload('6','securityFileUpload2');">
                    <!-- <a href="javascript:void(0);">查看</a> --><a href="javascript:void(0);" onclick="$('input[id=securityFileUpload2]').click();">修改</a><a href="javascript:void(0);" onclick="delFile('6');">删除</a>
                </div>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>进出口企业批文扫描件</dt>
              <dd>
                <div class="up_button" id="uploadImportAndExportFileDiv" <c:if test="${!empty companyMyInfo.importAndExportFileName}"> style="display: none;"</c:if>>
                  <a href="javascript:void(0);">上传<input class="form-control" type="file" id="importAndExportFileUpload" name="file" onchange="ajaxFileUpload('7','importAndExportFileUpload');"></a>
                </div>
                <div class="diplay_area" id="showImportAndExportFileDiv" <c:if test="${empty companyMyInfo.importAndExportFileName}"> style="display: none;"</c:if>>
                  <span id="importAndExportSpan">
                  <img id="importAndExportViewerImg" height="50" width="50" data-original="${pageContext.request.contextPath}${companyMyInfo.importAndExportFile}" src="${pageContext.request.contextPath}${companyMyInfo.importAndExportFile}" alt="">
                  </span>
                  <input style="display:none"  type="file" id="importAndExportFileUpload2" name="file" onchange="ajaxFileUpload('7','importAndExportFileUpload2');">
                    <!-- <a href="javascript:void(0);">查看</a> --><a href="javascript:void(0);" onclick="$('input[id=importAndExportFileUpload2]').click();">修改</a><a href="javascript:void(0);" onclick="delFile('7');">删除</a>
                </div>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>经营许可证扫描件</dt>
              <dd>
                <div class="up_button" id="uploadBusinessFileDiv" <c:if test="${!empty companyMyInfo.businessFileName}"> style="display: none;"</c:if>>
                  <a href="javascript:void(0);">上传<input class="form-control" type="file" id="businessFileUpload" name="file" onchange="ajaxFileUpload('8','businessFileUpload');"></a>
                </div>
                <div class="diplay_area" id="showBusinessFileDiv" <c:if test="${empty companyMyInfo.businessFileName}"> style="display: none;"</c:if>>
                  <span id="businessSpan">
                  	<img id="businessViewerImg" height="50" width="50" data-original="${pageContext.request.contextPath}${companyMyInfo.businessFile}" src="${pageContext.request.contextPath}${companyMyInfo.businessFile}" alt="">
                  	<%-- ${companyMyInfo.businessFileName} --%>
                  </span>
                  <input style="display:none"  type="file" id="businessFileUpload2" name="file" onchange="ajaxFileUpload('8','businessFileUpload2');">
                    <!-- <a href="javascript:void(0);" onclick="$('input[id=businessViewerImg]').click();" >查看</a> -->
				    
                    <a href="javascript:void(0);" onclick="$('input[id=businessFileUpload2]').click();">修改</a>
                    <a href="javascript:void(0);" onclick="delFile('8');">删除</a>
                </div>
                
              </dd>
            </dl>
            
          </div>
        <!-- .section --></div>
        <div class="btn_area">
          <button class="btn btn-default gray" type="button" onclick="window.location.href='${pageContext.request.contextPath}/supervise/companyMyInfo/init?addOrUpdate=${addOrUpdate}&id=${companyMyInfo.id}'">返回上一步</button>
          <button class="btn btn-default blue" type="button" onclick = "saveCheckCompanyMyInfo(${addOrUpdate});">保存并提交审核</button>
        </div>
      </div>
     </form>
    </div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
<script>
$('#showBusinessFileDiv').viewer("data-original");
$('#showImportAndExportFileDiv').viewer("data-original");
$('#showSecurityFileDiv').viewer("data-original");
$('#showQuFileDiv').viewer("data-original");
$('#showBankFileDiv').viewer("data-original");
$('#showTaxFileDiv').viewer("data-original");
$('#showLicenceFileDiv2').viewer("data-original");
$('#showOrganizationFileDiv').viewer("data-original");
$('#showLicenceFileDiv').viewer("data-original");
</script>
</body>
</html>