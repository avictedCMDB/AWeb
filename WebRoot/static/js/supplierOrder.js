function query(action){
	
	document.getElementById("queryForm").action=action;
	document.getElementById("queryForm").submit();
	
}
function queryFast(action,status){
	$("#orderStatus").val(status);
	document.getElementById("queryForm").action=action;
	document.getElementById("queryForm").submit();
}
function doSend(atcion,orderId){
	var supExpressName = $('#supExpressName').val();
	var supExpressCode = $('#supExpressCode').val();
	if (supExpressName == null || supExpressName == '') {
		alert('�������������ƣ�');
		return;
	}
	if (supExpressCode == null || supExpressCode == '') {
		alert('�������������ţ�');
		return;
	}
	$.ajax({

	     type: 'POST',

	     url: atcion,

		    data : {
			'orderId' : orderId,
			'supExpressName' : supExpressName,
			'supExpressCode' : supExpressCode
		} ,

	    success: function (data){
//	    	window.location.href=window.location.href;
	    	window.opener.reloadWindows(null);
	    	window.close();
	    } ,

	    dataType: 'json',
	    
	    cache:false,
	});
}
function passStatus(atcion,orderId,returnAction,authority){
	if ($('#quoteDate').val() == '') {
		alert('��ѡ�����ڣ�');
		return;
	}
	if ($('#sendPerson').val() == '') {
		alert('�����뷢���ˣ�');
		return;
	}
	if ($('#sendPersonTel').val() == '') {
		alert('�������ֻ����룡');
		return;
	}
	if ($('#sendPersonFax').val() == '') {
		alert('�����봫��ţ�');
		return;
	}
	if (isNaN($('#sendPersonTel').val())) {
		alert('��������ȷ���ֻ��ţ�');
		return;
	}
	if ($('#fileName').val() == '') {
		alert('���ϴ����۵���');
		return;
	}
//	var supplierReviewRemark = $('#supplierReviewRemark').val();
//	$("input:hidden[name='supGoodsId']").each(
//			function(){
//				if (supGoodsId == '') {
//					supGoodsId = this.value;
//				}else {
//					supGoodsId = supGoodsId + ','+this.value;
//				}
//	});
//	$("input:text[name='goodsPrice']").each(
//			function(){
//				if (goodsPrice == '') {
//					goodsPrice = this.value;
//				}else {
//					goodsPrice = goodsPrice + ','+this.value;
//				}
//	});
//	$("input:text[name='buyNum']").each(
//			function(){
//				if (buyNum == '') {
//					buyNum = this.value;
//				}else {
//					buyNum = buyNum + ','+this.value;
//				}
//	});
//	$("input:text[name='orderAmount']").each(
//			function(){
//				orderAmount = parseInt(orderAmount) + parseInt(this.value);
//	});
	$.ajax({

	     type: 'POST',

	     url: atcion,

		    data : {
			'orderId' : orderId,
			'companyname' : $('#companyname').val(),
			'contactPerson' : $('#contactPerson').val(),
			'contactNum' : $('#contactNum').val(),
			'contactFax' : $('#contactFax').val(),
			'quoteDate' : $('#quoteDate').val(),
			'sendPerson' : $('#sendPerson').val(),
			'sendPersonTel' : $('#sendPersonTel').val(),
			'sendPersonFax' : $('#sendPersonFax').val(),
			'quoteAttachmentPath' : $('#quoteAttachmentPath').val(),
			'fileName' : $('#fileName').val()
		} ,

	    success: function (data){
	    	window.location.href=returnAction;
	    } ,

	    dataType: 'json',
	    
	    contentType: "application/x-www-form-urlencoded; charset=utf-8", 
	    
	    cache:false,
	});
}
function returnStatus(atcion,orderId,returnAction){
	var supplierReviewRemark = $('#supplierReviewRemark').val();
	$.ajax({

	     type: 'POST',

	     url: atcion,

		    data : {
			'orderId' : orderId,
			'supplierReviewRemark' : supplierReviewRemark
		} ,

	    success: function (data){
	    	window.location.href=returnAction;
	    } ,

	    dataType: 'json',
	    
	    cache:false,
	    
	});
}
function addNum(status,index){
	var id = "";
	if (status == "1") {
		id = "price";
	}else if (status == "2") {
		id = "num";
	}
	id = id+index;
	$('#'+id).val(parseInt($('#'+id).val())+1);
	$('#sumPrice'+index).val(parseInt($('#price'+index).val())*$('#num'+index).val());
	
}
function minusNum(status,index){
	var id = "";
	if (status == "1") {
		id = "price";
	}else if (status == "2") {
		id = "num";
	}
	id = id+index;
	if ($('#'+id).val() > 1) {
		$('#'+id).val(parseInt($('#'+id).val()) - 1);
	}else {
		alert('���������򵥼۲���Ϊ0��');
		return;
	}
	$('#sumPrice'+index).val(parseInt($('#price'+index).val())*$('#num'+index).val());
}
function checkNum(status,index){
	var id = "";
	if (status == "1") {
		id = "price";
	}else if (status == "2") {
		id = "num";
	}
	id = id+index;
	if(isNaN($("#"+id).val())){
		alert('��������ȷ�����֣�');
		$("#"+id).focus();
		return;
	}
	if($("#"+id).val()<= 0){
		alert('���������򵥼۲���Ϊ0��');
		$("#"+id).focus();
		return;
	}
	$('#sumPrice'+index).val(parseInt($('#price'+index).val())*$('#num'+index).val());
}
function changeRadio(obj){
	if(obj.checked && obj.value == '1'){
		$('#contractName').removeAttr("readonly");
		$('#contractPrice').removeAttr("readonly","readonly");
		$('#uploadPictureButton').attr('disabled',false);
		$('#uploadContractButton').attr('disabled',false);
		$('#signDate').removeAttr("readonly");
	}else {
		$('#contractName').attr("readonly","readonly");
		$('#contractPrice').attr("readonly","readonly");
		$('#signDate').attr("readonly","readonly");
		$('#uploadPictureButton').attr('disabled',true);
		$('#uploadContractButton').attr('disabled',true);
	}
}
function uploadContract(action,type){
	if (type == '1') {
		if ($("#uploadFileContract").val() == '') {
			alert('����ѡ��Ҫ�ϴ��ı��۵�!');
			return;
		}
	}
	
	$('#contractForm').attr('enctype', 'multipart/form-data'); 
	document.getElementById("contractForm").action=action;
	document.getElementById("contractForm").submit();
}
function deletePicture(action,url){
	document.getElementById("contractForm").action=action;
	document.getElementById("contractForm").submit();
}
