
function showAddInvoice(action){
	window.location.href = action+"/management/invoice/addInvoicePage";
}
function deleteInv(action){
	if(confirm("��ȷ���Ƿ�ɾ����")){
		window.location.href = action;
	}
	
}