$(document).ready(function(){
	$('#sul > li').click(function(){
    	$(this).addClass('active').siblings().removeClass('active');
    	var s_val = $(this).children().html();
    	if(s_val=='全部'){
    		$('#order_status').val('99');
    	}else if(s_val=='待审核'){
    		$('#order_status').val('1');
    	}else if(s_val=='待收货'){
    		$('#order_status').val('2');
    	}else{
    		$('#order_status').val('6');
    	}
    	clrVal();//tab页查询前先请所有查询条件
    	doInit($('#path').val());
	});
});

function doInit(path){
	document.getElementById("searchForm").action=path+"/management/order";
	document.getElementById("searchForm").submit();
}

function downloadExcel(path){
	document.getElementById("searchForm").action=path+"/management/order/downloadExcel";
	document.getElementById("searchForm").submit();
}

function getOrderStatus(){
	var order_status1 = $('#order_status1').val();
	$('#order_status').val(order_status1);
	if(order_status1=='99' || order_status1=='1' || order_status1=='6'){
		$('#li'+order_status1).addClass('active').siblings().removeClass('active');
	}else if(order_status1=='2'){
		$('#li3').addClass('active').siblings().removeClass('active');
	}else{
		$("#li99").removeClass('active').siblings().removeClass('active');
	}
}

function exchangeGoods(path,order_id){
	window.location.href=path+'/management/orderExchange?o='+order_id;;
}

function refoundGoods(path,order_id){
	window.location.href=path+'/management/orderRefound?o='+order_id;
}

function doReceived(path,order_id){
	var result =confirm("请确认是否收到货?");
	if(result ==true){
		$.ajax({
		    url: path+'/management/order/doReceived?o='+order_id,
		    type: "POST",
		    contentType : 'application/json;charset=gbk', //设置请求头信息
		    dataType:"json",
		    success: function(data){
		    	if(data.result=='ok'){
		    		window.location.reload();
		    	}else{
		    		alert('系统忙，请稍后再试。');
		    	}
		    },
		    error: function(res){
	            alert('系统忙，请稍后再试。');
	        }
		});
	}
}

function clrVal(){
	$("#sup_name").val('');
	$("#order_id").val('');
	$("#goods_name").val('');
	$("#order_time").val('');
	$("#order_status1").val('99');
	
}

function clrAllVal(){
	clrVal();
	$("#order_status").val('99');
	$("#li99").addClass('active').siblings().removeClass('active');
}

function openWindow(path){
	window.open(path);
}

function wuLiuShow(order_id,sup_id,supOrderId,sup_type){
	var path = $("#path").val();
		if($("#cpiDiv").length==0||$("#cpiDiv").is(":hidden")){
			$("#cpiDiv").remove();
			if(sup_type=='1'){//传统供应商
				var span = $("#wl_"+order_id);
		    	var cpiDiv = $("<div id='cpiDiv' onclick='closeDiv()' class='delivery_info'>" +
		    						"<div class='arrow_top'><img src='"+path+"/static/img/management/icon-up.png'></div>" +
		    				  "<div class='close' onclick=''><i class='fa fa-close'></i></div><div class='title'>物流配送</div></div>");
		    	var cpiUL = $("<ul id='cpiUL'></ul>");
	    		var cpiLI;
	    		var supExpressCodeVal=$('#supExpressCode_'+order_id).val();
	    		if(supExpressCodeVal!='null' && supExpressCodeVal!=null && supExpressCodeVal!='' && supExpressCodeVal!=undefined){
	   				cpiLI = $("<li>" +
		   						"<p>物流名称："+$('#supExpressName_'+order_id).val()+"</p>" +
		   						"<p>物流单号："+supExpressCodeVal+"</p>" +
		   					"</li>");
		    		cpiLI.appendTo(cpiUL);
	    		}
		    	cpiUL.appendTo(cpiDiv);
		    	cpiDiv.appendTo(span);
	   		}else{
	   			if(sup_id=='4'){
		   			$("#resultTab").empty();
		   			var resultTab = $("#resultTab");
		   	    	var title = $("<tr><th width='40%'>商品名称</th><th class='last' width='60%'>物流明细</th></tr>");
		   	    	title.appendTo(resultTab);
		   			$.ajax({
		   			    url: path+'/management/ordercpi?orderID='+order_id+"&supID="+sup_id+"&supOrderId="+supOrderId,
		   			    type: "POST",
		   			    contentType : 'application/json;charset=gbk', //设置请求头信息
		   			    dataType:"json",
		   			    success: function(data){
		   			    	$(data).each(function (i) {
		   			    		var tr = $("<tr></tr>");
		   			    		var goodsTD = $("<td></td>");
		   			    		var goodsStr = "";
		   			    		console.log(this.names[0]);
		   			    		 for ( var i = 0; i < this.names.length; i++) {
		   			    			 goodsStr += this.names[i]+"<br/>";
		   						}
		   			    		goodsTD.html(goodsStr);
		   			    		goodsTD.appendTo(tr);
		   			    		
		   			    		var wuliuTD = $("<td class='limited'></td>");
		   			    		var wuliuUL = $("<ul></ul>");
		   			    		 for ( var i = 0; i < this.orderCpis.length; i++) {
		   			    			 var li = $("<li><span class='title'>物流配送</span>" +
		   				    					"<span>"+this.orderCpis[i].msgTime+"</span>" +
		   				    					this.orderCpis[i].content+"</li>");
		   				    			li.appendTo(wuliuUL);
		   						}
		   			    		wuliuUL.appendTo(wuliuTD);
		   			    		wuliuTD.appendTo(tr);
		   			    		tr.appendTo(resultTab);
		   			    		
		   			    	});
		   			    },
		   			    error: function(res){
		   		            alert('系统忙，请稍后再试。');
		   		        }
		   			});	   			
		   		}
				else{ 
					$.ajax({
					    url: path+'/management/ordercpi?orderID='+order_id+"&supID="+sup_id+"&supOrderId="+supOrderId,
					    type: "POST",
					    contentType : 'application/json;charset=gbk', //设置请求头信息
					    dataType:"json",
					    success: function(data){
					    	var span = $("#wl_"+order_id);
					    	var cpiDiv = $("<div id='cpiDiv' onclick='closeDiv()' class='delivery_info'>" +
					    						"<div class='arrow_top'><img src='"+path+"/static/img/management/icon-up.png'></div>" +
					    				  "<div class='close'><i class='fa fa-close'></i></div><div class='title'>物流配送</div></div>");
					    	var cpiUL = $("<ul id='cpiUL'></ul>");
					    	$(data).each(function (i) {
					    		var cpiLI;
					    		if (sup_id == '2'){
					    			if(i==0){
						    			cpiLI = $("<li>" +
						    						"<p>"+this.msgTime+"</p>" +
						    						"<p>"+this.content+"</p>" +
						    						"<p>"+this.operator+"</p>" +
						    					"</li>");
						    		}else{
						    			cpiLI = $("<li class='old'>" +
					    						"<p>"+this.msgTime+"</p>" +
					    						"<p>"+this.content+"</p>" +
					    						"<p>"+this.operator+"</p>" +
					    					"</li>");
						    		}		    			
					    		}else{
					    			if(i==0){
						    			cpiLI = $("<li>" +
						    						"<p>"+this.operate_time+"</p>" +
						    						"<p>"+this.content+"</p>" +
						    						"<p>"+this.operator+"</p>" +
						    					"</li>");
						    		}else{
						    			cpiLI = $("<li class='old'>" +
					    						"<p>"+this.operate_time+"</p>" +
					    						"<p>"+this.content+"</p>" +
					    						"<p>"+this.operator+"</p>" +
					    					"</li>");
						    		}		    			
					    		}
					    		cpiLI.appendTo(cpiUL);
				            });
					    	
					    	cpiUL.appendTo(cpiDiv);
					    	cpiDiv.appendTo(span);
					    },
					    error: function(res){
				            alert('系统忙，请稍后再试。');
				        }
					});
		   		}
	   		} 
		}else{
			$("#cpiDiv").hide();
		}
	
	
}

function orderCancel(order_id,sup_id,supOrderId,sup_type){
	var path = $("#path").val();
	var result =confirm("您确定要取消订单吗？");
	if(result ==true){
		$.ajax({
		    url: path+'/management/order/orderCancel?orderID='+order_id+"&supID="+sup_id+"&supOrderId="+supOrderId+"&sup_type="+sup_type,
		    type: "POST",
		    contentType : 'application/json;charset=gbk', //设置请求头信息
		    dataType:"json",
		    success: function(data){
		    	if(data.result=='ok'){
					window.location.reload();
		    	}else{
		    		alert('系统忙，请稍后再试。');
		    	}
		    },
		    error: function(res){
	            alert('系统忙，请稍后再试。');
	        }
		});
	}
}

function orderDel(order_id){
	var path = $("#path").val();
	var result =confirm("您确定要删除订单吗？");
	if(result ==true){
		$.ajax({
		    url: path+'/management/order/orderDel?orderID='+order_id,
		    type: "POST",
		    contentType : 'application/json;charset=gbk', //设置请求头信息
		    dataType:"json",
		    success: function(data){
		    	if(data.result=='ok'){
					window.location.reload();
		    	}else{
		    		alert('系统忙，请稍后再试。');
		    	}
		    },
		    error: function(res){
	            alert('系统忙，请稍后再试。');
	        }
		});
	}
}

function wuLiuHide(prefix,wlid){
	$('#cpiDiv').hide();
}

function invoiceShow(prefix,orderId){
	$('#'+prefix+orderId).show();
}

function invoiceHide(prefix,orderId){
	$('#'+prefix+orderId).hide();
}

function showP(orderID,supID){
	var iWidth=715;                          //弹出窗口的宽度; 
    var iHeight=445;                         //弹出窗口的高度;  
	var iTop = (window.screen.availHeight-30-iHeight)/2;       //获得窗口的垂直位置;
	var iLeft = (window.screen.availWidth-10-iWidth)/2;           //获得窗口的水平位置;
	var path = $("#path").val();
	var url = path+"/management/order/quote?orderID="+orderID+"&supID="+supID;
	window.open(url, 'newwindow', 'height='+iHeight+', width='+iWidth+', top='+iTop+', left='+iLeft+', toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, status=no');
}

function closeDiv(){
	$("#cpiDiv").remove();
}