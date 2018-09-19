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
<title>首页|中航招标网</title>
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
			alert('请输入用户名！');
			return false;
		}
		var regex=/^[0-9A-Za-z_]{6,15}$/;
		if (!regex.exec($('#user').val())) {
			alert('用户名只包含大小写英文、数字和下划线，长度为6-15');
			return false;
		}
		
		if ($('#password').val() == '') {
			alert('请输入密码！');
			return false;
		}
		
		regex=/^(?![a-zA-z]+$)(?!\d+$)(?![!@#$%^&*]+$)[a-zA-Z\d!@#$%^&*]{6,15}$/;
		if (!regex.exec($('#password').val())) {
			alert('密码格式错误，格式为字母+数字、字母+特殊字符、数字+特殊字符，长度为6-15');
			return false;
		}
		
		if ($('#password').val() != $('#confirm').val()) {
			alert('密码与确认密码不一致！');
			return false;
		}
		if ($('#companyName').val() == '') {
			alert('请输入企业名称！');
			return false;
		}
		
		if ($('#name').val() == '') {
			alert('请输入联系人姓名！');
			return false;
		}
		
		if ($('#tel').val() == '') {
			alert('请输入手机号码！');
			return false;
		}
		regex = /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/; 
		if (!regex.exec($('#tel').val())) {
			alert('手机号码格式错误！');
			return false;
		}
		if ($('#poster').val() == '') {
			alert('请输入邮箱！');
			return false;
		}
		regex =  /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
		if (!regex.exec($('#poster').val())) {
			alert('邮箱格式错误！');
			return false;
		}
		if ($('#code').val() == '') {
			alert('请输入手机验证码！');
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
			alert("注册成功！");
			window.close();
		}else if(data == 1){
			alert("验证码错误！");
		}else if(data == 2){
			alert("企业已存在！");
		}else if(data == 3){
			alert("用户名已存在！");
		}else if(data == 4){
			alert("验证码已失效，请重新发送！");
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
    			alert('请输入手机号码！');
    			return false;
    		}
    		regex = /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/; 
    		if (!regex.exec($('#tel').val())) {
    			alert('手机号码格式错误！');
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
            btn.value = "获取验证码";
            btn.innerText = "获取验证码";
            wait = 60;
        } else {
            btn.setAttribute("disabled", true);
            btn.value = wait + "秒后重新获取验证码";
            btn.innerText = wait + "秒后重新获取验证码";
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
			alert("手机号码已存在！");
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
					<h1><img src="${pageContext.request.contextPath}/static/img/index_top/img-logo.png" alt="中航招标网" style="cursor:pointer;" onclick="window.location.href='${pageContext.request.contextPath}/';"/></h1>
					<span class="txt">用户注册</span>
				</div>
				<div id="login">已有账号<a href="${pageContext.request.contextPath}/">请登录</a></div>
			</div>
		<!-- register_header --></div>
		<div class="content">
			<div class="inner clearfix">
			<form id="inserForm">
				<div class="register_area">
					<div class="register_list">
						<dl class="clearfix">
							<dt>用户身份</dt>
							<dd class="role_area">
								<div class="role_list clearfix">
									<input type="hidden" value="1" name="insertType" id="insertType"/>
									<ul>
										<li class="active" id="insertSup"><a href="javascript:void(0)" onclick="changeInsertType(1)">投标人/供应商</a></li>
										<li id="insertManagement"><a href="javascript:void(0)" onclick="changeInsertType(2)">招标人/采购人</a></li>
									</ul>
								</div>
								<div class="attention">
									<ul>
										<li>1、投标人/供应商：您可以利用平台在线参与招标项目/供应链采购(企业采购)项目。</li>
										<li>2、招标人/采购人：您可以利用平台发布招标/采购信息，规范管理单位的招标/采购业务。</li>
									</ul>
								</div>
							</dd>
						</dl>
						<dl class="clearfix">
							<dt><span class="red">*</span>用户名</dt>
							<dd><input type="text" class="form-control" maxlength="15" id="user" name="user" placeholder="请输入用户名" /></dd>
						</dl>
						<dl class="clearfix">
							<dt><span class="red">*</span>密码</dt>
							<dd><input type="password" class="form-control" maxlength="15" id="password" name="password" placeholder="建议至少使用两种字符" /></dd>
						</dl>
						<dl class="clearfix">
							<dt><span class="red">*</span>确认密码</dt>
							<dd><input type="password" class="form-control" maxlength="15" id="confirm" name="confirm" placeholder="请再次输入密码" /></dd>
						</dl>
						<dl class="clearfix">
							<dt><span class="red">*</span>企业名称</dt>
							<dd><input type="text" class="form-control" maxlength="32" id="companyName" name="companyName" placeholder="请填写在工商局注册的全称" /></dd>
						</dl>
						<dl class="clearfix">
							<dt><span class="red"></span>经营范围</dt>
							<dd><textarea class="form-control" rows="3" name="companyDetail"></textarea></dd>
						</dl>
						<dl class="clearfix">
							<dt><span class="red">*</span>联系人姓名</dt>
							<dd><input type="text" class="form-control" maxlength="32" id="name" name="name" placeholder="请填写真实姓名" /></dd>
						</dl>
						<dl class="clearfix">
							<dt><span class="red">*</span>邮箱</dt>
							<dd><input type="text" class="form-control" maxlength="32" id="poster" name="poster" placeholder="建议使用常用邮箱" /></dd>
						</dl>
						<dl class="clearfix">
							<dt><span class="red">*</span>手机号</dt>
							<dd>
								<div class="input-group">
									<input type="text" class="form-control" maxlength="12" id="tel" name="tel" placeholder="请填写手机号码" />
									<span class="input-group-btn">
										<button class="btn btn-default" type="button" onclick="time(this,'${pageContext.request.contextPath}/market/register/sendVerificationCode')">获取验证码</button>
									</span>
								</div>
							</dd>
						</dl>
						<dl class="clearfix">
							<dt><span class="red">*</span>手机验证码</dt>
							<dd>
								<div class="input-group">
									<input type="text" class="form-control" id="code" maxlength="4" name="code" placeholder="请输入验证码" />
								</div>
							</dd>
						</dl>
					</div>
						<div class="readbook">
							<input type="checkbox" onclick="changeCheckBox(this)"/>
							<a href="#" data-toggle="modal" data-target="#agreement" >《用户注册协议》</a>
							<a href="#" data-toggle="modal" data-target="#secret" >《隐私策略》</a>
							<a href="#" data-toggle="modal" data-target="#sincerity">《诚信廉洁承诺》</a>
							<a href="#" data-toggle="modal" data-target="#rule">《注册审核规则》</a>
						</div>
						<div class="modal fade" id="agreement" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
										<h4 class="modal-title" id="myModalLabel">用户注册协议</h4>
									</div>
									<div class="modal-body">
										<h4><img src="${pageContext.request.contextPath}/static/img/index_top/img-logo.png" alt="中航招标网"></h4>
										<div class="content_text">
											<h3>中航招标网电子交易平台用户注册协议</h3>
											<p>请务必认真阅读和理解本《用户注册协议》（以下简称《协议》）中规定的所有权利和义务。除非您接受本《协议》条款，否则您无权注册、登录或使用中航招标网电子交易平台（以下简称“中航招标网”）所涉及的相关服务。您一旦注册、登录、使用或以任何方式使用中航招标网涉及的相关服务的行为将视为对本《协议》的接受，即表示您同意接受本《协议》各项条款的约束。</p>
											<h5>一、特别提醒</h5>
											<p>1. 本协议的个别条款可能会根据业务需要不时地进行调整，一旦条款内容发生变动，将会在本网站以公告的方式予以公布。若您继续使用、接受中航招标网的服务，视为您已充分阅读、理解并接受修改后的协议内容；若您不同意修改后的协议内容，您有权停止使用中航招标网的服务。</p>
											<p>2、本协议内容包括协议正文及所有中航招标网已经发布或将来可能发布的各类规则。所有规则为本协议不可分割的一部分，与本协议正文具有同等法律效力。</p>
											<h5>二、用户</h5>
											<p>1.中航招标网的用户是具有完全民事行为能力，能够承担相应法律责任的自然人、法人或其他组织。若您不具备此资格，请不要使用中航招标网提供的服务，否则您及您的监护人应承担因此而导致的一切后果，且中航招标网有权注销（永久冻结）您的账户，并向您及您的监护人索偿。如您代表一家公司或其他法律主体在中航招标网登记，则您须声明和保证您已获得该公司或其他法律主体的授权，您有责任和义务使该公司或该法律主体受本协议条款的约束。</p>
											<p>2.中航招标网的服务将不提供给那些被中航招标网临时或永久取消会员资格的自然人、法人或其他组织。</p>
											<h5>三、注册条款</h5>
											<p>1.若您申请注册成为中航招标网的用户，您须遵守以下规则：</p>
											<p>（1）申请注册时，根据中航招标网的要求，提供真实、准确、即时、完整的注册信息，否则将承担由此所引起的一起责任和义务；</p>
											<p>（2）维护并及时更新注册信息以保持其真实、准确、即时、完整。</p>
											<p>2.在注册过程中，您可自主选择一个登录名和密码。您应妥善保管您的登录名和密码，并对通过该账号进行的所有行为负责。</p>
											<h5>四、使用条款</h5>
											<p> 中航招标网不对用户注册提供的任何有关信息内容的真实性、适用性、合法性承担责任。您对服务的使用是根据所有适用于服务的地方法律、国家法律和国际法律标准的。</p>
											<h5>您同意并承诺：</h5>
											<p>1、您对通过中航招标网发布的所有信息，包括但不限于注册信息、采购信息的准确性、完整性、即时性、合法性都独立承担所有责任。您应当准确填写并及时更新您提供的电子邮件地址、联系电话、联系地址、邮政编码等联系方式，以便中航招标网或其他用户与您进行有效联系，因通过这些联系方式无法与您取得联系，导致您在使用中航招标网服务过程中产生任何损失或增加费用的，应由您完全独自承担。您了解并同意，您有义务保持你提供的联系方式的有效性，如有变更需要更新的，您应按中航招标网的要求进行操作。否则，中航招标网有权中止或者终止您的相关服务或者中航招标网帐号的使用，中航招标网对此不承担任何责任</p>
											<p>2、在中航招标网上发布信息或者利用中航招标网的服务时必须符合中国有关法律、法规，不得在中航招标网上或者利用中航招标网的服务制作、复制、发布、传播以下信息：</p>
											<p>（1）反对宪法所确定的基本原则的；</p>
											<p>（2）危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；</p>
											<p>（3）损害国家荣誉和利益的；</p>
											<p>（4）煽动民族仇恨、民族歧视、破坏民族团结的；</p>
											<p>（5）破坏国家宗教政策，宣扬邪教和封建迷信的；</p>
											<p>（6）散布谣言，扰乱社会秩序，破坏社会稳定的；</p>
											<p>（7）散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的；</p>
											<p>（8）侮辱或者诽谤他人，侵害他人合法权益的；</p>
											<p>（9）含有法律、行政法规禁止的其他内容的。</p>
											<p>3、在利用中航招标网服务时还必须符合其他有关国家和地区的法律规定以及国际法的有关规定。</p>
											<p>4、不以任何方式干扰中航招标网的服务。</p>
											<p>5、遵守中航招标网的所有其他规定和程序。</p>
											<p>您需对自己在使用中航招标网服务过程中的行为承担法律责任。用户理解，如果中航招标网发现其消息内容明显属于上段第2条所列内容之一，依据中国法律，中航招标网有义务立即停止其服务，保存有关记录，向国家有关机关报告，并且删除含有该内容的消息。</p>
											<p>6、 您使用中航招标网服务必须遵守国家有关法律和政策等，维护国家利益，保护国家安全，并遵守本协议，对于您违法或违反本协议的行为而引起的一切责任，由您负全部责任，一概与中航招标网无关，导致中航招标网损失的，中航招标网有权要求您赔偿，并有权立即停止提供服务，保留相关记录，保留配合司法机关追究法律责任的权利。</p>
											<p>7、 用户之间通过中航招标网与其他用户交易，因受误导或欺骗而导致或可能导致的任何心理、生理上的伤害以及经济上的损失，由过错方依法承担所有责任，一概与中航招标网无关。</p>
											<p>8、当您注册成为会员后，中航招标网会向您注册时提供的联系方式（包括但不限于电子邮箱、手机号码等）发送中航招标网通知或与本网站服务相关的各类商业性电子信息，前述信息进入接收系统时，视为送达。如您不同意继续接收商业性电子信息须通过书面形式通知我们。</p>
											<h5>五、信息收集</h5>
											<p>当您注册成为中航招标网的用户时，中航招标网需要收集您的姓名、电子邮箱（Email）地址等信息。当您浏览中航招标网时，服务器会自动收集您的IP地址。中航招标网有权收集供应商及其产品信息、采购商的采购信息，构建数据库系统。除非会员许可或法律需要，中航招标网不会泄露与某一用户直接相关的上述信息。具体的信息收集及使用规则，请参看中航招标网《隐私策略》。</p>
											<h5>六、费用</h5>
											<p>中航招标网保留收取服务费用的权利。请注意：中航招标网不承担您因使用中航招标网的服务而需支付的软硬件、税收及其它费用。中航招标网保留在未经书面通知，仅在网站公示的情况下随时改变或不继续提供某些或全部服务（暂时性的或永久的）。</p>
											<h5>七、中止及终止</h5>
											<p>1．对于用户的以下行为，中航招标网有权在告知或未经告知的情况下中止或终止相关服务或者拒绝其以任何形式使用中航招标网，并不因此承担任何责任，且保留追究您法律责任的权利：</p>
											<p>（1）利用中航招标网进行违法、违纪或违反本协议规定的活动；</p>
											<p>（2）提供的信息不真实、不准确、不即时、不完整；</p>
											<p>（3）利用中航招标网滥发重复信息或者发布与中航招标网服务无关的信息；</p>
											<p>（4）未经授权向中航招标网会员发送大量与业务不相关的信息；</p>
											<p>（5）冒用他人的名义发布信息；</p>
											<p>（6）计划破坏、攻击中航招标网电脑系统、网络的完整性，或者试图擅自进入中航招标网电脑系统、网络；</p>
											<p>（7）使用或提供含有毁坏、干扰、截取或侵占任何系统、数据或个人资料的任何电脑病毒、伪装破坏程序、电脑蠕虫、定时程序炸弹或其他破坏性程序；</p>
											<p>（8）盗用他人在中航招标网上的登录名或密码；</p>
											<p>（9）未经中航招标网书面同意，擅自允许他人使用中航招标网服务（包括但不限于擅自允许他人使用其登陆名或密码，或者擅自将其登陆名或密码转让给他人的），或者通过中航招标网获得相关信息。</p>
											<p>2．您同意，中航招标网有权基于合理的怀疑并经电子邮件通知的情况下中止或者终止您的相关服务或者中航招标网帐号的使用，中航招标网对此不承担任何责任。</p>
											<p>3．一旦您的服务被终止，您将不能在中航招标网上发布信息，也不能让别人代为发布信息；您在中航招标网的注册资料及所有相关信息均会被删除或丢弃；同时对您服务终止前的行为，中航招标网保留追究您法律责任的权利。</p>
											<h5>八、责任声明</h5>
											<p>1． 中航招标网将尽力核查用户提交的信息，并依照有关法律法规以及网站运营规则进行审核、发布或删除用户提交的信息，但不能完全保证信息的真实性、准确性和合法性。</p>
											<p>2．中航招标网含有与其他网站的链接。中航招标网并不能控制这些网站及其所提供的资源，所以中航招标网对链接网站上的内容、广告、服务、产品信息的真实性、准确性、完整性及有效性不做任何承诺，且不因此承担任何责任。</p>
											<p>3．中航招标网不保证网站是不受干扰的、没有故障的，也不对使用效果做任何保证。中航招标网不对因人为或非人为因素造成的会员与中航招标网服务器之间的连接受阻而无法访问负责。您同意独立承担因网站意外中断、操作或传输的迟延、电脑病毒、网络连接故障、未经授权的进入等引起的损失。</p>
											<p>4．因不可抗力（包括但不限于自然灾害、罢工或骚乱、暴动、战争行为、政府行为等）以及因互联网的特殊性而产生的包括黑客攻击、互联网连通中断或者系统故障、电信部门技术调整导致的影响、政府管制而造成的暂时性关闭在内的任何影响网络正常运营的因素等非中航招标网原因，致使中航招标网履行迟延或不能履行的，中航招标网不对您承担任何责任。但中航招标网应在不可抗力发生后及时通知会员并采取措施，尽最大努力减轻可能给会员造成的损失。</p>
											<p>5．中航招标网将尽最大努力来减少错误，但网站上提供的服务和信息仍可能包含错误内容，中航招标网对用户因使用中航招标网而造成的损失不负法律责任。中航招标网对其服务和信息不作保证，不论什么情况下对用户因使用中航招标网而造成的直接、间接、偶尔的、特殊的、惩罚性的损害或其他一切损害不负法律责任，即便事先被告知损害存在的可能性也是如此。若您对中航招标网提供的部分或所有服务不满，您有权停止使用这些服务。</p>
											<p>6． 中航招标网无法保证用户所公布的信息的真实性、及时性、安全性和正确性，您应独立承担因使用中航招标网而产生的风险。中航招标网希望您在使用本网站时，小心谨慎并运用常识。</p>
											<h5>九、知识产权</h5>
											<p>1．中航招标网上所有内容的选材、整理、编排、排版、汇编，以及由中航招标网创作的文字、图片、商标等的著作权，无论是否明示，均属中航招标网所有。任何自然人、法人或其他组织未经中航招标网书面授权或许可，不得修改、出版、传播、参与传播、销售、制作衍生作品，或以其他任何方式使用整体或部分的中航招标网上提供的产品、服务和功能。</p>
											<p>2．中航招标网上所有可阅读的资料等都受到《中华人民共和国著作权法》、《中华人民共和国商标法》等的法律保护。中航招标网尊重和保护他人的知识产权，不允许在没有著作权、商标权或其他专有权权利人明确许可的情况下，发布或者传播任何可能侵犯他人权利的信息、图片，否则，行为人承担由此产生的全部责任。</p>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="modal fade" id="secret" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
										<h4 class="modal-title" id="myModalLabel">隐私策略</h4>
									</div>
									<div class="modal-body">
										<h4><img src="${pageContext.request.contextPath}/static/img/index_top/img-logo.png" alt="中航招标网"></h4>
										<div class="content_text">
											<h3>中航招标网电子交易平台隐私策略</h3>
											<p>我们非常重视您的隐私，保护用户隐私是中航招标网的重点原则，以下即是当您浏览、使用中航招标网时，我们的隐私策略。该策略作为《用户协议》的一部分，在您选择使用我们提供的服务时，必须被全部接受。以下策略可能会因将来提供更多的新服务而有所改动。相关条款一旦被修改，我们会在重要页面上提醒、说明，并立即生效。如果您不同意被修改的隐私策略，可主动取消已获得的服务；如果您继续使用服务，则视为接受策略的修改。故建议您定期查阅。</p>
											<h5>一、用户信息</h5>
											<p>1、中航招标网将对您所提供的资料进行严格的管理及保护，通过技术手段、提供隐私保护服务功能、 强化内部管理等办法充分保护用户的个人资料安全。中航招标网保证不对外公开或向第三方提供用户注册的资料，及用户在使用服务时存储的非公开内容，但下列情况除外：</p>
											<p>（1）事先获得您的明确授权；</p>
											<p>（2） 根据有关的法律法规要求；</p>
											<p>（3） 按照相关司法机构或政府主管部门的要求；</p>
											<p>（4）只有透露你的个人资料，才能提供你所要求的产品的和服务；</p>
											<p>（5） 因黑客行为或用户的保管疏忽导致帐号、密码遭他人非法使用；</p>
											<p>（6））由于您将用户密码告知他人或与他人共享注册帐户，由此导致的任何个人资料泄露；</p>
											<p>2、账户信息我们主要收集您在中航招标网上注册为会员后的账户信息，包括账户内需要提交的公司名称、地址、联系人、电话、传真、电子邮箱等公司、产品和招标采购信息（您可通过登录名和密码修改以上部分内容）。收集这些信息的目的是为了执行中航招标网的服务条款，为您提供我们承诺的服务，或解决可能存在的问题。</p>
											<p>3、隐含信息我们还收集可供中航招标网及其商业伙伴参考或使用的隐含信息。此类信息来源于“用户访问记录”，包括但不限于“Cookies”（访问中航招标网要求您需要接受“Cookies”）、“IP地址”、浏览过的网页或其他数字识别，以及非会员用户在使用中航招标网部分服务时被要求提交的信息。我们对这些信息进行收集，是为了使我们的网站界面对您更友好，并通过综合统计与市场分析，更有针对性的为您提供有效服务，同时也是防止中航招标网受到恶意攻击的必要措施。</p>
											<p>4、其他信息为了能够向您提供更全面、专业、细致的服务，中航招标网在某些领域会通过与第三方合作的方式建立服务。在您选择应用第三方的服务时，您可能需要向该第三方提供某些信息，如向在线支付机构提供银行卡信息。一旦您使用了第三方合作伙伴的服务或产品，中航招标网隐私策略将不再生效，我们建议您查看该合作伙伴网站的隐私策略，并了解该合作伙伴对于收集、使用、泄露您的个人信息的规定。</p>
											<p>5、我们不会将您在访问和使用中航招标网网站以及相关服务时提交的信息如姓名、地址、电子邮件地址以及电话号码等透露或公开给第三方个人或企业。同时, 如上所述, 我们可能会将这些信息的统计结果与我们的合作伙伴共享。</p>
											<h5>二、隐私保护原则的变动</h5>
											<p>如果我们需要改变隐私策略, 我们会把相关的改动在相关页面发布, 以便您能随时了解我们会收集什么信息, 我们可能会如何使用这些信息以及我们是否会把此信息透露给第三方。</p>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="modal fade" id="rule" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
										<h4 class="modal-title" id="myModalLabel">注册审核规则</h4>
									</div>
									<div class="modal-body">
										<h4><img src="${pageContext.request.contextPath}/static/img/index_top/img-logo.png" alt="中航招标网"/></h4>
										<div class="content_text">
											<h3>注册审核规则</h3>
											<h5>新用户注册须知</h5>
											<p>1.注册成为中航招标网电子交易平台用户前务必仔细阅读《用户注册协议》 《隐私策略》 《诚信廉洁承诺》，并了解相应的注册申请程序; </p>
											<p>2.申请成为中航招标网电子交易平台用户提供的资料和信息必须真实有效和完整;</p>
											<p>3.在完成网上资料申报后，必须通过中航招标网电子交易平台的线上审核才可以使用平台的相应功能;</p>
											<p>平台客服电话：<span>010-84892588</span></p>
											<p class="special red">温馨提示：因企业名称只能在系统中注册一次，请注册单位完成会员审核后妥善保管企业用户名、密码；如因注册人离职而丢失用户名、密码的，后果自负</p>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="modal fade" id="sincerity" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
										<h4 class="modal-title" id="myModalLabel">诚信廉洁承诺</h4>
									</div>
									<div class="modal-body">
										<h4><img src="${pageContext.request.contextPath}/static/img/index_top/img-logo.png" alt="中航招标网"/></h4>
										<div class="content_text">
											<h3>诚信廉洁承诺</h3>
											<p>为维护市场公平竞争，营造诚实守信的招投标交易环境，我单位自愿加入 “中航招标网电子交易平台投标企业会员信息库”（以下简称会员库），自愿将本单位相关信息予以登记并在中航招标网电子交易平台网站对外发布，会员库发布的相关信息均经我单位确认无误，对此郑重承诺如下：</p>
											<p>一、我单位提交并在会员库发布的相关信息均真实有效，提交的材料无任何伪造、修改、虚假成份，材料所述内容均为本单位真实拥有。若违反本承诺一经查实，本单位愿意接受公开通报，自愿退出所有中航招标网电子交易平台正在进行的投标项目并取消会员资格，按照《中华人民共和国招标投标法》第五十四条，禁止三年内进入招标采购市场。</p>
											<p>二、我单位在参加中航招标网电子交易平台项目投标过程中严格遵守各项廉政制度，如有违反自愿按规定接受处罚。</p>
											<p>三、我单位今后将认真、及时维护和更新会员库中与我单位有关的内容，如未能及时维护和更新，将自愿承担由此造成的一切不良后果。</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					<div class="btn_register"><button class="btn btn-default blue disable" disabled="disabled" type="button" id="subButton"  onclick="insert('${pageContext.request.contextPath}/market/register/insert')">立即注册</button></div>
				</div>
				</form>
				<div class="help_area">
					<h2>用户注册帮助</h2>
					<div class="help_list">
						<ul>
							<li><i>1</i><a href="${pageContext.request.contextPath}/market/help/indexHelpInfo?type=1">用户注册帮助</a></li>
							<li><i>2</i><a href="${pageContext.request.contextPath}/market/help/indexHelpInfo?type=1">会员注册是否收费？</a></li>
							<li><i>3</i><a href="${pageContext.request.contextPath}/market/help/indexHelpInfo?type=1">提交了企业资料审核，能否尽快予以审核通过？</a></li>
							<li class="more"><a href="${pageContext.request.contextPath}/market/help/indexHelpInfo?type=1">更多帮助信息 </a></li>
						</ul>
					</div>
				</div>
			</div>
		<!-- content --></div>
	<!-- page-wrapper --></div>
</body>
</html>