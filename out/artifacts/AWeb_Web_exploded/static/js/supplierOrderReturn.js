function query(action){
	document.getElementById("queryForm").action=action;
	document.getElementById("queryForm").submit();
}
function  openConfirmPage(returnStatus,action){
	if (returnStatus == '0') {
		opDialog(action,'1100px','600px');
	}else {
		alert('换货状态不为待确认，不可审核确认！');
		return ;
	}
}
function  confirmDeliveryStatus(action,returnStatus,returnId){
	if (returnStatus == '3') {
		if(confirm("是否确认收货？")){
			updateDeliveryReturnStatus(action,'4',returnId);
		}
	} else{
		alert('换货状态不为待收货，不可收货确认确认！');
		return ;
	}
}
function updateDeliveryReturnStatus(action,refoundStatus,refoundId){
	$.ajax({

	     type: 'POST',

	     url: action ,

		    data : {
			'refoundstatus' : refoundStatus,
			'refoundId' : refoundId
		} ,

	    success: function (data){
	    	window.location.href=window.location.href;
	    } ,

	    dataType: 'json',
	    
	    cache:false,
	});
}
function queryFast(action,status){
	$("#refoundStatus").val(status);
	document.getElementById("queryForm").action=action;
	document.getElementById("queryForm").submit();
}
function updateReturnStatus(action,refoundId){
	var refoundStatus = $("input[name='optionsRadiosinline']:checked").val();
	var supplierAddressId = $("input[name='optionsRadios']:checked").val();
	
	if ($('#supCheckInfo').val() == '') {
		alert('请输入审核意见！');
		return ;
	}
	if (supplierAddressId == '' || supplierAddressId == undefined) {
		supplierAddressId = '';
	}
	$.ajax({

	     type: 'POST',

	     url: action ,

		    data : {
			'refoundStatus' : refoundStatus,
			'supplierAddressId' : supplierAddressId,
			'supCheckInfo' : $('#supCheckInfo').val(),
			'refoundId' : refoundId
		} ,

	    success: function (data){
//	    	window.returnValue = "reload";
	    	window.opener.reloadWindows(null);
	    	window.close();
	    } ,

	    dataType: 'json',
	    
	    cache:false,
	});
}
function openDetailed(action){
	window.location.href = action;
}