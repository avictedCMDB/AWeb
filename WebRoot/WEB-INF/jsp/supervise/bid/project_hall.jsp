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
<title>���۴���|�к��б���</title>
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
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bid/supervise/project_hall.js"></script>
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
          <h2>${proj.projName }<span>�����۴�����</span></h2>
          <div class="left_box">
             <div class="supplier_list box_line">
               <h3>���й�Ӧ��</h3>
               <div class="list_inner">
                 <ul id="rank_ul">
                 </ul>
               </div>
               <div class="btn_list">
                 <ul>
                   <li><button class="btn btn-default blue" data-toggle="modal" id="auth_click">����Ȩ�޹���</button></li>
                   <li><button class="btn btn-default blue" data-toggle="modal" id="his_click">������ʷ��¼</button></li>
                 </ul>
               </div>
               <!-- �����򣨱���Ȩ�޹�����start -->
               <div class="modal fade" id="auth_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                  <div class="modal-dialog">
                     <div class="modal-content">
                       <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                          <h4 class="modal-title" id="myModalLabel">����Ȩ�޹���</h4>
                       </div>
                       <div class="modal-body clearfix">
                         <div class="form-group ">
                            <label class="col-sm-2 control-label">��Ӧ������</label>
                            <div class="col-sm-10 input-group">
                                <input type="text" class="form-control" id="auth_sup_name">
                                <span class="input-group-btn"> 
                                  <button class="btn btn-default blue" type="button" id="auth_query">��ѯ</button>
                                </span>
                            </div>
                         </div>
                         <table class="hall">
                           <tr>
                             <th width="10%">���</th>
                             <th width="60%">��Ӧ��</th>
                             <th class="last" width="30%">����</th>
                           </tr>
                           <tbody id="auth_tbody"></tbody>
                         </table>
                       </div>
                     </div>
                  </div>
               </div>
               <!-- �����򣨱���Ȩ�޹�����end -->
               <!-- �����򣨱�����ʷ��¼��start -->
               <div class="modal fade" id="his_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                  <div class="modal-dialog">
                     <div class="modal-content">
                       <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                          <h4 class="modal-title" id="myModalLabel">������ʷ��¼</h4>
                       </div>
                       <div class="modal-body clearfix">
                          <div class="serach_area clearfix">
                            <div class="form-group">
                              <label class="col-sm-4 control-label">��Ӧ�����ƣ�</label>
                              <div class="col-sm-8"><input class="form-control" id="his_sup_name"></div>
                            </div>
                            <div class="form-group">
                              <label class="col-sm-4 control-label">�����ƺţ�</label>
                              <div class="col-sm-8"><input class="form-control" id="his_bid_num"></div>
                            </div>
                            <div class="form-group last">
                              <button class="btn blue btn-default" id="his_query">��ѯ</button>
                            </div>
                          </div>
                         <table class="hall">
                           <tr>
                             <th width="30%">��Ӧ������</th>
                             <th width="15%">�����ƺ�</th>
                             <th width="15%">����</th>
                             <th class="last">����ʱ��</th>
                           </tr>
                           <tbody id="his_tbody"></tbody>
                         </table>
                       </div>
                     </div>
                  </div>
               </div>
               <!-- �����򣨱�����ʷ��¼��end -->

             <!--.supplier_list--></div>
          <!--.left_box--></div>
          <div class="article">
            <div class="overview box_line">
              <h3>��Ӧ�̱�����Ϣ����</h3>
              <div class="chart overview_inner">
                <h4>��������ͼ</h4>
                <div class="chart_img" id="chart" style="width:620px; height:300px;">
                 
                </div>
              </div>
              <div class="overview_inner">
                <h4>������ϸ</h4>
                <div class="table_list">
                  <table class="hall">
                    <tr>
                      <th>����</th>
                      <th>���</th>
                      <th>��ʼ���ۣ�Ԫ��</th>
                      <th>���±��ۣ�Ԫ��</th>
                      <th>����</th>
                      <th>IP</th>
                      <th class="last">ʱ��</th>
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
                    <option value="">�����й�Ӧ��</option>
                    <c:forEach var="i" items="${sups}">
                    <option value="${i.supCode}">${i.supName}</option>
                    </c:forEach>
                  </select>
                </div>
                <div class="sent_area">
                  <div class="input-group">
                      <input type="text" class="form-control" id="msg_input">
                      <span class="input-group-btn">
                         <button class="btn btn-default blue" type="button" id="msg_send">����</button>
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
              <h4>��ǰʱ��</h4>
              <div class="time_area" id="time_count" data-time="${time}">
                <div class="hour">
                  <span class="num" id="time_hour">00</span>
                  <span>Сʱ</span>
                </div>
                <div class="txt">:</div>
                <div class="minutes">
                  <span class="num" id="time_min">00</span>
                  <span>����</span>
                </div>
                <div class="txt">:</div>
                <div class="second">
                  <span class="num" id="time_sec">00</span>
                  <span>��</span>
                </div>
              </div>
            <!--.time--></div>
            <div class="rule box_line">
              <h3>���۹���</h3>
              <div class="rule_inner">
                <dl class="clearfix">
                  <dt>��Ŀ��ţ�</dt>
                  <dd>${proj.projId }</dd>
                </dl>
                <dl class="clearfix">
                  <dt>��Ŀ���ƣ�</dt>
                  <dd>${proj.projName }</dd>
                </dl>
                <dl class="clearfix">
                  <dt>�������ۣ�</dt>
                  <dd>${proj.publishQuota == 2 ? '������' : '����' }</dd>
                </dl>
                <dl class="clearfix">
                  <dt>���귽ʽ��</dt>
                  <dd>${proj.decideType == 2 ? '�������' : '�۸����' }</dd>
                </dl>
                <dl class="clearfix">
                  <dt>���۱��֣�</dt>
                  <dd>${proj.currencyName }</dd>
                </dl>
                <dl class="clearfix">
                  <dt>����׼��ʱ�䣺</dt>
                  <dd><fmt:formatDate value="${proj.bidStartTime}" pattern="yyyy-MM-dd HH:mm"/></dd>
                </dl>
                <dl class="clearfix">
                  <dt>����ʱ����</dt>
                  <dd>${proj.bidDuration }����</dd>
                </dl>
                <dl class="clearfix">
                  <dt>��ʱ���ۣ�</dt>
                  <dd>${proj.timeoutInterval }��</dd>
                </dl>
                <dl class="clearfix">
                  <dt>����ʽ��</dt>
                  <dd>�۸�����</dd>
                </dl>
                <dl class="clearfix">
                  <dt>���۴������ƣ�</dt>
                  <dd>${proj.timesLimitType == 1 ? '��' : proj.timesLimitNum }</dd>
                </dl>
                <dl class="clearfix">
                  <dt>��С������</dt>
                  <dd>
                  	<c:if test="${proj.minIncrType == 1}">��</c:if>
                  	<c:if test="${proj.minIncrType == 2}">${proj.minIncrVal}</c:if>
                  	<c:if test="${proj.minIncrType == 3}">${proj.minIncrVal}%</c:if>
                  </dd>
                </dl>
                <dl class="clearfix">
                  <dt>�ɹ�Ԥ�㣺</dt>
                  <dd>${proj.budget }</dd>
                </dl>
                <dl class="clearfix">
                  <dt>�Ƿ���ʾ��Ӧ����ͱ��ۣ�</dt>
                  <dd>
                  	<c:if test="${proj.showMinQuota == 1}">��</c:if>
                  	<c:if test="${proj.showMinQuota == 2}">��</c:if>
                  </dd>
                </dl>                
              </div>
            </div>
          <!--.right_box--></div>
      <!--.inner--></div>
  <!--#contents--></div>
</body>
</html>