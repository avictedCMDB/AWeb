<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="/WEB-INF/tlds/tag.tld" prefix="mc"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>商品需求管理|中航招标网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/profession_special_goods.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/imgbox.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/professionSpecialGoods.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/fileUpload.js"></script> --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.imgbox.pack.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
</head>

<body>
<input type="hidden" id="path" name="path" value="${pageContext.request.contextPath}"/>
<input type="hidden" id="sup_id" name="sup_id" value="${offStandardRequire.supID}"/>
<input type="hidden" id="new_sup_id" name="new_sup_id" value="${offStandardRequire.supIDSNames}"/>
<input type="hidden" id="ID" name="ID" value="${offStandardRequire.ID}"/>
<input type="hidden" id="updateImgCount" name="updateImgCount" value="${offStandardRequire.imgCount}"/>

<%-- <c:forEach var="aii" varStatus="status" items="${offStandardRequire.auditImageInfos}">
	<input type="hidden" id="updatePaths_${status.index}"  value="${aii.url}"/>
	<input type="hidden" id="hiddenPath_${status.index}" name="hidden_path"  value="${aii.url}"/>
</c:forEach> --%>
<%-- <input type="hidden" id="paths" name="paths" value="${offStandardRequire.paths}"/> --%>
<div class="page-wrapper">
	<jsp:include page="header.jsp"/>
  
  <div id="contents">
    <div class="inner">
	  <jsp:include page="left_menu.jsp">
		  <jsp:param name="menu" value="offStandardRequire" />
	  </jsp:include>
	  
      <div id="matter_section">
      	<h2>发布商品需求</h2>
      	<div id="info_list">
          <div class="section_inner">
          	 <dl class="clearfix">
                  <dt>需求名称：</dt>
                  <dd>
					<input type="text" class="form-control"  name="goodsName" id="goodsName" value="${offStandardRequire.goodsName}"/>
                  </dd>
              </dl>
              <dl class="clearfix">
                  <dt>需求描述：</dt>
                  <dd><textarea id="goods_desc_new" name="goods_desc_new" class="form-control" rows="3">${offStandardRequire.goodsDescNew}</textarea></dd>
              </dl>
              <dl class="clearfix special">
                  <dt>商品附件：</dt>
                  <dd>
                 	<input type="hidden" id="auditCount" value="${fn:length(offStandardRequire.auditImageInfos)}">
                  	<input type="file" id="uploadFile" name="file" onChange="ajaxFileUpload('${pageContext.request.contextPath}','uploadFile','affairsDiv')"/> <span class='blue-text'>支持上传文件格式为jpg/jpeg/png/gif/bmp/doc/docx/pdf/xls/xlsx，单个文件小于2M！</span>
					<div id="affairsDiv">
						<c:forEach var="auditImageInfo" items="${offStandardRequire.auditImageInfos}" varStatus="status">
							<div id="contentDiv1_${status.index}">
								<c:choose>
	                      					<c:when test="${fn:contains(auditImageInfo.url.toLowerCase(),'.jpg')}">
	                      						<img height='100px' width='100px' src="${pageContext.request.contextPath}${auditImageInfo.url}"/>
	                      					</c:when>
	                      					<c:when test="${fn:contains(auditImageInfo.url.toLowerCase(),'.png')}">
	                      						<img height='100px' width='100px' src="${pageContext.request.contextPath}${auditImageInfo.url}"/>
	                      					</c:when>
	                      					<c:when test="${fn:contains(auditImageInfo.url.toLowerCase(),'.bmp')}">
	                      						<img height='100px' width='100px' src="${pageContext.request.contextPath}${auditImageInfo.url}"/>
	                      					</c:when>
	                      					<c:when test="${fn:contains(auditImageInfo.url.toLowerCase(),'.jpeg')}">
	                      						<img height='100px' width='100px' src="${pageContext.request.contextPath}${auditImageInfo.url}"/>
	                      					</c:when>
	                      					<c:when test="${fn:contains(auditImageInfo.url.toLowerCase(),'.gif')}">
	                      						<img height='100px' width='100px' src="${pageContext.request.contextPath}${auditImageInfo.url}"/>
	                      					</c:when>
	                      					<c:otherwise>
	                      						<a href="${pageContext.request.contextPath}/management/specialGoods/downloadSpecialFile?specialAttachmentPath=${auditImageInfo.url}" class="download">${auditImageInfo.fileName}</a>
	                      					</c:otherwise>
	                      				</c:choose>
								
								<a href='javascript:void(0);' onclick="delImage('contentDiv1_${status.index}','${auditImageInfo.url}');"><img src="${pageContext.request.contextPath}/static/img/icon-close_blue.png"/></a>
								<input type='hidden' value='${auditImageInfo.url}' name='auditImages'/>
							</div>
						</c:forEach>
					</div> 
					<div class="link_download"><a href="${pageContext.request.contextPath}/management/specialGoods/downloadSpecialTemp" class="blue_link">采购商品需求导入模板下载</a></div>
                  </dd>
              </dl>
              <dl class="clearfix spectal_title">
                  <dt>是否公开：</dt>
                  <dd>
                    <input type="radio" name="isRelease" id="isRelease1" value="0" <c:if test="${offStandardRequire.isRelease eq '0' || empty offStandardRequire.isRelease}">checked="checked"</c:if>  onclick="showSupDl('0');"/>不公开&nbsp;&nbsp;
					<input type="radio" name="isRelease" id="isRelease2" value="1" <c:if test="${offStandardRequire.isRelease != '0' && !empty offStandardRequire.isRelease}">checked="checked"</c:if>onclick="showSupDl('1');"/>公开
                  </dd>
                  <dt>截至日期：</dt>
                  <dd>
                      <div class="input-group">
                        <input class="form-control special_input" id="closeDate" name="closeDate" value="${offStandardRequire.closeDate}" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                        <span class="input-group-addon">
                          <i class="fa fa-calendar"></i>
                        </span>
                      </div>
                  </dd>
              </dl>
              
	              <dl class="clearfix" id="supDL">
                  <dt>选择供应商：</dt>
                  <dd>
                      <ul class="tab_list">
						<c:if test="${isShowBtn1 == 1}">
                         <li><a href="javascript:void(0);" onclick="gotoSelectSupPage(1)">合作供应商</a></li>
						</c:if>
                         <li><a href="javascript:void(0);" onclick="gotoSelectSupPage(2)">平台其他供应商</a></li>
                      </ul>
                      <ul class="list_inner clearfix">
                      		<c:if test="${!empty offStandardRequire.ID}">
                      			<c:forEach var="supInfo" varStatus="status" items="${offStandardRequire.supInfos}">
                      				<li id="${supInfo.supID}">
										${supInfo.supName}<a href='javascript:void(0);' onclick='removeSup(this);'><img src="${pageContext.request.contextPath}/static/img/icon-close_blue.png"/></a></li>
                      			</c:forEach>
                      		</c:if>
                      </ul>
                  </dd>
              </dl>
              <div class="btn_list">
          <ul class="list-inline clearfix">
           <c:choose>
           	<c:when test="${!empty offStandardRequire.ID}">
           		<li><button type="button" onclick="doUpdate('${pageContext.request.contextPath}');" class="btn btn-default add_btn">提交</button></li>
           	</c:when>
           	<c:otherwise>
           		<li><button type="button" onclick="doSave('${pageContext.request.contextPath}');" class="btn btn-default add_btn">提交</button></li>
           	</c:otherwise>
           </c:choose>
            
            <li><button type="button" onclick="window.location.href='${pageContext.request.contextPath}'+'/management/specialGoods/offStandardRequirePage';" class="btn btn-default add_btn">取消</button></li>
          </ul>
        </div>
          </div>
      </div>
      <!--#matter_section--></div>
    <!--.inner--></div>
  <!--#contents--></div>
  
  <jsp:include page="footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>