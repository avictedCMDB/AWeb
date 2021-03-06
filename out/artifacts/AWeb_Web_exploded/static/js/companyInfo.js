function searchCompany(supID){
	var path = $("#path").val();
//	var companyName = $("#companyName").val();
//	var companyCode = $("#companyCode").val();
//	window.location.href = "${pageContext.request.contextPath}/supervise/companyInfo?companyName="+companyName+"&companyCode="+companyCode;
	document.getElementById("companyForm").action=path+"/supervise/companyInfo";
	document.getElementById("companyForm").submit();
}

function clean(){
	$("#companyName").val("");
 	$("#companyCode").val("");
 	$("#userName").val("");
 	$("#contactPerson").val("");
 	$("#contactIphone").val("");
 	$("#timeStart").val("");
 	$("#timeEnd").val("");
}

function addCompanyInfo(id){
	var path = $("#path").val();
	var adminType = $("#adminType").val();
	if(adminType=="1"){
		if(id!=""&&id!=null){
			window.location.href = path+"/supervise/companyMyInfo/init?addOrUpdate=2&id="+id+"&flg=1";
		}else{
			window.location.href = path+"/supervise/companyMyInfo/init?addOrUpdate=1&id=''"+"&flg=1";
		}
		
	}else{
		if(id!=""&&id!=null){
			window.location.href = path+"/supervise/companyInfo/initEditCompany?id="+id+""+"&flg=1";
		}else{
			window.location.href = path+"/supervise/companyInfo/initEditCompany?flg=1";
		}
	}
	
}

function editCompanyInfo(type){
	var path = $("#path").val();
	var id;
	var companyCode = $("#companyCode").html();
	var companyName = $("#companyName").val();
	if(companyName==""||companyName==null){
		alert("请输入公司名称!");
		return;
	}
	if(type=="1"){
		id = companyCode;
		$.ajax({
	        type: "POST",
	        url: path+"/supervise/companyInfo/addCompanyInfo",
	        dataType: 'json',
	        data: {
	        	id:id,
	        	companyName:companyName,
	        	companyCode:companyCode
	        },
	        success: function(data) {
	        	if("success"==data.status){
	        		window.location.href=path+"/supervise/companyInfo";
	    		}else{
	    			alert(data.status);
	    		}
	        	
	        }
	    });
	}else{
		id = $("#id").val();
		$.ajax({
	        type: "POST",
	        url: path+"/supervise/companyInfo/updCompanyInfo",
	        dataType: 'json',
	        data: {
	        	id:id,
	        	companyName:companyName
	        },
	        success: function(data) {
	        	if("success"==data.status){
	        		window.location.href=path+"/supervise/companyInfo";
	    		}else{
	    			alert(data.status);
	    		}
	        }
	    });
	}
}

function cancle(){
	var path = $("#path").val();
	window.location.href = path+"/supervise/companyInfo";
}

function delCompanyInfo(id,companyType){
	var path = $("#path").val();
	if(confirm("请确认是否进行删除操作！")){
		$.ajax({
	        type: "POST",
	        url: path+"/supervise/companyInfo/delCompanyInfo",
	        contentType:"application/x-www-form-urlencoded; charset=utf-8", 
	        dataType: 'json',
	        data: {
	        	id:id,
	        	companyType:companyType
	        },
	        success: function(data) {
	        	if("success"==data.status){
	        		window.location.href=path+"/supervise/companyInfo";
	    		}else{
	    			alert(data.status);
	    		}
	        }
	    });
	}
	
}

function checkInit(companyID){
	var path = $("#path").val();
	window.location.href= path+"/supervise/companyInfo/checkInit?witchPage=1&id="+companyID+"&flg=1";
}

function resetPassword(userName,supID){
	$("#supID").val(supID);
	$("#userNameDD").html(userName);
}

function editSupPassword(){
	var path = $("#path").val();
	if ($('#newPassword').val() == '') {
		alert('请输入新密码！');
		return false;
	}
	if ($('#valitedPassword').val() == '') {
		alert('请输入确认密码！');
		return false;
	}
	
	if ($('#newPassword').val() != $('#valitedPassword').val()) {
		alert('新密码与确认密码不一致！');
		return false;
	}
	
	$.ajax({
        type: "POST",
        url: path+"/supervise/companyInfo/editSupPassword",
        contentType:"application/x-www-form-urlencoded; charset=utf-8", 
        dataType: 'json',
        data: {
        	supID:$("#supID").val(),
        	password:$('#newPassword').val()
        },
        success: function(data) {
        	if("success"==data.status){
        		alert("密码修改成功");
        		window.location.reload();
    		}else if("supIDNullError" == data.status){
    			alert("修改失败，无用户标识");
    		}else{
    			alert("修改密码失败，无新密码信息");
    		}
        },
        error:function(data){
        	alert("可能由于网络原因，导致修改密码失败");
        }
    });
}