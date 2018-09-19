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
	    			var iWidth=750;                          //弹出窗口的宽度; 
		    	    var iHeight=300;                         //弹出窗口的高度; 
		    		var iTop = (window.screen.availHeight-30-iHeight)/2;       //获得窗口的垂直位置;
		    		var iLeft = (window.screen.availWidth-10-iWidth)/2;           //获得窗口的水平位置;
		    		var url = path+"/market/goods/prof/professionEnquiryPage?goodsName="+goodsName+"&goodsID="+supGoodsId+"&supID="+supId+"&goodsModel="+goodsModel+"&goodsPriceBefore="+agreePrice;
		    		window.open(url, 'newwindow', 'height='+iHeight+', width='+iWidth+', top='+iTop+', left='+iLeft+', toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no');
	    		}else{
	    			alert("该商品已经询价,请去询价管理查看此商品询价结果！");
	    		}
	    		
	    	}
	     },
	     error : function() {  
	    	 alert("异常！");  
	     } 
	});
}