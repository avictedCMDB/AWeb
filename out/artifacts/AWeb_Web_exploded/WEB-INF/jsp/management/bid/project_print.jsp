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
<title>��Ӧ�̱�������|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/baojiadan.css" rel="stylesheet">

<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/echarts-all.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/echarts.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/date.js"></script>
<style>

</style>
<script type="text/javascript">
var quotas = ${quotas};

$(function () {
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
 

</script>
</head>

<body>
<div id="matter_section">
  <h2>��Ӧ�̱�������</h2>
  <div class="search_area">
    <div class="search_list clearfix">
      <dl class="clearfix">
        <dt>��Ŀ���ƣ�</dt>
        <dd>
          <input type="text" class="form-control" readonly="readonly" value="${proj.projName }">
        </dd>
      </dl>
      <dl class="clearfix">
        <dt>��Ŀ��ţ�</dt>
        <dd>
          <input type="text" class="form-control" readonly="readonly" value="${proj.projId }">
        </dd>
      </dl>
      <dl class="clearfix">
        <dt>�������ڣ�</dt>
        <dd>
          <input type="text" class="form-control" readonly="readonly" value="<fmt:formatDate value="${proj.bidStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/> �� <fmt:formatDate value="${proj.timeoutEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/>">
        </dd>
      </dl>
      <dl class="clearfix">
        <dt>��Ŀ״̬��</dt>
        <dd>
        <c:if test="${proj.projStatus == 4}"><input type="text" class="form-control" readonly="readonly" value="δ�ڱ�"></c:if>
        <c:if test="${proj.projStatus == 5}"><input type="text" class="form-control" readonly="readonly" value="���ڱ�"></c:if>
        <c:if test="${proj.projStatus == 6}"><input type="text" class="form-control" readonly="readonly" value="�ѷϱ�"></c:if>
        <c:if test="${proj.projStatus == 7}"><input type="text" class="form-control" readonly="readonly" value="�Ѷ���"></c:if>
        <c:if test="${proj.projStatus == 8}"><input type="text" class="form-control" readonly="readonly" value="�ѹ�ʾ"></c:if>
        <c:if test="${proj.projStatus == 9}"><input type="text" class="form-control" readonly="readonly" value="����ֹ"></c:if>
          
        </dd>
      </dl>
    </div>
  </div>
  
  <div class="search_result">
    <div class="chart_area">
      <h3>��Ӧ�̱�������ͼ</h3>
      <div class="chart_img" id="chart" style="width:100%; height:300px;">
        
      </div>
    </div>
    <div class="section">
      <h3>��Ӧ�̱�����ϸ</h3>
      <table border="0">
        <tr>
          <th width="450">��Ӧ������</th>
          <th width="240">����</th>
          <th class="last">����ʱ��</th>
        </tr>
        <c:forEach var="i" items="${quotaList}" varStatus="sta">
        <tr>
          <td>${i.supName }</td>
          <td>${i.quotaNum }</td>
          <td><fmt:formatDate value="${i.quotaTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
        </tr>
        </c:forEach>
      </table>
    </div>
    <div class="section" id="result-summary">
      <h3>��Ӧ�̾��۽������</h3>
      <table border="0">
        <tr>
          <th width="450">��Ӧ������</th>
          <th width="120">���ձ���</th>
          <th width="120">�ɹ�Ԥ��</th>
          <th width="120">��֧���</th>
          <th class="last">�ۿ���</th>
        </tr>
        <c:forEach var="i" items="${sups}" varStatus="sta">
              
              <tr>
              
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
              </tr>
              </c:forEach>
      </table>
      <div class="sign-icon"><img src="${pageContext.request.contextPath}/static/img/bid/img_seal_sample02.png" alt=""></div>
    </div>
    <div class="submit_btn" id="btn_area">
      <button class="btn btn-default blue" type="button" id="print_btn">��ӡ</button>
      <a class="btn btn-default blue" target="_blank" href="${pageContext.request.contextPath}/management/bid/project/export/pdf?projId=${proj.projId}">����PDF</a>
      <button class="btn btn-default gray" type="button" onclick="window.close();">�ر�</button>
    </div>
  </div>
</div>
<script type="text/javascript">
$(function () {
	$("#print_btn").click(function () {
		$("#btn_area").hide();
		window.print();
		$("#btn_area").show();
	});
});
</script>
</body>
</html>
