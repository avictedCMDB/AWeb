<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<jsp:include page="../meta.jsp">
	<jsp:param value="���۲ɹ�" name="title" />
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/bid_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_trial_spot.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/date.js"></script>
<script type="text/javascript">
var disable = "${disable}";
$(function () {
	lastTime();
	setInterval(function () {
		var time = Date.fromString($("#sys_time").text(), 'yyyy-mm-dd hh:min:ss').getTime();
		$("#sys_time").text(new Date(time + 1000).asString('yyyy-mm-dd hh:min:ss'));
		
		lastTime();
		
	}, 1000);
	
	$("#quota_inc").click(function () {
		var val = $.trim($("#quota_val").val());
		
		if (/^\d+$/.test(val)) {
			$("#quota_val").val(parseInt(val) + parseInt($(this).attr("data-step")));
		} else {
			$("#quota_val").val($(this).attr("data-step"));
		}
	});
	
	$("#quota_dec").click(function () {
		var val = $.trim($("#quota_val").val());
		
		if (/^\d+$/.test(val)) {
			var newVal = parseInt(val) - parseInt($(this).attr("data-step"));
			$("#quota_val").val(newVal < 0 ? 0 : newVal);
		} else {
			$("#quota_val").val(0);
		}
	});
	
	$("#rank_refresh").click(function () {
		rankRefresh();
	});
	
	$("#quota_btn").click(function () {
		if (disable) return;
		
		var val = $.trim($("#quota_val").val());
		if (val == "") {
			alert("������۸�");
			return false;
		}
		
		if (/^\d+$/.test(val) && val > 0) {
			
		} else {
			alert("�۸����Ϊ����0����");
			return false;
		}
		
		if (val >= ${threshold} || confirm("���ĳ��۵��ھ���ֵ��${threshold}���Ƿ�ȷ�ϳ��ۣ�")) {
			async('${pageContext.request.contextPath}/market/bid/quota/submit', {projId:'${proj.projId}', val:val}, function (msg) {
				alert("���۳ɹ�");
				window.location.reload();
			});
		}
		
	});
	
	$("#msg_send").click(function () {
		if (disable) return;
		var msg = $.trim($("#msg_input").val());
		
		if (msg == "") {
			alert("��������Ϣ����");
			return false;
		}
		

		async('${pageContext.request.contextPath}/market/bid/quota/msg/send', {projId:'${proj.projId}', msg:msg}, function (msg) {
			var item = msg.result;
			appendMsg(item);
			$("#msg_input").val("");
		});
	});
	
	setInterval(loadMsg, 5000);
	setInterval(rankRefresh, 10000);
	
	rankRefresh();
	loadMsg();
});

var msgId = 0;

var loadMsg = function () {
	if (disable) return;
	async('${pageContext.request.contextPath}/market/bid/quota/msg/data', {projId:'${proj.projId}', msgId:msgId}, function (msg) {


		if (msg.result) {
          	for (var i = 0; i < msg.result.length; i++) {
				appendMsg(msg.result[i]);
				msgId = msg.result[i].msgId;
           	}
             
		}
	}, false, true);
}

/*

                       <li>
                         <p class="title">�Ҷ����й�Ӧ��˵<span>15:00:01</span></p>
                         <p class="txt">�������Ա���ʱ���������Ա���ʱ���������Ա���ʱ��</p>
                       </li>
 */
 
var appendMsg = function (msg) {
	if ($("#msg_" + msg.msgId).size() > 0) {
		return;
	}	 
	
	var li = $("<li>");
	li.attr("id", "msg_" + msg.msgId);
	var title = "";
	if (msg.sendType == 1) {
		title = "�ҶԲɹ���˵";
	} else if (msg.supCode == 0) {
		title = "�ɹ��˶����й�Ӧ��˵";
	} else {
		title = "�ɹ��˶���˵";
	}
	li.append('<p class="title">' + title + ' <span> ' + (new Date(msg.sendTime).asString('yyyy-mm-dd hh:min:ss')) + '</span></p>');
	li.append('<p class="txt">' + msg.msgContent + '</p>');
	
	$("#chat_ul").append(li);
	
	var st = $("#chat_ul").height() - $("#chat_cnt").height();
	
	if (st > 0) {
		$("#chat_cnt").scrollTop(st);
	}
}

function rankRefresh() {

	if (disable) return;
	
	$("#rank_tbody").empty();
	
	async('${pageContext.request.contextPath}/market/bid/quota/rank', {projId:'${proj.projId}'}, function (msg) {
		/*
		
                       <tr class="red">
                           <td>2</td>
                           <td>SZ2017030289</td>
                           <td>2300</td>
                           <td>2017-03-02 14:00:00</td>
                       </tr>
		*/

		if (msg.result) {
          	for (var i = 0; i < msg.result.length; i++) {
          		var item = msg.result[i];
          		var row = $('<tr>');
          		if (item.supCode == "${sup.supCode}") {
          			row.addClass("red");
          		}
          		
          		if (i == 0) {
          			$("#show_min_quota").text(item.quotaNum);
          		}
          		
          		row.append('<td>' + (i + 1) + '</td>');
	        	
          		row.append('<td>' + item.bidNum + '</td>');

          		row.append('<td>' + item.quotaNumString + '</td>');

          		row.append('<td>' + new Date(item.quotaTime).asString('yyyy-mm-dd') + '</td>');
          		
	            $("#rank_tbody").append(row);
        	   
           	}
             
		}
	});
}


function lastTime() {
	var diff = $("#last_time").attr("data-time");
	var arr = timeDiff(diff);

	$("#last_time").text(arr[0] + "��" + prefix(2, arr[1]) + "Сʱ" + prefix(2, arr[2]) + "��" + prefix(2, arr[3]) + "��");
	
	
	if (arr[0] == 0 && arr[1] == 0 && arr[2] == 0 && arr[3] == 0) {
		window.location.reload();
	}
	
	$("#last_time").attr("data-time", diff - 1000);
}


function prefix(num, val) {
    return (new Array(num).join('0') + val).slice(-num);
}

var timeDiff = function (diff) {

    var day = parseInt(diff / (24 * 60 * 60 * 1000));
    var hour = parseInt(diff / (60 * 60 * 1000) - day * 24);
    var min = parseInt((diff / (60 * 1000)) - day * 24 * 60 - hour * 60);
    var sec = parseInt(diff / 1000 - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60);
    
    if (day < 0) {
    	day = 0;
    }
    
    if (hour < 0) {
    	hour = 0;
    }
    
    if (min < 0) {
    	min = 0;
    }
    
    if (sec < 0) {
    	sec = 0;
    }
    
    return [day, hour, min, sec];
}
</script>
</head>

<body>
  <div id="contents">
    <div class="inner">
       <div id="matter_section">
           <div class="tab clearfix">
              <ul id="myTab" class="nav nav-tabs">
                  <li><a href="#myinfo" data-toggle="tab">�ҵı�����Ϣ</a></li>
                  <li class="active"><a href="#rank" data-toggle="tab">��������</a></li>
              </ul>
          </div>
          <div id="myTabContent" class="tab-content">
            <div class="tab-pane fade in" id="myinfo">
              <div class="tab_section">
                 <div class="table_rank">
                   <table class="table_area">
                       <tr>
                           <th>��Ӧ���ƺ���</th>
                           <th>����</th>
                           <th class="last">����ʱ��</th>
                       </tr>
                       <c:forEach var="i" items="${mys}">
                       <tr>
                           <td>${i.bidNum}</td>
                           <td>${i.quotaNum}</td>
                           <td><fmt:formatDate value="${i.quotaTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                       </tr>
                       </c:forEach>
                   </table>
                 </div>
              </div>
            </div>
            <div class="tab-pane fade in active" id="rank">
              <div class="tab_section">
                 <div class="title_list clearfix">
                     <h2>���۵���Ŀ���<span>${proj.projId}</span></h2>
                     <p style="cursor:pointer;" id="rank_refresh">ˢ����������</p>
                 </div>
                 <div class="table_rank">
                   <table class="table_area">
                       <tr>
                           <th>����</th>
                           <th>��Ӧ���ƺ�</th>
                           <th>����</th>
                           <th class="last">����ʱ��</th>
                       </tr>
                       <tbody id="rank_tbody">
                       </tbody>
                   </table>
                   <p class="red">��ɫ�ǹ�˾�ı���</p>
                 </div>
              </div>
            </div>
                 <div class="chat box_line">
                  <div class="chat_content" id="chat_cnt">
                     <ul id="chat_ul">
                     </ul>
                  <!--.chat_content--></div>
                  <div class="chat_sent clearfix">
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
          </div>
       </div>
       <div id="right_section">
           <div class="info_list">
               <dl class="clearfix">
                  <dt>�����ƺţ�</dt>
                  <dd>${sup.bidNum }</dd>
                </dl>
                <dl class="clearfix">
                  <dt>ϵͳʱ�䣺</dt>
                  <dd id="sys_time"><fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss"/></dd>
                </dl>
                <dl class="clearfix">
                  <dt>ʣ��ʱ�䣺</dt>
                  <dd id="last_time" data-time="${time}"></dd>
                </dl>
                <dl class="clearfix">
                  <dt>������Ŀ״̬��</dt>
                  <dd>${sta}</dd>
                </dl>
                <dl class="clearfix">
                  <dt>���֣�</dt>
                  <dd>${proj.currencyName}</dd>
                </dl>
                <c:if test="${proj.budgetPublic == 1}">
                <dl class="clearfix">
                  <dt>�ɹ�Ԥ�㣺</dt>
                  <dd>${proj.budget}</dd>
                </dl>
                </c:if>
                <dl class="clearfix">
                  <dt>�״α��ۣ�</dt>
                  <dd>${firstQuota}</dd>
                </dl>
                <dl class="clearfix">
                  <dt>��߱������ƣ�</dt>
                  <dd>                  	
                     <c:if test="${proj.quotaLimitType == 1}">����</c:if>
                     <c:if test="${proj.quotaLimitType == 2}">${proj.quotaLimitNum}</c:if>
                  </dd>
                </dl>
                <dl class="clearfix">
                  <dt>��ǰ���ۣ�</dt>
                  <dd>${currentQuota}</dd>
                </dl>
                <c:if test="${proj.showMinQuota == 1 }">
                <dl class="clearfix">
                  <dt>Ŀǰ��͹�Ӧ�̱��۽�</dt>
                  <dd id="show_min_quota">0</dd>
                </dl>
                </c:if>
                <dl class="clearfix">
                  <dt>���۴������ƣ�</dt>
                <c:if test="${proj.timesLimitType == 1 }">
                  <dd>����</dd>
                </c:if>
                <c:if test="${proj.timesLimitType == 2 }">
                  <dd>${proj.timesLimitNum}</dd>
                </c:if>
                </dl>
                <dl class="clearfix">
                  <dt>��С������</dt>
                  <dd>${quotaStep > 0 ? quotaStep : '����'}</dd>
                </dl>
                <dl class="clearfix">
                  <dt>�ڱ�۸�</dt>
                <c:if test="${proj.acceptType == 1 }">
                  <dd>��Ӧ�������ձ��۳ɽ�</dd>
                </c:if>
                <c:if test="${proj.acceptType == 2 }">
                  <dd>��Ӧ������ͱ��۳ɽ�</dd>
                </c:if>
                </dl>
                
           </div>
           <div class="price">
               <h2>���۽��</h2>
               <div class="input-group">
                   <span class="input-group-addon" style="cursor:pointer;" id="quota_inc" data-step="${quotaStep}">+</span>
                   <input type="text" class="form-control" id="quota_val" maxlength="7">
                   <span class="input-group-addon" style="cursor:pointer;" id="quota_dec" data-step="${quotaStep}">-</span>
               </div>
               <button class="btn btn-default orange" id="quota_btn">����</button>
               <p><a href="${pageContext.request.contextPath}/market/bid/quota/threshold?projId=${proj.projId}">�޸ľ���ֵ</a></p>
           </div>
       </div>
    <!--.inner--></div>
  <!--#contents--></div>
</body>
</html>