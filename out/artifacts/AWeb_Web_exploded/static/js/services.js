
function search(){
	var path= $("#path").val();
	var typeID = $("#typeID").val();
	var servicesID = $("#servicesID").val();
	var serviceStatus =$("#serviceStatus").val();
	var exchangeOrRefound = $("#exchangeOrRefound").val();
	var url = path;
	if(exchangeOrRefound=="1"){
		url = url + "/management/services/exchangeServices?servicesID="+servicesID+"&servicesStatus="+serviceStatus+"&exchangeOrRefound="+exchangeOrRefound+"&typeID="+typeID;
	}else{
		url = url + "/management/services/refoundServices?servicesID="+servicesID+"&servicesStatus="+serviceStatus+"&exchangeOrRefound="+exchangeOrRefound+"&typeID="+typeID;
	}
	window.location.href = url;
}

function auditCancle(serviceID,goodsPrice,goodsPriceInit,goodsNum,supID,typeID,supGoodsID,orderID){
	var path = $("#path").val();
//	var serviceStatus =$("#serviceStatus").val();
	var exchangeOrRefound = $("#exchangeOrRefound").val();
//	var servicesID = $("servicesID").val();
	$.ajax({
        type: "POST",
        url: path+"/management/services/auditCancle",
        data: {
        	exchangeOrRefound:exchangeOrRefound,
        	servicesID:serviceID,
        	goodsPrice:goodsPrice,
        	goodsPriceInit:goodsPriceInit,
        	exchangeNum:goodsNum,
        	refoundNum:goodsNum,
        	supID:supID,
        	typeID:typeID,
        	supGoodsID:supGoodsID,
        	orderID:orderID
        },
        dataType:"json",
        success: function(data) {
        	if("success"==data.status){
    			alert("成功取消服务单！");
    		}else{
    			if(data.msg!=null&&data.msg!=""){
    				alert("京东服务单信息："+data.msg);
    			}else{
    				alert("取消服务单失败！");
    			}
    			
    		}
        	
        	var url = path;
        	if(exchangeOrRefound=="1"){
        		url = url + "/management/services/exchangeServices?typeID="+typeID+"&exchangeOrRefound="+exchangeOrRefound;
        	}else{
        		url = url + "/management/services/refoundServices?typeID="+typeID+"&exchangeOrRefound="+exchangeOrRefound;
        	}
        	window.location.href=url;
        }
    });
}