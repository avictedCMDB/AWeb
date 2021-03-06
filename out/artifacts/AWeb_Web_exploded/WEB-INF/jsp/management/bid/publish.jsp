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
<title>发布竞价采购|中航招标网</title>
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
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bid/management/publish.js?v=20170606"></script>

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
      <jsp:include page="../left_menu.jsp"/>
          <div id="matter_section">
          <div id="sec_inner_1">
               <div class="nav_step">
                  <ul class="clearfix">
                    <li class="current">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step01.png" alt="1"></span>选择竞价类型</a>
                    </li>
                    <li>
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step02.png" alt="1"></span>添加竞价标的</a>
                    </li>
                    <li>
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step03.png" alt="1"></span>添加竞价概要信息</a>
                    </li>
                    <li>
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step04.png" alt="1"></span>添加竞价信息</a>
                    </li>
                    <li class="last">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step05.png" alt="1"></span>添加标书</a>
                    </li>
                  </ul>
               </div>
               <div class="step_section section" id="step01">
                   <div class="list_inner clearfix">
                       <div class="form-group">
                           <label class="title">采购类型</label>
                           <div class="input_area">
                               <select class="form-control" id="bid_cat" name="bid_cat" ${ro}>
                                   <option value="">请选择</option>
                                   <c:forEach var="i" items="${cats}">
                                   <option value="${i.codeValue }" <c:if test="${i.codeValue == proj.bidCat}">selected="selected"</c:if>>${i.codeText }</option>
                                   </c:forEach>
                               </select>
                           </div>
                       </div>
                       <div class="form-group">
                           <label class="title">竞价项目编号</label>
                           <div class="input_area">
                               <input type="text" class="form-control" id="proj_id" name="proj_id" readonly="readonly" value="${projId}">
                           </div>
                       </div>
                       <div class="form-group">
                           <label class="title">竞价项目名称</label>
                           <div class="input_area">
                               <input type="text" class="form-control" id="proj_name" name="proj_name" ${ro} maxlength="100" value="${proj.projName}">
                           </div>
                       </div>
                       <div class="form-group">
                           <label class="title">竞价类型</label>
                           <div class="input_area">
                               <select class="form-control" id="proj_type" name="proj_type" ${ro}>
                                   <option value="1" <c:if test="${proj.projType == 1}">selected="selected"</c:if>>邀请竞价</option>
                                   <option value="2" <c:if test="${proj.projType == 2}">selected="selected"</c:if>>公开竞价</option>
                               </select>
                           </div>
                       </div>
                       <div class="form-group">
                           <label class="title">决标方式</label>
                           <div class="input_area">
                               <select class="form-control" id="decide_type" name="decide_type" ${ro}>
                                   <option value="1" <c:if test="${proj.decideType == 1}">selected="selected"</c:if>>价格决标</option>
                                   <option value="2" <c:if test="${proj.decideType == 2}">selected="selected"</c:if>>评标决标</option>
                               </select>
                           </div>
                       </div>
                       <div class="form-group special_group">
                           <label class="title">币种</label>
                           <div class="input_area input_area_special">
                               <select class="form-control" id="currency" name="currency" ${ro}>
                                   <c:forEach var="i" items="${currencys}">
                                   <option value="${i.codeValue }" <c:if test="${i.codeValue == proj.currency}">selected="selected"</c:if>>${i.codeText }</option>
                                   </c:forEach>
                               </select>
                           </div>
                       </div>
                       <div class="form-group special_group special_group02">
                           <label class="title">汇率</label>
                           <div class="input_area input_area_special">
                               <input type="text" class="form-control" id="exchange_rate" name="exchange_rate" maxlength="10" value="${proj == null ? '1' : proj.exchangeRate}" ${ro}>
                           </div>
                       </div>
                       <div class="form-group">
                           <label class="title title_special">采购预算</label>
                           <div class="input_area input-group input_area_special">
                               <input type="text" class="form-control" id="budget" name="budget" maxlength="10" value="${proj == null || proj.budget == 0 ? '' : proj.budget}" ${ro}>
                               <span>元</span>
                           </div>
                           <label class="title">是否公开：</label>
                           <div class="input_area input-group input_area_special" style="margin-top:3px;">
                               <label class="checkbox-inline">
                                   <input type="radio" name="budget_public" value="1" ${ro} <c:if test="${proj.budgetPublic == 1}">checked="checked"</c:if>>是
                               </label>
                               <label class="checkbox-inline">
                                   <input type="radio" name="budget_public" value="2" ${ro} <c:if test="${proj == null or proj.budgetPublic == 2}">checked="checked"</c:if>>否
                               </label>
                          </div>
                       </div>
                       <div class="form-group">
                           <label class="title title_special">最少投标单位数量</label>
                           <div class="input_area input-group input_area_special">
                               <input type="text" class="form-control" id="min_tender" name="min_tender" maxlength="4" value="${proj == null ? '2' : proj.minTender}" ${ro}>
                               <span>家</span>
                           </div>
                       </div>
                   <!--.list_inner--></div>
                   <div class="add_inner">
                       <div class="btn_list">
                       <c:if test="${func != 'detail'}">
                           <button class="btn btn-default blue" id="mtr_add">添加项目条目</button>
                       </c:if>
                       </div>
                       <!--弹出框start-->
                       <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                           <div class="modal-dialog">
                               <div class="modal-content">
                                   <div class="modal-header">
                                       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                       <h4 class="modal-title" id="myModalLabel">添加采购商品</h4>
                                   </div>
                                   <div class="modal-body">
                                       <label class="checkbox-inline">
                                           <input type="radio" name="mtr_select" value="1" checked>导入采购条目
                                       </label>
                                       <label class="checkbox-inline">
                                           <input type="radio" name="mtr_select" value="2">从物料库查找
                                       </label>
                                       <div class="select_area" id="templet01">
                                       <form id="mtr_form" target="upload_target" action="${pageContext.request.contextPath}/management/bid/${act}/mtr/import" enctype="multipart/form-data" method="post">
                                           <input id="mtr_file" name="mtr_file" type="file" style="display:none">
                                       </form>
                                           <div class="input-append"> 
                                              <input id="mtr_field" class="input-large form-control" type="text" style="height:30px;" readonly="readonly"> 
                                              <a class="btn btn-default red" onclick="$('#mtr_file').click();">浏览文件</a>
                                              <button type="button" class="btn btn-default red" id="mtr_upload">开始上传</button>
                                              <label><a href="${pageContext.request.contextPath}/management/bid/${act}/mtr/template" target="_blank">物料导入模板下载</a></label>
                                           </div>
                                           <script type="text/javascript"> 
                                             $('#mtr_file').change(function() { 
                                               $('#mtr_field').val($(this).val()); 
                                             });
                                           </script>
                                           <div class="result_info">
                                               <p id="mtr_result">导入信息</p>
                                           </div>
                                       </div>
                                       <div class="select_area" id="templet02" style="display:none;">
                                           <div class="form-group">
                                              <label class="title">物料名称</label>
                                              <div class="input_area">
                                                  <input type="text" class="form-control" id="mtr_query_name">
                                              </div>
                                           </div>
                                           <div class="btn_list">
                                               <button class="btn btn-default blue" id="mtr_query">查询</button>
                                               <button class="btn btn-default blue" id="mtr_query_add">添加</button>
                                           </div>
                                           <div class="table_list">
                                               <table>
                                                  <tr>
                                                    <th width="40"></th>
                                                    <th>物料名称</th>
                                                    <th>品牌</th>
                                                    <th class="last">规格型号</th>
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
                                       <button type="button" class="btn btn-default blue" data-dismiss="modal">确定</button>
                                       <button type="button" class="btn btn-default gray_cart" data-dismiss="modal">取消</button>
                                   </div>
                               </div>
                           </div>
                       </div>
                       <!--弹出框end-->
                       <table>
                           <tr>
                               <th width="120">物料名称</th>
                               <th width="90">数量</th>
                               <th width="70">单位</th>
                               <th>品牌厂商</th>
                               <th width="90">型号</th>
                               <th width="90">商品单价</th>
                               <th width="70">是否标配</th>
                               <th width="90">售后服务</th>
                               <th width="90">规格配置</th>
                               <c:if test="${func != 'detail' }">
                               <th class="last" width="90">操作</th>
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
                                  <td>${i.materPrice}</td>
                                  <td>${i.ifStandard}</td>
                                  <td>${i.saleService}</td>
                                  <td>${i.specConf}</td>
                               <c:if test="${func != 'detail' }">
                                  <td><a href="javascript:;" onclick="mtrDel(this);">删除</a></td>
                               </c:if>
                                </tr>
                           </c:forEach>   
                           </tbody>
                       </table>
                   <!--.add_inner--></div>
               <!--.step_section--></div>
               <div class="submit_btn">
                   <ul>
                       <li><button class="btn btn-default blue" data-step="2" data-cur="1">下一步</button></li>
                       <!-- <li><button class="btn btn-default gray_cart">取消</button></li>  -->
                   </ul>
               </div>
          <!-- #sec_inner_1 --></div>
          <div id="sec_inner_2" style="display:none;">
               <div class="nav_step">
                  <ul class="clearfix">
                    <li class="current_prev">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step01.png" alt="1"></span>选择竞价类型</a>
                    </li>
                    <li class="current">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step02.png" alt="1"></span>添加竞价标的</a>
                    </li>
                    <li>
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step03.png" alt="1"></span>添加竞价概要信息</a>
                    </li>
                    <li>
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step04.png" alt="1"></span>添加竞价信息</a>
                    </li>
                    <li class="last">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step05.png" alt="1"></span>添加标书</a>
                    </li>
                  </ul>
               </div>
               <div class="step_section section" id="step02">
                   <div class="list_inner clearfix">
                       <div class="form-group">
                           <label class="title">项目编号：</label>
                           <span class="proj-id-span"></span>
                       </div>
                       <div class="form-group">
                           <label class="title">项目名称：</label>
                           <span class="proj-name-span"></span>
                       </div>
                       <div class="form-group special_group01">
                           <label class="title">报价方式：</label>
                           <div class="input_area">
                               <label class="checkbox-inline">
                                   <input type="radio" name="quota_type" value="1" ${ro} <c:if test="${proj == null or proj.quotaType == 1}">checked="checked"</c:if>>单个标的报价单
                               </label>
                               <label class="checkbox-inline">
                                   <input type="radio" name="quota_type" value="2" ${ro} <c:if test="${proj.quotaType == 2}">checked="checked"</c:if>>多个标的报总价
                               </label>
                          </div>
                       </div>
                       <div class="form-group special_group01">
                           <label class="title">报价上限：</label>
                           <div class="input_area">
                               <label class="checkbox-inline"><input type="radio" name="quota_limit_type" value="1" ${ro} <c:if test="${proj == null or proj.quotaLimitType == 1}">checked="checked"</c:if>>不设报价上限</label>
                               <label class="checkbox-inline"><input type="radio" name="quota_limit_type" value="2" ${ro} <c:if test="${proj.quotaLimitType == 2}">checked="checked"</c:if>>报价上限为</span></label>
                               <div class="input_area input-group input_area_special">
                                   <input type="text" class="form-control" id="quota_limit_num" maxlength="10" ${ro} <c:if test="${proj.quotaLimitType != 2}">readonly="readonly"</c:if> <c:if test="${proj.quotaLimitType == 2}">value="${proj.quotaLimitNum}"</c:if>>
                                   <span>元</span>
                               </div>
                            </div>
                       </div>
                   <!--.list_inner--></div>
                   <div class="add_inner add_inner_first">
                       <div class="title_add clearfix">
                            <div class="title_inner clearfix">
                                <p>竞价标的</p>
                                <div class="btn_list">
                                <c:if test="${func != 'detail'}">
                                    <button class="btn btn-default blue" data-toggle="modal" id="subject_add">添加标的</button>
                                </c:if>
                                </div>
                            </div>
                       </div>

                       <!--弹出框 添加标的start-->
                       <div class="modal fade" id="subjectModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                           <div class="modal-dialog">
                               <div class="modal-content">
                                   <div class="modal-header">
                                       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                       <h4 class="modal-title" id="myModalLabel">添加标的</h4>
                                   </div>
                                   <div class="modal-body clearfix">
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">标的编码：</label>
                                           <div class="col-sm-10">
                                               <input class="form-control" id="subject_id" readonly="readonly">
                                           </div>
                                       </div>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">标的名称：</label>
                                           <div class="col-sm-10">
                                               <input class="form-control" id="subject_name">
                                           </div>
                                       </div>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">数量：</label>
                                           <div class="col-sm-10">
                                               <input class="form-control" id="subject_num">
                                           </div>
                                       </div>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">计量单位：</label>
                                           <div class="col-sm-10">
                                               <input class="form-control" id="subject_unit">
                                           </div>
                                       </div>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">说明：</label>
                                           <div class="col-sm-10">
                                               <textarea class="form-control" rows="3" id="intro"></textarea>
                                           </div>
                                       </div>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">物料信息：</label>
                                           <div class="col-sm-10" id="mtr_sel">
                                               
                                           </div>
                                       </div>
                                   </div>
                                   <div class="modal-footer">
                                       <button type="button" class="btn btn-default blue" id="subject_modal_ok">确定</button>
                                       <button type="button" class="btn btn-default gray_cart" data-dismiss="modal">取消</button>
                                   </div>
                               </div>
                           </div>
                       </div>
                       <!--弹出框 添加标的end-->
                       <table>
                           <tr>
                               <th width="120">标的编码</th>
                               <th width="250">标的名称</th>
                               <th width="90">数量</th>
                               <th width="90">计量单位</th>
                               <th>说明</th>
                                <c:if test="${func != 'detail'}">
                               <th class="last" width="120">操作</th>
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
                                  <td><a href="javascript:;" onclick="subjectEdit(this);">修改</a><a href="javascript:;" onclick="subjectDel(this);">删除</a></td>
                                </c:if>
                                </tr>
                           </c:forEach>   
                           </tbody>
                       </table>
                   <!--.add_inner--></div>
                   <!--  <div class="add_inner">
                       <div class="title_add clearfix">
                            <div class="title_inner clearfix">
                                <p>拆分方案：<span>（如果不拆分，可以不填写内容）</span><span><input type="radio" name="split_type" value="1" ${ro} <c:if test="${proj == null or proj.splitType == 1}">checked="checked"</c:if>>对供应商可见</span><span><input type="radio" name="split_type" value="2" ${ro} <c:if test="${proj.splitType == 2}">checked="checked"</c:if>>对供应商不可见</span></p>
                                <div class="btn_list">
                                <c:if test="${func != 'detail'}">
                                    <button class="btn btn-default blue" data-toggle="modal" id="split_add">添加拆分方案</button>
                                </c:if>
                                </div>
                            </div>
                       </div>
                      
                               <div class="modal fade" id="split_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                   <div class="modal-dialog">
                                       <div class="modal-content">
                                           <div class="modal-header">
                                               <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                               <h4 class="modal-title" id="myModalLabel">添加分配比例</h4>
                                           </div>
                                           <div class="modal-body">
                                               <div class="form-group clearfix">
                                                 <label class="col-sm-2 control-label">竞价名次：</label>
                                                 <label class="col-sm-10" id="bid_rank">001</label>
                                              </div>
                                              <div class="form-group clearfix">
                                                 <label class="col-sm-2 control-label">分配比例：</label>
                                                 <div class="col-sm-10">
                                                     <input class="form-control" id="split_prop">
                                                 </div>
                                              </div> 
                                           </div>
                                           <div class="modal-footer">
                                               <button type="button" class="btn btn-default blue" id="split_modal_ok">确定</button>
                                               <button type="button" class="btn btn-default gray_cart" data-dismiss="modal">取消</button>
                                           </div>
                                       </div>
                                   </div>
                               </div>
                             
                       <table>
                           <tr>
                               <th>竞价名次</th>
                               <th>分配比例</th>
                                <c:if test="${func != 'detail'}">
                               <th class="last" width="120">操作</th>
                                </c:if>
                           </tr>
                           <tbody id="split_tbody">
                           <c:forEach var="i" items="${proj.splits}">
                                <tr>
                                  <td>${i.bidRank}</td>
                                  <td>${i.splitProp}</td>
                                <c:if test="${func != 'detail'}">
                                  <td><a href="javascript:;" onclick="splitDel(this);">删除</a></td>
                                </c:if>
                                </tr>
                           </c:forEach>   
                           </tbody>
                       </table>
                  </div>-->
                   <div class="add_inner" id="sup_select">
                       <div class="title_add clearfix">
                            <div class="title_inner clearfix">
                                <p>供应商</p>
                                <div class="btn_list">
                                <c:if test="${func != 'detail'}">
                                    <button class="btn btn-default blue" data-toggle="modal" id="supplier_add">添加供应商</button>
                                </c:if>
                                </div>
                            </div>
                       </div>
                       <!--弹出框start-->
                               <div class="modal fade" id="supplier_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                   <div class="modal-dialog">
                                       <div class="modal-content">
                                           <div class="modal-header">
                                               <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                               <h4 class="modal-title" id="myModalLabel">添加供应商</h4>
                                           </div>
                                           <div class="modal-body">
                                               <div class="sreach_area">
                                                   <div class="form-group clearfix">
                                                       <label class="col-sm-2 control-label">供应商编号：</label>
                                                       <div class="col-sm-4">
                                                           <input class="form-control" id="sup_code">
                                                       </div>
                                                       <label class="col-sm-2 control-label">供应商名称：</label>
                                                       <div class="col-sm-4">
                                                           <input class="form-control" id="sup_name">
                                                       </div>
                                                   </div>
                                                   <div class="form-group clearfix">
                                                       <label class="col-sm-2 control-label">联系人：</label>
                                                       <div class="col-sm-4">
                                                           <input class="form-control" id="contact_person">
                                                       </div>
                                                       <label class="col-sm-2 control-label">联系人电话：</label>
                                                       <div class="col-sm-4">
                                                           <input class="form-control" id="contact_num">
                                                       </div>
                                                   </div>
                                               </div>
                                               <div class="submit_btn">
                                                    <button class="btn btn-default blue" id="supplier_query">搜索</button>
                                               </div>
                                               <table>
                                                     <tr>
                                                         <th width="40"></th>
                                                         <th width="90">供应商编号</th>
                                                         <th width="90">供应商名称</th>
                                                         <th width="90">联系人</th>
                                                         <th width="90">联系人电话</th>
                                                         <th class="last">邮件</th>
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
                                               <button type="button" class="btn btn-default blue" id="supplier_modal_ok">确定</button>
                                               <button type="button" class="btn btn-default gray_cart" data-dismiss="modal">取消</button>
                                           </div>
                                       </div>
                                   </div>
                               </div>
                               <!--弹出框end-->
                       <table>
                           <tr>
                               <th width="150">供应商编码</th>
                               <th>公司名称</th>
                               <th width="120">联系人</th>
                               <th width="120">联系电话</th>
                               <th width="120">邮件</th>
                                <c:if test="${func != 'detail'}">
                               <th class="last" width="120">操作</th>
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
                                  <td><a href="javascript:;" onclick="supplierDel(this);">删除</a></td>
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
                               <td class="center"><a href="#">删除</a></td>
                           </tr>
                            -->
                       </table>
                   <!--.add_inner--></div>
               <!--.step_section--></div>
               <div class="submit_btn">
                   <ul>
                       <li><button class="btn btn-default gray_cart" data-step="1">上一步</button></li>
                       <li><button class="btn btn-default blue" data-step="3" data-cur="2">下一步</button></li>
                   </ul>
               </div>
          <!--#sec_inner_2--></div>
          <div id="sec_inner_3" style="display:none;">
               <div class="nav_step">
                  <ul class="clearfix">
                    <li class="done">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step01.png" alt="1"></span>选择竞价类型</a>
                    </li>
                    <li class="current_prev">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step02.png" alt="1"></span>添加竞价标的</a>
                    </li>
                    <li class="current">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step03.png" alt="1"></span>添加竞价概要信息</a>
                    </li>
                    <li>
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step04.png" alt="1"></span>添加竞价信息</a>
                    </li>
                    <li class="last">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step05.png" alt="1"></span>添加标书</a>
                    </li>
                  </ul>
               </div>
               <div class="step_section section" id="step03">
                   <div class="list_inner clearfix">
                       <div class="form-group">
                           <label class="title">项目编号：</label>
                           <span class="proj-id-span"></span>
                       </div>
                       <div class="form-group">
                           <label class="title">项目名称：</label>
                           <span class="proj-name-span"></span>
                       </div>
                       <div class="form-group">
                           <label class="title">竞价开始时间：</label>
                           <div class="input_area input-group input-group_special">
                               <input type="text" class="form-control" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm', onpicked:bidStartTimePicked})" id="bid_start_time" ${ro} value="<fmt:formatDate value="${proj.bidStartTime}" pattern="yyyy-MM-dd HH:mm"/>" readonly="readonly" <c:if test="${func != 'detail'}"> style="background-color:#fff" </c:if>>
                               <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                           </div>
                       </div>
                       <div class="form-group">
                           <label class="title">报名截至时间：</label>
                           <div class="input_area input-group input-group_special">
                               <input type="text" class="form-control form_special" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" id="join_end_time" readonly="readonly" value="<fmt:formatDate value="${proj.joinEndTime}" pattern="yyyy-MM-dd HH:mm"/>" readonly="readonly" <c:if test="${func != 'detail'}"> style="background-color:#fff" </c:if>>
                               <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                           </div>
                       </div>
                       <div class="form-group">
                           <label class="title">正式竞价时长：</label>
                           <div class="input_area input-group input_area_special">
                               <input type="text" class="form-control form-control01" id="bid_duration" value="${proj.bidDuration}" ${ro}>
                               <span>分</span>
                          </div>
                       </div>
                       <div class="form-group">
                           <label class="title">超时竞价时间间隔：</label>
                           <div class="input_area input-group input_area_special">
                               <input type="text" class="form-control form-control01" id="timeout_interval" value="${proj.timeoutInterval}" ${ro}>
                               <span>秒</span>
                           </div>
                       </div>
                       <div class="form-group">
                           <label class="title">最低降价幅度：</label>
                           <div class="input_area">
                               <label class="checkbox-inline"><input type="radio" name="min_incr_type" value="1" ${ro} <c:if test="${proj == null or proj.minIncrType == 1}">checked="checked"</c:if>>无限制</label>
                               <label class="checkbox-inline"><input type="radio" name="min_incr_type" value="2" ${ro} <c:if test="${proj.minIncrType == 2}">checked="checked"</c:if>>数值</label>
                               <div class="input_area input-group input_area_special_last">
                                   <input type="text" class="form-control" id="min_incr_val_2"  ${ro} <c:if test="${proj.minIncrType != 2}"> readonly="readonly" </c:if> <c:if test="${proj.minIncrType == 2}">value="${proj.minIncrVal}"</c:if>>
                               </div>
                               <label class="checkbox-inline"><input type="radio" name="min_incr_type" value="3" ${ro} <c:if test="${proj.minIncrType == 3}">checked="checked"</c:if>>总价百分比</label>
                               <div class="input_area input-group input_area_special_last">
                                   <input type="text" class="form-control" id="min_incr_val_3"  ${ro} <c:if test="${proj.minIncrType != 3}"> readonly="readonly" </c:if> <c:if test="${proj.minIncrType == 3}">value="${proj.minIncrVal}"</c:if>>
                                   <span>%</span>
                               </div>
                            </div>
                       </div>
                       <div class="form-group">
                           <label class="title">报价限制：</label>
                           <div class="input_area input-group input_area02">
                               <span class="first">最大降幅不能超过首次报价</span>
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
                           <label class="title">报价次数限制：</label>
                           <div class="input_area">
                               <label class="checkbox-inline"><input type="radio" name="times_limit_type" value="1" ${ro} <c:if test="${proj == null or proj.timesLimitType == 1}">checked="checked"</c:if>>不限</label>
                               <label class="checkbox-inline"><input type="radio" name="times_limit_type" value="2" ${ro} <c:if test="${proj.timesLimitType == 2}">checked="checked"</c:if>>限制总报价次数</span></label>
                               <div class="input_area input-group input_area_special_last">
                                   <input type="text" class="form-control" id="times_limit_num" ${ro} <c:if test="${proj.timesLimitType != 2}"> readonly="readonly" </c:if> <c:if test="${proj.timesLimitType == 2}">value="${proj.timesLimitNum}"</c:if>>
                               </div>
                            </div>
                       </div>
                       <div class="form-group">
						   <label class="title">是否显示供应商最低报价：</label>
                           <div class="input_area" style="width:100px">
                               <label class="checkbox-inline">
                                   <input type="radio" name="show_min_quota" value="1" ${ro} <c:if test="${proj.showMinQuota == 1}">checked="checked"</c:if>>是
                               </label>
                               <label class="checkbox-inline">
                                   <input type="radio" name="show_min_quota" value="2" ${ro} <c:if test="${proj == null or proj.showMinQuota == 2}">checked="checked"</c:if>>否
                               </label>
                           </div>
                       </div>
                       <div class="form-group">
                           <label class="title">授标价格：</label>
                           <div class="input_area">
                               <label class="checkbox-inline">
                                   <input type="radio" name="accept_type" value="1" ${ro} <c:if test="${proj == null or proj.acceptType == 1}">checked="checked"</c:if>>供应商以最终报价成交
                               </label>
                               <label class="checkbox-inline">
                                   <input type="radio" name="accept_type" value="2" ${ro} <c:if test="${proj.acceptType == 2}">checked="checked"</c:if>>供应商以最低报价成交
                               </label>
                           </div>
                       </div>
                       <div class="form-group">
						   <label class="title">公开报价：</label>
                           <div class="input_area">
                               <label class="checkbox-inline">
                                   <input type="radio" name="publish_quota" value="1" ${ro} <c:if test="${proj.publishQuota == 1}">checked="checked"</c:if>>是
                               </label>
                               <label class="checkbox-inline">
                                   <input type="radio" name="publish_quota" value="2" ${ro} <c:if test="${proj == null or proj.publishQuota == 2}">checked="checked"</c:if>>否
                               </label>
                           </div>
                       </div>
                       <div class="form-group ">
                           <label class="title">标书售价：</label>
                           <div class="input_area input-group">
                               <input type="text" class="form-control" id="tender_price" value="${proj == null ? 0 : proj.tenderPrice}" ${ro}>
                               <span>元（如果不需要，可以填0）</span>
                           </div>
                       </div>
                       <div class="form-group ">
                           <label class="title">投标保证金：</label>
                           <div class="input_area input-group">
                               <input type="text" class="form-control" id="bid_bond" value="${proj == null ? 0 : proj.bidBond}" ${ro}>
                               <span>元（如果不需要，可以填0）</span>
                           </div>
                       </div>
                   <!--.list_inner--></div>
               <!--.step_section--></div>
               <div class="submit_btn">
                   <ul>
                       <li><button class="btn btn-default gray_cart" data-step="2">上一步</button></li>
                       <li><button class="btn btn-default blue" data-step="4" data-cur="3">下一步</button></li>
                   </ul>
               </div>
          <!--#sec_inner_3--></div>
          <div id="sec_inner_4" style="display:none;">
               <div class="nav_step">
                  <ul class="clearfix">
                    <li class="done">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step01.png" alt="1"></span>选择竞价类型</a>
                    </li>
                    <li class="done">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step02.png" alt="1"></span>添加竞价标的</a>
                    </li>
                    <li class="current_prev">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step03.png" alt="1"></span>添加竞价概要信息</a>
                    </li>
                    <li class="current">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step04.png" alt="1"></span>添加竞价信息</a>
                    </li>
                    <li class="last">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step05.png" alt="1"></span>添加标书</a>
                    </li>
                  </ul>
               </div>
               <div class="step_section section" id="step04">
                   <div class="list_inner clearfix">
                       <div class="form-group">
                           <label class="title">项目编号：</label>
                           <span class="proj-id-span"></span>
                       </div>
                       <div class="form-group">
                           <label class="title">项目名称：</label>
                           <span class="proj-name-span"></span>
                       </div>
                       <div class="form-group special_group01">
                           <label class="title">竞价投标人资格：</label>
                           <div class="input_area">
                             <textarea class="form-control" rows="3" id="bidder_qual" ${ro}><c:if test="${proj == null }">无</c:if><c:if test="${proj != null}">${proj.bidderQual }</c:if></textarea>
                           </div>
                       </div>
                       <div class="form-group special_group01">
                           <label class="title">竞价招标文件的邀请：</label>
                           <div class="input_area">
                             <textarea class="form-control" rows="3" id="bid_invitation" ${ro}><c:if test="${proj == null }">无</c:if><c:if test="${proj != null}">${proj.bidInvitation }</c:if></textarea>
                           </div>
                       </div>
                       <div class="form-group special_group01">
                           <label class="title">网上竞价采购的时间规定：</label>
                           <div class="input_area">
                             <textarea class="form-control" rows="3" id="bid_time_rule" ${ro}><c:if test="${proj == null }">无</c:if><c:if test="${proj != null}">${proj.bidTimeRule }</c:if></textarea>
                           </div>
                       </div>
                       <div class="form-group special_group01">
                           <label class="title">在线竞价投标报价：</label>
                           <div class="input_area">
                             <textarea class="form-control" rows="3" id="bid_quota_rule" ${ro}><c:if test="${proj == null }">无</c:if><c:if test="${proj != null}">${proj.bidQuotaRule }</c:if></textarea>
                           </div>
                       </div>
                       <div class="form-group special_group01">
                           <label class="title">注意事项：</label>
                           <div class="input_area">
                             <textarea class="form-control" rows="3" id="caution" ${ro}><c:if test="${proj == null }">无</c:if><c:if test="${proj != null}">${proj.caution }</c:if></textarea>
                           </div>
                       </div>
                       <div class="form-group special_group01">
                           <label class="title">其他：</label>
                           <div class="input_area">
                             <textarea class="form-control" rows="3" id="remark" ${ro}><c:if test="${proj == null }">无</c:if><c:if test="${proj != null}">${proj.remark }</c:if></textarea>
                           </div>
                       </div>
                       
                   <!--.list_inner--></div>
               <!--.step_section--></div>
               <div class="submit_btn">
                   <ul>
                       <li><button class="btn btn-default gray_cart" data-step="3">上一步</button></li>
                       <li><button class="btn btn-default blue" data-step="5" data-cur="4">下一步</button></li>
                   </ul>
               </div>
          <!--#sec_inner_4--></div>
          <div id="sec_inner_5" style="display:none;">
               <div class="nav_step">
                  <ul class="clearfix">
                    <li class="done">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step01.png" alt="1"></span>选择竞价类型</a>
                    </li>
                    <li class="done">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step02.png" alt="1"></span>添加竞价标的</a>
                    </li>
                    <li class="done">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step03.png" alt="1"></span>添加竞价概要信息</a>
                    </li>
                    <li class="current_prev">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step04.png" alt="1"></span>添加竞价信息</a>
                    </li>
                    <li class="last current">
                      <a href="#"><span><img src="${pageContext.request.contextPath}/static/img/bid/img-step05.png" alt="1"></span>添加标书</a>
                    </li>
                  </ul>
               </div>
               <div class="step_section section" id="step05">
                   <div class="list_inner clearfix">
                       <div class="form-group">
                           <label class="title">项目编号：</label>
                           <span class="proj-id-span"></span>
                       </div>
                       <div class="form-group">
                           <label class="title">项目名称：</label>
                           <span class="proj-name-span"></span>
                       </div>
                   <!--.list_inner--></div>
                   <div class="add_inner">
                       <div class="title_add clearfix">
                            <div class="title_inner clearfix">
                                <p>商务要求</p>
                                <div class="btn_list">
                                	<c:if test="${func != 'detail'}">
                                    <button class="btn btn-default blue" data-toggle="modal" id="busi_add">添加</button>
                                    </c:if>
                                </div>
                            </div>
                       </div>
                       
                       <!--弹出框start-->
                       <div class="modal fade" id="busi_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                           <div class="modal-dialog">
                               <div class="modal-content">
                                   <div class="modal-header">
                                       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                       <h4 class="modal-title" id="myModalLabel">商务要求</h4>
                                   </div>
                                   <div class="modal-body">
                                   		<input type="hidden" id="busi_id"/>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">标题：</label>
                                           <div class="col-sm-10">
                                               <input class="form-control" id="tender_title_busi">
                                           </div>
                                       </div>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">发票类型：</label>
                                           <div class="col-sm-10">
                                               <label class="checkbox-inline">
                                                   <input type="radio" name="invoice_type" id="invoice_type_3" value="3" checked>增值发票
                                               </label>
                                               <label class="checkbox-inline">
                                                   <input type="radio" name="invoice_type" id="invoice_type_2" value="2">普通发票
                                               </label>
                                               <label class="checkbox-inline">
                                                   <input type="radio" name="invoice_type" id="invoice_type_1" value="1">不需要发票
                                               </label>
                                           </div>
                                       </div>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">交货期：</label>
                                           <div class="col-sm-10">
                                                <div class="input_area input_area_day">
                                                    <span>下单后</span>
                                                    <input class="form-control form-control_day" id="delivery_time">
                                                    <span>天内交货至采购商指定地点</span>
                                                </div>
                                           </div>
                                       </div>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">收货地：</label>
                                           <div class="col-sm-10">
                                                <div class="input_area input_area_day">
                                                    <select class="form-control form-control_place" id="addr_prov">
                                                    	<option value="">请选择</option>
                                                    	<c:forEach var="i" items="${provs}">
                                                    	<option value="${i.supAreaID}">${i.supAreaName}</option>
                                                    	</c:forEach>
                                                    </select>
                                                    <span>省</span>
                                                    <select class="form-control form-control_place" id="addr_city">
                                                    	<option value="">请选择</option>
                                                    </select>
                                                    <span>市</span>
                                                    <select class="form-control form-control_place" id="addr_dist">
                                                    	<option value="">请选择</option>
                                                    </select>
                                                    <span>区</span>
                                                    <input class="form-control form-control_place02" id="addr_detail">
                                                </div>
                                           </div>
                                       </div>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">其他：</label>
                                           <div class="col-sm-10">
                                                <textarea class="form-control" rows="3" id="tender_content_busi"></textarea>
                                                
	                                           <div class="input-append" id="file_show_busi" style="display:none;">
	                                              <input id="file_name_busi" class="input-large form-control" type="text" style="height:30px;" readonly="readonly"> 
	                                              <button type="button" class="btn btn-default red" id="file_del_busi">删除文件</button>
	                                           </div>
                                               
	                                           <div class="input-append" id="file_input_busi"> 
	                                           
			                                       <form id="attach_form_busi" target="upload_target" action="${pageContext.request.contextPath}/management/bid/${act}/upload" enctype="multipart/form-data" method="post">
			                                           <input id="attach_file_busi" name="attach_file" type="file" style="display:none">
			                                       </form>
	                                              <input id="attach_field_busi" class="input-large form-control" type="text" style="height:30px;" readonly="readonly"> 
	                                              <a class="btn btn-default red" onclick="$('#attach_file_busi').click();">浏览文件</a>
	                                              <button type="button" class="btn btn-default red" id="attach_upload_busi">开始上传</button>
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
                                       <button type="button" class="btn btn-default blue" id="busi_modal_ok">确定</button>
                                       <button type="button" class="btn btn-default gray_cart" data-dismiss="modal">取消</button>
                                   </div>
                               </div>
                           </div>
                       </div>
                       <!--弹出框end-->
                       <table>
                           <tr>
                               <th width="60">序号</th>
                               <th width="200">标题</th>
                               <th width="120">发票类型</th>
                               <th width="150">交货期</th>
                               <th width="120">收货地</th>
                               <th>内容</th>
                               <th width="120">文件</th>
                              	<c:if test="${func != 'detail'}">
                               <th class="last" width="90">操作</th>
                               </c:if>
                           </tr>
                           <tbody id="busi_tbody">
                           <c:forEach var="i" items="${proj.tenders}">
                           <c:if test="${i.tenderType == 1}">
                                <tr id="busi_tr_${i.tenderId}">
                                  <td>${i.tenderId}</td>
                                  <td>${i.tenderTitle}</td>
                                  <td data-val="${i.invoiceType}">
                                  	<c:if test="${i.invoiceType == 1}">不需要</c:if>
                                  	<c:if test="${i.invoiceType == 2}">普通发票</c:if>
                                  	<c:if test="${i.invoiceType == 3}">增值发票</c:if>                                  
                                  </td>
                                  <td>${i.deliveryTime}天</td>
                                  <td data-prov="${i.addrProv}" data-city="${i.addrCity}" data-dist="${i.addrDist}" data-detail="${i.addrDetail}">${i.addrProvName} ${i.addrCityName} ${i.addrDistName} ${i.addrDetail}</td>
                                  <td>${i.tenderContent}</td>
                                  <td data-path="${i.attachPath}"><a href="javascript:;" onclick="downclick(this);">${i.attachName}</a></td>
                              	<c:if test="${func != 'detail'}">
                                  <td><a href="javascript:;" onclick="busiEdit(this);">修改</a><a href="javascript:;" onclick="busiDel(this);">删除</a></td>
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
                               <td><a href="#">删除</a><a href="#">编辑</a></td>
                           </tr>
                            -->
                       </table>
                   <!--.add_inner--></div>
                   <div class="add_inner">
                       <div class="title_add clearfix">
                            <div class="title_inner clearfix">
                                <p>技术要求</p>
                                <div class="btn_list">
                              	<c:if test="${func != 'detail'}">
                                    <button class="btn btn-default blue" data-toggle="modal" id="tech_add">添加</button>
                               </c:if>
                                </div>
                            </div>
                       </div>
                       
                       <!--弹出框start-->
                       <div class="modal fade" id="tech_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                           <div class="modal-dialog">
                               <div class="modal-content">
                                   <div class="modal-header">
                                       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                       <h4 class="modal-title" id="myModalLabel">技术要求</h4>
                                   </div>
                                   <div class="modal-body">
                                   		<input type="hidden" id="tech_id"/>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">标题：</label>
                                           <div class="col-sm-10">
                                               <input class="form-control" id="tender_title_tech">
                                           </div>
                                       </div>
                                       <div class="form-group clearfix">
                                           <label class="col-sm-2 control-label">内容：</label>
                                           <div class="col-sm-10">
                                                <textarea class="form-control" rows="3" id="tender_content_tech"></textarea>
                                                
	                                           <div class="input-append" id="file_show_tech" style="display:none;">
	                                              <input id="file_name_tech" class="input-large form-control" type="text" style="height:30px;" readonly="readonly"> 
	                                              <button type="button" class="btn btn-default red" id="file_del_tech">删除文件</button>
	                                           </div>
                                               
                                                
	                                           <div class="input-append" id="file_input_tech"> 
                                                
			                                       <form id="attach_form_tech" target="upload_target" action="${pageContext.request.contextPath}/management/bid/${act}/upload" enctype="multipart/form-data" method="post">
			                                           <input id="attach_file_tech" name="attach_file" type="file" style="display:none">
			                                       </form>
	                                              <input id="attach_field_tech" class="input-large form-control" type="text" style="height:30px;" readonly="readonly"> 
	                                              <a class="btn btn-default red" onclick="$('#attach_file_tech').click();">浏览文件</a>
	                                              <button type="button" class="btn btn-default red" id="attach_upload_tech">开始上传</button>
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
                                       <button type="button" class="btn btn-default blue" id="tech_modal_ok">确定</button>
                                       <button type="button" class="btn btn-default gray_cart" data-dismiss="modal">取消</button>
                                   </div>
                               </div>
                           </div>
                       </div>
                       <!--弹出框end-->
                       <table>
                           <tr>
                               <th width="60">序号</th>
                               <th width="200">标题</th>
                               <th>内容</th>
                               <th width="120">文件</th>
                              	<c:if test="${func != 'detail'}">
                               <th class="last" width="90">操作</th>
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
                                  <td><a href="javascript:;" onclick="techEdit(this);">修改</a><a href="javascript:;" onclick="techDel(this);">删除</a></td>
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
                               <td><a href="#">删除</a><a href="#">编辑</a></td>
                           </tr>
                            -->
                       </table>
                   <!--.add_inner--></div>
               <!--.step_section--></div>
               <div class="submit_btn">
                   <ul>
                       <li><button class="btn btn-default gray_cart" data-step="4">上一步</button></li>
                        <c:if test="${func != 'detail'}">
                       <li><button class="btn btn-default blue submit-btn" data-action="save">保存</button></li>
                       <li><button class="btn btn-default blue submit-btn" data-action="publish">发布标书</button></li>
                       </c:if>
                       
                      	<c:if test="${func == 'detail'}">
                       <li><button class="btn btn-default blue" onclick="javascript:history.go(-1);">返回</button></li>
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