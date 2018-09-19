function queryEnquiry(action){
	document.getElementById("queryForm").action=action;
	document.getElementById("queryForm").submit();
}

function updateNoEnquiryStatus(action,id){
	if(confirm("是否确认拒绝！")){
		$.ajax({

		     type: 'POST',

		     url: action ,

			    data : {
				'id' : id,
				'status' : '2',
				'price' : ''
			} ,

		    success: function (data){
		    	alert('拒绝成功！');
		    	window.location.href=window.location.href;
		    } ,

		    dataType: 'json',
		    
		    cache:false,
		});
	}
}
function updateYesEnquiryStatus(action){
	if ($('#goodsPriceAfter').val()== '') {
		alert('请输入商品报价！');
		return;
	}
	if (isNaN($('#goodsPriceAfter').val())) {
		alert('请输入正确的数字！');
		return;
	}
	$.ajax({

	     type: 'POST',

	     url: action ,

		    data : {
			'id' : $('#goodsId').val(),
			'status' : '1',
			'price' : $('#goodsPriceAfter').val()
		} ,

	    success: function (data){
	    	alert('报价成功！');
	    	window.opener.reloadWindows(null);
	    	window.close();
	    } ,

	    dataType: 'json',
	    
	    cache:false,
	});
}