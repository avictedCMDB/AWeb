function search(){
	var path = $("#path").val();
	document.getElementById("enterpriseForm").action=path+"/management/enterprise";
	document.getElementById("enterpriseForm").submit();
}
function clearSearchParam(){
	$("#goodsName").val("");
	$("#startDate1").val("");
	$("#endDate1").val("");
	$("#startDate2").val("");
	$("#endDate2").val("");
	$("#supName").val("");
	$("#enquiryStatus").val("");
}


function addCart(supID,goodsID,goodsNum){
	var path = $("#path").val();
	if(confirm("确认添加到购物车？")){
		$.ajax({
		     type: 'POST',
		     url: path+"/management/enterprise/addCart",
		     dataType: 'json',
		     data:{  
		    	 supID : supID,
		    	 supGoodsID:goodsID,
		    	 buyNum:goodsNum
		     },  
		     success: function(data) {  
		    	if(data.status =="success" ){  
		    		alert("已添加到购物车！");
		    		window.location.href=path+"/management/enterprise";
		    	}  
		     },
		     error : function() {  
		    	 alert("异常！");  
		     } 
		});
	}
	
}

function delEnterprise(goodsID){
	var path = $("#path").val();
	if(confirm("确认删除？")){
		$.ajax({
		     type: 'POST',
		     url: path+"/management/enterprise/delete",
		     dataType: 'json',
		     data:{  
		    	 goodsID : goodsID  
		     },  
		     success: function(data) {  
		    	if(data.status =="success" ){  
		    		alert("删除成功！");
		    		window.location.href=path+"/management/enterprise";
		    	}  
		     },
		     error : function() {  
		    	 alert("异常！");  
		     } 
		});
	}
}