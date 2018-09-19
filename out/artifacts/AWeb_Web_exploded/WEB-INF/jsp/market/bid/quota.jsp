<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<jsp:include page="../meta.jsp">
	<jsp:param value="竞价采购" name="title" />
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
			alert("请输入价格");
			return false;
		}
		
		if (/^\d+$/.test(val) && val > 0) {
			
		} else {
			alert("价格必须为大于0整数");
			return false;
		}
		
		if (val >= ${threshold} || confirm("您的出价低于警戒值：${threshold}，是否确认出价？")) {
			async('${pageContext.request.contextPath}/market/bid/quota/submit', {projId:'${proj.projId}', val:val}, function (msg) {
				alert("出价成功");
				window.location.reload();
			});
		}
		
	});
	
	$("#msg_send").click(function () {
		if (disable) return;
		var msg = $.trim($("#msg_input").val());
		
		if (msg == "") {
			alert("请输入消息内容");
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
                         <p class="title">我对所有供应商说<span>15:00:01</span></p>
                         <p class="txt">现在是试报价时间现在是试报价时间现在是试报价时间</p>
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
		title = "我对采购人说";
	} else if (msg.supCode == 0) {
		title = "采购人对所有供应商说";
	} else {
		title = "采购人对我说";
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

	$("#last_time").text(arr[0] + "天" + prefix(2, arr[1]) + "小时" + prefix(2, arr[2]) + "分" + prefix(2, arr[3]) + "秒");
	
	
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
                  <li><a href="#myinfo" data-toggle="tab">我的报价信息</a></li>
                  <li class="active"><a href="#rank" data-toggle="tab">最新排名</a></li>
              </ul>
          </div>
          <div id="myTabContent" class="tab-content">
            <div class="tab-pane fade in" id="myinfo">
              <div class="tab_section">
                 <div class="table_rank">
                   <table class="table_area">
                       <tr>
                           <th>供应商牌号码</th>
                           <th>报价</th>
                           <th class="last">报价时间</th>
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
                     <h2>竞价的项目编号<span>${proj.projId}</span></h2>
                     <p style="cursor:pointer;" id="rank_refresh">刷新最新排名</p>
                 </div>
                 <div class="table_rank">
                   <table class="table_area">
                       <tr>
                           <th>排名</th>
                           <th>供应商牌号</th>
                           <th>报价</th>
                           <th class="last">报价时间</th>
                       </tr>
                       <tbody id="rank_tbody">
                       </tbody>
                   </table>
                   <p class="red">红色是贵公司的报价</p>
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
                             <button class="btn btn-default blue" type="button" id="msg_send">发送</button>
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
                  <dt>您的牌号：</dt>
                  <dd>${sup.bidNum }</dd>
                </dl>
                <dl class="clearfix">
                  <dt>系统时间：</dt>
                  <dd id="sys_time"><fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss"/></dd>
                </dl>
                <dl class="clearfix">
                  <dt>剩余时间：</dt>
                  <dd id="last_time" data-time="${time}"></dd>
                </dl>
                <dl class="clearfix">
                  <dt>竞价项目状态：</dt>
                  <dd>${sta}</dd>
                </dl>
                <dl class="clearfix">
                  <dt>币种：</dt>
                  <dd>${proj.currencyName}</dd>
                </dl>
                <c:if test="${proj.budgetPublic == 1}">
                <dl class="clearfix">
                  <dt>采购预算：</dt>
                  <dd>${proj.budget}</dd>
                </dl>
                </c:if>
                <dl class="clearfix">
                  <dt>首次报价：</dt>
                  <dd>${firstQuota}</dd>
                </dl>
                <dl class="clearfix">
                  <dt>最高报价限制：</dt>
                  <dd>                  	
                     <c:if test="${proj.quotaLimitType == 1}">不限</c:if>
                     <c:if test="${proj.quotaLimitType == 2}">${proj.quotaLimitNum}</c:if>
                  </dd>
                </dl>
                <dl class="clearfix">
                  <dt>当前报价：</dt>
                  <dd>${currentQuota}</dd>
                </dl>
                <c:if test="${proj.showMinQuota == 1 }">
                <dl class="clearfix">
                  <dt>目前最低供应商报价金额：</dt>
                  <dd id="show_min_quota">0</dd>
                </dl>
                </c:if>
                <dl class="clearfix">
                  <dt>报价次数限制：</dt>
                <c:if test="${proj.timesLimitType == 1 }">
                  <dd>不限</dd>
                </c:if>
                <c:if test="${proj.timesLimitType == 2 }">
                  <dd>${proj.timesLimitNum}</dd>
                </c:if>
                </dl>
                <dl class="clearfix">
                  <dt>最小降幅：</dt>
                  <dd>${quotaStep > 0 ? quotaStep : '不限'}</dd>
                </dl>
                <dl class="clearfix">
                  <dt>授标价格：</dt>
                <c:if test="${proj.acceptType == 1 }">
                  <dd>供应商以最终报价成交</dd>
                </c:if>
                <c:if test="${proj.acceptType == 2 }">
                  <dd>供应商以最低报价成交</dd>
                </c:if>
                </dl>
                
           </div>
           <div class="price">
               <h2>报价金额</h2>
               <div class="input-group">
                   <span class="input-group-addon" style="cursor:pointer;" id="quota_inc" data-step="${quotaStep}">+</span>
                   <input type="text" class="form-control" id="quota_val" maxlength="7">
                   <span class="input-group-addon" style="cursor:pointer;" id="quota_dec" data-step="${quotaStep}">-</span>
               </div>
               <button class="btn btn-default orange" id="quota_btn">出价</button>
               <p><a href="${pageContext.request.contextPath}/market/bid/quota/threshold?projId=${proj.projId}">修改警戒值</a></p>
           </div>
       </div>
    <!--.inner--></div>
  <!--#contents--></div>
</body>
</html>
