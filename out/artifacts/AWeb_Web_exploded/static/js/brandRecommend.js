function search(){
	var path = $("#path").val();
	document.getElementById("searchForm").action=path+"/supervise/brand";
	document.getElementById("searchForm").submit();
}

function cancleBrand(bid){
	var path = $("#path").val();
	if(confirm("确定取消推荐？")){
		window.location.href = path+"/supervise/brand/cancleBrand/"+bid;
	}
}

function setBrandPage(brand_name){
	var iWidth=715;                          //弹出窗口的宽度; 
    var iHeight=295;                         //弹出窗口的高度; 
	var iTop = (window.screen.availHeight-30-iHeight)/2;       //获得窗口的垂直位置;
	var iLeft = (window.screen.availWidth-10-iWidth)/2;           //获得窗口的水平位置;
	var path = $("#path").val();
	var url = path+"/supervise/brand/setBrandPage?brand_name="+brand_name;
	window.open(url, 'newwindow', 'height='+iHeight+', width='+iWidth+', top='+iTop+', left='+iLeft+', toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no');
}

function setBrand(){
	var path = $("#path").val();
	//验证信息是否填写
	var picPath = $("#brand_image").val();
	var brand_name = $("#brand_name").val();
	var begin_date = $("#begin_date").val();
	var end_date = $("#end_date").val();
	var bid = $("#bid").val();
	if(begin_date=="" || begin_date == null){
		alert("请选择开始时间");
		return;
	}
	if(end_date == "" || end_date == null){
		alert("请选择结束时间");
		return;
	}
	if(picPath=="" || picPath ==null){
		alert("请选择图片");
		return;
	}
	
	$.ajax({
        type: "POST",
        url: path+"/supervise/brand/setBrand",
        contentType:"application/x-www-form-urlencoded; charset=utf-8", 
        data: {
        	begin_date:begin_date,
        	end_date:end_date,
        	brand_image:picPath,
        	brand_name:brand_name,
        	bid:bid
        },
        success: function(data) {
        	if("success"==data){
    			alert("推荐成功！");
    		}
//    		window.returnValue = "reload";
//    		window.close();
        	window.opener.location.href=path+"/supervise/brand";
    		window.close();
        }
    });
//	document.getElementById("supplierRecommendSubmitForm").action=path+"/supervise/supplierReommend/setRecommend";
//	document.getElementById("supplierRecommendSubmitForm").submit();
}

//上传图片
function ajaxFileUpload(fileID) {  
	/*if($("#lefile").val()==""){
		alert("请选选择图片！");
		return;
	}*/
	if($("#supImageAfter").val()!=""){
		alert("请先删除然后选择图片！");
		return;
	}
	var path = $("#path").val();
	$.ajaxFileUpload({  
        url: path + '/supervise/brand/uploadPic', //服务器端请求地址  
        secureuri: false, //是否需要安全协议，一般设置为false  
        fileElementId: fileID, //文件上传域的ID  
        dataType: 'json', //返回值类型 一般设置为json  
        enctype:'multipart/form-data',//注意一定要有该参数  
        success: function (data, status)  //服务器成功响应处理函数  
        {  
        	data = data.replace(/<pre.*?>/g, '');  //ajaxFileUpload会对服务器响应回来的text内容加上<pre style="....">text</pre>前后缀  
        	data = data.replace(/<PRE.*?>/g, '');  
        	data = data.replace("<PRE>", '');  
        	data = data.replace("</PRE>", '');  
        	data = data.replace("<pre>", '');  
        	data = data.replace("</pre>", ''); 
        	var pos=data.lastIndexOf("/")+1; 
        	var picName = data.substring(pos);
        	$("#supPicImg").attr('src',path+data);
        	$("#brand_image").val(data);
        	$("#supImageAfter").val(data);
//        	$("#photoCover").text("");
        },  
        error: function (data, status, e)//服务器响应失败处理函数  
        {  
        	alert("上传失败");
        }  
    });
}  

//删除图片
function delImage(contentDiv){
	var picName = $("#brand_image").val();
	var path = $("#path").val();
	var pos=picName.lastIndexOf("/");
	if(pos>0){
		picName = picName.substring(pos);
	}
	$.ajax({
	     type: 'POST',
	     url: path+"/supervise/brand/deletePic",
	     dataType: 'json',
	     data:{  
	    	 fileName : picName  
	     },  
	     success: function(data) {
	    	if(data.status =="success" ){  
	    		$("#supPicImg").remove();
	    		$("<img width='180' height='57' id='supPicImg' src=''/>").appendTo($("#imgP"));
	    		$("#brand_image").val("");
	    		$("#supImageAfter").val("");
	    	}  
	     },
	     error : function() {
	    	 alert("异常！");  
	     } 
	});
}

function cancle(){
	var path = $("#path").val();
	window.close();
	window.location.href=path+"/supervise/brand";
}

function clrAllVal(){
	$('#brand_name').val('');
	$('#begin_date').val('');
	$('#end_date').val('');
	$('#if_recommand').val('');
}