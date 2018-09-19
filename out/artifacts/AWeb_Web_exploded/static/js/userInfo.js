function updatePassword(){
	var path = $("#path").val();
	var oldPassword = $("#oldPassword").val();
	var newPassword = $("#newPassword").val();
	var confirmPassword = $("#confirmPassword").val();
	
	if(oldPassword == ""){
		alert("请输入旧密码！");
		return;
	}
	if(newPassword == ""){
		alert("请输入新密码！");
		return;
	}
	if(confirmPassword == ""){
		alert("请输入确认密码！");
		return;
	}
	if(newPassword!=confirmPassword){
		alert("新密码和确认密码不一致！");
		return;
	}
	$.ajax({
	     type: 'POST',
	     url: path+"/management/info/changePwd",
	     dataType: 'json',
	     data:{  
	    	 oldPassword : oldPassword,
	    	 newPassword : newPassword
	     },  
	     success: function(data) {  
	    	if(data.result =="success" ){  
	    		alert("修改成功！");
	    	}else{
	    		alert("旧密码错误！");
	    	}
	     },
	     error : function() {  
	    	 alert("异常！");  
	     } 
	});
}