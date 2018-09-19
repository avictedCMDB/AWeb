function deleteData(action){
	if(confirm("是否删除该条记录？")){
		window.location.href = action;
	}
}
function deleteList(action){
	var checkIDs = "";
	var checkCount = 0;
	$("input:checkbox[name='checkIDs']:checked").each(function() {
		checkCount++;
		checkIDs = checkIDs + $(this).val() + ',';
	});
	if(checkCount == 0){
		alert('请选择要删除的数据！');
		return;
	}
	if(confirm("是否删除该条记录？")){
		checkIDs = checkIDs.substring(0,checkIDs.length - 1);
		window.location.href = action+checkIDs;
	}
}
function checkAll(){
	if($("#checkAll").is(':checked') == true){
		$(":checkbox").prop("checked",true);
	}else{
		$(":checkbox").removeAttr("checked");
	}
}
function redirectPage(action){
	window.location.href = action;
}
function clearForm(objE){//objE为form表单  
    $(objE).find(':input').each(  
        function(){  
            switch(this.type){  
                case 'passsword':  
                case 'select-multiple':  
                case 'select-one':  
                case 'text':  
                case 'textarea':  
                    $(this).val('');  
                    break;  
                case 'checkbox':  
                case 'radio':  
                    this.checked = false;  
            }  
        }     
    );  
}
function opDialog(action,dialogWidth,dialogHeight) {
//	var result = window.showModalDialog(action,"1","edge: Raised; center: Yes; help: Yes; resizable: Yes; status: Yes; dialogWidth="+dialogWidth+";dialogHeight="+dialogHeight);
	var iTop = (parseInt(window.screen.availHeight)-30-parseInt(dialogHeight))/2;       //获得窗口的垂直位置;
	var iLeft = (parseInt(window.screen.availWidth)-10-parseInt(dialogWidth))/2;           //获得窗口的水平位置;
	window.open(action, 'newwindow', 'height='+dialogHeight+', width='+dialogWidth+', top='+iTop+', left='+iLeft+', toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no,modal=yes');
//	alert(result.opener);
//	if(result == "reload" && result != null && result != undefined){
//		window.location.href=window.location.href;
//	}else if (result != null && result != undefined) {
//		window.location.href = result;
//	}
}
function reloadWindows(action){
	if (action ==null) {
		window.location.href=window.location.href;
	}else{
		window.location.href = action;
	}
		
}

function ajaxSubmit(action){
	var formParam = $("#supplierSubmit").serialize();
	$.ajax({

	     type: 'POST',

	     url: action ,

	    data: formParam ,

	    success: ajaxSuccess ,

	    dataType: 'json',
	    
	    cache:false,
	});
}

function queryAreaSub(action){
	$.ajax({

	     type: 'POST',

	     url: action ,

	    data: {'parentId':$('#area').val()} ,

	    success: function (data){
	    	var num = 0;
	    	$(data).each(function () {
	    		if (num == 0) {
	    			$("#areaSub").html("");
	    			$("#areaLast").html("");
	    			$("#spanStore").html("");
	    			$("#areaSub").append($("<option/>").text('请选择').attr("value",''));
				}
	    		num++;
	        	$("#areaSub").append($("<option/>").text(this.supAreaName).attr("value",this.supAreaID));
	            
	        });
	    } ,

	    dataType: 'json',
	    
	    cache:false,
	});
}
function queryAreaSubTo(action){
	$.ajax({

	     type: 'POST',

	     url: action ,

	    data: {'parentId':$('#areaSub').val()} ,

	    success: function (data){
	    	var num = 0;
	    	$(data).each(function () {
	    		if (num == 0) {
	    			$("#areaLast").html("");
	    			$("#spanStore").html("");
	    			$("#areaLast").append($("<option/>").text('请选择').attr("value",''));
				}
	    		num++;
	        	$("#areaLast").append($("<option/>").text(this.supAreaName).attr("value",this.supAreaID));
	            
	        });
	    } ,

	    dataType: 'json',
	    
	    cache:false,
	});
}