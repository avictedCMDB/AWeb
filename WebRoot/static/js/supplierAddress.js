function saveAddress(action){
	if($("#supName").val()==""||$("#supName").val()==null){
		alert("����д�ջ���������");
		return;
	}
	if($("#area").val()==""||$("#area").val()==null){
		alert("��ѡ��һ����ַ��");
		return;
	}
	if($("#areaSub").val()==""||$("#areaSub").val()==null){
		alert("��ѡ�������ַ��");
		return;
	}
	if($("#areaLast").val()==""||$("#areaLast").val()==null){
		alert("��ѡ��������ַ��");
		return;
	}
	if(isNaN($("#supTel").val())){
		alert('��ϵ�绰ֻ��Ϊ����,���������룡');
		return;
	}
	document.getElementById("supplierAddressForm").action=action;
	document.getElementById("supplierAddressForm").submit();
}
function deleteAddress(action){
	if(confirm("�Ƿ�ɾ���õ�ַ��")){
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
		alert('��ѡ��Ҫɾ���ĵ�ַ��');
		return;
	}
	if(confirm("�Ƿ�ɾ���õ�ַ��")){
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
	if(confirm("�Ƿ�����ΪĬ�ϵ�ַ��")){
		window.location.href = action;
	}
}
function redirectAddress(action){
	window.location.href = action;
}