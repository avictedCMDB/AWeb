function checkAll(){
	if($("#checkAll").is(':checked') == true){
		$(":checkbox").prop("checked",true);
	}else{
		$(":checkbox").removeAttr("checked");
	}
}

function delSomeAddress(){
	var addressIDs = "";
	var index = $("input:checkbox[name='checkAddressIDs']:checked").size()-1;
	$("input:checkbox[name='checkAddressIDs']:checked").each(function(i) { // ������ѡ��
		if(i<index){
			addressIDs += $(this).val()+",";  // ÿһ����ѡ�����ֵ
		}else{
			addressIDs += $(this).val();
		}
		
	});
	if(addressIDs==""){
		alert("��ѡ������һ����ַ��");
		return;
	}
	window.location.href = "/AWeb/management/address/delete/"+addressIDs;
};

function addMarketAddress(){
	window.location.href = "/AWeb/management/address/addAddressPage";
}
