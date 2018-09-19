
$(function () {
	param.projStatus = 1;
	queryProj();
	
	$("#query_btn").click(function () {
		var proj_id = $.trim($("#proj_id").val());
		var proj_name = $.trim($("#proj_name").val());
		var bid_cat = $.trim($("#bid_cat").val());
		var create_time = $.trim($("#create_time").val());
		var proj_status = $(".proj_status.active").attr("data-status");
		
		param.projId = proj_id;
		param.projName = proj_name;
		param.bidCat = bid_cat;
		param.createTime = create_time;
		param.projStatus = proj_status;
		
		param.page = 1;
		
		queryProj();
	});
	
	$("#reset_btn").click(function () {
		$("#proj_id").val("");
		$("#proj_name").val("");
		$("#bid_cat").val("");
		$("#create_time").val("");
	});
	
	$(".proj_status").click(function () {
		$(".proj_status").removeClass("active");
		$(this).addClass("active");
		param.projStatus = $(this).attr("data-status");
		param.page = 1;
		
		queryProj();
	});
});

var param = {};

var queryProj = function (reload) {

	if (typeof(reload) != "boolean" || !reload) {
		var page = $(this).attr("data-page");
		if ($(this).parent().hasClass("active")) {
			return false;
		}
		
		
		if (page) {
			param.page = page;
		} else {
			param.page = 1;
		}
	}
	
	$("#project_tbody").empty();
	
	async(CONTEXT + '/management/bid/project/query', param, function (msg) {
		var result = msg.result;

		if (result.data) {
			/*

                      	 	<!-- 
                      	 	<tr>
                      	 		<td></td>
                      	 		<td></td>
                      	 		<td></td>
                      	 		<td>2017-02-24 15:00:00</td>
                      	 		<td>������</td>
                      	 		<td><a href="#">���۴���</a><a href="#">�������Ӧ</a></td>
                      	 	</tr>
                      	 	 -->
            */
             
			
          	for (var i = 0; i < result.data.length; i++) {
          		var item = result.data[i];
	        	var tr = $("<tr>");
	            tr.append("<td><a href='" + CONTEXT + "/management/bid/project/detail?projId=" + item.projId + "'>" + item.projId + "</a></td>");
	            tr.append("<td>" + item.projName + "</td>");
	            tr.append("<td>" + item.bidCatName + "</td>");
	            tr.append("<td>" + new Date(item.bidStartTime).asString("yyyy-mm-dd hh:min") + "</td>");
	            var status = "";
	            
	            var flag = false;
	            if (item.projStatus == 1) {
	            	status = "������";
	            } else if (item.projStatus == 2) {
	            	status = "������";
	            } else if (item.projStatus == 3) {
	            	status = "�ѿ���";
	            } else if (item.projStatus == 4) {
	            	status = "���ڱ�";
	            } else if (item.projStatus == 5) {
	            	status = "���ڱ�";
	            } else if (item.projStatus == 6) {
	            	status = "�ѷϱ�";
	            } else if (item.projStatus == 7) {
	            	status = "�Ѷ���";
	            } else if (item.projStatus == 8) {
	            	status = "�ѹ�ʾ";
	            	if (new Date(item.publicityEnd).getTime() < new Date().getTime() ) {
	            		flag = true;
	            	}
	            }else if (item.projStatus == 9) {
	            	status = "����ֹ";
	            }
	            
	            tr.append("<td>" + status + "</td>");
	            var op = $("<td>");
	            if (item.projStatus == 2 || item.projStatus == 3) {
	            	op.append("<a target='_blank' href='" + CONTEXT + "/management/bid/project/hall?projId=" + item.projId + "'>���۴���</a>");
	            } else if (item.projStatus == 1) {
	            	op.append("<a href='javascript:;' data-id='" + item.projId + "' data-time='" + (new Date(item.bidStartTime).getTime()) + "' onclick='publish(this)'>��������</a>");
	            	op.append("<a href='" + CONTEXT + "/management/bid/project/edit?projId=" + item.projId + "'>�޸���Ŀ</a>");
	            	op.append("<a href='javascript:;' data-id='" + item.projId + "', onclick='del(this)'>ɾ��</a>");
	            	op.append("<a href='" + CONTEXT + "/management/bid/project/detail?projId=" + item.projId + "'>�鿴</a>");
	            } else if (item.projStatus == 4 || flag) {
	            	op.append("<a href='" + CONTEXT + "/management/bid/project/award?projId=" + item.projId + "'>�ڱ�</a>");
	            	op.append("<a href='" + CONTEXT + "/management/bid/project/obsolete?projId=" + item.projId + "'>�ϱ�</a>");
	            } else if (item.projStatus == 5) {
	            	op.append("<a href='" + CONTEXT + "/management/bid/project/view?projId=" + item.projId + "'>����</a>");
	            	if (item.ifContract == 1) {
		            	op.append("<a href='" + CONTEXT + "/management/bid/contract?menuParam=00011004&projId=" + item.projId + "'>��ͬ����</a>");
	            	} else {
		            	op.append("<a href='" + CONTEXT + "/management/bid/project/notice?projId=" + item.projId + "'>����֪ͨ��</a>");
	            	}
	            } else if (item.projStatus == 6 || item.projStatus == 9) {
	            	op.append("<a href='" + CONTEXT + "/management/bid/project/view?projId=" + item.projId + "'>�鿴</a>");
	            } else if (item.projStatus == 7) {
//	            	op.append("<a href='" + CONTEXT + "/management/bid/project/view?projId=" + item.projId + "'>�鿴</a>");
	            	op.append("<a href='" + CONTEXT + "/management/bid/project/notice?projId=" + item.projId + "'>����֪ͨ��</a>");
	            } else if (item.projStatus == 8) {
	            	op.append("<a href='" + CONTEXT + "/management/bid/project/obsolete?projId=" + item.projId + "'>�ϱ�</a>");
	            	op.append("<a target='_blank' href='" + CONTEXT + "/market/bid/publicity?projId=" + item.projId + "'>�鿴</a>");
	            }
	            
	            tr.append(op);
	            $("#project_tbody").append(tr);
        	   
           	}
             
             
		}
		
		paging("#project_page", result.pages, param.page, queryProj);
	});
}

var publish = function (obj) {
	var projId = $(obj).attr("data-id");
	var time = $(obj).attr("data-time");
	
	if (time < new Date().getTime() + 86400000) {
		alert("���ۿ�ʼʱ�䲻��С�ڵ�ǰʱ��+1�죬���޸ĺ󷢲�");
		return false;
	}

	if (confirm("�Ƿ�ȷ�Ϸ�������Ŀ��")) {
		async(CONTEXT + '/management/bid/project/publish', {projId:projId}, function (msg) {
			alert("�����ɹ�");
			queryProj(true);
		});
	}
	
}



var del = function (obj) {
	var projId = $(obj).attr("data-id");

	if (confirm("�Ƿ�ȷ��ɾ������Ŀ��")) {
		async(CONTEXT + '/management/bid/project/del', {projId:projId}, function (msg) {
			alert("ɾ���ɹ�");
			queryProj(true);
		});
	}
	
}