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
<title>${title}|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_get.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_lose.css" rel="stylesheet">

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
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/encodeurigbk.js"></script>
<style>
#attach_field, #file_name {
	width:200px;
	display:inline-block;
}

.modal-body {
	height: 350px;
	overflow-y:scroll;
}
.modal .input_area {
	display: inline-block;
}
.modal .form-group {
	position: relative;
}
.modal-body .form-group {
	width: auto;
}
.modal .form-group .input-group .form-control {
	border-bottom-right-radius: 4px;
    border-top-right-radius: 4px;
    
}

.modal .form-group .input-group .input-group-btn .btn {
	border-radius: 4px;
	margin-left: 10px;
}
.serach_area .form-group{
	width: 44%;
	display: inline-block;
	float: left;
	padding-right: 20px;
}
.serach_area .form-group.last {
	width: 24%;
}
.modal-body .serach_area .form-group .col-sm-4{
	text-align: right;
	line-height: 28px;
}
.modal-body .serach_area .form-group .col-sm-8 {
	padding-left: 0;
	padding-right: 0;
}
.modal-body .serach_area .form-control {
	height: 28px;
}
</style>
<script type="text/javascript">
var quotas = ${quotas};
/*
 <tr>
 <td>2300</td>
 <td>2017-03-15 16:50</td>
</tr>
 */
$(function () {
	$(".quota-detail").click(function () {
		
		$("#quota_tbody").empty();
		var sup = $(this).attr("data-sup");
		$(quotas).each(function () {
			if (this.supCode == sup) {
				var tr = $("<tr>");
				tr.append('<td>' + this.quotaNum + '</td>');
				tr.append('<td>' + new Date(this.quotaTime).asString('yyyy-mm-dd hh:min:ss') + '</td>');
				$("#quota_tbody").append(tr);
			}
		});
		
		$("#info_details").modal("show");
	});
	
	$("#submit_btn").click(function () {
		var sup = $("input[name=sup_sel]:checked").val();
		var if_publicity = $("input[name=if_publicity]:checked").val();
		var if_contract = $("input[name=if_contract]:checked").val();
		var publicity_start = $("#publicity_start").val();
		var publicity_end = $("#publicity_end").val();
		var proj_status = $("#proj_status").val();
		
		if (!sup || sup == "") {
			alert("��ѡ��Ӧ��");
			return false;
		}
		
		if (if_publicity == 1) {
			if (publicity_start == "") {
				alert("��ѡ��ʾ��ʼʱ��");
				return false;
			}
			
			if (publicity_end == "") {
				alert("��ѡ��ʾ����ʱ��");
				return false;
			}
			
			if (publicity_end <= publicity_start) {
				alert("��ʾ����ʱ�������ڿ�ʼʱ��");
				return false;
			}
			
			if (proj_status != 8) {
				window.location.href='${pageContext.request.contextPath}/management/bid/project/publicity?projId=${proj.projId}&sup=' + sup + '&publicity_start=' + publicity_start + '&publicity_end=' + publicity_end;
				return;
			}
		}
		

		async('${pageContext.request.contextPath}/management/bid/project/award/submit', {
			projId:'${proj.projId}',
			supCode:sup,
			ifContract:if_contract
		}, function (msg) {
			alert("�����ɹ�");
			history.go(-1);
		});
	});
	
	$("#obsolete_btn").click(function () {
		var reason = $.trim($("#obsolete_reason").val());
		
		if (reason == "") {
			alert("������ϱ�����");
			return false;
		}
		

		async('${pageContext.request.contextPath}/management/bid/project/obsolete/submit', {
			projId:'${proj.projId}',
			reason:reason
		}, function (msg) {
			alert("�����ɹ�");
			history.go(-1);
		});
	});
	

	$("#attach_upload").click(function () {
		if ($("#attach_field").val() == "") {
			alert("��ѡ���ϴ��ļ�");
			return false;
		}
		if (loading) return;
		loading = true;

		$("#upload_target").appendTo($(document.body));
		$("#attach_form").submit();
	});
	
	$("#file_del").click(function () {
		$("#attach_file").val("");
		$("#attach_field").val("");
		$("#contract_file").val("");
		$("#attach_name").val("");
		$("#file_name").val("");
		$("#file_input").show();
		$("#file_show").hide();
	});
	
	$("input[name=if_publicity]").click(function () {
		var val = $(this).val();
		
		if (val == 1) {
			$("#publicity_time").show();
			$("#submit_btn").text("ȷ�Ϲ�Ӧ�̲���ʾ");
			$("#contract_div").hide();
		} else {

			$("#publicity_time").hide();
			$("#submit_btn").text("ȷ�Ϲ�Ӧ�̲��ڱ�");
			$("#contract_div").show();
		}
	});
	
	$("#show_his").click(function () {
		$("#his_modal").modal("show");
		queryHis();
	});


	$("#his_query").click(queryHis);
	
	$("#his_export").click(function () {
		var name = $.trim($("#his_sup_name").val());
		window.open("${pageContext.request.contextPath}/management/bid/project/export/quota?projId=${proj.projId}&name=" + encodeURIComponentGBK(name));
	});
	
	var chart = echarts.init(document.getElementById('chart'));
	var rank = [];
	var map = {};
	var first = {};
	var keys = [];
	var series = [];
	var minTime = new Date();
	var maxTime = new Date();
	var quotaData = quotas;
  	for (var i = 0; i < quotaData.length; i++) {
  		var item = quotaData[i];
		if (map.hasOwnProperty(item.bidNum)) {
			if (map[item.bidNum].quotaRound < item.quotaRound) {
				map[item.bidNum] = item;
			}
		} else {
			map[item.bidNum] = item;
		}
		
		if(item.quotaRound == 1) {
			first[item.bidNum] = item.quotaNum;
            keys.push(item.supName);
		}
		
		if (i == 0) {
			minTime = item.quotaTime;
		}
		
		if (i == quotaData.length - 1) {
			maxTime = item.quotaTime;
		}
   	}
  	
  	for (var i in map) {
  		rank.push(map[i]);
  	}
  	
  	rank.sort(function(a, b){
  		if (a.quotaNum == b.quotaNum) {
  			return a.quotaTime - b.quotaTime;
  		} else {
            return a.quotaNum - b.quotaNum;
  		}
    });
  	
  	for (var i = 0; i < rank.length; i++) {
  		var item = rank[i];
        var data = [];
      	for (var j = 0; j < quotaData.length; j++) {
      		if (quotaData[j].bidNum == item.bidNum) {
      			data.push([
                   new Date(quotaData[j].quotaTime),
                   quotaData[j].quotaNum
                ]);
      		}
      	}
      	series.push({
              name: item.supName,
              type: 'line',
              showAllSymbol: true,
              symbolSize: 5,
              data:data
      	});
  	}
  	
    var option = {
    			    title : {
    			        x:'center'
    			    },
    			    tooltip : {
    			        trigger: 'item',
    			        formatter : function (params) {
							
    			            return new Date(params.value[0]).asString('yyyy-mm-dd hh:min:ss') + '<br/>'
    			                   + params.value[1];
    			        }
    			    },
    			    toolbox: {
    			        show : false
    			    },
    			    legend : {
    			        data : keys
    			    },
    			    grid: {
    			        y2: 80,
    			        x2:20,
    			        x:70,
    			        y:30
    			    },
    			    xAxis : [
    			        {
    			            type : 'time',
    			            min:minTime,
    			            max:maxTime,
    			            splitNumber:8,
    			            axisLabel:{
            			        formatter : function (params) {
        							
            			            return new Date(params).asString('mm-dd\nhh:min:ss');
            			        },
    			                textStyle:{
    			                   fontSize:10
    			              }
    			            }
    			        }
    			    ],
    			    yAxis : [
    			        {
    			            type : 'value'
    			        }
    			    ],
    			    series : series
    			};
    
    chart.setOption(option);
});
 

 var _uploadCallback = function (result, url, fail, data) {
 	loading = false;
	if (result > 0) {
		$("#file_name").val(data.name);
		$("#attach_name").val(data.name);
		$("#attach_path").val(data.path);
		$("#file_input").hide();
		$("#file_show").show();
	} else {
		alert(fail);
	}
 }
 
 

 var queryHis = function () {
 	var supName = $.trim($("#his_sup_name").val());
 	var bidNum = $.trim($("#his_bid_num").val());

 	$("#his_tbody").empty();
 	/*
 		<tr>
           <td></td>
           <td></td>
           <td></td>
           <td>2017-02-27 15:00:00</td>
         </tr>
     */
 	if (quotas) {
 		for (var i = 0; i < quotas.length; i++) {
 			if ((supName == "" || quotas[i].supName.indexOf(supName) >= 0) && (bidNum == "" || quotas[i].bidNum == bidNum)) {
 				var tr = $("<tr>");
 				tr.append('<td>' + quotas[i].supName + '</td>');
 				tr.append('<td>' + quotas[i].quotaNum + '</td>');
 				tr.append('<td>' + new Date(quotas[i].quotaTime).asString('yyyy-mm-dd hh:min:ss') + '</td>');
 				$("#his_tbody").append(tr);
 			}
 		}
 	}
 }
</script>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />  
  
  <input type="hidden" id="proj_status" value="${proj.projStatus }"/>
  <div id="contents">
    <div class="inner">
      <jsp:include page="../left_menu.jsp"/>
      <div id="matter_section">
          <h2>${title}</h2>
          <div class="step_section section" id="step01">
              <div class="list_inner clearfix">
              	<c:if test="${action == 'award' or action == 'obsolete'}">
              		<c:set var="spe" value="special_group01"></c:set>
              	</c:if>
                  <div class="form-group ${spe }">
                     <label class="title">��Ŀ���ƣ�</label>
                     <span>${proj.projName }</span>
                  </div>
                  <div class="form-group ${spe }">
                     <label class="title">��Ŀ��ţ�</label>
                     <span>${proj.projId }</span>
                  </div>
                  <div class="form-group ${spe }">
                     <label class="title">�������ڣ�</label>
                     <span><fmt:formatDate value="${proj.bidStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/> �� <fmt:formatDate value="${proj.timeoutEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                  </div>
                  <div class="form-group">
                  <c:if test="${proj.projStatus > 4 and action != 'obsolete'}">
                     <label class="title">��Ŀ״̬��</label>
                     <span>
                     <c:if test="${proj.projStatus == 5}">���ڱ�</c:if>
                     <c:if test="${proj.projStatus == 6}">�ѷϱ�</c:if>
                     <c:if test="${proj.projStatus == 7}">�Ѷ���</c:if>
                     <c:if test="${proj.projStatus == 8}">�ѹ�ʾ</c:if>
                     <c:if test="${proj.projStatus == 9}">����ֹ</c:if>
                     </span>
                  </c:if>
                  </div>
              	<c:if test="${action == 'award' and proj.projStatus == 4}">
                  <div class="form-group special_group01">
                     <label class="title">�Ƿ�ʾ��</label>
                     <div class="input_area">
                         <label class="checkbox-inline check_special">
                             <input name="if_publicity" value="1" checked="checked" type="radio">��
                         </label>
                         <label class="checkbox-inline check_special">
                             <input name="if_publicity" value="2" type="radio">��
                         </label>
                         <div class="input_area input-group input_area_special" id="publicity_time">
                             <input class="form-control" type="text" id="publicity_start" readonly="readonly" value="<fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/>" style="background-color:#fff;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                             <span class="input-group-addon border_right">
                                <i class="fa fa-calendar"></i>
                             </span>
                             <span class="text">��</span>
                             <input class="form-control border_left" id="publicity_end" type="text" readonly="readonly" style="background-color:#fff;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                             <span class="input-group-addon">
                                 <i class="fa fa-calendar"></i>
                             </span>
                         </div>
                     </div>
                  </div>
                 </c:if>
              	<c:if test="${action != 'award' or proj.projStatus != 4}">
                  <div class="form-group special_group01">
                     <label class="title">�Ƿ�ʾ��</label>
                     <div class="input_area">
                         <label class="checkbox-inline check_special">
                             <input name="if_publicity" value="1" <c:if test="${proj.ifPublicity == 1}"> checked="checked"</c:if> type="radio" disabled="disabled">��
                         </label>
                         <label class="checkbox-inline check_special">
                             <input name="if_publicity" value="2" <c:if test="${proj.ifPublicity == 2}"> checked="checked"</c:if> type="radio" disabled="disabled">��
                         </label>
                         <c:if test="${proj.ifPublicity == 1}">
                         <div class="input_area input-group input_area_special">
                             <input class="form-control" type="text" id="publicity_start" readonly="readonly" value="<fmt:formatDate value="${proj.publicityStart}" pattern="yyyy-MM-dd"/>" disabled="disabled">
                             <span class="input-group-addon border_right">
                                <i class="fa fa-calendar"></i>
                             </span>
                             <span class="text">��</span>
                             <input class="form-control border_left" id="publicity_end" type="text" readonly="readonly" value="<fmt:formatDate value="${proj.publicityEnd}" pattern="yyyy-MM-dd"/>" disabled="disabled")">
                             <span class="input-group-addon">
                                 <i class="fa fa-calendar"></i>
                             </span>
                         </div>
                         </c:if>
                     </div>
                  </div>
              	</c:if>
              	<c:if test="${action == 'award'}">
                  <div class="form-group special_group01" id="contract_div" <c:if test="${proj.projStatus != 8 }">style="display:none;"</c:if>>
                     <label class="title">���ɵ��Ӻ�ͬ��</label>
                     <div class="input_area">
                         <label class="checkbox-inline check_special">
                             <input name="if_contract" value="1" checked="checked" type="radio">��
                         </label>
                         <label class="checkbox-inline check_special">
                             <input name="if_contract" value="2" type="radio">��
                         </label>
                     </div>
                  </div>
              	</c:if>
                  <c:if test="${action == 'obsolete' and (proj.projStatus <= 5 and proj.projStatus >= 4 or proj.projStatus == 8)}">
                  <div class="form-group">
                     <label class="title">�ϱ����ɣ�</label>
                     <div class="input_area">
                       <input type="text" class="form-control" id="obsolete_reason">
                     </div>
                  </div>
                  <div class="btn_list">
                      <button class="btn btn-default blue" id="obsolete_btn">�ϱ�</button>
                      <button class="btn btn-default gray_cart" onclick="history.go(-1)">����</button>
                  </div>
                  </c:if>
                  <c:if test="${proj.projStatus == 6}">
                  <div class="form-group special_group01">
                     <label class="title">�ϱ����ɣ�</label>
                     <span>${proj.obsoleteReason }</span>
                  </div>
                  </c:if>
                  <c:if test="${proj.projStatus == 9}">
                  <div class="form-group special_group01">
                     <label class="title">��ֹ���ɣ�</label>
                     <span>${proj.terminateReason }</span>
                  </div>
                  </c:if>
              </div>
          </div>
          <div class="search_result">
          	<div class="chart_area">
              <h4>��Ӧ�̱�������ͼ</h4>
              <div class="chart_img" id="chart" style="width:100%; height:300px;">
                
              </div>
            </div>
            <table class="table_area">
              <tr>
              <c:if test="${action == 'award' and (proj.projStatus == 4 or proj.projStatus == 8)}">
                <th width="60"></th>
              </c:if>
                <th>��Ӧ������</th>
                <th width="120">���ձ���</th>
                <th width="120">�ɹ�Ԥ��</th>
                <th width="120">��֧���</th>
                <th width="90">�ۿ���</th>
                <th width="100">��������</th>
                <th class="last" width="100">������ʷ</th>
              </tr>
              <c:forEach var="i" items="${sups}" varStatus="sta">
              
              <tr <c:if test="${i.bidResult == 1 and action != 'obsolete'}">class="red"</c:if>>
              <c:if test="${action == 'award' and proj.projStatus == 4}">
                <td><input type="radio" name="sup_sel" value="${i.supCode}"></td>
              </c:if>
              <c:if test="${action == 'award' and proj.projStatus == 8}">
                <td><input type="radio" name="sup_sel" value="${i.supCode}" <c:if test="${i.bidResult == 1}">checked="checked"</c:if> disabled="disabled"></td>
              </c:if>
                <td>${i.supName}</td>
                <td>${i.realCurrentQuota }</td>
                <td>${proj.budget > 0 ? proj.budget : '��' }</td>
                <td>${proj.budget > 0 ? (proj.budget - i.realCurrentQuota) : '��' }</td>
                <td>
                <c:if test="${proj.budget > 0}">
				<fmt:formatNumber type="percent" value="${(proj.budget - i.realCurrentQuota) / proj.budget}" />
                </c:if>
                <c:if test="${proj.budget == 0}">
                ��
                </c:if>
                </td>
                <td><a href="javascript:;" class="quota-detail" data-sup="${i.supCode }">����</a></td>
                <c:if test="${sta.index == 0 }">
                <td rowspan="${fn:length(sups) }"><a href="javascript:;" id="show_his" >�鿴</a></td>
                </c:if>
              </tr>
              </c:forEach>
            </table>
            <c:if test="${action == 'view' and proj.projStatus != 6 and proj.projStatus != 9}">
            <p class="red">��ܰ��ʾ����ɫ��עΪ���굥λ�����˽⣡��</p>
            </c:if>
          </div>
          <div class="modal fade" id="info_details" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                              <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                              <h4 class="modal-title" id="myModalLabel">��Ӧ�̱�������</h4>
                            </div>
                            <div class="modal-body">
                              <table class="table_area">
                                <tr>
                                  <th>����</th>
                                  <th class="last">����ʱ��</th>
                                </tr>
                                <tbody id="quota_tbody"></tbody>
                              </table>
                            </div>
                        </div>
              </div>
          </div>
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

                            <div class="form-group last">
                              <button class="btn blue btn-default" id="his_query">��ѯ</button>
                              <button class="btn blue btn-default" id="his_export">����</button>
                            </div>
                          </div>
                         <table class="table_area">
                           <tr>
                             <th width="30%">��Ӧ������</th>
                             <th width="15%">����</th>
                             <th class="last">����ʱ��</th>
                           </tr>
                           <tbody id="his_tbody"></tbody>
                         </table>
                       </div>
                     </div>
                  </div>
               </div>
          <c:if test="${action != 'obsolete' }">
          <div class="submit_btn">
              <ul>
          <c:if test="${action == 'award' and proj.projStatus == 4}">
                  <li><button class="btn btn-default blue" id="submit_btn">ȷ�Ϲ�Ӧ�̲���ʾ</button></li>
          </c:if>
          <c:if test="${action == 'award' and proj.projStatus == 8}">
                  <li><button class="btn btn-default blue" id="submit_btn">ȷ�Ϲ�Ӧ�̲��ڱ�</button></li>
          </c:if>
          <c:if test="${action == 'view' and proj.projStatus == 5}">
                  <li><a href="${pageContext.request.contextPath}/management/bid/project/obsolete?projId=${proj.projId}" class="btn btn-default blue">�ϱ�</a></li>
          </c:if>
                  <li><a target="_blank" href="${pageContext.request.contextPath}/management/bid/project/print?projId=${proj.projId}" class="btn btn-default blue">�鿴��������</a></li>
                  <li><button class="btn btn-default gray_cart" onclick="history.go(-1);">����</button></li>
              </ul>
          </div>
          </c:if>
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp"/>
<!--.page-wrapper--></div>

<iframe width="0" height="0" border="0" style="display: none;" name="upload_target" id="upload_target"></iframe>
	
</body>
</html>