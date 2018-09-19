<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../meta.jsp" >
	<jsp:param value="帮助中心" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supervise_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supervise_help.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/help.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>

</head>

<body>
<input type="hidden" id="path" value="${pageContext.request.contextPath}"/>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  
  <div id="contents">
    <div class="inner">
    	<jsp:include page="../left.jsp">
    		<jsp:param value="help" name="menu"/>
    	</jsp:include>
      <div id="matter_section">
      	<h2>帮助中心</h2>
      	<form action="" method="post" id="helpForm">
      	<div class="search_area section">
          <div class="search_list clearfix">
            <dl class="clearfix first">
              <dt>标题：</dt>
              <dd>
                <input type="text" id="searchTitle" name="searchTitle" value="${help.searchTitle}" class="form-control">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>内容：</dt>
              <dd>
                <input id="searchContext" name="searchContext" value="${help.searchContext}" type="text" class="form-control">
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>类型：</dt>
              <dd>
                <select id="searceType" name="searceType" class="form-control">
                  <option value="" selected="selected">请选择</option>
                  <option value="0" <c:if test="${help.searceType == '0'}">selected="selected"</c:if>>采购帮助</option>
                  <option value="1" <c:if test="${help.searceType == '1'}">selected="selected"</c:if>>供应商帮助</option>
                  <option value="2" <c:if test="${help.searceType == '2'}">selected="selected"</c:if>>资料下载</option>
                </select>
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="search();">查询</button></li>
              <li><button type="button" class="btn btn-default red" data-toggle="modal" data-target="#myModal" onclick="addHelp('1');">新增</button></li>
            </ul>
          </div>
          </form>
          <!--弹出框 添加标的start-->
                       <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                           <div class="modal-dialog">
                               <div class="modal-content">
                                   <div class="modal-header">
                                       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                       <h4 class="modal-title" id="modalTitle">添加帮助内容</h4>
                                   </div>
                                   <form action="" method="post" id="helpEditForm">
                                   <input type="hidden" id="id" name="id"/>
                                   <input type="hidden" id="fileName" name="fileName"/>
                                   <input type="hidden" id="filePath" name="filePath"/>
                                   <input type="hidden" id="addOrUpdate" name="addOrUpdate"/>
                                   <input type="hidden" id="helpTypeBuyer" name="helpTypeBuyer"/>
                                   <input type="hidden" id="helpTypeSup" name="helpTypeSup"/>
                                   <div class="modal-body clearfix">
                                       <label class="checkbox-inline">
                                           <input type="radio" id="optionsRadios1" name="type" value="0" checked onclick="tab('0');"></input>采购帮助
                                       </label>
                                       <label class="checkbox-inline">
                                           <input type="radio" id="optionsRadios2" name="type" value="1" onclick="tab('1');">供应商帮助
                                       </label>
                                       <label class="checkbox-inline">
                                           <input type="radio" id="optionsRadios3" name="type" value="2" onclick="tab('2');">资料下载
                                       </label>
										
										
                                       <div class="form-group clearfix" id="buyerQuestionTypeDiv" >
                                           <label class="col-sm-2 control-label">问题类型：</label>
                                           <div class="col-sm-10">
                                               <select id="questionType1" name="questionType1">
                                                <c:forEach var="buyerCode" varStatus="index" items="${buyerCodes}">
                                               	<option value="${buyerCode.codeValue}">${buyerCode.codeText}</option>
                                               	</c:forEach>
                                               </select>
                                           </div>
                                       </div>
                                       <div class="form-group clearfix" id="supQuestionTypeDiv" style="display:none;">
                                           <label class="col-sm-2 control-label">问题类型：</label>
                                           <div class="col-sm-10">
                                               <select id="questionType2" name="questionType2">
                                               	<c:forEach var="supCode" varStatus="index" items="${supCodes}">
                                               	<option value="${supCode.codeValue}">${supCode.codeText}</option>
                                               	</c:forEach>
                                               </select>
                                           </div>
                                       </div>

                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">标题：</label>
                                           <div class="col-sm-10">
                                               <input class="form-control" id="title" name="title">
                                           </div>
                                       </div>
                                       
                                       <div class="form-group clearfix" id="contextDiv">
                                           <label class="col-sm-2 control-label">内容：</label>
                                           <div class="col-sm-10">
                                               <textarea class="form-control" rows="3" id="context" name="context"></textarea>
                                           </div>
                                       </div>
                                       </form> 
                                       
                                       <div class="form-group clearfix" id="fileDiv" style="display:none">
                                           <label class="col-sm-2 control-label">附件：</label>
                                           <div class="col-sm-10">
                                           
                                           <div class="select_area" id="delFileDiv" style="display:none">
                                          	 <div class="input-append" >
	                                            <input id="file_name_tech" class="input-large form-control" type="text" style="display: inline-block;height:30px;width:200px" readonly="readonly"> 
	                                            <button type="button" class="btn btn-default red" id="file_del" onclick="delFile();">删除文件</button>
	                                   		 </div>
	                                   	   </div>
	                                   		
	                                   		
                                             <div class="select_area " id="templet01">
	                                           <input id="uploadFile" name="file" type="file" style="display:none" onchange="showFileName();">
	                                           <div class="input-append"> 
	                                              <input id="photoCover" class="input-large form-control" type="text" style="height:30px;"/> 
	                                              <a class="btn btn-default red" onclick="$('input[id=uploadFile]').click();" >浏览文件</a>
	                                              <button type="button" class="btn btn-default red" onclick="ajaxFileUpload('uploadFile');">开始上传</button>
	                                              
	                                           </div>
	                                          <!--  <script type="text/javascript"> 
	                                             $('input[id=uploadFile]').change(function() { 
	                                               $('#photoCover').val($(this).val()); 
	                                             });
	                                           </script> -->
	                                        </div>
                                   		   </div>
                                        </div>
                                       </div>
                                     
                                   <div class="modal-footer">
                                       <button type="button" class="btn btn-default blue" onclick="save();">保存</button>
                                       <button type="button" class="btn btn-default gray_cart" data-dismiss="modal">取消</button><!-- data-dismiss="modal" -->
                                   </div>
                               </div>
                           </div>
                       </div>
                       <!--弹出框 添加标的end-->
        <!--.search_area--></div>
      	<div class="search_result section">
          <table border="0">
            <tr>
              <!-- <th width="30"></th> -->
              <th width="120">标题</th>
              <th width="70">内容</th>
              <th width="50">类型</th>
              <th width="50">问题类型</th>
              <th width="50">附件</th>
              <th width="50">创建时间</th>
              <th width="50">状态</th>
              <th width="100" class="last">操作</th>
            </tr>
            <c:forEach var="help" varStatus="index" items="${helps}">
             <tr>
               <!-- <td><input type="checkbox"></td> -->
               <td>${help.title}</td>
               <td>${help.context}</td>
               <td>
              	 <c:if test="${help.type=='0'}">
              	 	采购帮助
              	 </c:if>
              	 <c:if test="${help.type=='1'}">
              	 	供应商帮助
              	 </c:if>
              	 <c:if test="${help.type=='2'}">
              	 	资料下载
              	 </c:if>
               </td>
               <td>
               		<c:if test="${help.type=='0'}">
               			${help.helpTypeBuyerName}
               		</c:if>
               		<c:if test="${help.type=='1'}">
               			${help.helpTypeSupName}	
               		</c:if>
               	</td>
               <td><a href="${pageContext.request.contextPath}/supervise/help/downloadHelp?filePath=${help.filePath}">${help.fileName}</a></td>
               <td>${help.createDate}</td>
               <td>
               	  <c:if test="${help.status == '0'}">
               	  	启用
               	  </c:if>
               	  <c:if test="${help.status == '1'}">
               	  	禁用
               	  </c:if>
               	</td>
               <td>
	               <c:if test="${help.status == '1'}"><a href="${pageContext.request.contextPath}/supervise/help/updateStatus?id=${help.id}&status=0">启用</a></c:if>
	               <c:if test="${help.status == '0'}"><a href="${pageContext.request.contextPath}/supervise/help/updateStatus?id=${help.id}&status=1">停用</a></c:if>
	               <a href="javascript:void(0);" data-toggle="modal" data-target="#myModal" onclick="updateHelp(${help.id});">修改</a>
	               <a href="javascript:void(0);" onclick="delHelp('${help.id}');">删除</a>
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
