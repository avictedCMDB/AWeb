<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>��ҳ|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/register.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/index_top.js"></script>
<script type="text/javascript">
	function changeInsertType (type){
		$('#insertType').val(type);
		if (type == 1) {
			$('#insertSup').attr("class", "active");
			$('#insertManagement').removeClass("active");
		}else{
			$('#insertSup').removeClass("active");
			$('#insertManagement').attr("class", "active");
		}
	}
	function insert(action){

		if ($('#user').val() == '') {
			alert('�������û�����');
			return false;
		}
		var regex=/^[0-9A-Za-z_]{6,15}$/;
		if (!regex.exec($('#user').val())) {
			alert('�û���ֻ������СдӢ�ġ����ֺ��»��ߣ�����Ϊ6-15');
			return false;
		}
		
		if ($('#password').val() == '') {
			alert('���������룡');
			return false;
		}
		
		regex=/^(?![a-zA-z]+$)(?!\d+$)(?![!@#$%^&*]+$)[a-zA-Z\d!@#$%^&*]{6,15}$/;
		if (!regex.exec($('#password').val())) {
			alert('�����ʽ���󣬸�ʽΪ��ĸ+���֡���ĸ+�����ַ�������+�����ַ�������Ϊ6-15');
			return false;
		}
		
		if ($('#password').val() != $('#confirm').val()) {
			alert('������ȷ�����벻һ�£�');
			return false;
		}
		if ($('#companyName').val() == '') {
			alert('��������ҵ���ƣ�');
			return false;
		}
		
		if ($('#name').val() == '') {
			alert('��������ϵ��������');
			return false;
		}
		
		if ($('#tel').val() == '') {
			alert('�������ֻ����룡');
			return false;
		}
		regex = /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/; 
		if (!regex.exec($('#tel').val())) {
			alert('�ֻ������ʽ����');
			return false;
		}
		if ($('#poster').val() == '') {
			alert('���������䣡');
			return false;
		}
		regex =  /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
		if (!regex.exec($('#poster').val())) {
			alert('�����ʽ����');
			return false;
		}
		if ($('#code').val() == '') {
			alert('�������ֻ���֤�룡');
			return false;
		}
		
		
		var formParam = $("#inserForm").serialize();
		$.ajax({

		     type: 'POST',

		     url: action ,

		    data: formParam ,

		    success: insertSuccess ,

		    dataType: 'json',
		    
		    cache:false,
		});
	}
	function insertSuccess(data){
		if (data == 0) {
			alert("ע��ɹ���");
			window.close();
		}else if(data == 1){
			alert("��֤�����");
		}else if(data == 2){
			alert("��ҵ�Ѵ��ڣ�");
		}else if(data == 3){
			alert("�û����Ѵ��ڣ�");
		}else if(data == 4){
			alert("��֤����ʧЧ�������·��ͣ�");
		}
	}
	function changeCheckBox(obj){
		var btn = document.getElementById('subButton');
		if (obj.checked) {
			btn.removeAttribute("disabled");
			btn.className = btn.className.replace('disable','');
		}else{
			btn.setAttribute("disabled", true);
			btn.className = btn.className + ' disable';
		}
	}
    var wait = 60;

    function time(btn,action) {
    	if(wait == 60){
    		if ($('#tel').val() == '') {
    			alert('�������ֻ����룡');
    			return false;
    		}
    		regex = /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/; 
    		if (!regex.exec($('#tel').val())) {
    			alert('�ֻ������ʽ����');
    			return false;
    		}
    		var formParam = $("#inserForm").serialize();
    		$.ajax({

    		     type: 'POST',

    		     url: action ,

    		    data: formParam ,

    		    success: sendSuccess ,

    		    dataType: 'json',
    		    
    		    cache:false,
    		});
    	}
        if (wait == 0) {
            btn.removeAttribute("disabled");
            btn.value = "��ȡ��֤��";
            btn.innerText = "��ȡ��֤��";
            wait = 60;
        } else {
            btn.setAttribute("disabled", true);
            btn.value = wait + "������»�ȡ��֤��";
            btn.innerText = wait + "������»�ȡ��֤��";
            wait--;
            setTimeout(function () {
                time(btn,action);
            },
            1000);
        }
    }
    function sendSuccess(data){
		if (data == 0) {
			
		}else if(data == 1){
			alert("�ֻ������Ѵ��ڣ�");
			wait = 0;
		}
	}
</script>
</head>
<body>
	<div class="page-wrapper">
		<div id="register_header">
			<div class="inner clearfix">
				<div id="logo">
					<h1><img src="${pageContext.request.contextPath}/static/img/index_top/img-logo.png" alt="�к��б���" style="cursor:pointer;" onclick="window.location.href='${pageContext.request.contextPath}/';"/></h1>
					<span class="txt">�û�ע��</span>
				</div>
				<div id="login">�����˺�<a href="${pageContext.request.contextPath}/">���¼</a></div>
			</div>
		<!-- register_header --></div>
		<div class="content">
			<div class="inner clearfix">
			<form id="inserForm">
				<div class="register_area">
					<div class="register_list">
						<dl class="clearfix">
							<dt>�û�����</dt>
							<dd class="role_area">
								<div class="role_list clearfix">
									<input type="hidden" value="1" name="insertType" id="insertType"/>
									<ul>
										<li class="active" id="insertSup"><a href="javascript:void(0)" onclick="changeInsertType(1)">Ͷ����/��Ӧ��</a></li>
										<li id="insertManagement"><a href="javascript:void(0)" onclick="changeInsertType(2)">�б���/�ɹ���</a></li>
									</ul>
								</div>
								<div class="attention">
									<ul>
										<li>1��Ͷ����/��Ӧ�̣�����������ƽ̨���߲����б���Ŀ/��Ӧ���ɹ�(��ҵ�ɹ�)��Ŀ��</li>
										<li>2���б���/�ɹ��ˣ�����������ƽ̨�����б�/�ɹ���Ϣ���淶������λ���б�/�ɹ�ҵ��</li>
									</ul>
								</div>
							</dd>
						</dl>
						<dl class="clearfix">
							<dt><span class="red">*</span>�û���</dt>
							<dd><input type="text" class="form-control" maxlength="15" id="user" name="user" placeholder="�������û���" /></dd>
						</dl>
						<dl class="clearfix">
							<dt><span class="red">*</span>����</dt>
							<dd><input type="password" class="form-control" maxlength="15" id="password" name="password" placeholder="��������ʹ�������ַ�" /></dd>
						</dl>
						<dl class="clearfix">
							<dt><span class="red">*</span>ȷ������</dt>
							<dd><input type="password" class="form-control" maxlength="15" id="confirm" name="confirm" placeholder="���ٴ���������" /></dd>
						</dl>
						<dl class="clearfix">
							<dt><span class="red">*</span>��ҵ����</dt>
							<dd><input type="text" class="form-control" maxlength="32" id="companyName" name="companyName" placeholder="����д�ڹ��̾�ע���ȫ��" /></dd>
						</dl>
						<dl class="clearfix">
							<dt><span class="red"></span>��Ӫ��Χ</dt>
							<dd><textarea class="form-control" rows="3" name="companyDetail"></textarea></dd>
						</dl>
						<dl class="clearfix">
							<dt><span class="red">*</span>��ϵ������</dt>
							<dd><input type="text" class="form-control" maxlength="32" id="name" name="name" placeholder="����д��ʵ����" /></dd>
						</dl>
						<dl class="clearfix">
							<dt><span class="red">*</span>����</dt>
							<dd><input type="text" class="form-control" maxlength="32" id="poster" name="poster" placeholder="����ʹ�ó�������" /></dd>
						</dl>
						<dl class="clearfix">
							<dt><span class="red">*</span>�ֻ���</dt>
							<dd>
								<div class="input-group">
									<input type="text" class="form-control" maxlength="12" id="tel" name="tel" placeholder="����д�ֻ�����" />
									<span class="input-group-btn">
										<button class="btn btn-default" type="button" onclick="time(this,'${pageContext.request.contextPath}/market/register/sendVerificationCode')">��ȡ��֤��</button>
									</span>
								</div>
							</dd>
						</dl>
						<dl class="clearfix">
							<dt><span class="red">*</span>�ֻ���֤��</dt>
							<dd>
								<div class="input-group">
									<input type="text" class="form-control" id="code" maxlength="4" name="code" placeholder="��������֤��" />
								</div>
							</dd>
						</dl>
					</div>
						<div class="readbook">
							<input type="checkbox" onclick="changeCheckBox(this)"/>
							<a href="#" data-toggle="modal" data-target="#agreement" >���û�ע��Э�顷</a>
							<a href="#" data-toggle="modal" data-target="#secret" >����˽���ԡ�</a>
							<a href="#" data-toggle="modal" data-target="#sincerity">�����������ŵ��</a>
							<a href="#" data-toggle="modal" data-target="#rule">��ע����˹���</a>
						</div>
						<div class="modal fade" id="agreement" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true">��</button>
										<h4 class="modal-title" id="myModalLabel">�û�ע��Э��</h4>
									</div>
									<div class="modal-body">
										<h4><img src="${pageContext.request.contextPath}/static/img/index_top/img-logo.png" alt="�к��б���"></h4>
										<div class="content_text">
											<h3>�к��б������ӽ���ƽ̨�û�ע��Э��</h3>
											<p>����������Ķ������Ȿ���û�ע��Э�顷�����¼�ơ�Э�顷���й涨������Ȩ�������񡣳��������ܱ���Э�顷�����������Ȩע�ᡢ��¼��ʹ���к��б������ӽ���ƽ̨�����¼�ơ��к��б����������漰����ط�����һ��ע�ᡢ��¼��ʹ�û����κη�ʽʹ���к��б����漰����ط������Ϊ����Ϊ�Ա���Э�顷�Ľ��ܣ�����ʾ��ͬ����ܱ���Э�顷���������Լ����</p>
											<h5>һ���ر�����</h5>
											<p>1. ��Э��ĸ���������ܻ����ҵ����Ҫ��ʱ�ؽ��е�����һ���������ݷ����䶯�������ڱ���վ�Թ���ķ�ʽ���Թ�������������ʹ�á������к��б����ķ�����Ϊ���ѳ���Ķ������Ⲣ�����޸ĺ��Э�����ݣ�������ͬ���޸ĺ��Э�����ݣ�����Ȩֹͣʹ���к��б����ķ���</p>
											<p>2����Э�����ݰ���Э�����ļ������к��б����Ѿ������������ܷ����ĸ���������й���Ϊ��Э�鲻�ɷָ��һ���֣��뱾Э�����ľ���ͬ�ȷ���Ч����</p>
											<h5>�����û�</h5>
											<p>1.�к��б������û��Ǿ�����ȫ������Ϊ�������ܹ��е���Ӧ�������ε���Ȼ�ˡ����˻�������֯���������߱����ʸ��벻Ҫʹ���к��б����ṩ�ķ��񣬷����������ļ໤��Ӧ�е���˶����µ�һ�к�������к��б�����Ȩע�������ö��ᣩ�����˻��������������ļ໤����������������һ�ҹ�˾�����������������к��б����Ǽǣ������������ͱ�֤���ѻ�øù�˾�����������������Ȩ���������κ�����ʹ�ù�˾��÷��������ܱ�Э�������Լ����</p>
											<p>2.�к��б����ķ��񽫲��ṩ����Щ���к��б�����ʱ������ȡ����Ա�ʸ����Ȼ�ˡ����˻�������֯��</p>
											<h5>����ע������</h5>
											<p>1.��������ע���Ϊ�к��б������û��������������¹���</p>
											<p>��1������ע��ʱ�������к��б�����Ҫ���ṩ��ʵ��׼ȷ����ʱ��������ע����Ϣ�����򽫳е��ɴ��������һ�����κ�����</p>
											<p>��2��ά������ʱ����ע����Ϣ�Ա�������ʵ��׼ȷ����ʱ��������</p>
											<p>2.��ע������У���������ѡ��һ����¼�������롣��Ӧ���Ʊ������ĵ�¼�������룬����ͨ�����˺Ž��е�������Ϊ����</p>
											<h5>�ġ�ʹ������</h5>
											<p> �к��б��������û�ע���ṩ���κ��й���Ϣ���ݵ���ʵ�ԡ������ԡ��Ϸ��Գе����Ρ����Է����ʹ���Ǹ������������ڷ���ĵط����ɡ����ҷ��ɺ͹��ʷ��ɱ�׼�ġ�</p>
											<h5>��ͬ�Ⲣ��ŵ��</h5>
											<p>1������ͨ���к��б���������������Ϣ��������������ע����Ϣ���ɹ���Ϣ��׼ȷ�ԡ������ԡ���ʱ�ԡ��Ϸ��Զ������е��������Ρ���Ӧ��׼ȷ��д����ʱ�������ṩ�ĵ����ʼ���ַ����ϵ�绰����ϵ��ַ�������������ϵ��ʽ���Ա��к��б����������û�����������Ч��ϵ����ͨ����Щ��ϵ��ʽ�޷�����ȡ����ϵ����������ʹ���к��б�����������в����κ���ʧ�����ӷ��õģ�Ӧ������ȫ���Գе������˽Ⲣͬ�⣬�������񱣳����ṩ����ϵ��ʽ����Ч�ԣ����б����Ҫ���µģ���Ӧ���к��б�����Ҫ����в����������к��б�����Ȩ��ֹ������ֹ������ط�������к��б����ʺŵ�ʹ�ã��к��б����Դ˲��е��κ�����</p>
											<p>2�����к��б����Ϸ�����Ϣ���������к��б����ķ���ʱ��������й��йط��ɡ����棬�������к��б����ϻ��������к��б����ķ������������ơ�����������������Ϣ��</p>
											<p>��1�������ܷ���ȷ���Ļ���ԭ��ģ�</p>
											<p>��2��Σ�����Ұ�ȫ��й¶�������ܣ��߸�������Ȩ���ƻ�����ͳһ�ģ�</p>
											<p>��3���𺦹�������������ģ�</p>
											<p>��4��ɿ�������ޡ��������ӡ��ƻ������Ž�ģ�</p>
											<p>��5���ƻ������ڽ����ߣ�����а�̺ͷ⽨���ŵģ�</p>
											<p>��6��ɢ��ҥ�ԣ�������������ƻ�����ȶ��ģ�</p>
											<p>��7��ɢ�����ࡢɫ�顢�Ĳ�����������ɱ���ֲ����߽�������ģ�</p>
											<p>��8��������߷̰����ˣ��ֺ����˺Ϸ�Ȩ��ģ�</p>
											<p>��9�����з��ɡ����������ֹ���������ݵġ�</p>
											<p>3���������к��б�������ʱ��������������йع��Һ͵����ķ��ɹ涨�Լ����ʷ����йع涨��</p>
											<p>4�������κη�ʽ�����к��б����ķ���</p>
											<p>5�������к��б��������������涨�ͳ���</p>
											<p>������Լ���ʹ���к��б�����������е���Ϊ�е��������Ρ��û����⣬����к��б�����������Ϣ�������������϶ε�2����������֮һ�������й����ɣ��к��б�������������ֹͣ����񣬱����йؼ�¼��������йػ��ر��棬����ɾ�����и����ݵ���Ϣ��</p>
											<p>6�� ��ʹ���к��б�������������ع����йط��ɺ����ߵȣ�ά���������棬�������Ұ�ȫ�������ر�Э�飬������Υ����Υ����Э�����Ϊ�������һ�����Σ�������ȫ�����Σ�һ�����к��б����޹أ������к��б�����ʧ�ģ��к��б�����ȨҪ�����⳥������Ȩ����ֹͣ�ṩ���񣬱�����ؼ�¼���������˾������׷���������ε�Ȩ����</p>
											<p>7�� �û�֮��ͨ���к��б����������û����ף������󵼻���ƭ�����»���ܵ��µ��κ������������ϵ��˺��Լ������ϵ���ʧ���ɹ����������е��������Σ�һ�����к��б����޹ء�</p>
											<p>8������ע���Ϊ��Ա���к��б���������ע��ʱ�ṩ����ϵ��ʽ�������������ڵ������䡢�ֻ�����ȣ������к��б���֪ͨ���뱾��վ������صĸ�����ҵ�Ե�����Ϣ��ǰ����Ϣ�������ϵͳʱ����Ϊ�ʹ������ͬ�����������ҵ�Ե�����Ϣ��ͨ��������ʽ֪ͨ���ǡ�</p>
											<h5>�塢��Ϣ�ռ�</h5>
											<p>����ע���Ϊ�к��б������û�ʱ���к��б�����Ҫ�ռ������������������䣨Email����ַ����Ϣ����������к��б���ʱ�����������Զ��ռ�����IP��ַ���к��б�����Ȩ�ռ���Ӧ�̼����Ʒ��Ϣ���ɹ��̵Ĳɹ���Ϣ���������ݿ�ϵͳ�����ǻ�Ա���ɻ�����Ҫ���к��б�������й¶��ĳһ�û�ֱ����ص�������Ϣ���������Ϣ�ռ���ʹ�ù�����ο��к��б�������˽���ԡ���</p>
											<h5>��������</h5>
											<p>�к��б���������ȡ������õ�Ȩ������ע�⣺�к��б������е�����ʹ���к��б����ķ������֧������Ӳ����˰�ռ��������á��к��б���������δ������֪ͨ��������վ��ʾ���������ʱ�ı�򲻼����ṩĳЩ��ȫ��������ʱ�ԵĻ����õģ���</p>
											<h5>�ߡ���ֹ����ֹ</h5>
											<p>1�������û���������Ϊ���к��б�����Ȩ�ڸ�֪��δ����֪���������ֹ����ֹ��ط�����߾ܾ������κ���ʽʹ���к��б�����������˳е��κ����Σ��ұ���׷�����������ε�Ȩ����</p>
											<p>��1�������к��б�������Υ����Υ�ͻ�Υ����Э��涨�Ļ��</p>
											<p>��2���ṩ����Ϣ����ʵ����׼ȷ������ʱ����������</p>
											<p>��3�������к��б����ķ��ظ���Ϣ���߷������к��б��������޹ص���Ϣ��</p>
											<p>��4��δ����Ȩ���к��б�����Ա���ʹ�����ҵ����ص���Ϣ��</p>
											<p>��5��ð�����˵����巢����Ϣ��</p>
											<p>��6���ƻ��ƻ��������к��б�������ϵͳ������������ԣ�������ͼ���Խ����к��б�������ϵͳ�����磻</p>
											<p>��7��ʹ�û��ṩ���лٻ������š���ȡ����ռ�κ�ϵͳ�����ݻ�������ϵ��κε��Բ�����αװ�ƻ����򡢵�����桢��ʱ����ը���������ƻ��Գ���</p>
											<p>��8�������������к��б����ϵĵ�¼�������룻</p>
											<p>��9��δ���к��б�������ͬ�⣬������������ʹ���к��б������񣨰�����������������������ʹ�����½�������룬�������Խ����½��������ת�ø����˵ģ�������ͨ���к��б�����������Ϣ��</p>
											<p>2����ͬ�⣬�к��б�����Ȩ���ں����Ļ��ɲ��������ʼ�֪ͨ���������ֹ������ֹ������ط�������к��б����ʺŵ�ʹ�ã��к��б����Դ˲��е��κ����Ρ�</p>
											<p>3��һ�����ķ�����ֹ�������������к��б����Ϸ�����Ϣ��Ҳ�����ñ��˴�Ϊ������Ϣ�������к��б�����ע�����ϼ����������Ϣ���ᱻɾ��������ͬʱ����������ֹǰ����Ϊ���к��б�������׷�����������ε�Ȩ����</p>
											<h5>�ˡ���������</h5>
											<p>1�� �к��б����������˲��û��ύ����Ϣ���������йط��ɷ����Լ���վ��Ӫ���������ˡ�������ɾ���û��ύ����Ϣ����������ȫ��֤��Ϣ����ʵ�ԡ�׼ȷ�ԺͺϷ��ԡ�</p>
											<p>2���к��б���������������վ�����ӡ��к��б��������ܿ�����Щ��վ�������ṩ����Դ�������к��б�����������վ�ϵ����ݡ���桢���񡢲�Ʒ��Ϣ����ʵ�ԡ�׼ȷ�ԡ������Լ���Ч�Բ����κγ�ŵ���Ҳ���˳е��κ����Ρ�</p>
											<p>3���к��б�������֤��վ�ǲ��ܸ��ŵġ�û�й��ϵģ�Ҳ����ʹ��Ч�����κα�֤���к��б�����������Ϊ�����Ϊ������ɵĻ�Ա���к��б���������֮�������������޷����ʸ�����ͬ������е�����վ�����жϡ���������ĳ��ӡ����Բ������������ӹ��ϡ�δ����Ȩ�Ľ�����������ʧ��</p>
											<p>4���򲻿ɿ�������������������Ȼ�ֺ����չ���ɧ�ҡ�������ս����Ϊ��������Ϊ�ȣ��Լ��������������Զ������İ����ڿ͹�������������ͨ�жϻ���ϵͳ���ϡ����Ų��ż����������µ�Ӱ�졢�������ƶ���ɵ���ʱ�Թر����ڵ��κ�Ӱ������������Ӫ�����صȷ��к��б���ԭ����ʹ�к��б������г��ӻ������еģ��к��б����������е��κ����Ρ����к��б���Ӧ�ڲ��ɿ���������ʱ֪ͨ��Ա����ȡ��ʩ�������Ŭ��������ܸ���Ա��ɵ���ʧ��</p>
											<p>5���к��б����������Ŭ�������ٴ��󣬵���վ���ṩ�ķ������Ϣ�Կ��ܰ����������ݣ��к��б������û���ʹ���к��б�������ɵ���ʧ�����������Ρ��к��б�������������Ϣ������֤������ʲô����¶��û���ʹ���к��б�������ɵ�ֱ�ӡ���ӡ�ż���ġ�����ġ��ͷ��Ե��𺦻�����һ���𺦲����������Σ��������ȱ���֪�𺦴��ڵĿ�����Ҳ����ˡ��������к��б����ṩ�Ĳ��ֻ����з�����������Ȩֹͣʹ����Щ����</p>
											<p>6�� �к��б����޷���֤�û�����������Ϣ����ʵ�ԡ���ʱ�ԡ���ȫ�Ժ���ȷ�ԣ���Ӧ�����е���ʹ���к��б����������ķ��ա��к��б���ϣ������ʹ�ñ���վʱ��С�Ľ��������ó�ʶ��</p>
											<h5>�š�֪ʶ��Ȩ</h5>
											<p>1���к��б������������ݵ�ѡ�ġ����������š��Ű桢��࣬�Լ����к��б������������֡�ͼƬ���̱�ȵ�����Ȩ�������Ƿ���ʾ�������к��б������С��κ���Ȼ�ˡ����˻�������֯δ���к��б���������Ȩ�����ɣ������޸ġ����桢���������봫�������ۡ�����������Ʒ�����������κη�ʽʹ������򲿷ֵ��к��б������ṩ�Ĳ�Ʒ������͹��ܡ�</p>
											<p>2���к��б��������п��Ķ������ϵȶ��ܵ����л����񹲺͹�����Ȩ���������л����񹲺͹��̱귨���ȵķ��ɱ������к��б������غͱ������˵�֪ʶ��Ȩ����������û������Ȩ���̱�Ȩ������ר��ȨȨ������ȷ���ɵ�����£��������ߴ����κο����ַ�����Ȩ������Ϣ��ͼƬ��������Ϊ�˳е��ɴ˲�����ȫ�����Ρ�</p>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="modal fade" id="secret" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true">��</button>
										<h4 class="modal-title" id="myModalLabel">��˽����</h4>
									</div>
									<div class="modal-body">
										<h4><img src="${pageContext.request.contextPath}/static/img/index_top/img-logo.png" alt="�к��б���"></h4>
										<div class="content_text">
											<h3>�к��б������ӽ���ƽ̨��˽����</h3>
											<p>���Ƿǳ�����������˽�������û���˽���к��б������ص�ԭ�����¼��ǵ��������ʹ���к��б���ʱ�����ǵ���˽���ԡ��ò�����Ϊ���û�Э�顷��һ���֣�����ѡ��ʹ�������ṩ�ķ���ʱ�����뱻ȫ�����ܡ����²��Կ��ܻ������ṩ������·���������Ķ����������һ�����޸ģ����ǻ�����Ҫҳ�������ѡ�˵������������Ч���������ͬ�ⱻ�޸ĵ���˽���ԣ�������ȡ���ѻ�õķ������������ʹ�÷�������Ϊ���ܲ��Ե��޸ġ��ʽ��������ڲ��ġ�</p>
											<h5>һ���û���Ϣ</h5>
											<p>1���к��б������������ṩ�����Ͻ����ϸ�Ĺ�����������ͨ�������ֶΡ��ṩ��˽���������ܡ� ǿ���ڲ������Ȱ취��ֱ����û��ĸ������ϰ�ȫ���к��б�����֤�����⹫������������ṩ�û�ע������ϣ����û���ʹ�÷���ʱ�洢�ķǹ������ݣ�������������⣺</p>
											<p>��1�����Ȼ��������ȷ��Ȩ��</p>
											<p>��2�� �����йصķ��ɷ���Ҫ��</p>
											<p>��3�� �������˾���������������ܲ��ŵ�Ҫ��</p>
											<p>��4��ֻ��͸¶��ĸ������ϣ������ṩ����Ҫ��Ĳ�Ʒ�ĺͷ���</p>
											<p>��5�� ��ڿ���Ϊ���û��ı�����������ʺš����������˷Ƿ�ʹ�ã�</p>
											<p>��6�������������û������֪���˻������˹���ע���ʻ����ɴ˵��µ��κθ�������й¶��</p>
											<p>2���˻���Ϣ������Ҫ�ռ������к��б�����ע��Ϊ��Ա����˻���Ϣ�������˻�����Ҫ�ύ�Ĺ�˾���ơ���ַ����ϵ�ˡ��绰�����桢��������ȹ�˾����Ʒ���б�ɹ���Ϣ������ͨ����¼���������޸����ϲ������ݣ����ռ���Щ��Ϣ��Ŀ����Ϊ��ִ���к��б����ķ������Ϊ���ṩ���ǳ�ŵ�ķ��񣬻������ܴ��ڵ����⡣</p>
											<p>3��������Ϣ���ǻ��ռ��ɹ��к��б���������ҵ���ο���ʹ�õ�������Ϣ��������Ϣ��Դ�ڡ��û����ʼ�¼���������������ڡ�Cookies���������к��б���Ҫ������Ҫ���ܡ�Cookies��������IP��ַ�������������ҳ����������ʶ���Լ��ǻ�Ա�û���ʹ���к��б������ַ���ʱ��Ҫ���ύ����Ϣ�����Ƕ���Щ��Ϣ�����ռ�����Ϊ��ʹ���ǵ���վ����������Ѻã���ͨ���ۺ�ͳ�����г���������������Ե�Ϊ���ṩ��Ч����ͬʱҲ�Ƿ�ֹ�к��б����ܵ����⹥���ı�Ҫ��ʩ��</p>
											<p>4��������ϢΪ���ܹ������ṩ��ȫ�桢רҵ��ϸ�µķ����к��б�����ĳЩ�����ͨ��������������ķ�ʽ������������ѡ��Ӧ�õ������ķ���ʱ����������Ҫ��õ������ṩĳЩ��Ϣ����������֧�������ṩ���п���Ϣ��һ����ʹ���˵������������ķ�����Ʒ���к��б�����˽���Խ�������Ч�����ǽ������鿴�ú��������վ����˽���ԣ����˽�ú����������ռ���ʹ�á�й¶���ĸ�����Ϣ�Ĺ涨��</p>
											<p>5�����ǲ��Ὣ���ڷ��ʺ�ʹ���к��б�����վ�Լ���ط���ʱ�ύ����Ϣ����������ַ�������ʼ���ַ�Լ��绰�����͸¶�򹫿������������˻���ҵ��ͬʱ, ��������, ���ǿ��ܻὫ��Щ��Ϣ��ͳ�ƽ�������ǵĺ�����鹲����</p>
											<h5>������˽����ԭ��ı䶯</h5>
											<p>���������Ҫ�ı���˽����, ���ǻ����صĸĶ������ҳ�淢��, �Ա�������ʱ�˽����ǻ��ռ�ʲô��Ϣ, ���ǿ��ܻ����ʹ����Щ��Ϣ�Լ������Ƿ��Ѵ���Ϣ͸¶����������</p>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="modal fade" id="rule" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true">��</button>
										<h4 class="modal-title" id="myModalLabel">ע����˹���</h4>
									</div>
									<div class="modal-body">
										<h4><img src="${pageContext.request.contextPath}/static/img/index_top/img-logo.png" alt="�к��б���"/></h4>
										<div class="content_text">
											<h3>ע����˹���</h3>
											<h5>���û�ע����֪</h5>
											<p>1.ע���Ϊ�к��б������ӽ���ƽ̨�û�ǰ�����ϸ�Ķ����û�ע��Э�顷 ����˽���ԡ� �����������ŵ�������˽���Ӧ��ע���������; </p>
											<p>2.�����Ϊ�к��б������ӽ���ƽ̨�û��ṩ�����Ϻ���Ϣ������ʵ��Ч������;</p>
											<p>3.��������������걨�󣬱���ͨ���к��б������ӽ���ƽ̨��������˲ſ���ʹ��ƽ̨����Ӧ����;</p>
											<p>ƽ̨�ͷ��绰��<span>010-84892588</span></p>
											<p class="special red">��ܰ��ʾ������ҵ����ֻ����ϵͳ��ע��һ�Σ���ע�ᵥλ��ɻ�Ա��˺����Ʊ�����ҵ�û��������룻����ע������ְ����ʧ�û���������ģ�����Ը�</p>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="modal fade" id="sincerity" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true">��</button>
										<h4 class="modal-title" id="myModalLabel">���������ŵ</h4>
									</div>
									<div class="modal-body">
										<h4><img src="${pageContext.request.contextPath}/static/img/index_top/img-logo.png" alt="�к��б���"/></h4>
										<div class="content_text">
											<h3>���������ŵ</h3>
											<p>Ϊά���г���ƽ������Ӫ���ʵ���ŵ���Ͷ�꽻�׻������ҵ�λ��Ը���� ���к��б������ӽ���ƽ̨Ͷ����ҵ��Ա��Ϣ�⡱�����¼�ƻ�Ա�⣩����Ը������λ�����Ϣ���ԵǼǲ����к��б������ӽ���ƽ̨��վ���ⷢ������Ա�ⷢ���������Ϣ�����ҵ�λȷ�����󣬶Դ�֣�س�ŵ���£�</p>
											<p>һ���ҵ�λ�ύ���ڻ�Ա�ⷢ���������Ϣ����ʵ��Ч���ύ�Ĳ������κ�α�졢�޸ġ���ٳɷݣ������������ݾ�Ϊ����λ��ʵӵ�С���Υ������ŵһ����ʵ������λԸ����ܹ���ͨ������Ը�˳������к��б������ӽ���ƽ̨���ڽ��е�Ͷ����Ŀ��ȡ����Ա�ʸ񣬰��ա��л����񹲺͹��б�Ͷ�귨������ʮ��������ֹ�����ڽ����б�ɹ��г���</p>
											<p>�����ҵ�λ�ڲμ��к��б������ӽ���ƽ̨��ĿͶ��������ϸ����ظ��������ƶȣ�����Υ����Ը���涨���ܴ�����</p>
											<p>�����ҵ�λ������桢��ʱά���͸��»�Ա�������ҵ�λ�йص����ݣ���δ�ܼ�ʱά���͸��£�����Ը�е��ɴ���ɵ�һ�в��������</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					<div class="btn_register"><button class="btn btn-default blue disable" disabled="disabled" type="button" id="subButton"  onclick="insert('${pageContext.request.contextPath}/market/register/insert')">����ע��</button></div>
				</div>
				</form>
				<div class="help_area">
					<h2>�û�ע�����</h2>
					<div class="help_list">
						<ul>
							<li><i>1</i><a href="${pageContext.request.contextPath}/market/help/indexHelpInfo?type=1">�û�ע�����</a></li>
							<li><i>2</i><a href="${pageContext.request.contextPath}/market/help/indexHelpInfo?type=1">��Աע���Ƿ��շѣ�</a></li>
							<li><i>3</i><a href="${pageContext.request.contextPath}/market/help/indexHelpInfo?type=1">�ύ����ҵ������ˣ��ܷ񾡿��������ͨ����</a></li>
							<li class="more"><a href="${pageContext.request.contextPath}/market/help/indexHelpInfo?type=1">���������Ϣ </a></li>
						</ul>
					</div>
				</div>
			</div>
		<!-- content --></div>
	<!-- page-wrapper --></div>
</body>
</html>