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
<title>竞价大厅|中航招标网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_hall.css" rel="stylesheet">

<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/date.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/echarts-all.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/echarts.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bid/management/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bid/management/project_hall.js?v=20170603"></script>
<script type="text/javascript">
var CONTEXT = "${pageContext.request.contextPath}";
var projId = "${proj.projId}";
var contextDisable = '${disable}';
var waiting = '${waiting}';

</script>
</head>

<body>

  <div id="contents">
      <div class="inner clearfix">
          <h2>${proj.projName }<span>【竞价大厅】</span></h2>
          <div class="left_box">
             <div class="supplier_list box_line">
               <h3>所有供应商</h3>
               <div class="list_inner">
                 <ul id="rank_ul">
                 </ul>
               </div>
               <div class="btn_list">
                 <ul>
                   <li><button class="btn btn-default blue" data-toggle="modal" id="auth_click">报价权限管理</button></li>
                   <li><button class="btn btn-default blue" data-toggle="modal" id="his_click">报价历史记录</button></li>
                 </ul>
               </div>
               <!-- 弹出框（报价权限管理）start -->
               <div class="modal fade" id="auth_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                  <div class="modal-dialog">
                     <div class="modal-content">
                       <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                          <h4 class="modal-title" id="myModalLabel">报价权限管理</h4>
                       </div>
                       <div class="modal-body clearfix">
                         <div class="form-group ">
                            <label class="col-sm-2 control-label">供应商名称</label>
                            <div class="col-sm-10 input-group">
                                <input type="text" class="form-control" id="auth_sup_name">
                                <span class="input-group-btn"> 
                                  <button class="btn btn-default blue" type="button" id="auth_query">查询</button>
                                </span>
                            </div>
                         </div>
                         <table class="hall">
                           <tr>
                             <th width="10%">序号</th>
                             <th width="60%">供应商</th>
                             <th class="last" width="30%">操作</th>
                           </tr>
                           <tbody id="auth_tbody"></tbody>
                         </table>
                       </div>
                     </div>
                  </div>
               </div>
               <!-- 弹出框（报价权限管理）end -->
               <!-- 弹出框（报价历史记录）start -->
               <div class="modal fade" id="his_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                  <div class="modal-dialog">
                     <div class="modal-content">
                       <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                          <h4 class="modal-title" id="myModalLabel">报价历史记录</h4>
                       </div>
                       <div class="modal-body clearfix">
                          <div class="serach_area clearfix">
                            <div class="form-group">
                              <label class="col-sm-4 control-label">供应商名称：</label>
                              <div class="col-sm-8"><input class="form-control" id="his_sup_name"></div>
                            </div>
                            <div class="form-group">
                              <label class="col-sm-4 control-label">竞价牌号：</label>
                              <div class="col-sm-8"><input class="form-control" id="his_bid_num"></div>
                            </div>
                            <div class="form-group last">
                              <button class="btn blue btn-default" id="his_query">查询</button>
                            </div>
                          </div>
                         <table class="hall">
                           <tr>
                             <th width="30%">供应商名称</th>
                             <th width="15%">竞价牌号</th>
                             <th width="15%">报价</th>
                             <th class="last">报价时间</th>
                           </tr>
                           <tbody id="his_tbody"></tbody>
                         </table>
                       </div>
                     </div>
                  </div>
               </div>
               <!-- 弹出框（报价历史记录）end -->

             <!--.supplier_list--></div>
          <!--.left_box--></div>
          <div class="article">
            <div class="overview box_line">
              <h3>供应商报价信息总览</h3>
              <div class="chart overview_inner">
                <h4>报价趋势图</h4>
                <div class="chart_img" id="chart" style="width:620px; height:300px;">
                 
                </div>
              </div>
              <div class="overview_inner">
                <h4>报价明细</h4>
                <div class="table_list">
                  <table class="hall">
                    <tr>
                      <th>排名</th>
                      <th>编号</th>
                      <th>初始报价（元）</th>
                      <th>最新报价（元）</th>
                      <th>降幅</th>
                      <th>IP</th>
                      <th class="last">时间</th>
                    </tr>
                    <tbody id="rank_tbody"></tbody>
                  </table>
                </div>
              </div>
            <!--.overview--></div>
            <div class="chat box_line">
              <div class="chat_content" id="msg_cnt">
                 <ul id="msg_ul">
                 </ul>
              <!--.chat_content--></div>
              <div class="chat_sent clearfix">
                <div class="select">
                  <select class="form-control" id="sup_sel">
                    <option value="">对所有供应商</option>
                    <c:forEach var="i" items="${sups}">
                    <option value="${i.supCode}">${i.supName}</option>
                    </c:forEach>
                  </select>
                </div>
                <div class="sent_area">
                  <div class="input-group">
                      <input type="text" class="form-control" id="msg_input">
                      <span class="input-group-btn">
                         <button class="btn btn-default blue" type="button" id="msg_send">发送</button>
                      </span>
                  </div>
                </div>
              </div>
            <!--.chat--></div>
          <!--.article--></div>
          <div class="right_box">
            <div class="btn_list">
              <ul>
                <li class="current"><button class="btn btn-default blue" id="sta_text">${sta}</button></li>
              </ul>
            </div>
            <div class="time">
              <h4>当前时长</h4>
              <div class="time_area" id="time_count" data-time="${time}">
                <div class="hour">
                  <span class="num" id="time_hour">00</span>
                  <span>小时</span>
                </div>
                <div class="txt">:</div>
                <div class="minutes">
                  <span class="num" id="time_min">00</span>
                  <span>分钟</span>
                </div>
                <div class="txt">:</div>
                <div class="second">
                  <span class="num" id="time_sec">00</span>
                  <span>秒</span>
                </div>
              </div>
            <!--.time--></div>
            <div class="rule box_line">
              <h3>竞价规则</h3>
              <div class="rule_inner">
                <dl class="clearfix">
                  <dt>项目编号：</dt>
                  <dd>${proj.projId }</dd>
                </dl>
                <dl class="clearfix">
                  <dt>项目名称：</dt>
                  <dd>${proj.projName }</dd>
                </dl>
                <dl class="clearfix">
                  <dt>公开报价：</dt>
                  <dd>${proj.publishQuota == 2 ? '不公开' : '公开' }</dd>
                </dl>
                <dl class="clearfix">
                  <dt>决标方式：</dt>
                  <dd>${proj.decideType == 2 ? '评标决标' : '价格决标' }</dd>
                </dl>
                <dl class="clearfix">
                  <dt>报价币种：</dt>
                  <dd>${proj.currencyName }</dd>
                </dl>
                <dl class="clearfix">
                  <dt>竞价准备时间：</dt>
                  <dd><fmt:formatDate value="${proj.bidStartTime}" pattern="yyyy-MM-dd HH:mm"/></dd>
                </dl>
                <dl class="clearfix">
                  <dt>竞价时长：</dt>
                  <dd>${proj.bidDuration }分钟</dd>
                </dl>
                <dl class="clearfix">
                  <dt>超时竞价：</dt>
                  <dd>${proj.timeoutInterval }秒</dd>
                </dl>
                <dl class="clearfix">
                  <dt>排序方式：</dt>
                  <dd>价格排序</dd>
                </dl>
                <dl class="clearfix">
                  <dt>报价次数限制：</dt>
                  <dd>${proj.timesLimitType == 1 ? '无' : proj.timesLimitNum }</dd>
                </dl>
                <dl class="clearfix">
                  <dt>最小降幅：</dt>
                  <dd>
                  	<c:if test="${proj.minIncrType == 1}">无</c:if>
                  	<c:if test="${proj.minIncrType == 2}">${proj.minIncrVal}</c:if>
                  	<c:if test="${proj.minIncrType == 3}">${proj.minIncrVal}%</c:if>
                  </dd>
                </dl>
                <dl class="clearfix">
                  <dt>采购预算：</dt>
                  <dd>${proj.budget }</dd>
                </dl>
                <dl class="clearfix">
                  <dt>是否显示供应商最低报价：</dt>
                  <dd>
                  	<c:if test="${proj.showMinQuota == 1}">是</c:if>
                  	<c:if test="${proj.showMinQuota == 2}">否</c:if>
                  </dd>

                </dl>
              </div>
            </div>
          <!--.right_box--></div>
      <!--.inner--></div>
  <!--#contents--></div>
</body>
</html>