function query(action){
	
	document.getElementById("queryForm").action=action;
	document.getElementById("queryForm").submit();
	
}
function returnGoodsDelete(action){
	var goodsIds = "";
	var checkCount = 0;
	$("input:checkbox[name='checkGoodsInfo']:checked").each(function() {
		checkCount++;
		goodsIds = goodsIds + $(this).val() + ',';
	});
	if(checkCount == 0){
		alert('��ѡ��Ҫ��ԭ�����ݣ�');
		return;
	}
	goodsIds = goodsIds.substring(0,goodsIds.length - 1);
	window.location.href = action+"?&goodsIds="+goodsIds;
}