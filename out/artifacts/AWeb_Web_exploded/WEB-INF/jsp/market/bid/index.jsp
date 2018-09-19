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
<link href="${pageContext.request.contextPath}/static/css/bid.css" rel="stylesheet">

<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/date.js"></script>
<style>
#header .buy {
	margin-top:38px;
}

#header .logo {
	margin-left:0;
}
</style>

<script type="text/javascript">
$(function () {

    $("#more_btn").click(function () {
    	if ($("#more").attr("data-state") == "show") {
       	 	$("#more").slideUp();

       	 	$("#more").removeAttr("data-state");
    	} else {
       	 	$("#more").slideDown();
       	 	$("#more").attr("data-state", "show");
    	}
    });
	setInterval(function() {
		$(".time-refresh").each(function () {
			var diff = $(this).attr("data-time");
			
			diff -= 1000;

	        var arr = timeDiff(diff);
	        
	        var day = arr[0];
	        var hour = arr[1];
	        var min = arr[2];
	        var sec = arr[3];
	        
	        $(this).attr("data-time", diff);
	        if ($(this).hasClass("list-item")) {
		        $(this).html("ʣ�ࣺ" + day + " �� " + prefix(2, hour) + ":" + prefix(2, min) + ":" + prefix(2, sec));
	        } else {
		        $(this).html("ʣ��ʱ�䣺<span class=\"red\">" + day + "</span>��<span class=\"red\">" + prefix(2, hour) + ":" + prefix(2, min) + ":" + prefix(2, sec) + "</span>");
	        }
		});
	}, 1000);
	
	
	$(".chx-btn").click(function () {
		$(this).parent().find(".active").removeClass("active");
		$(this).addClass("active");
		
		
		var prov = $("#addr_prov .active a").attr("data-val");
		var comp = $("#company_id .active a").attr("data-val");
		var cat = $("#bid_cat .active a").attr("data-val");

		param.projName = "";
		param.addrProv = prov;
		param.companyId = comp;
		param.bidCat = cat;
		
		loaded = [0, 0, 0];

		$("#myTab li.active").trigger("click");
	});
	
	$("#myTab li").click(function () {
		var idx = $(this).index();
		var total = $(this).attr("data-total");
		if (!total) {
			total = 0;
		}
		$("#total_num").text(total);
		if (loaded[idx] == 1) {
			return;
		}
		
		param.page = 1;
		
		if (idx == 0) {
			loadNotice();
		} else if (idx == 1) {
			loadProj();
		} else {
			loadResult();
		}
	});
	
	$(".proj-order").click(function () {
		if ($(this).hasClass("active")) {
			return;
		}
		
		$(".proj-order.active").removeClass("active");
		$(this).addClass("active");
		
		param.order = $(this).attr("data-order");
		
		param.page = 1;
		
		loadProj();
	});
	
	$("#myTab li.active").trigger("click");

    
    $(".result-page").click(function () {
    	if ($(this).hasClass("active")) return;
	   	 $(".result-page.active").removeClass("active");
	   	 $(this).addClass("active");
	   	 
	   	loadResult(true);
    });
	
});

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

var loaded = [0, 0, 0];

var param = {
	"projName":"${q}"
};

var loadNotice = function () {
	var page = $(this).attr("data-page");
	if ($(this).parent().hasClass("active")) {
		return false;
	}
		
	if (page) {
		param.page = page;
	} else {
		param.page = 1;
	}
	
	$("#notice_list").empty();
	
	async('${pageContext.request.contextPath}/market/bid/index/query/notice', param, function (msg) {
		var result = msg.result;
		loaded[0] = 1;


		if (result.data) {
          	for (var i = 0; i < result.data.length; i++) {
          		var item = result.data[i];
          		var row = $('<div class="list">');
          		
          		row.append('<div class="col"><a target="_blank" href="${pageContext.request.contextPath}/market/bid/notice?projId=' + item.projId + '">' + item.projId + '</a></div>');
	        	
          		row.append('<div class="col col2" style="text-align:center;">' + item.projName + '</div>');

          		row.append('<div class="col">' + new Date(item.publishTime).asString('yyyy-mm-dd') + '</div>');
          		
	            $("#notice_list").append(row);
        	   
           	}
             
		}

        $("#myTab li").eq(0).attr("data-total", result.total);
		$("#total_num").text(result.total);
		paging("#notice_page", result.pages, param.page, loadProj);
	});
}

var loadProj = function () {
	var page = $(this).attr("data-page");
	if ($(this).parent().hasClass("active")) {
		return false;
	}
	
	
		
	if (page) {
		param.page = page;
	} else {
		param.page = 1;
	}
	
	$("#proj_list").empty();
	
	async('${pageContext.request.contextPath}/market/bid/index/query/proj', param, function (msg) {
		var result = msg.result;
		loaded[1] = 1;

		if (result.data) {
          	for (var i = 0; i < result.data.length; i++) {
          		var item = result.data[i];
          		var row = $('<div class="list_inner_box clearfix">');
          		
          		row.append('<div class="col"><p class="tit"><a target="_blank" href="${pageContext.request.contextPath}/market/bid/notice?projId=' + item.projId + '">' + item.projName + '</a></p><p>���귽ʽ��' + (item.decideType == 2 ? '�������' : '�۸����') + '</p></div>');
	        	
          		row.append('<div class="col col2"><p>�ɹ�����' + item.subNum + '��</p><p>�������ͣ�' + (item.projType == 1 ? "���뾺��" : "��������") + '</p></div>');
          		
          		row.append('<div class="col"><p>' + item.companyName + '</p><p>�ɹ����ͣ�' + item.bidCatName + '</p></div>');
          		
          		var d = new Date(item.bidEndTime);
          		
          		var diff = d.getTime() - new Date().getTime();
          		
          		var arr = timeDiff(diff);
          		
          		row.append('<div class="col"><p class="time-refresh list-item" data-time="' + diff + '">ʣ�ࣺ' + arr[0] + ' �� '  + prefix(2, arr[1]) + ':' + prefix(2, arr[2]) + ':' + prefix(2, arr[3]) + '</p><p>������' + new Date(item.publishTime).asString('yyyy-mm-dd') + '</p></div>');
          		
          		row.append('<div class="col col2 col3"><a class="btn blue" target="_blank" href="${pageContext.request.contextPath}/market/bid/quota?projId=' + item.projId + '">��������</a></div>');
          		
	            $("#proj_list").append(row);
        	   
           	}
             
		}

        $("#myTab li").eq(1).attr("data-total", result.total);
		$("#total_num").text(result.total);
		paging("#proj_page", result.pages, param.page, loadProj);
	});
}

var loadResult = function (flag) {
	var page = $(this).attr("data-page");
	if (!flag && $(this).parent().hasClass("active")) {
		return false;
	}
	
	param.projStatus = $(".result-page.active").attr("data-status");
		
	if (page) {
		param.page = page;
	} else {
		param.page = 1;
	}
	
	$("#result_list").empty();
	if (param.projStatus == 8) {
		var inner = $('<div class="list_inner_box clearfix">');
		var table = $('<table class="table_area">');
		inner.append(table);
		table.append('<tr><th width="200">���۱��</th><th width="400">��Ŀ����</th><th width="120">��ʾ��</th><th width="150" class="last">��ʾ����</th></tr>');
		$("#result_list").append(inner);
	}
	
	/*
	
      <div class="list_inner_box clearfix">
          <div class="col"><p class="tit">���루Lenovo��H3005 ̨ʽ����</p><p>�������d���Լ����</p></div>
          <div class="col col2"><p>�ɹ�����10��</p><p>�б��ܶ2000.00</p></div>
          <div class="col"><p>������λ���й�����</p><p>�б굥λ������ɹ�</p></div>
          <div class="col"><p>�ɹ����ͣ����ǲɹ�</p><p>�б�ʱ�䣺2017-01-10</p></div>
          <div class="col col2 col3"><button class="btn btn-default blue">�б�֪ͨ��</button></div>
      </div>
     */
	
	async('${pageContext.request.contextPath}/market/bid/index/query/result', param, function (msg) {
		var result = msg.result;
		loaded[2] = 1;

		if (result.data) {
          	for (var i = 0; i < result.data.length; i++) {
          		var item = result.data[i];
          		if (param.projStatus == 7) {
              		var row = $('<div class="list_inner_box clearfix">');
              		
              		row.append('<div class="col"><p class="tit">' + item.projName + '</p><p>�������' + item.bidCatName + '</p></div>');
    	        	
              		row.append('<div class="col col2"><p>�ɹ�����' + item.subNum + '��</p><p>�����ܶ' + item.realCurrentQuota + '</p></div>');
              		
              		row.append('<div class="col"><p>������λ��' + item.companyName + '</p><p>���굥λ��' + item.supName + '</p></div>');
              		
              		row.append('<div class="col"><p>�ɹ����ͣ�' + (item.projType == 1 ? '���뾺��' : '��������') + '</p><p>����ʱ�䣺' + (new Date(item.noticeTime).asString("yyyy-mm-dd")) + '</p></div>');
              		
              		row.append('<div class="col col2 col3"><a class="btn btn-default blue" target="_blank" href="${pageContext.request.contextPath}/market/bid/result/show?projId=' + item.projId + '">����֪ͨ��</a></div>');
              		
    	            $("#result_list").append(row);
          		} else {
          			var diff = (new Date(item.publicityEnd).getTime() - new Date(item.publicityStart).getTime()) / 86400000;
          			$(".table_area").append('<tr><td><a target="_blank" href="${pageContext.request.contextPath}/market/bid/publicity?projId=' + item.projId + '">' + item.projId + '</a></td>'
          					+'<td>' + item.projName + '</td><td>' + diff + '��</td><td>' + new Date(item.publicityStart).asString('yyyy-mm-dd') + '</td></tr>');
					/*
                    <tr>
                      <td><a href="#">CX2017-01965</a></td>
                      <td>��Ŀ������Ŀ������Ŀ������Ŀ������Ŀ������Ŀ������Ŀ������</td>
                      <td>1��</td>
                      <td>2017-02-10</td>
                    </tr>
                    */
          		}
        	   
           	}
             
		}

        $("#myTab li").eq(2).attr("data-total", result.total);
		$("#total_num").text(result.total);
		paging("#result_page", result.pages, param.page, loadResult);
	});
     
}

</script>

</head>

<body>
<div class="page-wrapper">
		<jsp:include page="../header.jsp" />
			<div id="nav_area">
			<div class="inner clearfix" style="z-index:999;">
				<jsp:include page="../categorys.jsp" />
			</div>
    <!--#nav_area-->
  </div>
  <div id="contents">
    <div class="inner">
        <div id="top_recommend">
            <div class="recommend_inner clearfix">
                <div class="recommend_title">�ö��Ƽ�</div>
                <div class="recommend_list">
                    <ul class="clearfix">
                    <c:forEach var="i" items="${recomms}">
                        <li class="clearfix">
                            <div class="img">
                                <p class="logo"><img width="60px" height="60px" src="${pageContext.request.contextPath}/static/img/bid/logo-recommend.jpg" alt="" /></p>
                                <p><a href="javascript:;">${i.companyName}</a></p>
                            </div>
                            <div class="txt">
                                <p class="title">${i.projName}</p>
                                <p class="time-refresh" data-time="${viewHelper.timeDiff(i.bidEndTime)}">ʣ��ʱ�䣺${viewHelper.bidLastTime(i.bidEndTime)}</p>
                                <a class="btn blue" target="_blank" href="${pageContext.request.contextPath}/market/bid/quota?projId=${i.projId}">��������</a>
                            </div>
                        </li>
                    </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
        <div id="serach_area">
            <div class="search_title clearfix">
               <div class="txt">ѡ���������</div>
               <div class="result">������<span class="red" id="total_num">0</span>����ؽ��</div>
            </div>
            <div class="serach_inner">
                <dl class="search_list clearfix">
                    <dt class="list_title">�ɹ����</dt>
                    <dd class="list_inner">
                        <ul class="clearfix" id="bid_cat">
                           <li class="chx-btn active"><a href="javascript:;" class="do-search" data-val="">ȫ��</a></li>
		                    <c:forEach var="i" items="${cats}">
                           <li class="chx-btn"><a href="javascript:;" class="do-search" data-val="${i.codeValue}">${i.codeText}</a></li>
		                    </c:forEach>
                            <li class="btn_more"><button class="btn btn-default blue" id="more_btn" >��������</button></li>
                        </ul>
                    </dd>
                </dl>
                <div id="more" class="panel-collapse collapse">
	                <dl class="search_list clearfix">
	                   <dt class="list_title">���ڵ�</dt>
	                   <dd class="list_inner">
	                       <ul class="clearfix" id="addr_prov">
	                           <li class="chx-btn active"><a href="javascript:;" class="do-search" data-val="">ȫ��</a></li>
			                    <c:forEach var="i" items="${provs}">
	                           <li class="chx-btn"><a href="javascript:;" class="do-search" data-val="${i.supAreaId}">${i.supAreaName}</a></li>
			                    </c:forEach>
	                       </ul>
	                   </dd>
	                </dl>
	                <dl class="search_list clearfix">
	                    <dt class="list_title">�ɹ���˾</dt>
	                    <dd class="list_inner">
	                        <ul class="clearfix" id="company_id">
	                           <li class="chx-btn active"><a href="javascript:;" class="do-search" data-val="">ȫ��</a></li>
			                    <c:forEach var="i" items="${comps}">
	                           <li class="chx-btn"><a href="javascript:;" class="do-search" data-val="${i.companyCode}">${i.companyName}</a></li>
			                    </c:forEach>
	                        </ul>
	                    </dd>
	                </dl>
                </div>
            </div>
            <div class="serach_btn">
                
            </div>
        <!--#serach_area--></div>
        <div id="result">
            <div id="result_bottom" class="clearfix">
                <div class="end_list">
                    <h2>�����ر�</h2>
                    <div class="end_inner">
                        <ul>
                    		<c:forEach var="i" items="${exps}">
                            <li>
                                <h3><a target="_blank" href="${pageContext.request.contextPath}/market/bid/quota?projId=${i.projId}">${i.projName}</a></h3>
                                <p>�ɹ���λ��<a href="javascript:;">${i.companyName}</a></p>
                                <p class="time-refresh" data-time="${viewHelper.timeDiff(i.bidEndTime)}">ʣ��ʱ�䣺${viewHelper.bidLastTime(i.bidEndTime)}</p>
                            </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <div class="list_inner">
                    <div class="tab">
                        <ul id="myTab" class="nav nav-tabs">
                            <li><a href="#notice" data-toggle="tab">���۹���</a></li>
                            <li class="active"><a href="#hall" data-toggle="tab">���۴���</a></li>
                            <li><a href="#result_box" data-toggle="tab">���۽��</a></li>
                        </ul>
                     </div>
                     <div id="myTabContent" class="tab-content">
                          <div class="tab-pane fade in notice" id="notice">
                              <div class="notice_title">
                                  <div class="col">��Ŀ���</div>
                                  <div class="col col2">��Ŀ����</div>
                                  <div class="col">��������</div>
                              </div>
                              <div class="notice_inner" id="notice_list">
                              </div>
                              <div class="page" id="notice_page">
                              </div>
                          </div>
                          <div class="tab-pane fade in active" id="hall">
                              <div class="sort_area clearfix">
                                  <div class="sort_inner">
                                      <ul>
                                          <li class="proj-order" data-order="2"><a href="javascript:;">ʣ��ʱ��<i class="fa fa-sort-numeric-asc"></i></a></li>
                                          <li class="proj-order active" data-order="1"><a href="javascript:;">����ʱ��<i class="fa fa-sort-numeric-asc"></i></a></li>
                                      </ul>
                                  </div>
                              </div>
                              <div class="tab_list" id="proj_list">
                              </div>
                              <div class="page" id="proj_page">
                              </div>
                          
                          </div>
                          <div class="tab-pane fade" id="result_box">
                              <div class="sort_area clearfix">
                                  <div class="sort_area clearfix">
	                                  <div class="sort_inner">
	                                      <ul id="divstyletab" class="nav nav-tabs">
	                                          <li class="active result-page" data-status="8"><a href="javascript:;">���۹�ʾ</a></li>
	                                          <li class="result-page" data-status="7"><a href="javascript:;" >������</a></li>
	                                      </ul>
	                                  </div>
	                              </div>
                              </div>
                              <div class="tab_list" id="result_list">
                                  
                              </div>
                              <div class="page" id="result_page">
                              </div>
                          </div>
                     </div>
                </div>
            </div>
        <!--#result--></div>
    <!--.inner--></div>
  <!--#contents--></div>
		<jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>