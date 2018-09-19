<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>���۹���|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_step01.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_step02.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_step03.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_step04.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_step05.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/date.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bid/management/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bid/management/publish.js"></script>

<style>
#mtr_field, #attach_field_busi, #attach_field_tech, #file_name_busi, #file_name_tech {
	width: 200px;
    display: inline-block;
}
.pagination > li {
    margin-left: 8px;
    float: left;
}
</style>

<script type="text/javascript">
	var ACT = "${act}";
	var CONTEXT = "${pageContext.request.contextPath}";
	$(function () {
		
	});
</script>

</head>

<body>
<div class="page-wrapper">
  
  <jsp:include page="../header.jsp" />  
  
  <input type="hidden" id="func" value="${func}"/>
  
  <div id="contents">
      <div class="inner">
      <jsp:include page="../left.jsp"/>
          <div id="matter_section">
          <div id="sec_inner_1">
               <div class="nav_step">
                  <ul class="clearfix">
                    <li class="current">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step01.png" alt="1"></span>ѡ�񾺼�����</a>
                    </li>
                    <li>
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step02.png" alt="1"></span>���Ӿ��۱��</a>
                    </li>
                    <li>
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step03.png" alt="1"></span>���Ӿ��۸�Ҫ��Ϣ</a>
                    </li>
                    <li>
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step04.png" alt="1"></span>���Ӿ�����Ϣ</a>
                    </li>
                    <li class="last">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step05.png" alt="1"></span>���ӱ���</a>
                    </li>
                  </ul>
               </div>
               <div class="step_section section" id="step01">
                   <div class="list_inner clearfix">
                       <div class="form-group">
                           <label class="title">�ɹ�����</label>
                           <div class="input_area">
                               <select class="form-control" id="bid_cat" name="bid_cat" ${ro}>
                                   <option value="">��ѡ��</option>
                                   <c:forEach var="i" items="${cats}">
                                   <option value="${i.codeValue }" <c:if test="${i.codeValue == proj.bidCat}">selected="selected"</c:if>>${i.codeText }</option>
                                   </c:forEach>
                               </select>
                           </div>
                       </div>
                       <div class="form-group">
                           <label class="title">������Ŀ���</label>
                           <div class="input_area">
                               <input type="text" class="form-control" id="proj_id" name="proj_id" readonly="readonly" value="${projId}">
                           </div>
                       </div>
                       <div class="form-group">
                           <label class="title">������Ŀ����</label>
                           <div class="input_area">
                               <input type="text" class="form-control" id="proj_name" name="proj_name" ${ro} maxlength="30" value="${proj.projName}">
                           </div>
                       </div>
                       <div class="form-group">
                           <label class="title">��������</label>
                           <div class="input_area">
                               <select class="form-control" id="proj_type" name="proj_type" ${ro}>
                                   <option value="1" <c:if test="${proj.projType == 1}">selected="selected"</c:if>>���뾺��</option>
                                   <option value="2" <c:if test="${proj.projType == 2}">selected="selected"</c:if>>��������</option>
                               </select>
                           </div>
                       </div>
                       <div class="form-group">
                           <label class="title">���귽ʽ</label>
                           <div class="input_area">
                               <select class="form-control" id="decide_type" name="decide_type" ${ro}>
                                   <option value="1" <c:if test="${proj.decideType == 1}">selected="selected"</c:if>>�۸����</option>
                                   <option value="2" <c:if test="${proj.decideType == 2}">selected="selected"</c:if>>�������</option>
                               </select>
                           </div>
                       </div>
                       <div class="form-group special_group">
                           <label class="title">����</label>
                           <div class="input_area input_area_special">
                               <select class="form-control" id="currency" name="currency" ${ro}>
                                   <c:forEach var="i" items="${currencys}">
                                   <option value="${i.codeValue }" <c:if test="${i.codeValue == proj.currency}">selected="selected"</c:if>>${i.codeText }</option>
                                   </c:forEach>
                               </select>
                           </div>
                       </div>
                       <div class="form-group special_group special_group02">
                           <label class="title">����</label>
                           <div class="input_area input_area_special">
                               <input type="text" class="form-control" id="exchange_rate" name="exchange_rate" maxlength="10" value="${proj.exchangeRate}" ${ro}>
                           </div>
                       </div>
                       <div class="form-group">
                           <label class="title title_special">�ɹ�Ԥ��</label>
                           <div class="input_area input-group input_area_special">
                               <input type="text" class="form-control" id="budget" name="budget" maxlength="10" value="${proj == null || proj.budget == 0 ? '' : proj.budget}" ${ro}>
                               <span>Ԫ</span>
                           </div>
                           <label class="title">�Ƿ񹫿���</label>
                           <div class="input_area input-group input_area_special" style="margin-top:3px;">
                               <label class="checkbox-inline">
                                   <input type="radio" name="budget_public" value="1" ${ro} <c:if test="${proj.budgetPublic == 1}">checked="checked"</c:if>>��
                               </label>
                               <label class="checkbox-inline">
                                   <input type="radio" name="budget_public" value="2" ${ro} <c:if test="${proj == null or proj.budgetPublic == 2}">checked="checked"</c:if>>��
                               </label>
                          </div>
                       </div>
                       <div class="form-group">
                           <label class="title title_special">����Ͷ�굥λ����</label>
                           <div class="input_area input-group input_area_special">
                               <input type="text" class="form-control" id="min_tender" name="min_tender" maxlength="4" value="${proj == null ? '2' : proj.minTender}" ${ro}>
                               <span>��</span>
                           </div>
                       </div>
                   <!--.list_inner--></div>
                   <div class="add_inner">
                       <div class="btn_list">
                       <c:if test="${func != 'detail'}">
                           <button class="btn btn-default blue" id="mtr_add">������Ŀ��Ŀ</button>
                       </c:if>
                       </div>
                       <!--������start-->
                       <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                           <div class="modal-dialog">
                               <div class="modal-content">
                                   <div class="modal-header">
                                       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                       <h4 class="modal-title" id="myModalLabel">���Ӳɹ���Ʒ</h4>
                                   </div>
                                   <div class="modal-body">
                                       <label class="checkbox-inline">
                                           <input type="radio" name="mtr_select" value="1" checked>����ɹ���Ŀ
                                       </label>
                                       <label class="checkbox-inline">
                                           <input type="radio" name="mtr_select" value="2">�����Ͽ����
                                       </label>
                                       <div class="select_area" id="templet01">
                                       <form id="mtr_form" target="upload_target" action="${pageContext.request.contextPath}/management/bid/${act}/mtr/import" enctype="multipart/form-data" method="post">
                                           <input id="mtr_file" name="mtr_file" type="file" style="display:none">
                                       </form>
                                           <div class="input-append"> 
                                              <input id="mtr_field" class="input-large form-control" type="text" style="height:30px;" readonly="readonly"> 
                                              <a class="btn btn-default red" onclick="$('#mtr_file').click();">����ļ�</a>
                                              <button type="button" class="btn btn-default red" id="mtr_upload">��ʼ�ϴ�</button>
                                              <label><a href="${pageContext.request.contextPath}/management/bid/${act}/mtr/template" target="_blank">���ϵ���ģ������</a></label>
                                           </div>
                                           <script type="text/javascript"> 
                                             $('#mtr_file').change(function() { 
                                               $('#mtr_field').val($(this).val()); 
                                             });
                                           </script>
                                           <div class="result_info">
                                               <p id="mtr_result">������Ϣ</p>
                                           </div>
                                       </div>
                                       <div class="select_area" id="templet02" style="display:none;">
                                           <div class="form-group">
                                              <label class="title">��������</label>
                                              <div class="input_area">
                                                  <input type="text" class="form-control" id="mtr_query_name">
                                              </div>
                                           </div>
                                           <div class="btn_list">
                                               <button class="btn btn-default blue" id="mtr_query">��ѯ</button>
                                               <button class="btn btn-default blue" id="mtr_query_add">����</button>
                                           </div>
                                           <div class="table_list">
                                               <table>
                                                  <tr>
                                                    <th width="40"></th>
                                                    <th>��������</th>
                                                    <th>Ʒ��</th>
                                                    <th class="last">����ͺ�</th>
                                                  </tr>
                                                  <tbody id="mtr_query_tbody">                                               
                                                  </tbody>
                                                  <!-- 
                                                  <tr>
                                                    <td><input type="checkbox"></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                  </tr>
                                                   -->
                                               </table>
                                           </div>
                                           <div class="page" id="mtr_page">
			                              </div>
                                       </div>
                                   </div>

                                   <div class="modal-footer">
                                       <button type="button" class="btn btn-default blue" data-dismiss="modal">ȷ��</button>
                                       <button type="button" class="btn btn-default gray_cart" data-dismiss="modal">ȡ��</button>
                                   </div>
                               </div>
                           </div>
                       </div>
                       <!--������end-->
                       <table>
                           <tr>
                               <th width="120">��������</th>
                               <th width="90">����</th>
                               <th width="70">��λ</th>
                               <th>Ʒ�Ƴ���</th>
                               <th width="90">�ͺ�</th>
                               <th width="70">�Ƿ����</th>
                               <th width="90">�ۺ����</th>
                               <th width="90">�������</th>
                               <c:if test="${func != 'detail' }">
                               <th class="last" width="90">����</th>
                               </c:if>
                           </tr>
                           <tbody id="mtr_tbody">
                           <c:forEach var="i" items="${proj.materiels}">
                                <tr data-id="${i.materSeq}" id="mtr_tr_${i.materSeq}">
                                  <td>${i.materName}</td>
                                  <td>${i.materNum}</td>
                                  <td>${i.materUnit}</td>
                                  <td>${i.materBrand}</td>
                                  <td>${i.materModel}</td>
                                  <td>${i.ifStandard}</td>
                                  <td>${i.saleService}</td>
                                  <td>${i.specConf}</td>
                               <c:if test="${func != 'detail' }">
                                  <td><a href="javascript:;" onclick="mtrDel(this);">ɾ��</a></td>
                               </c:if>
                                </tr>
                           </c:forEach>   
                           </tbody>
                       </table>
                   <!--.add_inner--></div>
               <!--.step_section--></div>
               <div class="submit_btn">
                   <ul>
                       <li><button class="btn btn-default blue" data-step="2" data-cur="1">��һ��</button></li>
                       <!-- <li><button class="btn btn-default gray_cart">ȡ��</button></li>  -->
                   </ul>
               </div>
          <!-- #sec_inner_1 --></div>
          <div id="sec_inner_2" style="display:none;">
               <div class="nav_step">
                  <ul class="clearfix">
                    <li class="current_prev">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step01.png" alt="1"></span>ѡ�񾺼�����</a>
                    </li>
                    <li class="current">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step02.png" alt="1"></span>���Ӿ��۱��</a>
                    </li>
                    <li>
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step03.png" alt="1"></span>���Ӿ��۸�Ҫ��Ϣ</a>
                    </li>
                    <li>
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step04.png" alt="1"></span>���Ӿ�����Ϣ</a>
                    </li>
                    <li class="last">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step05.png" alt="1"></span>���ӱ���</a>
                    </li>
                  </ul>
               </div>
               <div class="step_section section" id="step02">
                   <div class="list_inner clearfix">
                       <div class="form-group">
                           <label class="title">��Ŀ��ţ�</label>
                           <span class="proj-id-span"></span>
                       </div>
                       <div class="form-group">
                           <label class="title">��Ŀ���ƣ�</label>
                           <span class="proj-name-span"></span>
                       </div>
                       <div class="form-group special_group01">
                           <label class="title">���۷�ʽ��</label>
                           <div class="input_area">
                               <label class="checkbox-inline">
                                   <input type="radio" name="quota_type" value="1" ${ro} <c:if test="${proj == null or proj.quotaType == 1}">checked="checked"</c:if>>������ı��۵�
                               </label>
                               <label class="checkbox-inline">
                                   <input type="radio" name="quota_type" value="2" ${ro} <c:if test="${proj.quotaType == 2}">checked="checked"</c:if>>�����ı��ܼ�
                               </label>
                          </div>
                       </div>
                       <div class="form-group special_group01">
                           <label class="title">�������ޣ�</label>
                           <div class="input_area">
                               <label class="checkbox-inline"><input type="radio" name="quota_limit_type" value="1" ${ro} <c:if test="${proj == null or proj.quotaLimitType == 1}">checked="checked"</c:if>>���豨������</label>
                               <label class="checkbox-inline"><input type="radio" name="quota_limit_type" value="2" ${ro} <c:if test="${proj.quotaLimitType == 2}">checked="checked"</c:if>>��������Ϊ</span></label>
                               <div class="input_area input-group input_area_special">
                                   <input type="text" class="form-control" id="quota_limit_num" maxlength="10" ${ro} <c:if test="${proj.quotaLimitType != 2}">readonly="readonly"</c:if> <c:if test="${proj.quotaLimitType == 2}">value="${proj.quotaLimitNum}"</c:if>>
                                   <span>Ԫ</span>
                               </div>
                            </div>
                       </div>
                   <!--.list_inner--></div>
                   <div class="add_inner add_inner_first">
                       <div class="title_add clearfix">
                            <div class="title_inner clearfix">
                                <p>���۱��</p>
                                <div class="btn_list">
                                <c:if test="${func != 'detail'}">
                                    <button class="btn btn-default blue" data-toggle="modal" id="subject_add">���ӱ��</button>
                                </c:if>
                                </div>
                            </div>
                       </div>

                       <!--������ ���ӱ��start-->
                       <div class="modal fade" id="subjectModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                           <div class="modal-dialog">
                               <div class="modal-content">
                                   <div class="modal-header">
                                       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                       <h4 class="modal-title" id="myModalLabel">���ӱ��</h4>
                                   </div>
                                   <div class="modal-body clearfix">
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">��ı��룺</label>
                                           <div class="col-sm-10">
                                               <input class="form-control" id="subject_id" readonly="readonly">
                                           </div>
                                       </div>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">������ƣ�</label>
                                           <div class="col-sm-10">
                                               <input class="form-control" id="subject_name">
                                           </div>
                                       </div>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">������</label>
                                           <div class="col-sm-10">
                                               <input class="form-control" id="subject_num">
                                           </div>
                                       </div>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">������λ��</label>
                                           <div class="col-sm-10">
                                               <input class="form-control" id="subject_unit">
                                           </div>
                                       </div>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">˵����</label>
                                           <div class="col-sm-10">
                                               <textarea class="form-control" rows="3" id="intro"></textarea>
                                           </div>
                                       </div>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">������Ϣ��</label>
                                           <div class="col-sm-10" id="mtr_sel">
                                               
                                           </div>
                                       </div>
                                   </div>
                                   <div class="modal-footer">
                                       <button type="button" class="btn btn-default blue" id="subject_modal_ok">ȷ��</button>
                                       <button type="button" class="btn btn-default gray_cart" data-dismiss="modal">ȡ��</button>
                                   </div>
                               </div>
                           </div>
                       </div>
                       <!--������ ���ӱ��end-->
                       <table>
                           <tr>
                               <th width="120">��ı���</th>
                               <th width="250">�������</th>
                               <th width="90">����</th>
                               <th width="90">������λ</th>
                               <th>˵��</th>
                                <c:if test="${func != 'detail'}">
                               <th class="last" width="120">����</th>
                               </c:if>
                           </tr>
                           <tbody id="subject_tbody">
                           <c:forEach var="i" items="${proj.subjects}">
                                <tr id="subject_tr_${i.subjectId}" data-mtr="${i.maters}">
                                  <td>${i.subjectId}</td>
                                  <td class="left">${i.subjectName}</td>
                                  <td>${i.subjectNum}</td>
                                  <td>${i.subjectUnit}</td>
                                  <td class="left">${i.intro}</td>
                                <c:if test="${func != 'detail'}">
                                  <td><a href="javascript:;" onclick="subjectEdit(this);">�޸�</a><a href="javascript:;" onclick="subjectDel(this);">ɾ��</a></td>
                                </c:if>
                                </tr>
                           </c:forEach>   
                           </tbody>
                       </table>
                   <!--.add_inner--></div>
                   <!--<div class="add_inner">
                       <div class="title_add clearfix">
                            <div class="title_inner clearfix">
                                <p>��ַ�����<span>���������֣����Բ���д���ݣ�</span><span><input type="radio" name="split_type" value="1" ${ro} <c:if test="${proj == null or proj.splitType == 1}">checked="checked"</c:if>>�Թ�Ӧ�̿ɼ�</span><span><input type="radio" name="split_type" value="2" ${ro} <c:if test="${proj.splitType == 2}">checked="checked"</c:if>>�Թ�Ӧ�̲��ɼ�</span></p>
                                <div class="btn_list">
                                <c:if test="${func != 'detail'}">
                                    <button class="btn btn-default blue" data-toggle="modal" id="split_add">���Ӳ�ַ���</button>
                                </c:if>
                                </div>
                            </div>
                       </div>
                       
                               <div class="modal fade" id="split_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                   <div class="modal-dialog">
                                       <div class="modal-content">
                                           <div class="modal-header">
                                               <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                               <h4 class="modal-title" id="myModalLabel">���ӷ������</h4>
                                           </div>
                                           <div class="modal-body">
                                               <div class="form-group clearfix">
                                                 <label class="col-sm-2 control-label">�������Σ�</label>
                                                 <label class="col-sm-10" id="bid_rank">001</label>
                                              </div>
                                              <div class="form-group clearfix">
                                                 <label class="col-sm-2 control-label">���������</label>
                                                 <div class="col-sm-10">
                                                     <input class="form-control" id="split_prop">
                                                 </div>
                                              </div> 
                                           </div>
                                           <div class="modal-footer">
                                               <button type="button" class="btn btn-default blue" id="split_modal_ok">ȷ��</button>
                                               <button type="button" class="btn btn-default gray_cart" data-dismiss="modal">ȡ��</button>
                                           </div>
                                       </div>
                                   </div>
                               </div>

                       <table>
                           <tr>
                               <th>��������</th>
                               <th>�������</th>
                                <c:if test="${func != 'detail'}">
                               <th class="last" width="120">����</th>
                                </c:if>
                           </tr>
                           <tbody id="split_tbody">
                           <c:forEach var="i" items="${proj.splits}">
                                <tr>
                                  <td>${i.bidRank}</td>
                                  <td>${i.splitProp}</td>
                                <c:if test="${func != 'detail'}">
                                  <td><a href="javascript:;" onclick="splitDel(this);">ɾ��</a></td>
                                </c:if>
                                </tr>
                           </c:forEach>   
                           </tbody>
                       </table>
                   </div> -->
                   <div class="add_inner" id="sup_select">
                       <div class="title_add clearfix">
                            <div class="title_inner clearfix">
                                <p>��Ӧ��</p>
                                <div class="btn_list">
                                <c:if test="${func != 'detail'}">
                                    <button class="btn btn-default blue" data-toggle="modal" id="supplier_add">���ӹ�Ӧ��</button>
                                </c:if>
                                </div>
                            </div>
                       </div>
                       <!--������start-->
                               <div class="modal fade" id="supplier_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                   <div class="modal-dialog">
                                       <div class="modal-content">
                                           <div class="modal-header">
                                               <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                               <h4 class="modal-title" id="myModalLabel">���ӹ�Ӧ��</h4>
                                           </div>
                                           <div class="modal-body">
                                               <div class="sreach_area">
                                                   <div class="form-group clearfix">
                                                       <label class="col-sm-2 control-label">��Ӧ�̱�ţ�</label>
                                                       <div class="col-sm-4">
                                                           <input class="form-control" id="sup_code">
                                                       </div>
                                                       <label class="col-sm-2 control-label">��Ӧ�����ƣ�</label>
                                                       <div class="col-sm-4">
                                                           <input class="form-control" id="sup_name">
                                                       </div>
                                                   </div>
                                                   <div class="form-group clearfix">
                                                       <label class="col-sm-2 control-label">��ϵ�ˣ�</label>
                                                       <div class="col-sm-4">
                                                           <input class="form-control" id="contact_person">
                                                       </div>
                                                       <label class="col-sm-2 control-label">��ϵ�˵绰��</label>
                                                       <div class="col-sm-4">
                                                           <input class="form-control" id="contact_num">
                                                       </div>
                                                   </div>
                                               </div>
                                               <div class="submit_btn">
                                                    <button class="btn btn-default blue" id="supplier_query">����</button>
                                               </div>
                                               <table>
                                                     <tr>
                                                         <th width="40"></th>
                                                         <th width="90">��Ӧ�̱��</th>
                                                         <th width="90">��Ӧ������</th>
                                                         <th width="90">��ϵ��</th>
                                                         <th width="90">��ϵ�˵绰</th>
                                                         <th class="last">�ʼ�</th>
                                                     </tr>
                                                     <tbody id="supplier_query_tbody"></tbody>
                                                     <!-- 
                                                     <tr>
                                                          <td><input type="checkbox"></td>
                                                          <td></td>
                                                          <td></td>
                                                          <td></td>
                                                          <td></td>
                                                          <td></td>
                                                     </tr>
                                                      -->
                                               </table>
						                       <div class="page" id="supplier_page">
						                       </div>
                                           </div>
                                           <div class="modal-footer">
                                               <button type="button" class="btn btn-default blue" id="supplier_modal_ok">ȷ��</button>
                                               <button type="button" class="btn btn-default gray_cart" data-dismiss="modal">ȡ��</button>
                                           </div>
                                       </div>
                                   </div>
                               </div>
                               <!--������end-->
                       <table>
                           <tr>
                               <th width="150">��Ӧ�̱���</th>
                               <th>��˾����</th>
                               <th width="120">��ϵ��</th>
                               <th width="120">��ϵ�绰</th>
                               <th width="120">�ʼ�</th>
                                <c:if test="${func != 'detail'}">
                               <th class="last" width="120">����</th>
                                </c:if>
                           </tr>
                           <tbody id="supplier_tbody">
                           <c:forEach var="i" items="${proj.suppliers}">
                                <tr id="supplier_tr_${i.supCode}">
                                  <td>${i.supCode}</td>
                                  <td>${i.supName}</td>
                                  <td>${i.contactPerson}</td>
                                  <td>${i.contactNum}</td>
                                  <td>${i.email}</td>
                                <c:if test="${func != 'detail'}">
                                  <td><a href="javascript:;" onclick="supplierDel(this);">ɾ��</a></td>
                                </c:if>
                                </tr>
                           </c:forEach>   
                           </tbody>
                           <!-- 
                           <tr>
                               <td></td>
                               <td></td>
                               <td></td>
                               <td></td>
                               <td></td>
                               <td class="center"><a href="#">ɾ��</a></td>
                           </tr>
                            -->
                       </table>
                   <!--.add_inner--></div>
               <!--.step_section--></div>
               <div class="submit_btn">
                   <ul>
                       <li><button class="btn btn-default gray_cart" data-step="1">��һ��</button></li>
                       <li><button class="btn btn-default blue" data-step="3" data-cur="2">��һ��</button></li>
                   </ul>
               </div>
          <!--#sec_inner_2--></div>
          <div id="sec_inner_3" style="display:none;">
               <div class="nav_step">
                  <ul class="clearfix">
                    <li class="done">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step01.png" alt="1"></span>ѡ�񾺼�����</a>
                    </li>
                    <li class="current_prev">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step02.png" alt="1"></span>���Ӿ��۱��</a>
                    </li>
                    <li class="current">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step03.png" alt="1"></span>���Ӿ��۸�Ҫ��Ϣ</a>
                    </li>
                    <li>
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step04.png" alt="1"></span>���Ӿ�����Ϣ</a>
                    </li>
                    <li class="last">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step05.png" alt="1"></span>���ӱ���</a>
                    </li>
                  </ul>
               </div>
               <div class="step_section section" id="step03">
                   <div class="list_inner clearfix">
                       <div class="form-group">
                           <label class="title">��Ŀ��ţ�</label>
                           <span class="proj-id-span"></span>
                       </div>
                       <div class="form-group">
                           <label class="title">��Ŀ���ƣ�</label>
                           <span class="proj-name-span"></span>
                       </div>
                       <div class="form-group">
                           <label class="title">���ۿ�ʼʱ�䣺</label>
                           <div class="input_area input-group input-group_special">
                               <input type="text" class="form-control" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm', onpicked:bidStartTimePicked})" id="bid_start_time" ${ro} value="<fmt:formatDate value="${proj.bidStartTime}" pattern="yyyy-MM-dd HH:mm"/>" readonly="readonly" <c:if test="${func != 'detail'}"> style="background-color:#fff" </c:if>>
                               <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                           </div>
                       </div>
                       <div class="form-group">
                           <label class="title">��������ʱ�䣺</label>
                           <div class="input_area input-group input-group_special">
                               <input type="text" class="form-control form_special" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" id="join_end_time" readonly="readonly" value="<fmt:formatDate value="${proj.joinEndTime}" pattern="yyyy-MM-dd HH:mm"/>" readonly="readonly" <c:if test="${func != 'detail'}"> style="background-color:#fff" </c:if>>
                               <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                           </div>
                       </div>
                       <div class="form-group">
                           <label class="title">��ʽ����ʱ����</label>
                           <div class="input_area input-group input_area_special">
                               <input type="text" class="form-control form-control01" id="bid_duration" value="${proj.bidDuration}" ${ro}>
                               <span>��</span>
                          </div>
                       </div>
                       <div class="form-group">
                           <label class="title">��ʱ����ʱ������</label>
                           <div class="input_area input-group input_area_special">
                               <input type="text" class="form-control form-control01" id="timeout_interval" value="${proj.timeoutInterval}" ${ro}>
                               <span>��</span>
                           </div>
                       </div>
                       <div class="form-group">
                           <label class="title">��;��۷��ȣ�</label>
                           <div class="input_area">
                               <label class="checkbox-inline"><input type="radio" name="min_incr_type" value="1" ${ro} <c:if test="${proj == null or proj.minIncrType == 1}">checked="checked"</c:if>>������</label>
                               <label class="checkbox-inline"><input type="radio" name="min_incr_type" value="2" ${ro} <c:if test="${proj.minIncrType == 2}">checked="checked"</c:if>>��ֵ</label>
                               <div class="input_area input-group input_area_special_last">
                                   <input type="text" class="form-control" id="min_incr_val_2"  ${ro} <c:if test="${proj.minIncrType != 2}"> readonly="readonly" </c:if> <c:if test="${proj.minIncrType == 2}">value="${proj.minIncrVal}"</c:if>>
                               </div>
                               <label class="checkbox-inline"><input type="radio" name="min_incr_type" value="3" ${ro} <c:if test="${proj.minIncrType == 3}">checked="checked"</c:if>>�ܼ۰ٷֱ�</label>
                               <div class="input_area input-group input_area_special_last">
                                   <input type="text" class="form-control" id="min_incr_val_3"  ${ro} <c:if test="${proj.minIncrType != 3}"> readonly="readonly" </c:if> <c:if test="${proj.minIncrType == 3}">value="${proj.minIncrVal}"</c:if>>
                                   <span>%</span>
                               </div>
                            </div>
                       </div>
                       <div class="form-group">
                           <label class="title">�������ƣ�</label>
                           <div class="input_area input-group input_area02">
                               <span class="first">��󽵷����ܳ����״α���</span>
                               <c:if test="${proj != null}">
                               <input type="text" class="form-control" id="quota_decr_limit" value="${proj.quotaDecrLimit}" ${ro}>
                               </c:if>
                               <c:if test="${proj == null}">
                               <input type="text" class="form-control" id="quota_decr_limit" value="100">
                               </c:if>
                               <span>%</span>
                           </div>
                       </div>
                       <div class="form-group">
                           <label class="title">���۴������ƣ�</label>
                           <div class="input_area">
                               <label class="checkbox-inline"><input type="radio" name="times_limit_type" value="1" ${ro} <c:if test="${proj == null or proj.timesLimitType == 1}">checked="checked"</c:if>>����</label>
                               <label class="checkbox-inline"><input type="radio" name="times_limit_type" value="2" ${ro} <c:if test="${proj.timesLimitType == 2}">checked="checked"</c:if>>�����ܱ��۴���</span></label>
                               <div class="input_area input-group input_area_special_last">
                                   <input type="text" class="form-control" id="times_limit_num" ${ro} <c:if test="${proj.timesLimitType != 2}"> readonly="readonly" </c:if> <c:if test="${proj.timesLimitType == 2}">value="${proj.timesLimitNum}"</c:if>>
                               </div>
                            </div>
                       </div>
                       <div class="form-group">
						   <label class="title">�Ƿ���ʾ��Ӧ����ͱ��ۣ�</label>
                           <div class="input_area" style="width:100px">
                               <label class="checkbox-inline">
                                   <input type="radio" name="show_min_quota" value="1" ${ro} <c:if test="${proj.showMinQuota == 1}">checked="checked"</c:if>>��
                               </label>
                               <label class="checkbox-inline">
                                   <input type="radio" name="show_min_quota" value="2" ${ro} <c:if test="${proj == null or proj.showMinQuota == 2}">checked="checked"</c:if>>��
                               </label>
                           </div>
                       </div>                       
                       <div class="form-group">
                           <label class="title">�ڱ�۸�</label>
                           <div class="input_area">
                               <label class="checkbox-inline">
                                   <input type="radio" name="accept_type" value="1" ${ro} <c:if test="${proj == null or proj.acceptType == 1}">checked="checked"</c:if>>��Ӧ�������ձ��۳ɽ�
                               </label>
                               <label class="checkbox-inline">
                                   <input type="radio" name="accept_type" value="2" ${ro} <c:if test="${proj.acceptType == 2}">checked="checked"</c:if>>��Ӧ������ͱ��۳ɽ�
                               </label>
                           </div>
                       </div>
                       <div class="form-group">
						   <label class="title">�������ۣ�</label>
                           <div class="input_area">
                               <label class="checkbox-inline">
                                   <input type="radio" name="publish_quota" value="1" ${ro} <c:if test="${proj.publishQuota == 1}">checked="checked"</c:if>>��
                               </label>
                               <label class="checkbox-inline">
                                   <input type="radio" name="publish_quota" value="2" ${ro} <c:if test="${proj == null or proj.publishQuota == 2}">checked="checked"</c:if>>��
                               </label>
                           </div>
                       </div>
                       <div class="form-group ">
                           <label class="title">�����ۼۣ�</label>
                           <div class="input_area input-group">
                               <input type="text" class="form-control" id="tender_price" value="${proj == null ? 0 : proj.tenderPrice}" ${ro}>
                               <span>Ԫ���������Ҫ��������0��</span>
                           </div>
                       </div>
                       <div class="form-group ">
                           <label class="title">Ͷ�걣֤��</label>
                           <div class="input_area input-group">
                               <input type="text" class="form-control" id="bid_bond" value="${proj == null ? 0 : proj.bidBond}" ${ro}>
                               <span>Ԫ���������Ҫ��������0��</span>
                           </div>
                       </div>
                   <!--.list_inner--></div>
               <!--.step_section--></div>
               <div class="submit_btn">
                   <ul>
                       <li><button class="btn btn-default gray_cart" data-step="2">��һ��</button></li>
                       <li><button class="btn btn-default blue" data-step="4" data-cur="3">��һ��</button></li>
                   </ul>
               </div>
          <!--#sec_inner_3--></div>
          <div id="sec_inner_4" style="display:none;">
               <div class="nav_step">
                  <ul class="clearfix">
                    <li class="done">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step01.png" alt="1"></span>ѡ�񾺼�����</a>
                    </li>
                    <li class="done">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step02.png" alt="1"></span>���Ӿ��۱��</a>
                    </li>
                    <li class="current_prev">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step03.png" alt="1"></span>���Ӿ��۸�Ҫ��Ϣ</a>
                    </li>
                    <li class="current">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step04.png" alt="1"></span>���Ӿ�����Ϣ</a>
                    </li>
                    <li class="last">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step05.png" alt="1"></span>���ӱ���</a>
                    </li>
                  </ul>
               </div>
               <div class="step_section section" id="step04">
                   <div class="list_inner clearfix">
                       <div class="form-group">
                           <label class="title">��Ŀ��ţ�</label>
                           <span class="proj-id-span"></span>
                       </div>
                       <div class="form-group">
                           <label class="title">��Ŀ���ƣ�</label>
                           <span class="proj-name-span"></span>
                       </div>
                       <div class="form-group special_group01">
                           <label class="title">����Ͷ�����ʸ�</label>
                           <div class="input_area">
                             <textarea class="form-control" rows="3" id="bidder_qual" ${ro}>${proj.bidderQual}</textarea>
                           </div>
                       </div>
                       <div class="form-group special_group01">
                           <label class="title">�����б��ļ������룺</label>
                           <div class="input_area">
                             <textarea class="form-control" rows="3" id="bid_invitation" ${ro}>${proj.bidInvitation}</textarea>
                           </div>
                       </div>
                       <div class="form-group special_group01">
                           <label class="title">���Ͼ��۲ɹ���ʱ��涨��</label>
                           <div class="input_area">
                             <textarea class="form-control" rows="3" id="bid_time_rule" ${ro}>${proj.bidTimeRule }</textarea>
                           </div>
                       </div>
                       <div class="form-group special_group01">
                           <label class="title">���߾���Ͷ�걨�ۣ�</label>
                           <div class="input_area">
                             <textarea class="form-control" rows="3" id="bid_quota_rule" ${ro}>${proj.bidQuotaRule}</textarea>
                           </div>
                       </div>
                       <div class="form-group special_group01">
                           <label class="title">ע�����</label>
                           <div class="input_area">
                             <textarea class="form-control" rows="3" id="caution" ${ro}>${proj.caution }</textarea>
                           </div>
                       </div>
                       <div class="form-group special_group01">
                           <label class="title">������</label>
                           <div class="input_area">
                             <textarea class="form-control" rows="3" id="remark" ${ro}>${proj.remark }</textarea>
                           </div>
                       </div>
                       
                   <!--.list_inner--></div>
               <!--.step_section--></div>
               <div class="submit_btn">
                   <ul>
                       <li><button class="btn btn-default gray_cart" data-step="3">��һ��</button></li>
                       <li><button class="btn btn-default blue" data-step="5" data-cur="4">��һ��</button></li>
                   </ul>
               </div>
          <!--#sec_inner_4--></div>
          <div id="sec_inner_5" style="display:none;">
               <div class="nav_step">
                  <ul class="clearfix">
                    <li class="done">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step01.png" alt="1"></span>ѡ�񾺼�����</a>
                    </li>
                    <li class="done">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step02.png" alt="1"></span>���Ӿ��۱��</a>
                    </li>
                    <li class="done">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step03.png" alt="1"></span>���Ӿ��۸�Ҫ��Ϣ</a>
                    </li>
                    <li class="current_prev">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step04.png" alt="1"></span>���Ӿ�����Ϣ</a>
                    </li>
                    <li class="last current">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step05.png" alt="1"></span>���ӱ���</a>
                    </li>
                  </ul>
               </div>
               <div class="step_section section" id="step05">
                   <div class="list_inner clearfix">
                       <div class="form-group">
                           <label class="title">��Ŀ��ţ�</label>
                           <span class="proj-id-span"></span>
                       </div>
                       <div class="form-group">
                           <label class="title">��Ŀ���ƣ�</label>
                           <span class="proj-name-span"></span>
                       </div>
                   <!--.list_inner--></div>
                   <div class="add_inner">
                       <div class="title_add clearfix">
                            <div class="title_inner clearfix">
                                <p>����Ҫ��</p>
                                <div class="btn_list">
                                	<c:if test="${func != 'detail'}">
                                    <button class="btn btn-default blue" data-toggle="modal" id="busi_add">����</button>
                                    </c:if>
                                </div>
                            </div>
                       </div>
                       
                       <!--������start-->
                       <div class="modal fade" id="busi_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                           <div class="modal-dialog">
                               <div class="modal-content">
                                   <div class="modal-header">
                                       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                       <h4 class="modal-title" id="myModalLabel">����Ҫ��</h4>
                                   </div>
                                   <div class="modal-body">
                                   		<input type="hidden" id="busi_id"/>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">���⣺</label>
                                           <div class="col-sm-10">
                                               <input class="form-control" id="tender_title_busi">
                                           </div>
                                       </div>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">��Ʊ���ͣ�</label>
                                           <div class="col-sm-10">
                                               <label class="checkbox-inline">
                                                   <input type="radio" name="invoice_type" id="invoice_type_3" value="3" checked>��ֵ��Ʊ
                                               </label>
                                               <label class="checkbox-inline">
                                                   <input type="radio" name="invoice_type" id="invoice_type_2" value="2">��ͨ��Ʊ
                                               </label>
                                               <label class="checkbox-inline">
                                                   <input type="radio" name="invoice_type" id="invoice_type_1" value="1">����Ҫ��Ʊ
                                               </label>
                                           </div>
                                       </div>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">�����ڣ�</label>
                                           <div class="col-sm-10">
                                                <div class="input_area input_area_day">
                                                    <span>�µ���</span>
                                                    <input class="form-control form-control_day" id="delivery_time">
                                                    <span>���ڽ������ɹ���ָ���ص�</span>
                                                </div>
                                           </div>
                                       </div>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">�ջ��أ�</label>
                                           <div class="col-sm-10">
                                                <div class="input_area input_area_day">
                                                    <select class="form-control form-control_place" id="addr_prov">
                                                    	<option value="">��ѡ��</option>
                                                    	<c:forEach var="i" items="${provs}">
                                                    	<option value="${i.supAreaID}">${i.supAreaName}</option>
                                                    	</c:forEach>
                                                    </select>
                                                    <span>ʡ</span>
                                                    <select class="form-control form-control_place" id="addr_city">
                                                    	<option value="">��ѡ��</option>
                                                    </select>
                                                    <span>��</span>
                                                    <select class="form-control form-control_place" id="addr_dist">
                                                    	<option value="">��ѡ��</option>
                                                    </select>
                                                    <span>��</span>
                                                    <input class="form-control form-control_place02" id="addr_detail">
                                                </div>
                                           </div>
                                       </div>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">������</label>
                                           <div class="col-sm-10">
                                                <textarea class="form-control" rows="3" id="tender_content_busi"></textarea>
                                                
	                                           <div class="input-append" id="file_show_busi" style="display:none;">
	                                              <input id="file_name_busi" class="input-large form-control" type="text" style="height:30px;" readonly="readonly"> 
	                                              <button type="button" class="btn btn-default red" id="file_del_busi">ɾ���ļ�</button>
	                                           </div>
                                               
	                                           <div class="input-append" id="file_input_busi"> 
	                                           
			                                       <form id="attach_form_busi" target="upload_target" action="${pageContext.request.contextPath}/management/bid/${act}/upload" enctype="multipart/form-data" method="post">
			                                           <input id="attach_file_busi" name="attach_file" type="file" style="display:none">
			                                       </form>
	                                              <input id="attach_field_busi" class="input-large form-control" type="text" style="height:30px;" readonly="readonly"> 
	                                              <a class="btn btn-default red" onclick="$('#attach_file_busi').click();">����ļ�</a>
	                                              <button type="button" class="btn btn-default red" id="attach_upload_busi">��ʼ�ϴ�</button>
	                                              <input type="hidden" id="attach_path_busi"/>
	                                              <input type="hidden" id="attach_name_busi"/>
	                                              
		                                           <script type="text/javascript"> 
		                                             $('#attach_file_busi').change(function() { 
		                                               $('#attach_field_busi').val($(this).val()); 
		                                             });
		                                           </script>
	                                           </div>
                                           
	                                       </div>
	                                     </div>
                                     </div>
                                   <div class="modal-footer">
                                       <button type="button" class="btn btn-default blue" id="busi_modal_ok">ȷ��</button>
                                       <button type="button" class="btn btn-default gray_cart" data-dismiss="modal">ȡ��</button>
                                   </div>
                               </div>
                           </div>
                       </div>
                       <!--������end-->
                       <table>
                           <tr>
                               <th width="60">���</th>
                               <th width="200">����</th>
                               <th width="120">��Ʊ����</th>
                               <th width="150">������</th>
                               <th width="120">�ջ���</th>
                               <th>����</th>
                               <th width="120">�ļ�</th>
                              	<c:if test="${func != 'detail'}">
                               <th class="last" width="90">����</th>
                               </c:if>
                           </tr>
                           <tbody id="busi_tbody">
                           <c:forEach var="i" items="${proj.tenders}">
                           <c:if test="${i.tenderType == 1}">
                                <tr id="busi_tr_${i.tenderId}">
                                  <td>${i.tenderId}</td>
                                  <td>${i.tenderTitle}</td>
                                  <td data-val="${i.invoiceType}">
                                  	<c:if test="${i.invoiceType == 1}">����Ҫ</c:if>
                                  	<c:if test="${i.invoiceType == 2}">��ͨ��Ʊ</c:if>
                                  	<c:if test="${i.invoiceType == 3}">��ֵ��Ʊ</c:if>                                  
                                  </td>
                                  <td>${i.deliveryTime}��</td>
                                  <td data-prov="${i.addrProv}" data-city="${i.addrCity}" data-dist="${i.addrDist}" data-detail="${i.addrDetail}">${i.addrProvName} ${i.addrCityName} ${i.addrDistName} ${i.addrDetail}</td>
                                  <td>${i.tenderContent}</td>
                                  <td data-path="${i.attachPath}"><a href="javascript:;" onclick="downclick(this);">${i.attachName}</a></td>
                              	<c:if test="${func != 'detail'}">
                                  <td><a href="javascript:;" onclick="busiEdit(this);">�޸�</a><a href="javascript:;" onclick="busiDel(this);">ɾ��</a></td>
                               </c:if>
                                </tr>
                           </c:if>
                           </c:forEach>   
                           </tbody>
                           <!-- 
                           <tr>
                               <td>1</td>
                               <td></td>
                               <td></td>
                               <td></td>
                               <td></td>
                               <td></td>
                               <td></td>
                               <td><a href="#">ɾ��</a><a href="#">�༭</a></td>
                           </tr>
                            -->
                       </table>
                   <!--.add_inner--></div>
                   <div class="add_inner">
                       <div class="title_add clearfix">
                            <div class="title_inner clearfix">
                                <p>����Ҫ��</p>
                                <div class="btn_list">
                              	<c:if test="${func != 'detail'}">
                                    <button class="btn btn-default blue" data-toggle="modal" id="tech_add">����</button>
                               </c:if>
                                </div>
                            </div>
                       </div>
                       
                       <!--������start-->
                       <div class="modal fade" id="tech_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                           <div class="modal-dialog">
                               <div class="modal-content">
                                   <div class="modal-header">
                                       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                       <h4 class="modal-title" id="myModalLabel">����Ҫ��</h4>
                                   </div>
                                   <div class="modal-body">
                                   		<input type="hidden" id="tech_id"/>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">���⣺</label>
                                           <div class="col-sm-10">
                                               <input class="form-control" id="tender_title_tech">
                                           </div>
                                       </div>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">���ݣ�</label>
                                           <div class="col-sm-10">
                                                <textarea class="form-control" rows="3" id="tender_content_tech"></textarea>
                                                
	                                           <div class="input-append" id="file_show_tech" style="display:none;">
	                                              <input id="file_name_tech" class="input-large form-control" type="text" style="height:30px;" readonly="readonly"> 
	                                              <button type="button" class="btn btn-default red" id="file_del_tech">ɾ���ļ�</button>
	                                           </div>
                                               
                                                
	                                           <div class="input-append" id="file_input_tech"> 
                                                
			                                       <form id="attach_form_tech" target="upload_target" action="${pageContext.request.contextPath}/management/bid/${act}/upload" enctype="multipart/form-data" method="post">
			                                           <input id="attach_file_tech" name="attach_file" type="file" style="display:none">
			                                       </form>
	                                              <input id="attach_field_tech" class="input-large form-control" type="text" style="height:30px;" readonly="readonly"> 
	                                              <a class="btn btn-default red" onclick="$('#attach_file_tech').click();">����ļ�</a>
	                                              <button type="button" class="btn btn-default red" id="attach_upload_tech">��ʼ�ϴ�</button>
	                                              <input type="hidden" id="attach_path_tech"/>
	                                              <input type="hidden" id="attach_name_tech"/>
	                                           </div>
	                                           <script type="text/javascript"> 
	                                             $('#attach_file_tech').change(function() { 
	                                               $('#attach_field_tech').val($(this).val()); 
	                                             });
	                                           </script>
                                           </div>
                                       </div>
                                     </div>
                                   <div class="modal-footer">
                                       <button type="button" class="btn btn-default blue" id="tech_modal_ok">ȷ��</button>
                                       <button type="button" class="btn btn-default gray_cart" data-dismiss="modal">ȡ��</button>
                                   </div>
                               </div>
                           </div>
                       </div>
                       <!--������end-->
                       <table>
                           <tr>
                               <th width="60">���</th>
                               <th width="200">����</th>
                               <th>����</th>
                               <th width="120">�ļ�</th>
                              	<c:if test="${func != 'detail'}">
                               <th class="last" width="90">����</th>
                               </c:if>
                           </tr>
                           <tbody id="tech_tbody">
                           <c:forEach var="i" items="${proj.tenders}">
                           <c:if test="${i.tenderType == 2}">
                                <tr id="tech_tr_${i.tenderId}">
                                  <td>${i.tenderId}</td>
                                  <td>${i.tenderTitle}</td>
								  <td>${i.tenderContent}</td>
                                  <td data-path="${i.attachPath}"><a href="javascript:;" onclick="downclick(this);">${i.attachName}</a></td>
                              	<c:if test="${func != 'detail'}">
                                  <td><a href="javascript:;" onclick="techEdit(this);">�޸�</a><a href="javascript:;" onclick="techDel(this);">ɾ��</a></td>
                                  </c:if>
                                </tr>
                           </c:if>
                           </c:forEach>   
                           </tbody>
                           <!-- 
                           <tr>
                               <td>1</td>
                               <td></td>
                               <td></td>
                               <td></td>
                               <td><a href="#">ɾ��</a><a href="#">�༭</a></td>
                           </tr>
                            -->
                       </table>
                   <!--.add_inner--></div>
               <!--.step_section--></div>
               <div class="submit_btn">
                   <ul>
                       <li><button class="btn btn-default gray_cart" data-step="4">��һ��</button></li>
                        <c:if test="${func != 'detail'}">
                       <li><button class="btn btn-default blue submit-btn" data-action="save">����</button></li>
                       <li><button class="btn btn-default blue submit-btn" data-action="publish">��������</button></li>
                       </c:if>
                       
                      	<c:if test="${func == 'detail'}">
                       <li><button class="btn btn-default blue" onclick="javascript:history.go(-1);">����</button></li>
                      	</c:if>
                   </ul>
               </div>
          <!--#sec_inner_5--></div>
          <!--#matter_section--></div>
      <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp"/>
<!--.page-wrapper--></div>	
<form action="${pageContext.request.contextPath}/management/bid/${act}/downfile" method="post" id="down_form" target="upload_target">
	<input type="hidden" name="path" id="down_path"/>
	<input type="hidden" name="name" id="down_name"/>
</form>
<iframe width="0" height="0" border="0" style="display: none;" name="upload_target" id="upload_target"></iframe>
									
</body>
</html>