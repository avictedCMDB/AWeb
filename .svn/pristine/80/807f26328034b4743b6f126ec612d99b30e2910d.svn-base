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
	$("input:checkbox[name='checkAddressIDs']:checked").each(function(i) { // 遍历多选框
		if(i<index){
			addressIDs += $(this).val()+",";  // 每一个被选中项的值
		}else{
			addressIDs += $(this).val();
		}
		
	});
	if(addressIDs==""){
		alert("请选择至少一条地址！");
		return;
	}
	window.location.href = "/AWeb/management/address/delete/"+addressIDs;
};

function addMarketAddress(){
	window.location.href = "/AWeb/management/address/addAddressPage";
}
