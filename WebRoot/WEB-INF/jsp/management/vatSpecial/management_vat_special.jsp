<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<%@ taglib uri="/WEB-INF/tlds/tag.tld" prefix="mc"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>增票资质|中航招标网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management_vat.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/vat.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/validateUtil.js"></script>
</head>
<body>
<input id="path" type="hidden" value="${pageContext.request.contextPath}">
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />  
  <div id="contents">
    <div class="inner">
    	
    	<jsp:include page="../left_menu.jsp">
		  <jsp:param name="menu" value="vat" />
	  </jsp:include>
      
      <div id="matter_section">
      	<h2>增票资质</h2>
        <div class="inner_main">
          <div class="attention">
            <p>我们会在一个工作日内完成审核工作。</p>
            <ul>
              <li>1）注意有效增值税发票开票资质仅为一个。</li>
              <!-- <li>2）发票常见问题查看<a href="#">增票资质帮助</a>。</li> -->
            </ul>
          </div>
          <div <c:if test="${!empty vatSpecial}">style="display:none"</c:if> class="step_list section_inner" id="addVatExplainDiv">
            <p><span class="tit">新增资质流程：</span><span>采购人管理中心</span><i class="fa fa-caret-right"></i><span>增票资质</span><i class="fa fa-caret-right"></i><span>点击“添加增票资质”按钮</span><i class="fa fa-caret-right"></i><span>填写资质信息</span><i class="fa fa-caret-right"></i><span>上传加盖公章的有效证件扫描件</span></p>
          </div>
          <div <c:if test="${empty vatSpecial}">style="display:none"</c:if> class="step_list section_inner" id="updVatExplainDiv">
            <p><span class="tit">增票资质修改流程：</span><span>点击“修改”按钮或“返回修改”链接</span><i class="fa fa-caret-right"></i><span>填写资质信息</span><i class="fa fa-caret-right"></i><span>点击“确定并重新上传”按钮</span><i class="fa fa-caret-right"></i><span>上传加盖公章的有效证件扫描件</span></p>
          </div>
          <div <c:if test="${!empty vatSpecial}">style="display:none"</c:if> class="section_inner state">
            <p>
            	<span class="tit">您的增票资质：</span>
	            <span class="none_list">未添加</span>
	            <span>
	            	<button type="button" class="btn btn-default blue" onclick="addVatSpecialInfo();">增加增票资质</button>
	            </span>
            </p>
          </div>
          <div <c:if test="${empty vatSpecial}">style="display:none"</c:if> class="section_inner state">
            <p>
	            <span class="tit">您的增票资质：</span>
	            <span class="none_list">已添加</span>
	            <span><button type="button" class="btn btn-default blue" onclick="addVatSpecialInfo();">修改</button></span>
	            <span><button type="button" class="btn btn-default gray" onclick="delVatSpecialInfo();">删除</button></span>
            </p>
          </div>
          <div class="add_area modify" style="display:none" id="vatSpecilDiv">
            <p>填写增票资质信息<span class="red">（所有信息均为必填）</span></p>
            <form class="form-horizontal" id="vatSpecialForm" action="" method="post">
              <input id="id" name="id" type="hidden" value="${vatSpecial.id}"/>
              <div class="form-group">
                <label for="name" class="control-label">单位名称:</label>
                <input type="text" class="form-control detail" id="companyName" name="companyName" value="${vatSpecial.companyName}" maxlength="64">
              </div>
              <div class="form-group">
                <label for="name" class="control-label">纳税人识别码:</label>
                <c:choose>
                	<c:when test="${!empty vatSpecial}">
                		<div class="detail">${vatSpecial.taxpayerCode}</div>
                		<input id="taxpayerCode" name="taxpayerCode" type="hidden" value="${vatSpecial.taxpayerCode}"/>
                	</c:when>
                	<c:otherwise>
                	 	<input type="text" class="form-control detail" id="taxpayerCode" name="taxpayerCode" maxlength="32">
                	</c:otherwise>
                </c:choose>
              </div>
              <div class="form-group">
                <label for="name" class="control-label">注册地址:</label>
                <input type="text" class="form-control detail" id="registerPath" name="registerPath" value="${vatSpecial.registerPath}" maxlength="64">
              </div>
              <div class="form-group">
                <label for="name" class="control-label">注册电话:</label>
                <input type="text" class="form-control detail" id="registerTel" name="registerTel" value="${vatSpecial.registerTel}" maxlength="32">
              </div>
              <div class="form-group">
                <label for="name" class="control-label">开户银行:</label>
                <input type="text" class="form-control detail" id="bankName" name="bankName" value="${vatSpecial.bankName}" maxlength="64">
              </div>
              <div class="form-group">
                <label for="name" class="control-label">银行账户:</label>
                <input type="text" class="form-control detail" id="bankAccount" name="bankAccount" value="${vatSpecial.bankAccount}" maxlength="32">
              </div>
            </form>
            <div class="btn_list">
              <ul class="clearfix">
              		<li><button  type="button" class="btn btn-default blue" onclick="addVat();">确定</button></li>
              		<li><button  type="button" class="btn btn-default gray" onclick="cancle();">取消</button></li>
              </ul>
            </div>
          </div>
          <input type="hidden" value="${vatSpecial.id}" id="businessIDInp"/>
          <div class="add_area up_area" <c:if test="${empty vatSpecial}">style="display:none"</c:if>>
            <div class="info_list">
              <p>增票资质信息</p>
              <ul>
                <li>单位名称：<span>${vatSpecial.companyName}</span></li>
                <li>纳税人识别码：<span>${vatSpecial.taxpayerCode}</span></li>
                <li>注册地址：<span>${vatSpecial.registerPath}</span></li>
                <li>注册电话：<span>${vatSpecial.registerTel}</span></li>
                <li>开户银行：<span>${vatSpecial.bankName}</span></li>
                <li>银行账户：<span>${vatSpecial.bankAccount}</span></li>
              </ul>
            </div>
            <input type="hidden" id="inp1" value="${fn:length(imageInfo1)}">
            <input type="hidden" id="inp2" value="${fn:length(imageInfo2)}">
            <input type="hidden" id="inp3" value="${fn:length(imageInfo3)}">
            <div class="info_list">
              <p>上传资质文件</p>
              <div class="section_inner">
                <p><span>上传文件均需加盖公章，支持的图片格式为jpg/jpeg/png/gif/bmp，务必上传清晰图片，单个图片需小于10M。 </span></p>
              </div>
              <div class="item clearfix">
                <span class="label_title">税务登记证副本：</span>
                <div class="up_btn">
                 <c:choose>
                  	<c:when test="${empty imageInfo1}">
                  		<span class="mr10">未上传</span>
                  	</c:when>
                  	<c:otherwise>
                  		<span class="mr10">已上传</span>
                  	</c:otherwise>
                  </c:choose>
                    <input type="file" id="uploadFile" name="file" onChange="ajaxFileUpload('${pageContext.request.contextPath}','uploadFile','affairsDiv',1)"/> 
                  <span class="ml10">没有税务登记证副本</span>
                  <a href="javaScript:void(0);" onclick="help(1);"><span class="fa fa-question-circle"></span></a>
					<div id="affairsDiv">
						<c:forEach var="imageInfo1" items="${imageInfo1}" varStatus="status">
							<div id="contentDiv1_${status.index}">
								<img height='100px' width='100px' src="${pageContext.request.contextPath}${imageInfo1.url}"/>
								<c:if test="${vatSpecial.auditStatus!='0'}">
								<a href='javascript:void(0);' onclick="delImage('contentDiv1_${status.index}','${imageInfo1.url}');">X</a>
								</c:if>
								<input type='hidden' value='${imageInfo1.url}' name='imageSaveInp1'/>
							</div>
						</c:forEach>
					</div> 
                  	<!-- <button  type="button" class="btn btn-default blue">上传</button> -->

                  <div class="info_display section_inner" id="helpDiv1" style="display:none">
                    <div class="arrow"><img src="${pageContext.request.contextPath}/static/img/management/icon-arrow.png" alt="" /></div>
                    <div class="close"><img src="${pageContext.request.contextPath}/static/img/management/icon-close.png" alt="" onclick="hideHelp(1);"/></div>
                    <div class="inner_info">
                      <p>如果没有税务登记证副本，请您提供三证合一的营业执照扫描件：</p>
                      <ul>
                        <li>少数试点单位现在营业执照、企业机构代码证、税务登记证简化为一张证照，即指三证合一的营业执照。</li>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
              <div class="item clearfix">
                <span class="label_title">一般纳税人证书：</span>
                <div class="up_btn">
                  <c:choose>
                  	<c:when test="${empty imageInfo2}">
                  		<span class="mr10">未上传</span>
                  	</c:when>
                  	<c:otherwise>
                  		<span class="mr10">已上传</span>
                  	</c:otherwise>
                  </c:choose>
                 <!--  <span class="flash-btn">
                  <button  type="button" class="btn btn-default blue">上传</button>
                  	
                  </span> -->
                  <input type="file" id="uploadFile2" name="file" onChange="ajaxFileUpload('${pageContext.request.contextPath}','uploadFile2','ratepayingDiv',2)"/> 
                                    <span class="ml10">没有一般纳税人证书</span>
                  <a href="javaScript:void(0);" onclick="help(2);"><span class="fa fa-question-circle"></span></a>
					<div id="ratepayingDiv">
						<c:forEach var="imageInfo2" items="${imageInfo2}" varStatus="status">
							<div id="contentDiv2_${status.index}">
								<img height='100px' width='100px' src="${pageContext.request.contextPath}${imageInfo2.url}"/>
								<c:if test="${vatSpecial.auditStatus!='0'}"> 
								<a href='javascript:void(0);' onclick="delImage('contentDiv2_${status.index}','${imageInfo2.url}');">X</a>
								</c:if>
								<input type='hidden' value='${imageInfo2.url}' name='imageSaveInp2'/>
							</div>
						</c:forEach>
					</div> 

                  <div class="info_display section_inner" id="helpDiv2" style="display:none">
                    <div class="arrow"><img src="${pageContext.request.contextPath}/static/img/management/icon-arrow.png" alt="" /></div>
                    <div class="close"><img src="${pageContext.request.contextPath}/static/img/management/icon-close.png" alt="" onclick="hideHelp(2);"/></div>
                    <div class="inner_info">
                      <p>如果没有一般纳税人证书，请您提供以下证件中任何一个扫描件：</p>
                      <ul>
                        <li>1.盖有“增值税一般纳税人”章的税务登记证副本；</li>
                        <li>2.一般纳税人年检通知书；</li>
                        <li>3.增值税一般纳税人申请人定表；</li>
                        <li>4.国家税务局增值税一般纳税人资格认定批复件；</li>
                        <li>5.国税局颁发的相关的一般纳税人税务事项通知书。</li>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="info_list">
              <p>上传增票授权委托书</p>
              <div class="section_inner">
                <p><span>上传文件均需加盖公章，支持的图片格式为jpg/jpeg/png/gif/bmp，务必上传清晰图片，单个图片需小于10M。 </span></p>
              </div>
              <div class="item clearfix">
                <span class="label_title">增票授权委托书：</span>
                <div class="up_btn">
                  <c:choose>
                  	<c:when test="${empty imageInfo3}">
                  		<span class="mr10">未上传</span>
                  	</c:when>
                  	<c:otherwise>
                  		<span class="mr10">已上传</span>
                  	</c:otherwise>
                  </c:choose>
                  
                  <!-- <span class="flash-btn"><button  type="button" class="btn btn-default blue">上传</button></span> -->
                  <input type="file" id="uploadFile3" name="file" onChange="ajaxFileUpload('${pageContext.request.contextPath}','uploadFile3','authorizeDiv',3)"/> 
                                    <span><a href="${pageContext.request.contextPath}/management/vat/download">增票授权委托书模板下载（ 个人账户需要时）</a></span>
					<div id="authorizeDiv">
						<c:forEach var="imageInfo3" items="${imageInfo3}" varStatus="status">
							<div id="contentDiv3_${status.index}">
								<img height='100px' width='100px' src="${pageContext.request.contextPath}${imageInfo3.url}"/>
								<c:if test="${vatSpecial.auditStatus!='0'}"> 
								<a  href='javascript:void(0);' onclick="delImage('contentDiv3_${status.index}','${imageInfo3.url}');">X</a>
								</c:if>
								<input type='hidden' value='${imageInfo3.url}' name='imageSaveInp3'/>
							</div>
						</c:forEach>
					</div> 

                </div>
              </div>
            </div>
            <div class="btn_list">
              <ul class="clearfix">
                <li><input  type="button" <c:if test="${vatSpecial.auditStatus=='0'}"> disabled = "disabled"</c:if> class="btn btn-default blue" onclick="saveVatPic();" value="确定"></input></li>
                <!-- <li><button  type="button" class="btn btn-default gray">取消</button></li> -->
              </ul>
            </div>
          </div>
        </div>
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>