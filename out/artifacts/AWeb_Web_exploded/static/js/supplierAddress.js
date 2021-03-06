function saveAddress(action){
	if($("#supName").val()==""||$("#supName").val()==null){
		alert("请填写收货人姓名！");
		return;
	}
	if($("#area").val()==""||$("#area").val()==null){
		alert("请选择一级地址！");
		return;
	}
	if($("#areaSub").val()==""||$("#areaSub").val()==null){
		alert("请选择二级地址！");
		return;
	}
	if($("#areaLast").val()==""||$("#areaLast").val()==null){
		alert("请选择三级地址！");
		return;
	}
	if(isNaN($("#supTel").val())){
		alert('联系电话只能为数字,请重新输入！');
		return;
	}
	document.getElementById("supplierAddressForm").action=action;
	document.getElementById("supplierAddressForm").submit();
}
function deleteAddress(action){
	if(confirm("是否删除该地址？")){
		window.location.href = action;
	}
}
function deleteAddressList(action){
	var addressIDs = "";
	var checkCount = 0;
	$("input:checkbox[name='checkAddressIDs']:checked").each(function() {
		checkCount++;
		addressIDs = addressIDs + $(this).val() + ',';
	});
	if(checkCount == 0){
		alert('请选择要删除的地址！');
		return;
	}
	if(confirm("是否删除该地址？")){
		addressIDs = addressIDs.substring(0,addressIDs.length - 1);
		window.location.href = action+addressIDs;
	}
}
function checkAll(){
	if($("#checkAll").is(':checked') == true){
		$(":checkbox").prop("checked",true);
	}else{
		$(":checkbox").removeAttr("checked");
	}
}
function setDefault(action){
	if(confirm("是否设置为默认地址？")){
		window.location.href = action;
	}
}
function redirectAddress(action){
	window.location.href = action;
}