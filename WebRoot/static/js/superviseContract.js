function search(){
	var path = $("#path").val();
	document.getElementById("searchForm").action=path+"/supervise/contract";
	document.getElementById("searchForm").submit();
}

function makeClear(objE){
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

function doDownload(contract_code){
	window.location.href=$("#path").val()+"/supervise/contract/doDownload?contract_code="+contract_code;
}