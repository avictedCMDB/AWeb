$(document).ready(function(){
	$('#sul > li').click(function(){
    	$(this).addClass('active').siblings().removeClass('active');
    	var s_val = $(this).children().html();
    	if(s_val=='ȫ��'){
    		$('#order_status').val('99');
    	}else if(s_val=='�����'){
    		$('#order_status').val('1');
    	}else if(s_val=='���ջ�'){
    		$('#order_status').val('2');
    	}else{
    		$('#order_status').val('6');
    	}
    	clrVal();//tabҳ��ѯǰ�������в�ѯ����
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
	var result =confirm("��ȷ���Ƿ��յ���?");
	if(result ==true){
		$.ajax({
		    url: path+'/management/order/doReceived?o='+order_id,
		    type: "POST",
		    contentType : 'application/json;charset=gbk', //��������ͷ��Ϣ
		    dataType:"json",
		    success: function(data){
		    	if(data.result=='ok'){
		    		window.location.reload();
		    	}else{
		    		alert('ϵͳæ�����Ժ����ԡ�');
		    	}
		    },
		    error: function(res){
	            alert('ϵͳæ�����Ժ����ԡ�');
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
			if(sup_type=='1'){//��ͳ��Ӧ��
				var span = $("#wl_"+order_id);
		    	var cpiDiv = $("<div id='cpiDiv' onclick='closeDiv()' class='delivery_info'>" +
		    						"<div class='arrow_top'><img src='"+path+"/static/img/management/icon-up.png'></div>" +
		    				  "<div class='close' onclick=''><i class='fa fa-close'></i></div><div class='title'>��������</div></div>");
		    	var cpiUL = $("<ul id='cpiUL'></ul>");
	    		var cpiLI;
	    		var supExpressCodeVal=$('#supExpressCode_'+order_id).val();
	    		if(supExpressCodeVal!='null' && supExpressCodeVal!=null && supExpressCodeVal!='' && supExpressCodeVal!=undefined){
	   				cpiLI = $("<li>" +
		   						"<p>�������ƣ�"+$('#supExpressName_'+order_id).val()+"</p>" +
		   						"<p>�������ţ�"+supExpressCodeVal+"</p>" +
		   					"</li>");
		    		cpiLI.appendTo(cpiUL);
	    		}
		    	cpiUL.appendTo(cpiDiv);
		    	cpiDiv.appendTo(span);
	   		}else{
	   			if(sup_id=='4'){
		   			$("#resultTab").empty();
		   			var resultTab = $("#resultTab");
		   	    	var title = $("<tr><th width='40%'>��Ʒ����</th><th class='last' width='60%'>������ϸ</th></tr>");
		   	    	title.appendTo(resultTab);
		   			$.ajax({
		   			    url: path+'/management/ordercpi?orderID='+order_id+"&supID="+sup_id+"&supOrderId="+supOrderId,
		   			    type: "POST",
		   			    contentType : 'application/json;charset=gbk', //��������ͷ��Ϣ
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
		   			    			 var li = $("<li><span class='title'>��������</span>" +
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
		   		            alert('ϵͳæ�����Ժ����ԡ�');
		   		        }
		   			});	   			
		   		}
				else{ 
					$.ajax({
					    url: path+'/management/ordercpi?orderID='+order_id+"&supID="+sup_id+"&supOrderId="+supOrderId,
					    type: "POST",
					    contentType : 'application/json;charset=gbk', //��������ͷ��Ϣ
					    dataType:"json",
					    success: function(data){
					    	var span = $("#wl_"+order_id);
					    	var cpiDiv = $("<div id='cpiDiv' onclick='closeDiv()' class='delivery_info'>" +
					    						"<div class='arrow_top'><img src='"+path+"/static/img/management/icon-up.png'></div>" +
					    				  "<div class='close'><i class='fa fa-close'></i></div><div class='title'>��������</div></div>");
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
				            alert('ϵͳæ�����Ժ����ԡ�');
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
	var result =confirm("��ȷ��Ҫȡ��������");
	if(result ==true){
		$.ajax({
		    url: path+'/management/order/orderCancel?orderID='+order_id+"&supID="+sup_id+"&supOrderId="+supOrderId+"&sup_type="+sup_type,
		    type: "POST",
		    contentType : 'application/json;charset=gbk', //��������ͷ��Ϣ
		    dataType:"json",
		    success: function(data){
		    	if(data.result=='ok'){
					window.location.reload();
		    	}else{
		    		alert('ϵͳæ�����Ժ����ԡ�');
		    	}
		    },
		    error: function(res){
	            alert('ϵͳæ�����Ժ����ԡ�');
	        }
		});
	}
}

function orderDel(order_id){
	var path = $("#path").val();
	var result =confirm("��ȷ��Ҫɾ��������");
	if(result ==true){
		$.ajax({
		    url: path+'/management/order/orderDel?orderID='+order_id,
		    type: "POST",
		    contentType : 'application/json;charset=gbk', //��������ͷ��Ϣ
		    dataType:"json",
		    success: function(data){
		    	if(data.result=='ok'){
					window.location.reload();
		    	}else{
		    		alert('ϵͳæ�����Ժ����ԡ�');
		    	}
		    },
		    error: function(res){
	            alert('ϵͳæ�����Ժ����ԡ�');
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
	var iWidth=715;                          //�������ڵĿ���; 
    var iHeight=445;                         //�������ڵĸ߶�;  
	var iTop = (window.screen.availHeight-30-iHeight)/2;       //��ô��ڵĴ�ֱλ��;
	var iLeft = (window.screen.availWidth-10-iWidth)/2;           //��ô��ڵ�ˮƽλ��;
	var path = $("#path").val();
	var url = path+"/management/order/quote?orderID="+orderID+"&supID="+supID;
	window.open(url, 'newwindow', 'height='+iHeight+', width='+iWidth+', top='+iTop+', left='+iLeft+', toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, status=no');
}

function closeDiv(){
	$("#cpiDiv").remove();
}