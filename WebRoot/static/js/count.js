//��Ӧ��ҳ��
function loadSupChart(){
	//TODO ajax��ȡ����
	var path = $("#path").val();
	var supID = $("#supID").val();
	
	if($("#startTime").val()==""){
		alert("�����뿪ʼʱ�䣡");
		return;
	}
	if($("#endTime").val()==""){
		alert("���������ʱ�䣡");
		return;
	}
	var startTimeInp = new Date($("#startTime").val());
	var endTimeInp = new Date($("#endTime").val());
	var startTime;
	var endTime;
	//������
	var optionsRadiosinline = $('input[name="optionsRadiosinline"]:checked').val();
	//TODO ����ѡ�е���������װ����
	if("1"==optionsRadiosinline){//��
		startTime = startTimeInp.getFullYear()+"-01-01 00:00:00";
		endTime = endTimeInp.getFullYear()+"-12-31 23:59:59";
	}else if("2"==optionsRadiosinline){//��
		//TODO �ж��·ݲ��ܳ���12����
		var leftsecond=parseInt((endTimeInp.getTime()-startTimeInp.getTime())/1000);
		var d=parseInt(leftsecond/(3600*24));//������������
		if(d>365 ||d<=0){
			alert("��ѡ�·ݲ�ܳ���12����");
			return;
		}
		var startTimeMonth = "";
		var endTimeMonth = "";
		if(startTimeInp.getMonth()+1 < 10){
			startTimeMonth = "0"+(startTimeInp.getMonth()+1);
		}else{
			startTimeMonth = startTimeInp.getMonth()+1;
		}
		if(endTimeInp.getMonth()+1 < 10){
			endTimeMonth = "0"+(endTimeInp.getMonth()+1);
		}else{
			endTimeMonth = endTimeInp.getMonth+1;
		}
		startTime = startTimeInp.getFullYear()+"-"+startTimeMonth+"-01 00:00:00";
		endTime = endTimeInp.getFullYear()+"-"+endTimeMonth+"-31 23:59:59";
	}else{//��
		//TODO �ж��ղ��ܳ���1������
		var leftsecond=parseInt((endTimeInp.getTime()-startTimeInp.getTime())/1000);
		var d=parseInt(leftsecond/(3600*24));//������������
		if(d>30 || d<=0){
			alert("��ѡͳ���������ܳ���30��");
			return;
		}
		var startTimeMonth = "";
		var endTimeMonth = "";
		var startTimeDay = "";
		var endTimeDay = "";
		if(startTimeInp.getMonth()+1 < 10){
			startTimeMonth = "0"+(startTimeInp.getMonth()+1);
		}else{
			startTimeMonth = startTimeInp.getMonth()+1;
		}
		if(endTimeInp.getMonth()+1 < 10){
			endTimeMonth = "0"+(endTimeInp.getMonth()+1);
		}else{
			endTimeMonth = endTimeInp.getMonth()+1;
		}
		if(startTimeInp.getDate()<10){
			startTimeDay = "0"+startTimeInp.getDate();
		}else{
			startTimeDay = startTimeInp.getDate();
		}
		if(endTimeInp.getDate()<10){
			endTimeDay = "0"+endTimeInp.getDate();
		}else{
			endTimeDay = endTimeInp.getDate();
		}
		startTime = startTimeInp.getFullYear()+"-"+startTimeMonth+"-"+startTimeDay+" 00:00:00";
		endTime = endTimeInp.getFullYear()+"-"+endTimeMonth+"-"+endTimeDay+" 23:59:59";
	}
	
		var url=path+"/supervise/count/sup?supID="+supID+"&startTime="+startTime+"&endTime="+endTime;
		$.getJSON(url,function (data) {
			if(data==null){
				$("#countChartDiv").html("δ�ҵ��������");
			}else{
				if(supID=="-1"){
					var dataArray = new Array();
					var nameArray = new Array();
					$(data).each(function () {
			        	$(this.counts).each(function (index) {
			        		var obj = new Object();
			        		obj.name = this.supName;
			        		obj.value = parseFloat(this.orderAmount).toFixed(2);
			        		dataArray[index] = obj;
			        		nameArray[index] = this.supName;
			            });
			        });
					loadPieChart(nameArray,dataArray);
				}else{
					var timeArray = new Array();
					var dataArray = new Array();
					$(data).each(function () {
			        	$(this.counts).each(function (index) {
			        		timeArray[index] = this.orderTime;
			        		dataArray[index] = parseFloat(this.orderAmount).toFixed(2);
			            });
			        });
					loadColumnChart(timeArray,dataArray);
				}
			}
			
	    });
	
}

//��ҵҳ��
function loadCompanyChart(){
	//TODO ajax��ȡ����
	var path = $("#path").val();
	var companyID = $("#companyID").val();
	
	if($("#startTime").val()==""){
		alert("�����뿪ʼʱ�䣡");
		return;
	}
	if($("#endTime").val()==""){
		alert("���������ʱ�䣡");
		return;
	}
	var startTimeInp = new Date($("#startTime").val());
	var endTimeInp = new Date($("#endTime").val());
	var startTime;
	var endTime;
	//������
	var optionsRadiosinline = $('input[name="optionsRadiosinline"]:checked').val();
	//TODO ����ѡ�е���������װ����
	if("1"==optionsRadiosinline){//��
		startTime = startTimeInp.getFullYear()+"-01-01 00:00:00";
		endTime = endTimeInp.getFullYear()+"-12-31 23:59:59";
	}else if("2"==optionsRadiosinline){//��
		//TODO �ж��·ݲ��ܳ���12����
		var leftsecond=parseInt((endTimeInp.getTime()-startTimeInp.getTime())/1000);
		var d=parseInt(leftsecond/(3600*24));//������������
		if(d>365 || d<=0){
			alert("��ѡ�·ݲ�ܳ���12����");
			return;
		}
		var startTimeMonth = "";
		var endTimeMonth = "";
		if(startTimeInp.getMonth()+1 < 10){
			startTimeMonth = "0"+(startTimeInp.getMonth()+1);
		}else{
			startTimeMonth = startTimeInp.getMonth()+1;
		}
		if(endTimeInp.getMonth()+1 < 10){
			endTimeMonth = "0"+(endTimeInp.getMonth()+1);
		}else{
			endTimeMonth = endTimeInp.getMonth()+1;
		}
		startTime = startTimeInp.getFullYear()+"-"+startTimeMonth+"-01 00:00:00";
		endTime = endTimeInp.getFullYear()+"-"+endTimeMonth+"-31 23:59:59";
	}else{//��
		//TODO �ж��ղ��ܳ���1������
		var leftsecond=parseInt((endTimeInp.getTime()-startTimeInp.getTime())/1000);
		var d=parseInt(leftsecond/(3600*24));//������������
		if(d>30 || d<=0){
			alert("��ѡͳ���������ܳ���30��");
			return;
		}
		var startTimeMonth = "";
		var endTimeMonth = "";
		var startTimeDay = "";
		var endTimeDay = "";
		if(startTimeInp.getMonth()+1 < 10){
			startTimeMonth = "0"+(startTimeInp.getMonth()+1);
		}else{
			startTimeMonth = startTimeInp.getMonth()+1;
		}
		if(endTimeInp.getMonth()+1 < 10){
			endTimeMonth = "0"+(endTimeInp.getMonth()+1);
		}else{
			endTimeMonth = endTimeInp.getMonth()+1;
		}
		if(startTimeInp.getDate()<10){
			startTimeDay = "0"+startTimeInp.getDate();
		}else{
			startTimeDay = startTimeInp.getDate();
		}
		if(endTimeInp.getDate()<10){
			endTimeDay = "0"+endTimeInp.getDate();
		}else{
			endTimeDay = endTimeInp.getDate();
		}
		startTime = startTimeInp.getFullYear()+"-"+startTimeMonth+"-"+startTimeDay+" 00:00:00";
		endTime = endTimeInp.getFullYear()+"-"+endTimeMonth+"-"+endTimeDay+" 23:59:59";
	}
	
	
		var url=path+"/supervise/count/company?companyID="+companyID+"&startTime="+startTime+"&endTime="+endTime;
		$.getJSON(url,function (data) {
			if(data==null){
				$("#countChartDiv").html("δ�ҵ��������");
			}else{
				if(companyID=="-1"){//���ع�Ӧ�̱���ͼ
					var dataArray = new Array();
					var nameArray = new Array();
					$(data).each(function () {
			        	$(this.counts).each(function (index) {
			        		var obj = new Object();
			        		obj.name = this.companyName;
			        		obj.value = parseFloat(this.orderAmount).toFixed(2);
			        		dataArray[index] = obj;
			        		nameArray[index] = this.companyName;
			            });
			        });
					loadPieChart(nameArray,dataArray);
				}else{
					var timeArray = new Array();
					var dataArray = new Array();
					$(data).each(function () {
			        	$(this.counts).each(function (index) {
			        		timeArray[index] = this.orderTime;
			        		dataArray[index] = parseFloat(this.orderAmount).toFixed(2);
			            });
			        });
					loadColumnChart(timeArray,dataArray);
				}
			}
			
	    });
}



//���ر�ͼ
function loadPieChart(nameArray,dataArray){
   //-----------------��ͼ-----------------
	var myChart = echarts.init(document.getElementById('countChartDiv'));
    var option = {
    			    title : {
//    			        text: '��������������ͼ',
//    			        subtext: titlePie,
    			        x:'center'
    			    },
    			    tooltip : {
    			        trigger: 'item',
    			        formatter: "{a} <br/>{b} : {c} ({d}%)"
    			    },
    			    legend: {
    			        orient : 'vertical',
    			        x : 'left',
    			        data:nameArray
    			    },
    			    toolbox: {
    			        show : true,
    			        feature : {
    			            //mark : {show: true},
    			            dataView : {show: true, readOnly: false},
    			            magicType : {
    			                show: true, 
    			                type: ['pie', 'funnel'],
    			                option: {
    			                    funnel: {
    			                        x: '25%',
    			                        width: '50%',
    			                        funnelAlign: 'left',
    			                        max: 1548
    			                    }
    			                }
    			            },
    			            restore : {show: true},
    			            saveAsImage : {show: true}
    			        }
    			    },
    			    calculable : true,
    			    series : [
    			        {
    			            name:'������Դ',
    			            type:'pie',
    			            radius : '55%',
    			            center: ['50%', '60%'],
    			            data:dataArray
    			        }
    			    ]
    			};
    myChart.setOption(option);
    
}
//��������ͼ
function loadColumnChart(timeArray,dataArray){
	//----------------����ͼ-----------------------
    var myChartBar = echarts.init(document.getElementById('countChartDiv'));
    var optionBar = {
		    		 title : {
		//			        text: '��������������ͼ',
//					        subtext: titleZ,
					        x:'center'
					    },
    			    tooltip : {
    			        trigger: 'axis',
    			        axisPointer : {            // ������ָʾ���������ᴥ����Ч
    			            type : 'shadow'        // Ĭ��Ϊֱ�ߣ���ѡΪ��'line' | 'shadow'
    			        }
    			    },
//    			    legend: {
////    			        data:['����','������']
//    			    	data:names
//    			    },
    			    toolbox: {
    			        show : true,
    			        orient: 'vertical',
    			        x: 'right',
    			        y: 'center',
    			        feature : {
    			            //mark : {show: true},
    			            dataView : {show: true, readOnly: false},
    			            magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
    			            restore : {show: true},
    			            saveAsImage : {show: true}
    			        }
    			    },
    			    calculable : true,
    			    xAxis : [
    			        {
    			            type : 'category',
    			            data : timeArray
    			        }
    			    ],
    			    yAxis : [
    			        {
    			            type : 'value'
    			        }
    			    ],
    			    series : [
    			        {
    			            name:"���۽��",
    			            type:'bar',
    			            data:dataArray
    			        }
//    			        ,{
//    			            name:names[1],
//    			            type:'bar',
//    			            data:weighsZZQ,
////    			            markLine : {
////    			                itemStyle:{
////    			                    normal:{
////    			                        lineStyle:{
////    			                            type: 'dashed'
////    			                        }
////    			                    }
////    			                },
////    			                data : [
////    			                    [{type : 'min'}, {type : 'max'}]
////    			                ]
////    			            }
//    			        }
    			    ]
    			};
    myChartBar.setOption(optionBar);
}
