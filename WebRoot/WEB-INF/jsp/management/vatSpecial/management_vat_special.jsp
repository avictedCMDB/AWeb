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
<title>��Ʊ����|�к��б���</title>
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
      	<h2>��Ʊ����</h2>
        <div class="inner_main">
          <div class="attention">
            <p>���ǻ���һ���������������˹�����</p>
            <ul>
              <li>1��ע����Ч��ֵ˰��Ʊ��Ʊ���ʽ�Ϊһ����</li>
              <!-- <li>2����Ʊ��������鿴<a href="#">��Ʊ���ʰ���</a>��</li> -->
            </ul>
          </div>
          <div <c:if test="${!empty vatSpecial}">style="display:none"</c:if> class="step_list section_inner" id="addVatExplainDiv">
            <p><span class="tit">�����������̣�</span><span>�ɹ��˹�������</span><i class="fa fa-caret-right"></i><span>��Ʊ����</span><i class="fa fa-caret-right"></i><span>�����������Ʊ���ʡ���ť</span><i class="fa fa-caret-right"></i><span>��д������Ϣ</span><i class="fa fa-caret-right"></i><span>�ϴ��Ӹǹ��µ���Ч֤��ɨ���</span></p>
          </div>
          <div <c:if test="${empty vatSpecial}">style="display:none"</c:if> class="step_list section_inner" id="updVatExplainDiv">
            <p><span class="tit">��Ʊ�����޸����̣�</span><span>������޸ġ���ť�򡰷����޸ġ�����</span><i class="fa fa-caret-right"></i><span>��д������Ϣ</span><i class="fa fa-caret-right"></i><span>�����ȷ���������ϴ�����ť</span><i class="fa fa-caret-right"></i><span>�ϴ��Ӹǹ��µ���Ч֤��ɨ���</span></p>
          </div>
          <div <c:if test="${!empty vatSpecial}">style="display:none"</c:if> class="section_inner state">
            <p>
            	<span class="tit">������Ʊ���ʣ�</span>
	            <span class="none_list">δ����</span>
	            <span>
	            	<button type="button" class="btn btn-default blue" onclick="addVatSpecialInfo();">������Ʊ����</button>
	            </span>
            </p>
          </div>
          <div <c:if test="${empty vatSpecial}">style="display:none"</c:if> class="section_inner state">
            <p>
	            <span class="tit">������Ʊ���ʣ�</span>
	            <span class="none_list">������</span>
	            <span><button type="button" class="btn btn-default blue" onclick="addVatSpecialInfo();">�޸�</button></span>
	            <span><button type="button" class="btn btn-default gray" onclick="delVatSpecialInfo();">ɾ��</button></span>
            </p>
          </div>
          <div class="add_area modify" style="display:none" id="vatSpecilDiv">
            <p>��д��Ʊ������Ϣ<span class="red">��������Ϣ��Ϊ���</span></p>
            <form class="form-horizontal" id="vatSpecialForm" action="" method="post">
              <input id="id" name="id" type="hidden" value="${vatSpecial.id}"/>
              <div class="form-group">
                <label for="name" class="control-label">��λ����:</label>
                <input type="text" class="form-control detail" id="companyName" name="companyName" value="${vatSpecial.companyName}" maxlength="64">
              </div>
              <div class="form-group">
                <label for="name" class="control-label">��˰��ʶ����:</label>
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
                <label for="name" class="control-label">ע���ַ:</label>
                <input type="text" class="form-control detail" id="registerPath" name="registerPath" value="${vatSpecial.registerPath}" maxlength="64">
              </div>
              <div class="form-group">
                <label for="name" class="control-label">ע��绰:</label>
                <input type="text" class="form-control detail" id="registerTel" name="registerTel" value="${vatSpecial.registerTel}" maxlength="32">
              </div>
              <div class="form-group">
                <label for="name" class="control-label">��������:</label>
                <input type="text" class="form-control detail" id="bankName" name="bankName" value="${vatSpecial.bankName}" maxlength="64">
              </div>
              <div class="form-group">
                <label for="name" class="control-label">�����˻�:</label>
                <input type="text" class="form-control detail" id="bankAccount" name="bankAccount" value="${vatSpecial.bankAccount}" maxlength="32">
              </div>
            </form>
            <div class="btn_list">
              <ul class="clearfix">
              		<li><button  type="button" class="btn btn-default blue" onclick="addVat();">ȷ��</button></li>
              		<li><button  type="button" class="btn btn-default gray" onclick="cancle();">ȡ��</button></li>
              </ul>
            </div>
          </div>
          <input type="hidden" value="${vatSpecial.id}" id="businessIDInp"/>
          <div class="add_area up_area" <c:if test="${empty vatSpecial}">style="display:none"</c:if>>
            <div class="info_list">
              <p>��Ʊ������Ϣ</p>
              <ul>
                <li>��λ���ƣ�<span>${vatSpecial.companyName}</span></li>
                <li>��˰��ʶ���룺<span>${vatSpecial.taxpayerCode}</span></li>
                <li>ע���ַ��<span>${vatSpecial.registerPath}</span></li>
                <li>ע��绰��<span>${vatSpecial.registerTel}</span></li>
                <li>�������У�<span>${vatSpecial.bankName}</span></li>
                <li>�����˻���<span>${vatSpecial.bankAccount}</span></li>
              </ul>
            </div>
            <input type="hidden" id="inp1" value="${fn:length(imageInfo1)}">
            <input type="hidden" id="inp2" value="${fn:length(imageInfo2)}">
            <input type="hidden" id="inp3" value="${fn:length(imageInfo3)}">
            <div class="info_list">
              <p>�ϴ������ļ�</p>
              <div class="section_inner">
                <p><span>�ϴ��ļ�����Ӹǹ��£�֧�ֵ�ͼƬ��ʽΪjpg/jpeg/png/gif/bmp������ϴ�����ͼƬ������ͼƬ��С��10M�� </span></p>
              </div>
              <div class="item clearfix">
                <span class="label_title">˰��Ǽ�֤������</span>
                <div class="up_btn">
                 <c:choose>
                  	<c:when test="${empty imageInfo1}">
                  		<span class="mr10">δ�ϴ�</span>
                  	</c:when>
                  	<c:otherwise>
                  		<span class="mr10">���ϴ�</span>
                  	</c:otherwise>
                  </c:choose>
                    <input type="file" id="uploadFile" name="file" onChange="ajaxFileUpload('${pageContext.request.contextPath}','uploadFile','affairsDiv',1)"/> 
                  <span class="ml10">û��˰��Ǽ�֤����</span>
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
                  	<!-- <button  type="button" class="btn btn-default blue">�ϴ�</button> -->

                  <div class="info_display section_inner" id="helpDiv1" style="display:none">
                    <div class="arrow"><img src="${pageContext.request.contextPath}/static/img/management/icon-arrow.png" alt="" /></div>
                    <div class="close"><img src="${pageContext.request.contextPath}/static/img/management/icon-close.png" alt="" onclick="hideHelp(1);"/></div>
                    <div class="inner_info">
                      <p>���û��˰��Ǽ�֤�����������ṩ��֤��һ��Ӫҵִ��ɨ�����</p>
                      <ul>
                        <li>�����Ե㵥λ����Ӫҵִ�ա���ҵ��������֤��˰��Ǽ�֤��Ϊһ��֤�գ���ָ��֤��һ��Ӫҵִ�ա�</li>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
              <div class="item clearfix">
                <span class="label_title">һ����˰��֤�飺</span>
                <div class="up_btn">
                  <c:choose>
                  	<c:when test="${empty imageInfo2}">
                  		<span class="mr10">δ�ϴ�</span>
                  	</c:when>
                  	<c:otherwise>
                  		<span class="mr10">���ϴ�</span>
                  	</c:otherwise>
                  </c:choose>
                 <!--  <span class="flash-btn">
                  <button  type="button" class="btn btn-default blue">�ϴ�</button>
                  	
                  </span> -->
                  <input type="file" id="uploadFile2" name="file" onChange="ajaxFileUpload('${pageContext.request.contextPath}','uploadFile2','ratepayingDiv',2)"/> 
                                    <span class="ml10">û��һ����˰��֤��</span>
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
                      <p>���û��һ����˰��֤�飬�����ṩ����֤�����κ�һ��ɨ�����</p>
                      <ul>
                        <li>1.���С���ֵ˰һ����˰�ˡ��µ�˰��Ǽ�֤������</li>
                        <li>2.һ����˰�����֪ͨ�飻</li>
                        <li>3.��ֵ˰һ����˰�������˶�����</li>
                        <li>4.����˰�����ֵ˰һ����˰���ʸ��϶���������</li>
                        <li>5.��˰�ְ䷢����ص�һ����˰��˰������֪ͨ�顣</li>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="info_list">
              <p>�ϴ���Ʊ��Ȩί����</p>
              <div class="section_inner">
                <p><span>�ϴ��ļ�����Ӹǹ��£�֧�ֵ�ͼƬ��ʽΪjpg/jpeg/png/gif/bmp������ϴ�����ͼƬ������ͼƬ��С��10M�� </span></p>
              </div>
              <div class="item clearfix">
                <span class="label_title">��Ʊ��Ȩί���飺</span>
                <div class="up_btn">
                  <c:choose>
                  	<c:when test="${empty imageInfo3}">
                  		<span class="mr10">δ�ϴ�</span>
                  	</c:when>
                  	<c:otherwise>
                  		<span class="mr10">���ϴ�</span>
                  	</c:otherwise>
                  </c:choose>
                  
                  <!-- <span class="flash-btn"><button  type="button" class="btn btn-default blue">�ϴ�</button></span> -->
                  <input type="file" id="uploadFile3" name="file" onChange="ajaxFileUpload('${pageContext.request.contextPath}','uploadFile3','authorizeDiv',3)"/> 
                                    <span><a href="${pageContext.request.contextPath}/management/vat/download">��Ʊ��Ȩί����ģ�����أ� �����˻���Ҫʱ��</a></span>
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
                <li><input  type="button" <c:if test="${vatSpecial.auditStatus=='0'}"> disabled = "disabled"</c:if> class="btn btn-default blue" onclick="saveVatPic();" value="ȷ��"></input></li>
                <!-- <li><button  type="button" class="btn btn-default gray">ȡ��</button></li> -->
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