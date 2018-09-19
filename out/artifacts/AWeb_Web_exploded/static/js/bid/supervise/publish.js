
var projId, projName;
var param = {};

var bidStartTimePicked = function () {

	var t = Date.fromString($("#bid_start_time").val(), 'yyyy-mm-dd hh:min').getTime();
	$("#join_end_time").val(new Date(t - 60 * 60 * 24 * 1000).asString('yyyy-mm-dd hh:min'));
}

$(function () {
	var func = $("#func").val();
	
	$("button[data-step]").click(function () {
		
		var cur = $(this).attr("data-cur");
		
		if (cur == 1) {
			var proj_type = $("#proj_type").val();
			if (func != 'detail') {
				var bid_cat = $("#bid_cat").val();
				if (bid_cat == "") {
					alert("请选择采购类型");
					return false;
				}
				param.bidCat = bid_cat;
				

				var proj_id = $("#proj_id").val();
				param.projId = proj_id;
				$(".proj-id-span").text(proj_id);

				var proj_name = $.trim($("#proj_name").val());
				if (proj_name == "") {
					alert("请输入竞价项目名称");
					return false;
				}
				param.projName = proj_name;
				$(".proj-name-span").text(proj_name);
				

				param.projType = proj_type;

				var decide_type = $("#decide_type").val();
				param.decideType = decide_type;

				var currency = $("#currency").val();
				param.currency = currency;

				var exchange_rate = $.trim($("#exchange_rate").val());
				if (exchange_rate == "") {
					alert("请输入汇率");
					return false;
				}
				param.exchangeRate = exchange_rate;

				var min_tender = $.trim($("#min_tender").val());
				if (min_tender == "") {
					alert("请输入最少投标单位数量");
					return false;
				} else if (!/^\d+$/.test(min_tender) || min_tender < 2) {
					alert("最少投标单位数量必须为不小于2的整数");
					return false;
				}
				param.minTender = min_tender;
				
				var budget = $.trim($("#budget").val());
				if (budget != "" && !/^\d+$/.test(budget) || budget < 1) {
					alert("采购预算必须为大于0整数");
					return false;
				}
				param.budget = budget;
				
				param.budgetPublic =  $("input[name=budget_public]:checked").val();
				
				var mtrs = $("#mtr_tbody").children();
				if (mtrs.size() == 0) {
					alert("请添加项目条目");
					return false;
				}
			
			param.materiels = [];
			
			$("#mtr_sel").empty();
			
			mtrs.each(function () {
				var tds = $(this).children();
				param.materiels.push({
					materSeq:$(this).attr("data-id"),
					materName:tds.eq(0).text(),
					materNum:tds.eq(1).text(),
					materUnit:tds.eq(2).text(),
					materBrand:tds.eq(3).text(),
					materModel:tds.eq(4).text(),
					ifStandard:tds.eq(5).text(),
					saleService:tds.eq(6).text(),
					specConf:tds.eq(7).text()
				});
                $("#mtr_sel").append('<label class="checkbox-inline"><input type="checkbox" name="mtr_sel" id="mtr_sel_' + $(this).attr("data-id") + '" value="' + $(this).attr("data-id") + '">' + $(this).find("td").eq(0).text() + '</label>');
			});	
			}
			
			if (proj_type == 1) {
				$("#sup_select").show();
			} else {
				$("#sup_select").hide();
			}
			
		} else if (cur == 2) {
			if (func != 'detail') {
			var quota_type = $("input[name=quota_type]:checked").val();
			param.quotaType = quota_type;
			var quota_limit_type = $("input[name=quota_limit_type]:checked").val();
			if (quota_limit_type == 2) {
				var quota_limit_num = $.trim($("#quota_limit_num").val());
				if (quota_limit_num == "") {
					alert("请输入报价上限");
					return false;
				} else if (!/^\d+$/.test(quota_limit_num) || quota_limit_num < 1) {
					alert("报价上限必须为大于0数字");
					return false;
				}
				param.quotaLimitNum = quota_limit_num;
			} else {
				param.quotaLimitNum = 0;
			}
			param.quotaLimitType = quota_limit_type;

			var subjects = $("#subject_tbody").children();
			if (subjects.size() == 0) {
				alert("请添加标的");
				return false;
			}
			
			
			param.subjects = [];
			var flag = true;
			
			subjects.each(function () {

				var maters = $(this).attr("data-mtr");
				var tds = $(this).children();
				
				$(maters.split(",")).each(function() {
					if ($("#mtr_tr_" + this).size() == 0) {
						alert("标的【" + tds.eq(1).text() + "】的部分物料信息已被删除，请重新选择");
						flag = false;
						return false;
					}
				});
				
				if (!flag) {
					return false;
				}
				
				param.subjects.push({
					subjectId:tds.eq(0).text(),
					subjectName:tds.eq(1).text(),
					subjectNum:tds.eq(2).text(),
					subjectUnit:tds.eq(3).text(),
					intro:tds.eq(4).text(),
					maters:maters
				});
			});
			

			if (!flag) {
				return false;
			}
			
			var split_type = $("input[name=split_type]:checked").val();
			param.splitType = split_type;
			
			param.splits = [];
			
			$("#split_tbody").children().each(function () {
				var tds = $(this).children();
				param.splits.push({
					bidRank:tds.eq(0).text(),
					splitProp:tds.eq(1).text()
				});
			});

			param.suppliers = [];
			if ($("#proj_type").val() == 1) {

				var suppliers = $("#supplier_tbody").children();
				if (suppliers.size() == 0) {
					alert("请添加供应商");
					return false;
				}
				
				suppliers.each(function () {
					param.suppliers.push({
						supCode:$(this).children().eq(0).text()
					});
				});
			} 
			}
			
			
		} else if (cur == 3) {

			if (func != 'detail') {
			
			var bid_start_time = $("#bid_start_time").val();
			if (bid_start_time == "") {
				alert("请选择竞价开始时间");
				return false;
			}
			
			param.bidStartTime = bid_start_time;
			

			var join_end_time = $("#join_end_time").val();
			if (join_end_time == "") {
				alert("请选择报名截至时间");
				return false;
			}
			
			param.joinEndTime = join_end_time;
			

			if (join_end_time > bid_start_time) {
				alert("报名截至时间不能晚于竞价开始时间");
				return false;
			}
			
			if (new Date().getTime() > Date.fromString(bid_start_time.substring(0, 10)).getTime()) {
				alert("竞价开始时间必须晚于当天日期");
				return false;
			}
			
			var bid_duration = $.trim($("#bid_duration").val());
			if (bid_duration == "") {
				alert("请输入正式竞价时长");
				return false;
			} else if (!/^\d+$/.test(bid_duration) || bid_duration < 1) {
				alert("正式竞价时长必须为大于0数字");
				return false;
			}
			
			param.bidDuration = bid_duration;
			
			var timeout_interval = $.trim($("#timeout_interval").val());
			if (timeout_interval == "") {
				alert("请输入超时竞价时间间隔");
				return false;
			} else if (!/^\d+$/.test(timeout_interval) || timeout_interval < 1) {
				alert("超时竞价时间间隔必须为大于0数字");
				return false;
			}
			
			param.timeoutInterval = timeout_interval;
			
			var min_incr_type = $("input[name=min_incr_type]:checked").val();
			
			param.minIncrType = min_incr_type;
			param.minIncrVal = 0;
			if (min_incr_type == 2) {
				var min_incr_val_2 = $.trim($("#min_incr_val_2").val());
				if (min_incr_val_2 == "") {
					alert("请输入最低竞价幅度（数值）");
					return false;
				} else if (!/^\d+$/.test(min_incr_val_2) || min_incr_val_2 < 1) {
					alert("最低竞价幅度（数值）必须为大于0数字");
					return false;
				}
				param.minIncrVal = min_incr_val_2;
			}
			if (min_incr_type == 3) {
				if (param.quotaLimitType != 2) {
					alert("报价上限为不限时不能选择最低竞价幅度（总价百分比）");
					return false;
				}
				
				
				var min_incr_val_3 = $.trim($("#min_incr_val_3").val());
				if (min_incr_val_3 == "") {
					alert("请输入最低竞价幅度（总价百分比）");
					return false;
				} else if (!/^\d+$/.test(min_incr_val_3) || min_incr_val_3 < 1 || min_incr_val_3 > 100) {
					alert("最低竞价幅度（数值）必须为大于0且小于100的数字");
					return false;
				}
				param.minIncrVal = min_incr_val_3;
			} 
			
			var quota_decr_limit = $.trim($("#quota_decr_limit").val());
			if (quota_decr_limit == "") {
				alert("请输入报价限制");
				return false;
			} else if (!/^\d+$/.test(quota_decr_limit) || quota_decr_limit < 1 || quota_decr_limit > 100) {
				alert("报价限制必须为大于0且小于100的数字");
				return false;
			}
			
			param.quotaDecrLimit = quota_decr_limit;
			
			var times_limit_type = $("input[name=times_limit_type]:checked").val();
			if (times_limit_type == 2) {
				var times_limit_num = $.trim($("#times_limit_num").val());
				if (times_limit_num == "") {
					alert("请输入报价次数限制");
					return false;
				} else if (!/^\d+$/.test(times_limit_num) || times_limit_num < 1) {
					alert("报价次数限制必须为大于0数字");
					return false;
				}
				param.timesLimitNum = times_limit_num;
			} else {
				param.timesLimitNum = 0;
			}
			
			param.timesLimitType = times_limit_type;
			
			var accept_type = $("input[name=accept_type]:checked").val();
			param.acceptType = accept_type;
			
			var tender_price = $.trim($("#tender_price").val());
			if (tender_price == "") {
				alert("请输入标书售价");
				return false;
			} else if (!/^\d+$/.test(tender_price)) {
				alert("标书售价必须为数字");
				return false;
			}
			
			param.tenderPrice = tender_price;
			
			var bid_bond = $.trim($("#bid_bond").val());
			if (bid_bond == "") {
				alert("请输入投标保证金");
				return false;
			} else if (!/^\d+$/.test(bid_bond)) {
				alert("投标保证金必须为数字");
				return false;
			}
			
			param.bidBond = bid_bond;
			

			var publish_quota = $("input[name=publish_quota]:checked").val();
			param.publishQuota = publish_quota;
			}
			
		} else if (cur == 4) {

			if (func != 'detail') {
			var bidder_qual = $.trim($("#bidder_qual").val());
			if (bidder_qual == "") {
				alert("请输入竞价投标人资格");
				return false;
			}
			
			param.bidderQual = bidder_qual;
			
			var bid_invitation = $.trim($("#bid_invitation").val());
			if (bid_invitation == "") {
				alert("请输入竞价招标文件的邀请");
				return false;
			}
			
			param.bidInvitation = bid_invitation;
			
			var bid_time_rule = $.trim($("#bid_time_rule").val());
			if (bid_time_rule == "") {
				alert("请输入网上竞价采购的时间规定");
				return false;
			}
			
			param.bidTimeRule = bid_time_rule;
			
			var bid_quota_rule = $.trim($("#bid_quota_rule").val());
			if (bid_quota_rule == "") {
				alert("请输入在线竞价投标报价");
				return false;
			}
			
			param.bidQuotaRule = bid_quota_rule;
			
			var caution = $.trim($("#caution").val());
			if (caution == "") {
				alert("请输入注意事项");
				return false;
			}
			
			param.caution = caution;
			
			var remark = $.trim($("#remark").val());
			param.remark = remark;
			}
		}
		
		$("#matter_section").children().hide();
		$("#sec_inner_" + $(this).attr("data-step")).show();
	});
	
	$("input[name=mtr_select]").click(function () {
		var val = $(this).val();
		if (val == 1) {
			$("#templet01").show();
			$("#templet02").hide();
		} else {
			$("#templet01").hide();
			$("#templet02").show();
		}
	});
	
	$("#mtr_add").click(function () {
		$("#mtr_file").val("");
		$("#mtr_field").val("");
		$("#mtr_result").text("导入信息");
		
		$("#mtr_query_name").val("");
		$("#mtr_query_tbody").empty();
		$("#mtr_page").empty();
		
		$("#myModal").modal("show");
	});
	
	$("#mtr_upload").click(function () {
		if ($("#mtr_field").val() == "") {
			alert("请选择导入文件");
			return false;
		}
		if (loading) return;
		loading = true;
		$("#mtr_result").text("导入中...");
		uploadType = 1;
		$("#upload_target").appendTo($(document.body));
		$("#mtr_form").submit();
	});
	
	$("#mtr_query").click(function () {
		var name = $.trim($("#mtr_query_name").val());
		if (name == "") {
			alert("请填写物料名称");
			return false;
		}
		
		mtrParam = {name:name};
		
		queryMtr();
	});
	
	$("#mtr_query_add").click(function () {
		var sel = $("input[name=mtr_query_sel]:checked");
		
		if (sel.size() == 0) {
			alert("请选择物料信息");
			return false;
		}
		
		sel.each(function () {
			var chx = $(this);
			var tds = chx.parent().parent().children();
			
			mtrInsert({
				materNum:chx.attr("data-materNum"),
				materUnit:chx.attr("data-materUnit"),
				ifStandard:chx.attr("data-ifStandard"),
				saleService:chx.attr("data-saleService"),
				specConf:chx.attr("data-specConf"),
				materName:tds.eq(1).text(),
				materBrand:tds.eq(2).text(),
				materModel:tds.eq(3).text()
			});
		});
	});
	
	$("input[name=quota_limit_type]").click(function () {
		if ($(this).val() == 1) {
			$("#quota_limit_num").attr("readonly", "readonly");
		} else {
			$("#quota_limit_num").removeAttr("readonly");
		}
	});
	
	$("#subject_add").click(function () {
		if ($("input[name=quota_type]:checked").val() == 1 && $("#subject_tbody").children().size() > 0) {
			alert("报价方式为【单个标的报价单】时，只能添加一个标的");
			return;
		}

		async(CONTEXT + '/management/bid/' + ACT + '/subject/no', mtrParam, function (msg) {
			$("#subject_id").val(msg.result);
			$("#subject_name").val("");
			$("#subject_num").val("");
			$("#subject_unit").val("");
			$("#intro").val("");
			$("input[name=mtr_sel]").each(function () {
				this.checked = false;
			});
			
			$("#subjectModal").modal("show");
		});
	});
	
	$("#subject_modal_ok").click(function () {
		var subject_id = $("#subject_id").val();
		var subject_name = $.trim($("#subject_name").val());
		var subject_num = $.trim($("#subject_num").val());
		var subject_unit = $.trim($("#subject_unit").val());
		var intro = $.trim($("#intro").val());
		var mtrs = [];
		
		$("input[name=mtr_sel]").each(function () {
			if (this.checked) {
				mtrs.push($(this).val());
			}
		});
		
		if (subject_name == "") {
			alert("请输入标的名称");
			return;
		}
		
		if (subject_num == "") {
			alert("请输入数量");
			return;
		} else if (!/^\d+$/.test(subject_num) || subject_num < 1) {
			alert("数量必须为大于1的数字");
			return;
		}
		
		if (subject_unit == "") {
			alert("请输入计量单位");
			return;
		}
		
		if (mtrs.length == 0) {
			alert("请选择物料信息");
			return;
		}
		
		var tr = $("#subject_tr_" + subject_id);
		
		if (tr.size() == 0) {
			tr = $("<tr>");
			tr.attr("id", "subject_tr_" + subject_id);
			$("#subject_tbody").append(tr);
		} else {
			tr.empty();
		}
		
		tr.attr("data-mtr", mtrs.join(","));
		
		tr.append("<td>" + subject_id + "</td>");
		tr.append('<td class="left">' + subject_name + '</td>');
		tr.append("<td>" + subject_num + "</td>");
		tr.append("<td>" + subject_unit + "</td>");
		tr.append('<td class="left">' + intro + '</td>');
		
		var edit = $("<a>");
		edit.attr("href", "javascript:;");
		edit.text("修改");
		edit.click(function () {
			subjectEdit(this);
		});
		
		var del = $("<a>");
		del.attr("href", "javascript:;");
		del.text("删除");
		del.click(function () {
			subjectDel(this);
		});
		
		var td = $("<td>");
		td.addClass("center");
		td.append(edit);
		td.append(del);
		
		tr.append(td);
		
		/*

        <tr>
            <td>1</td>
            <td class="left">标的名称标的名称标的名称</td>
            <td></td>
            <td></td>
            <td class="left">说明说明说明</td>
            <td class="center"><a href="#">修改</a><a href="#">删除</a></td>
        
        */

		$("#subjectModal").modal("hide");
	});
	
	$("#split_add").click(function () {
		var num = $("#split_tbody").children().size();
		$("#bid_rank").text(num + 1);
		$("#split_prop").val("");
		$("#split_modal").modal("show");
	});
	
	$("#split_modal_ok").click(function () {
		var bid_rank = $("#bid_rank").text();
		var split_prop = $.trim($("#split_prop").val());
		
		if (split_prop == "") {
			alert("请输入分配比例");
			return;
		}
		if (!/^\d+$/.test(split_prop) || split_prop < 1) {
			alert("分配比例必须为大于0数字");
			return;
		}
		
		var total = 0;
		$("#split_tbody").children().each(function () {
			var prop = $(this).children().eq(1).text();
			total = total + parseInt(prop);
		});
		
		if (total + parseInt(split_prop) > 100) {
			alert("所有分配比例之和不能超过100");
			return;
		}
		
		/*

	    <tr>
	        <td></td>
	        <td></td>
	        <td class="center"><a href="#">删除</a></td>
	    </tr>
	    <tr>
	        <td></td>
	        <td></td>
	        <td class="center"><a href="#">删除</a></td>
	    </tr>
	    */
		
		var tr = $("<tr>");
		tr.append("<td>" + bid_rank + "</td>");
		tr.append("<td>" + split_prop + "</td>");
		
		var del = $("<a>");
		del.attr("href", "javascript:;");
		del.text("删除");
		del.click(function () {
			splitDel(this);
		});
		
		var td = $("<td>");
		td.addClass("center");
		td.append(del);
		tr.append(td);
		
		$("#split_tbody").append(tr);
		
		$("#split_modal").modal("hide");

	});
	
	$("input[name=quota_type]").click(function () {
		if (this.value == 1 && $("#subject_tbody").children().size() > 1) {
			alert("单个标的报价单，只能添加一个标的，请删除其他标的后，再更换报价方式。");
			return false;
		}
	});
	
	$("#supplier_add").click(function () {
		$("#sup_code").val("");
		$("#sup_name").val("");
		$("#contact_person").val("");
		$("#contact_num").val("");
		$("#supplier_query_tbody").empty();
		$("#supplier_page").empty();
		$("#supplier_modal").modal("show");
	});

	$("#supplier_query").click(function () {
		var sup_code = $.trim($("#sup_code").val());
		var sup_name = $.trim($("#sup_name").val());
		var contact_person = $.trim($("#contact_person").val());
		var contact_num = $.trim($("#contact_num").val());
		
//		if (sup_code == "" && sup_name == "" && contact_person == "" && contact_num == "") {
//			alert("请至少输入一个查询条件");
//			return;
//		}
		
		supParam = {
				sup_code:sup_code,
				sup_name:sup_name,
				contact_person:contact_person,
				contact_num:contact_num
		};
		
		querySupplier();
		
	});

	$("#supplier_modal_ok").click(function () {
		if ($("input[name=supplier_sel]:checked").size() == 0) {
			alert("请选择供应商");
			return;
		}
		
		$("#supplier_query_tbody").children().each(function () {
			var tds = $(this).children();
			if (tds.eq(0).find("input").get(0).checked) {
				/*
				
                           <tr>
                               <td></td>
                               <td></td>
                               <td></td>
                               <td></td>
                               <td></td>
                               <td class="center"><a href="#">删除</a></td>
                           </tr>
                */
				if ($("#supplier_tr_" + tds.eq(1).text()).size() > 0) {
					return;
				}             
				var tr = $("<tr>");
				tr.attr("id", "supplier_tr_" + tds.eq(1).text());
                tr.append(tds.eq(1).clone());
                tr.append(tds.eq(2).clone());
                tr.append(tds.eq(3).clone());
                tr.append(tds.eq(4).clone());
                tr.append(tds.eq(5).clone());
                
                var td = $("<td>");
                td.addClass("center");
                
                var del = $("<a>");
                del.attr("href", "javascript:;");
                del.text("删除");
                del.click(function () {
                	supplierDel(this);
                });
                
                td.append(del);
                tr.append(td);
                
                $("#supplier_tbody").append(tr);
			}
		});
		
		$("#supplier_modal").modal("hide");
	});
	
	$("input[name=min_incr_type]").click(function () {
		$("#min_incr_val_2").attr("readonly", "readonly");
		$("#min_incr_val_3").attr("readonly", "readonly");
		
		if (this.value > 1) {
			$("#min_incr_val_" + this.value).removeAttr("readonly");
		}
	});
	
	$("input[name=times_limit_type]").click(function () {
		if (this.value == 2) {
			$("#times_limit_num").removeAttr("readonly");
		} else {
			$("#times_limit_num").attr("readonly", "readonly");
		}
	});
	
	
	
	$("#busi_add").click(function () {
		$("#tender_title_busi").val("商务要求");
		$("input[name='invoice_type']").get(0).checked = true;
		$("#delivery_time").val("");
		$("#addr_prov").val("");
		$("#addr_city").attr("data-sel", "");
		$("#addr_dist").attr("data-sel", "");
		$("#addr_prov").trigger("change");
		$("#addr_detail").val("");
		$("#tender_content_busi").val("");
		$("#attach_file_busi").val("");
		$("#attach_field_busi").val("");
		$("#attach_path_busi").val("");
		$("#attach_name_busi").val("");
		$("#file_input_busi").show();
		$("#file_show_busi").hide();
		$("#busi_id").val("");
		
		$("#busi_modal").modal("show");
	});
	
	$("#addr_prov").bind("change", function () {
		if ($(this).val() == "") {
			$("#addr_city").html("<option value=''>请选择</option>");
			$("#addr_city").trigger("change");
			return;
		}

		$("#addr_city").html("<option value=''>加载中...</option>");

		async(CONTEXT + '/management/bid/' + ACT + '/area', {area:$(this).val()}, function (msg) {
			var data = msg.result;
			$("#addr_city").html("<option value=''>请选择</option>");
			var sel = $("#addr_city").attr("data-sel");
			for (var i = 0; i < data.length; i++) {
				var sele = ""
				if (sel != "" && sel == data[i].supAreaID) {
					sele = " selected='selected'";
					$("#addr_city").attr("data-sel", "");
				}
				$("#addr_city").append("<option value='" + data[i].supAreaID + "'" + sele + ">" + data[i].supAreaName + "</option>");
			}
			$("#addr_city").trigger("change");
		});
	});
	
	$("#addr_city").bind("change", function () {
		if ($(this).val() == "") {
			$("#addr_dist").html("<option value=''>请选择</option>");
			$("#addr_dist").trigger("change");
			return;
		}

		$("#addr_dist").html("<option value=''>加载中...</option>");

		async(CONTEXT + '/management/bid/' + ACT + '/area', {area:$(this).val()}, function (msg) {
			var data = msg.result;
			$("#addr_dist").html("<option value=''>请选择</option>");
			var sel = $("#addr_dist").attr("data-sel");
			for (var i = 0; i < data.length; i++) {
				var sele = ""
				if (sel != "" && sel == data[i].supAreaID) {
					sele = " selected='selected'";
					$("#addr_dist").attr("data-sel", "");
				}
				$("#addr_dist").append("<option value='" + data[i].supAreaID + "'" + sele + ">" + data[i].supAreaName + "</option>");
			}
			$("#addr_dist").trigger("change");
		});
	});
	

	$("#attach_upload_busi").click(function () {
		if ($("#attach_field_busi").val() == "") {
			alert("请选择上传文件");
			return false;
		}
		if (loading) return;
		loading = true;

		uploadType = 2;
		$("#upload_target").appendTo($(document.body));
		$("#attach_form_busi").submit();
	});
	
	$("#file_del_busi").click(function () {
		$("#attach_file_busi").val("");
		$("#attach_field_busi").val("");
		$("#attach_path_busi").val("");
		$("#attach_name_busi").val("");
		$("#file_name_busi").val("");
		$("#file_input_busi").show();
		$("#file_show_busi").hide();
	});
	
	$("#busi_modal_ok").click(function () {
		var tender_title_busi = $.trim($("#tender_title_busi").val());
		if (tender_title_busi == "") {
			alert("请输入标题");
			return;
		}
		var delivery_time = $.trim($("#delivery_time").val());
		if (delivery_time == "") {
			alert("请输入交货期");
			return;
		}
		var addr_prov = $.trim($("#addr_prov").val());
		if (addr_prov == "") {
			alert("请选择收货地（省）");
			return;
		}
		var addr_city = $.trim($("#addr_city").val());
		if (addr_city == "") {
			alert("请选择收货地（市）");
			return;
		}
		var addr_dist = $.trim($("#addr_dist").val());
		if (addr_dist == "") {
			alert("请选择收货地（区）");
			return;
		}
		var addr_detail = $.trim($("#addr_detail").val());
		if (addr_detail == "") {
			alert("请选择收货地（详细）");
			return;
		}
		
		/*

        <!-- 
        <tr>
            <td>1</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td><a href="#">删除</a><a href="#">修改</a></td>
        </tr>
         -->
        */
       var busi_id = $("#busi_id").val();
        var tr = $("#busi_tr_" + busi_id);

        var idx = $("#busi_tbody").children().size() + parseInt(1);
        
        if (tr.size() == 0) {
        	tr = $("<tr>");
        	tr.attr("id", "busi_tr_" + idx);
            $("#busi_tbody").append(tr);
        } else {
        	idx = busi_id;
        	tr.empty();
        }
        
        tr.append("<td>" + idx + "</td>");
        tr.append("<td>" + tender_title_busi + "</td>");
        
		var td = $("<td>" + $("input[name=invoice_type]:checked").parent().text() + "</td>");
		td.attr("data-val", $("input[name=invoice_type]:checked").val());
        tr.append(td);

        tr.append("<td>" + delivery_time + "天</td>");
		var addr = $("#addr_prov").find("option:checked").text() + " " + $("#addr_city").find("option:checked").text() + " " + $("#addr_dist").find("option:checked").text() + " " + addr_detail;
		td = $("<td>" + addr + "</td>");
		td.attr("data-prov", addr_prov);
		td.attr("data-city", addr_city);
		td.attr("data-dist", addr_dist);
		td.attr("data-detail", addr_detail);
        tr.append(td);
        

        tr.append("<td>" + $("#tender_content_busi").val() + "</td>");

        td = $("<td><a href='javascript:;' onclick='downclick(this);'>" + $("#attach_name_busi").val() + "</a></td>");
        td.attr("data-path", $("#attach_path_busi").val());
        
        tr.append(td);
        
        
        var edit = $("<a href='javascript:;'>");
        edit.text("修改");
        edit.click(function () {
        	busiEdit(this);
        });

        var del = $("<a href='javascript:;'>");
        del.text("删除");
        del.click(function () {
        	busiDel(this);
        });
        
        td = $("<td>");
        td.append(edit);
        td.append(del);
        tr.append(td);
        
        $("#busi_modal").modal("hide");
	});
	

	$("#tech_add").click(function () {
		$("#tender_title_tech").val("技术要求");
		$("#tender_content_tech").val("");
		$("#attach_file_tech").val("");
		$("#attach_field_tech").val("");
		$("#attach_path_tech").val("");
		$("#attach_name_tech").val("");
		$("#file_input_tech").show();
		$("#file_show_tech").hide();
		$("#tech_id").val("");
		
		$("#tech_modal").modal("show");
	});
	
	$("#attach_upload_tech").click(function () {
		if ($("#attach_field_tech").val() == "") {
			alert("请选择上传文件");
			return false;
		}
		if (loading) return;
		loading = true;

		uploadType = 3;
		$("#upload_target").appendTo($(document.body));
		$("#attach_form_tech").submit();
	});
	
	$("#file_del_tech").click(function () {
		$("#attach_file_tech").val("");
		$("#attach_field_tech").val("");
		$("#attach_path_tech").val("");
		$("#attach_name_tech").val("");
		$("#file_name_tech").val("");
		$("#file_input_tech").show();
		$("#file_show_tech").hide();
	});
	
	$("#tech_modal_ok").click(function () {
		var tender_title_tech = $.trim($("#tender_title_tech").val());
		if (tender_title_tech == "") {
			alert("请输入标题");
			return;
		}

		var tender_content_tech = $.trim($("#tender_content_tech").val());
		if (tender_content_tech == "") {
			alert("请输入内容");
			return;
		}
		
		/*

        <!-- 
        <tr>
            <td>1</td>
            <td></td>
            <td></td>
            <td></td>
            <td><a href="#">删除</a><a href="#">修改</a></td>
        </tr>
         -->
        */
       var tech_id = $("#tech_id").val();
        var tr = $("#tech_tr_" + tech_id);

        var idx = $("#tech_tbody").children().size() + parseInt(1);
        
        if (tr.size() == 0) {
        	tr = $("<tr>");
        	tr.attr("id", "tech_tr_" + idx);
            $("#tech_tbody").append(tr);
        } else {
        	idx = tech_id;
        	tr.empty();
        }
        
        tr.append("<td>" + idx + "</td>");
        tr.append("<td>" + tender_title_tech + "</td>");
        
        

        tr.append("<td>" + $("#tender_content_tech").val() + "</td>");

        td = $("<td><a href='javascript:;' onclick='downclick(this);'>" + $("#attach_name_tech").val() + "</a></td>");
        td.attr("data-path", $("#attach_path_tech").val());
        
        tr.append(td);
        
        var del = $("<a href='javascript:;'>");
        del.text("删除");
        del.click(function () {
        	techDel(this);
        });
        
        var edit = $("<a href='javascript:;'>");
        edit.text("修改");
        edit.click(function () {
        	techEdit(this);
        });
        
        td = $("<td>");
        td.append(edit);
        td.append(del);
        tr.append(td);
        
        $("#tech_modal").modal("hide");
	});
	
	$(".submit-btn").click(function () {
		var busis = $("#busi_tbody").children();
		if (busis.size() == 0) {
			alert("请添加商务要求");
			return false;
		}
				
		var techs = $("#tech_tbody").children();
		if (techs.size() == 0) {
			alert("请添加技术要求");
			return false;
		}
				
		param.tenders = [];
		
		busis.each(function () {
			var tds = $(this).children();
			param.tenders.push({
				tenderId:tds.eq(0).text(),
				tenderType:1,
				tenderTitle:tds.eq(1).text(),
				tenderContent:tds.eq(5).text(),
				attachName:tds.eq(6).text(),
				attachPath:tds.eq(6).attr("data-path"),
				invoiceType:tds.eq(2).attr("data-val"),
				deliveryTime:tds.eq(3).text().replace("天", ""),
				addrProv:tds.eq(4).attr("data-prov"),
				addrCity:tds.eq(4).attr("data-city"),
				addrDist:tds.eq(4).attr("data-dist"),
				addrDetail:tds.eq(4).attr("data-detail")
			});
		});
		
		techs.each(function () {
			var tds = $(this).children();
			param.tenders.push({
				tenderId:tds.eq(0).text(),
				tenderType:2,
				tenderTitle:tds.eq(1).text(),
				tenderContent:tds.eq(2).text(),
				attachName:tds.eq(3).text(),
				attachPath:tds.eq(3).attr("data-path")
			});
		});
		
		
		var act = $(this).attr("data-action");
		param.func = $("#func").val();

		async(CONTEXT + '/management/bid/' + ACT + '/submit/' + act, param, function (msg) {
			if (act == "publish") {
				alert("发布成功");
			} else {
				alert("保存成功");
			}
			
			if (param.func == "edit") {
				history.go(-1);
			} else {
				window.location.href = CONTEXT + "/management/bid/project?menuParam=00011002";
			}
		});
	});
});

var mtrParam = null;
var supParam = null;

var queryMtr = function () {
	
	var page = $(this).attr("data-page");
	if ($(this).parent().hasClass("active")) {
		return false;
	}
	if (page) {
		mtrParam.page = page;
	} else {
		mtrParam.page = 1;
	}
	
	async(CONTEXT + '/management/bid/' + ACT + '/mtr/query', mtrParam, function (msg) {
		var result = msg.result;
		$("#mtr_query_tbody").empty();
		if (result.data) {
			/*

             <!-- 
             <tr>
               <td><input type="checkbox"></td>
               <td></td>
               <td></td>
               <td></td>
             </tr>
              -->
            */
             
			
          	for (var i = 0; i < result.data.length; i++) {
          		var item = result.data[i];
	        	var tr = $("<tr>");
	            var chx = $("<input type='checkbox'>");
	            chx.attr("name", "mtr_query_sel");
	            chx.attr("data-materUnit", item.materUnit);
	            chx.attr("data-materNum", item.materNum);
	            chx.attr("data-ifStandard", item.ifStandard);
	            chx.attr("data-saleService", item.saleService);
	            chx.attr("data-specConf", item.specConf);
	            var td = $("<td>");
	            td.append(chx);
	            tr.append(td);
	            tr.append("<td>" + item.materName + "</td>");
	            tr.append("<td>" + item.materBrand + "</td>");
	            tr.append("<td>" + item.materModel + "</td>");
	            $("#mtr_query_tbody").append(tr);
        	   
           	}
             
             
		}
		
		paging("#mtr_page", result.pages, mtrParam.page, queryMtr);
	});
}

var querySupplier = function () {
	
	var page = $(this).attr("data-page");
	if ($(this).parent().hasClass("active")) {
		return false;
	}
	
	
	if (page) {
		supParam.page = page;
	} else {
		supParam.page = 1;
	}
	
	async(CONTEXT + '/management/bid/' + ACT + '/supplier/query', supParam, function (msg) {
		var result = msg.result;

		$("#supplier_query_tbody").empty();
		if (result.data) {
			/*

            <tr>
                 <td><input type="checkbox"></td>
                 <td></td>
                 <td></td>
                 <td></td>
                 <td></td>
                 <td></td>
            </tr>
            */
             
			
          	for (var i = 0; i < result.data.length; i++) {
          		var item = result.data[i];
	        	var tr = $("<tr>");
	            var chx = $("<input type='checkbox'>");
	            chx.val(item.supCode);
	            chx.attr("name", "supplier_sel");
	            var td = $("<td>");
	            td.append(chx);
	            tr.append(td);
	            tr.append("<td>" + item.supCode + "</td>");
	            tr.append("<td>" + item.supName + "</td>");
	            tr.append("<td>" + __(item.contactPerson) + "</td>");
	            tr.append("<td>" + __(item.contactNum) + "</td>");
	            tr.append("<td>" + __(item.email) + "</td>");
	            $("#supplier_query_tbody").append(tr);
        	   
           	}
             
             
		}
		
		paging("#supplier_page", result.pages, supParam.page, querySupplier);
	});
}


var uploadType;
var _uploadCallback = function (result, url, fail, data) {
	loading = false;
		if (uploadType == 1) {
			if (result > 0) {
				for (var i = 0; i < data.length; i++) {
					mtrInsert(data[i]);
				}
				$("#mtr_result").text("共导入" + data.length + "条采购商品信息");
			} else {
				$("#mtr_result").html("导入失败：<br/>" + fail);
			}
		} else if (uploadType == 2) {
			if (result > 0) {
				$("#file_name_busi").val(data.name);
				$("#attach_name_busi").val(data.name);
				$("#attach_path_busi").val(data.path);
				$("#file_input_busi").hide();
				$("#file_show_busi").show();
			} else {
				alert(fail);
			}
		} else if (uploadType == 3) {
			if (result > 0) {
				$("#file_name_tech").val(data.name);
				$("#attach_name_tech").val(data.name);
				$("#attach_path_tech").val(data.path);
				$("#file_input_tech").hide();
				$("#file_show_tech").show();
			} else {
				alert(fail);
			}
		}
}

var mtrIndex = 1;

var mtrInsert = function (mtr) {
	var tr = $("<tr>");
	tr.attr("id", "mtr_tr_" + mtrIndex);
	tr.attr("data-id", mtrIndex++);
	
	var td1 = $("<td>");
	td1.text(mtr.materName);
	tr.append(td1);

	var td2 = $("<td>");
	td2.text(mtr.materNum);
	tr.append(td2);

	var td3 = $("<td>");
	td3.text(mtr.materUnit);
	tr.append(td3);

	var td4 = $("<td>");
	td4.text(mtr.materBrand);
	tr.append(td4);

	var td5 = $("<td>");
	td5.text(mtr.materModel);
	tr.append(td5);

	var td6 = $("<td>");
	td6.text(mtr.ifStandard);
	tr.append(td6);

	var td7 = $("<td>");
	td7.text(mtr.saleService);
	tr.append(td7);

	var td8 = $("<td>");
	td8.text(mtr.specConf);
	tr.append(td8);

	var td9 = $("<td>");
	td9.addClass("center");
	var del = $('<a href="javascript:;">删除</a>');
	del.click(function () {
		mtrDel(this);
	});
	td9.append(del);
	tr.append(td9);
	
	$("#mtr_tbody").append(tr);
}

var mtrDel = function (obj) {
	if (confirm("是否确认删除此条物料信息？")) {
		$(obj).parent().parent().remove();
	}
};

var subjectEdit = function (obj) {
	
	var row = $(obj).parent().parent();
	var tds = row.children();
	$("#subject_id").val(tds.eq(0).text());
	$("#subject_name").val(tds.eq(1).text());
	$("#subject_num").val(tds.eq(2).text());
	$("#subject_unit").val(tds.eq(3).text());
	$("#intro").val(tds.eq(4).text());

	$("input[name=mtr_sel]").each(function () {
		this.checked = false;
	});
	
	$(row.attr("data-mtr").split(",")).each(function () {
		if ($("#mtr_sel_" + this).size() > 0) {
			$("#mtr_sel_" + this).get(0).checked = true;
		}
	});
	
	$("#subjectModal").modal("show");
};

var subjectDel = function (obj) {
	if (confirm("是否确认删除此标的？")) {
		$(obj).parent().parent().remove();
	}
};

var splitDel = function (obj) {
	if (confirm("是否确认删除此名次的分配比例？删除将使后面的名次将提前")) {
		$(obj).parent().parent().remove();
		
		$("#split_tbody").children().each(function (index) {
			$(this).children().eq(0).text(index + 1);
		});
	}
};

var supplierDel = function (obj) {
	if (confirm("确认删除此供应商？")) {
    	$(obj).parent().parent().remove();
	}
};

var busiEdit = function (obj) {
    	var tds = $(obj).parent().parent().children();
    	
		$("#tender_title_busi").val(tds.eq(1).text());
		$("#invoice_type_" + tds.eq(2).attr("data-val")).get(0).checked = true;
		$("#delivery_time").val(tds.eq(3).text().replace("天", ""));
		$("#addr_prov").val(tds.eq(4).attr("data-prov"));
		$("#addr_city").attr("data-sel", tds.eq(4).attr("data-city"));
		$("#addr_dist").attr("data-sel", tds.eq(4).attr("data-dist"));
		$("#addr_prov").trigger("change");
		$("#addr_detail").val(tds.eq(4).attr("data-detail"));
		$("#tender_content_busi").val(tds.eq(5).text());
		$("#attach_file_busi").val("");
		$("#attach_field_busi").val("");
		if (tds.eq(6).attr("data-path") != "") {
    		$("#attach_path_busi").val(tds.eq(6).attr("data-path"));
    		$("#attach_name_busi").val(tds.eq(6).text());
    		$("#file_name_busi").val(tds.eq(6).text());
    		$("#file_input_busi").hide();
    		$("#file_show_busi").show();
		} else {
    		$("#attach_path_busi").val("");
    		$("#attach_name_busi").val("");
    		$("#file_input_busi").show();
    		$("#file_show_busi").hide();
		}
		$("#busi_id").val(tds.eq(0).text());
		
		$("#busi_modal").modal("show");
};

var busiDel = function (obj) {
	if (confirm("是否确认删除此标书？")) {
    	$(obj).parent().parent().remove();
    	var i = 1;
    	$("#busi_tbody").children().each(function () {
    		$(this).find("td").eq(0).text(i++);
    	});
	}
};

var techDel = function (obj) {
	if (confirm("是否确认删除此标书？")) {
    	$(obj).parent().parent().remove();
    	var i = 1;
    	$("#tech_tbody").children().each(function () {
    		$(this).find("td").eq(0).text(i++);
    	});
	}
};

var techEdit = function (obj) {
	var tds = $(obj).parent().parent().children();
	
	$("#tender_title_tech").val(tds.eq(1).text());
	$("#tender_content_tech").val(tds.eq(2).text());
	$("#attach_file_tech").val("");
	$("#attach_field_tech").val("");
	if (tds.eq(3).attr("data-path") != "") {
		$("#attach_path_tech").val(tds.eq(3).attr("data-path"));
		$("#attach_name_tech").val(tds.eq(3).text());
		$("#file_name_tech").val(tds.eq(3).text());
		$("#file_input_tech").hide();
		$("#file_show_tech").show();
	} else {
		$("#attach_path_tech").val("");
		$("#attach_name_tech").val("");
		$("#file_input_tech").show();
		$("#file_show_tech").hide();
	}
	$("#tech_id").val(tds.eq(0).text());
	
	$("#tech_modal").modal("show");
}

var downclick = function (obj) {
	$("#down_path").val($(obj).parent().attr("data-path"));
	$("#down_name").val($(obj).text());
	$("#down_form").submit();
}