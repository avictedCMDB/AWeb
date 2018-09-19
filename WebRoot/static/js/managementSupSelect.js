$(document).ready(function(){
	doInit();
	
	$('#allchecked').click(function(){
		var allcheck = $("#allchecked").is(':checked');
		$('input[name="subCheckbox"]').prop('checked',allcheck);
	});
});

function doInit(){
	var path = $('#path').val();
	var sup_type = $('#sup_type').val();
	var sup_name = $('#sup_name').val();
	var url=path+"/management/specialGoods/supSelectData?o="+sup_type+"&sup_name="+sup_name;

	$.ajax({
	    url: url,
	    type: "POST",
	    contentType : 'application/json;charset=gbk', //��������ͷ��Ϣ
	    dataType:"json",
	    success: function(dataJson){
	    	var strHtml = getSelectedGoodsHtml(dataJson,path);
			$("tr[id^='tr_']").each(function(){
				this.remove();
			});
			
			$('#title_tr').after(strHtml);
	    },
	    error: function(res){
            alert('ϵͳæ�����Ժ����ԡ�');
        }
	});
}

function getSelectedGoodsHtml(dataJson,path){
	var strArr = new Array();
	if(dataJson!=null && dataJson!="" && dataJson !=undefined){
		$(dataJson).each(function (i) {
			var goodsDetailUrl = path+"/market/goods/show?sid="+this.sup_id+"&gid="+this.sup_goods_id;
			strArr.push("<tr id='tr_"+this.sup_id+"'>");
		      strArr.push("<td><input type='checkbox' name='subCheckbox' value='"+this.sup_name+"_"+this.sup_id+"'></td>");
		      strArr.push("<td>"+(i+1)+"</td>");
		      strArr.push("<td class='left_none'>"+this.sup_name+"</td>");
		    strArr.push("</tr>");
	    });
	    
	    return strArr.join("");
    }else{
    	return "";
    }
}

//����
function doConfirm(){
	var select_supIds = "";//ѡ�еĹ�Ӧ����Ϣ
	$('input:checkbox[name=subCheckbox]:checked').each(function(i){
		if(0==i){
			select_supIds = $(this).val();
		}else{
			select_supIds += (","+$(this).val());
		}
	});
	if(window.opener){
		//Ϊ��ҳ��Ĺ�Ӧ��id������ֵ
		if(select_supIds != null && select_supIds !=""){//�����ѡ�е���Ϣ
			var fWindowText1 = window.opener.document.getElementById("sup_id");			
			var parentSupIds = fWindowText1.value;//��ʽΪ��,supId1,supId2,...,�����ſ�ͷ�ͽ�βs		
			var newSupIdArr = new Array();//��������ѡ�е�supName_supId
			if(parentSupIds != null && parentSupIds != ""){//��ҳ�湩Ӧ��id������Ϊ��
				if(select_supIds.indexOf(',')>0){
					var selectSupIdArr = new Array();
					selectSupIdArr = select_supIds.split(',');
					for(i=0;i<selectSupIdArr.length;i++){
						var lastString  = parentSupIds.charAt(parentSupIds.length - 1);					
						var sub_supId = selectSupIdArr[i].split('_')[1];
						var new_sub_supId = "";
						if(lastString == ","){
							new_sub_supId = selectSupIdArr[i].split('_')[1]
						}else{						
							new_sub_supId = ','+selectSupIdArr[i].split('_')[1];	
						}
						var flag = "0";//Ĭ��ѡ��Ӧ�̲����·���ʾ����
						if(parentSupIds.indexOf(',')>0){
							var parentSupIds_Array = parentSupIds.split(',');
							
							for(j=0;j<parentSupIds_Array.length;j++){
								if(parentSupIds_Array[j] == sub_supId){
									flag = "1";
									break;
								}
							}							
						}else if(parentSupIds == sub_supId){
							flag = "1";
						}

						if(flag == "0"){
							parentSupIds = parentSupIds+new_sub_supId;
							newSupIdArr.push(selectSupIdArr[i]);
						}
					}
				}else{//ֻѡ����һ����Ӧ��
					var sub_supId= select_supIds.split('_')[1];
					var new_sub_supId = "";
					var flag = "0";//Ĭ��ѡ��Ӧ�̲����·���ʾ����
					var lastString  = parentSupIds.charAt(parentSupIds.length - 1);
					if(lastString == ","){
						new_sub_supId = select_supIds.split('_')[1];
					}else{
						new_sub_supId = ','+select_supIds.split('_')[1];
					}					
					if(parentSupIds.indexOf(',')>0){
						var parentSupIds_Array = parentSupIds.split(',');
						for(k=0;k<parentSupIds_Array.length;k++){
							if(parentSupIds_Array[k] == sub_supId){
								flag = "1";
								break;
							}
						}							
					}else if(parentSupIds == sub_supId){
						flag = "1";
					}
					if(flag == "0"){//�ظ����������⣬��Ҫforѭ��������
						parentSupIds = parentSupIds+new_sub_supId;
						newSupIdArr.push(select_supIds);
					}
				}
			}else{
				//���������û��ֵ�Ļ���ֱ�ӽ�ѡ�еĹ�Ӧ��id��ֵ��ȥ
				if(select_supIds.indexOf(',')>0){
					var selectSupIdArr = new Array();
					selectSupIdArr = select_supIds.split(',');
					parentSupIds = '';
					for(i=0;i<selectSupIdArr.length;i++){
						var sub_supId = selectSupIdArr[i].split('_')[1]+",";
						parentSupIds = parentSupIds + sub_supId;
						newSupIdArr.push(selectSupIdArr[i]);
					}
				}else{//ֻѡ����һ����Ӧ��
					var sub_supId = select_supIds.split('_')[1];
					parentSupIds = sub_supId+",";
					newSupIdArr.push(select_supIds);
				}
			}
			fWindowText1.value = parentSupIds;//��ǰ���źͺ󶺺�
			var newSupIdObj = window.opener.document.getElementById("new_sup_id");
			newSupIdObj.value = newSupIdArr.join(',');
			window.opener.childCallParentMethod();//Ϊ��Ӧ��img��ֵ
			window.close();
		}else{
			alert('��ѡ��Ӧ�̡�');return;
		}
    }
}