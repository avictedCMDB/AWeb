function professionEnquiry(goodsName,supGoodsId,supId,goodsModel,agreePrice){
	var path = $("#path").val();
	$.ajax({
	     type: 'POST',
	     url: path+"/market/goods/prof/isLogin",
	     dataType: 'json',
	     data:{  
	    	 goodsID:supGoodsId,
	    	 supID:supId
	     },  
	     success: function(data) {  
	    	if(data.isLogin =="0" ){  
	    		window.location.href = path+"/passport/login";
	    	}else{
	    		if(data.canEnquiry =="1"){
	    			var iWidth=750;                          //�������ڵĿ���; 
		    	    var iHeight=300;                         //�������ڵĸ߶�; 
		    		var iTop = (window.screen.availHeight-30-iHeight)/2;       //��ô��ڵĴ�ֱλ��;
		    		var iLeft = (window.screen.availWidth-10-iWidth)/2;           //��ô��ڵ�ˮƽλ��;
		    		var url = path+"/market/goods/prof/professionEnquiryPage?goodsName="+goodsName+"&goodsID="+supGoodsId+"&supID="+supId+"&goodsModel="+goodsModel+"&goodsPriceBefore="+agreePrice;
		    		window.open(url, 'newwindow', 'height='+iHeight+', width='+iWidth+', top='+iTop+', left='+iLeft+', toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no');
	    		}else{
	    			alert("����Ʒ�Ѿ�ѯ��,��ȥѯ�۹����鿴����Ʒѯ�۽����");
	    		}
	    		
	    	}
	     },
	     error : function() {  
	    	 alert("�쳣��");  
	     } 
	});
}