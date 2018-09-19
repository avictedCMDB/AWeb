var supIDS = new Array();
function search(){
	var path = $("#path").val();
	document.getElementById("searchForm").action=path+"/management/specialGoods/offStandardRequirePage";
	document.getElementById("searchForm").submit();
}

function clear(){
	$("#status").val("");
	$("#supID").val(""); 
	$("#goodsDescNew").val("");
	$("#status").val("");
	$("#isRelease").val("");
	$("#beginDate").val("");
	$("#endDate").val("");
}

function specialCheck(requireID,quotePath){
	var iWidth=715;                          //弹出窗口的宽度; 
    var iHeight=625;                         //弹出窗口的高度;  
	var iTop = (window.screen.availHeight-30-iHeight)/2;       //获得窗口的垂直位置;
	var iLeft = (window.screen.availWidth-10-iWidth)/2;           //获得窗口的水平位置;
	var path = $("#path").val();
	var url = path+"/management/specialGoods/specialCheck?requireID="+requireID;
	window.open(url, 'newwindow', 'height='+iHeight+', width='+iWidth+', top='+iTop+', left='+iLeft+', toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, status=no');
}

function addCart(){
	var path = $("#path").val();
//	var supGoodsParams = new Array();
//	$("input:checkbox[name='supGoodsParams']:checked").each(function(i) {
//		supGoodsParams.push($(this).val());
//	});
//	 console.log(supGoodsParams);
	var supGoodsParams = "";
	for ( var int = 0; int < supIDS.length; int++) {
		var index = $("input:checkbox[name='supGoodsParams"+supIDS[int]+"']:checked").size()-1;
		$("input:checkbox[name='supGoodsParams"+supIDS[int]+"']:checked").each(function(i) { // 遍历多选框
			if(i<index || supGoodsParams != ""){
				if(supGoodsParams==""){
					supGoodsParams += $(this).val();
				}else{
					supGoodsParams += "#"+$(this).val();  // 每一个被选中项的值
				}
			}else{
				supGoodsParams += $(this).val();
			}
			
		});
	}
	
	if(supGoodsParams==""){
		alert("请选择至少一个商品！");
		return;
	}
	
	if(confirm("确认添加到购物车？")){
		$.ajax({
		     type: 'POST',
		     url: path+"/management/specialGoods/addCart",
		     dataType: 'json',
		     data:{  
		    	 specialGoodsParams : supGoodsParams
		     },  
		     success: function(data) {  
		    	if(data.status =="success" ){  
		    		alert("已添加到购物车！"); 
		    	}  
		     },
		     error : function() {  
		    	 alert("异常！");  
		     } 
		});
	}
	
}

function checkAll(supID){
	if(supIDS.toString().indexOf(supID)<=-1){
		supIDS.push(supID);
	}
	if($("#checkAll"+supID).is(':checked') == true){
		$("input:checkbox[name='supGoodsParams"+supID+"']:checkbox").prop("checked",true);
	}else{
		$("input:checkbox[name='supGoodsParams"+supID+"']:checkbox").removeAttr("checked");
	}
}
function addSup(supID){
	if(supIDS.toString().indexOf(supID)<=-1){
		supIDS.push(supID);
	}
}

function cancle(){
	window.close();
}

function compare(){
	$("#compare_form").submit();
}

function addCompare(){
	var checkCount = 0;
	var j = 0;
	for ( var int = 0; int < supIDS.length; int++) {
		var index = $("input:checkbox[name='supGoodsParams"+supIDS[int]+"']:checked").size();
		checkCount = checkCount+index;
		$("input:checkbox[name='supGoodsParams"+supIDS[int]+"']:checked").each(function(i) { // 遍历多选框
			if(j<4){
//				$("#sid_"+i).val($(this).val().split(",")[0]);
//				$("#gid_"+i).val($(this).val().split(",")[1]);
				window.opener.document.getElementById('sid_'+j).value = $(this).val().split(",")[0];
				window.opener.document.getElementById('gid_'+j).value = $(this).val().split(",")[1];
			}
			j = j+1;
		});
	}
	
	if(checkCount<3){
		alert("请选择至少三个商品进行比对！");
		return;
	}
	if(checkCount>4){
		alert("最多选择四件商品进行比对！");
		return;
	}
	window.opener.compare();
	window.close();
//	$("#compare_form").submit();
	
	
}

function addSpecial(){
	var path = $("#path").val();
	window.location.href = path+"/management/specialGoods";
}

function cancellation(id){
	var path = $("#path").val();
	window.location.href = path+"/management/specialGoods/cancellationInit?id="+id;
}

function updateSpecial(specialID){
 
	var path = $("#path").val();
	window.location.href = path+"/management/specialGoods/getSpecial?id="+specialID;
}

function delSpecial(id){
	var path = $("#path").val();
	if(confirm("确认删除需求？")){
		$.ajax({
		     type: 'POST',
		     url: path+"/management/specialGoods/delSpecial",
		     dataType: 'json',
		     data:{  
		    	 id : id
		     },  
		     success: function(data) {  
		    	 var path = $("#path").val();
		    	 document.getElementById("searchForm").action=path+"/management/specialGoods/offStandardRequirePage";
		    	 document.getElementById("searchForm").submit();
		     },
		     error : function() {  
		    	 alert("异常！");  
		     } 
		});
	}
}