function query(action){
	document.getElementById("queryForm").action=action;
	document.getElementById("queryForm").submit();
}
function  confirmExchangeStatus(exchangeStatus,action){
	if (exchangeStatus == '0') {
		opDialog(action,'1100px','600px');
	}else {
		alert('����״̬��Ϊ��ȷ�ϣ��������ȷ�ϣ�');
		return ;
	}
}
function  confirmDeliveryStatus(action,exchangeStatus,exchangeId){
	if (exchangeStatus == '3') {
		if(confirm("�Ƿ�ȷ���ջ���")){
			updateDeliveryExchangeStatus(action,'4',exchangeId);
		}
	} else{
		alert('����״̬��Ϊ���ջ��������ջ�ȷ��ȷ�ϣ�');
		return ;
	}
}
function updateDeliveryExchangeStatus(action,exchangeStatus,exchangeId){
	$.ajax({

	     type: 'POST',

	     url: action ,

		    data : {
			'exchangeStatus' : exchangeStatus,
			'supplierAddressId' : '',
			'supCheckInfo' : '',
			'exchangeId' : exchangeId
		} ,

	    success: function (data){
	    	window.location.href=window.location.href;
	    } ,

	    dataType: 'json',
	    
	    cache:false,
	});
}
function queryFast(action,status){
	$("#exchangeStatus").val(status);
	document.getElementById("queryForm").action=action;
	document.getElementById("queryForm").submit();
}
function updateExchangeStatus(action,exchangeId){
	var exchangeStatus = $("input[name='optionsRadiosinline']:checked").val();
//	var supplierAddressId = $("input[name='optionsRadios']:checked").val();
	var supplierAddressId = '';
	if ($('#supCheckInfo').val() == '') {
		alert('��������������');
		return ;
	}
//	if (supplierAddressId == '' || supplierAddressId == undefined) {
//		alert('������Ĭ�Ϲ�Ӧ�̵�ַ��');
//		return ;
//	}
	$.ajax({

	     type: 'POST',

	     url: action ,

		    data : {
			'exchangeStatus' : exchangeStatus,
			'supplierAddressId' : supplierAddressId,
			'supCheckInfo' : $('#supCheckInfo').val(),
			'exchangeId' : exchangeId
		} ,

	    success: function (data){
//	    	window.returnValue = "reload";
//	    	window.opener.location.reload();
//	    	window.opener.location.replace(window.opener.location);
//	    	window.opener.location =window.opener.location;
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
function exchaneGoodsSend(action){
	// ��Ӫ���
	var error = '';
	var exchangeExpressCodeSupOther = '';
	var exchangeExpressNameSupOther = '';
	if ($('input:radio[name=optionsRadios]:checked').val() == '0') {
		$('#exchangeExpressNameSup').val('��Ӫ���');
		$('#exchangeExpressCodeSup').val('');
		
		// ���������
	} else {
		$("input:text[name='exchangeExpressNameSupOther']").each(
				function(){
					if (this.value == '') {
						error = '�������ݹ�˾��';
						return false;
					}
					
		});
		$("input:text[name='exchangeExpressCodeSupOther']").each(
				function(){
					if (this.value == '') {
						error = error +' �������ݵ��ţ�';
						return false;
					}
		}); 
		if (error != '') {
			alert(error);
			return false;
		}
		$("input:text[name='exchangeExpressNameSupOther']").each(
				function(){
					if (exchangeExpressNameSupOther == '') {
						exchangeExpressNameSupOther = this.value;	
					}else {
						exchangeExpressNameSupOther = exchangeExpressNameSupOther + ','+this.value;	
					}
					
					
		});
		$("input:text[name='exchangeExpressCodeSupOther']").each(
				function(){
					if (exchangeExpressCodeSupOther == '') {
						exchangeExpressCodeSupOther = this.value;	
					}else {
						exchangeExpressCodeSupOther = exchangeExpressCodeSupOther + ','+this.value;	
					}
		});
		$('#exchangeExpressNameSup').val(exchangeExpressNameSupOther);
		$('#exchangeExpressCodeSup').val(exchangeExpressCodeSupOther);
		
	}
	document.getElementById("exchaneSendForm").action=action;
	document.getElementById("exchaneSendForm").submit();
}
function exchangeExpress(){
	if ($('input:radio[name=optionsRadios]:checked').val() == '0') {
		$("#expressDiv").hide();
	}else {
		$("#expressDiv").show();
	}
}
function addExpress(){
	
}
function delExpress(){
	
}