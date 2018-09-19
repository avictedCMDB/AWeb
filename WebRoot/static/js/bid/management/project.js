
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
                      	 		<td>待开标</td>
                      	 		<td><a href="#">竞价大厅</a><a href="#">澄清与回应</a></td>
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
	            	status = "待发布";
	            } else if (item.projStatus == 2) {
	            	status = "待开标";
	            } else if (item.projStatus == 3) {
	            	status = "已开标";
	            } else if (item.projStatus == 4) {
	            	status = "待授标";
	            } else if (item.projStatus == 5) {
	            	status = "已授标";
	            } else if (item.projStatus == 6) {
	            	status = "已废标";
	            } else if (item.projStatus == 7) {
	            	status = "已定标";
	            } else if (item.projStatus == 8) {
	            	status = "已公示";
	            	if (new Date(item.publicityEnd).getTime() < new Date().getTime() ) {
	            		flag = true;
	            	}
	            }else if (item.projStatus == 9) {
	            	status = "已终止";
	            }
	            
	            tr.append("<td>" + status + "</td>");
	            var op = $("<td>");
	            if (item.projStatus == 2 || item.projStatus == 3) {
	            	op.append("<a target='_blank' href='" + CONTEXT + "/management/bid/project/hall?projId=" + item.projId + "'>竞价大厅</a>");
	            } else if (item.projStatus == 1) {
	            	op.append("<a href='javascript:;' data-id='" + item.projId + "' data-time='" + (new Date(item.bidStartTime).getTime()) + "' onclick='publish(this)'>发布公告</a>");
	            	op.append("<a href='" + CONTEXT + "/management/bid/project/edit?projId=" + item.projId + "'>修改项目</a>");
	            	op.append("<a href='javascript:;' data-id='" + item.projId + "', onclick='del(this)'>删除</a>");
	            	op.append("<a href='" + CONTEXT + "/management/bid/project/detail?projId=" + item.projId + "'>查看</a>");
	            } else if (item.projStatus == 4 || flag) {
	            	op.append("<a href='" + CONTEXT + "/management/bid/project/award?projId=" + item.projId + "'>授标</a>");
	            	op.append("<a href='" + CONTEXT + "/management/bid/project/obsolete?projId=" + item.projId + "'>废标</a>");
	            } else if (item.projStatus == 5) {
	            	op.append("<a href='" + CONTEXT + "/management/bid/project/view?projId=" + item.projId + "'>详情</a>");
	            	if (item.ifContract == 1) {
		            	op.append("<a href='" + CONTEXT + "/management/bid/contract?menuParam=00011004&projId=" + item.projId + "'>合同管理</a>");
	            	} else {
		            	op.append("<a href='" + CONTEXT + "/management/bid/project/notice?projId=" + item.projId + "'>定标通知书</a>");
	            	}
	            } else if (item.projStatus == 6 || item.projStatus == 9) {
	            	op.append("<a href='" + CONTEXT + "/management/bid/project/view?projId=" + item.projId + "'>查看</a>");
	            } else if (item.projStatus == 7) {
//	            	op.append("<a href='" + CONTEXT + "/management/bid/project/view?projId=" + item.projId + "'>查看</a>");
	            	op.append("<a href='" + CONTEXT + "/management/bid/project/notice?projId=" + item.projId + "'>定标通知书</a>");
	            } else if (item.projStatus == 8) {
	            	op.append("<a href='" + CONTEXT + "/management/bid/project/obsolete?projId=" + item.projId + "'>废标</a>");
	            	op.append("<a target='_blank' href='" + CONTEXT + "/market/bid/publicity?projId=" + item.projId + "'>查看</a>");
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
		alert("竞价开始时间不能小于当前时间+1天，请修改后发布");
		return false;
	}

	if (confirm("是否确认发布此项目？")) {
		async(CONTEXT + '/management/bid/project/publish', {projId:projId}, function (msg) {
			alert("发布成功");
			queryProj(true);
		});
	}
	
}



var del = function (obj) {
	var projId = $(obj).attr("data-id");

	if (confirm("是否确认删除此项目？")) {
		async(CONTEXT + '/management/bid/project/del', {projId:projId}, function (msg) {
			alert("删除成功");
			queryProj(true);
		});
	}
	
}
