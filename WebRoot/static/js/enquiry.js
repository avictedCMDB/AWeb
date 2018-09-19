function enquiry(){
	var path = $("#path").val();
	var contactName = $("#contactName").val();
	var contactTel = $("#contactTel").val();
	var priceValidDate = $("#enquiryDate").val();
	var goodsNum = $("#goodsNum").val();
	var goodsID = $("#goodsID").val();
	var supID = $("#supID").val();
	var goodsPriceBefore = $("#goodsPriceBefore").val();
	if(contactName == "" || contactName == null){
		alert("请输入询价联系人！");
		return;
	}
	if(contactTel == "" || contactTel == null){
		alert("请输入联系人电话！");
		return;
	}
	if(!isPhoneNo(contactTel)){
		alert("请输入正确电话！");
		return;
	}
	if(enquiryDate == "" || enquiryDate == null){
		alert("请输入价格有效期！");
		return;
	}
	if(goodsNum == "" || goodsNum == null){
		alert("请输入采购数量！");
		return;
	}
	
	$.ajax({
        type: "POST",
        url: path+"/market/goods/prof/professionEnquiry",
        contentType:"application/x-www-form-urlencoded; charset=utf-8", 
        data: {
        	contactName:contactName,
        	contactTel:contactTel,
        	priceValidDate:priceValidDate,
        	goodsNum:goodsNum,
        	goodsID:goodsID,
        	supID:supID,
        	goodsPriceBefore:goodsPriceBefore
        },
        success: function(data) {
        	if("success"==data){
    			alert("询价成功！");
    		}
        	window.opener.location.href=path+"/market/goods/prof";
    		window.close();
        }
    });
}