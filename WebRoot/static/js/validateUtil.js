var regBox = {
	regNumberOrLetter : /^[A-Za-z0-9]+$/, //数字或字母
    regEmail : /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/,//邮箱
    regMobile : /^0?1[3|4|5|8][0-9]\d{8}$/,//手机
    regTel : /^0\d{2,3}-?\d{7,8}$/,//电话
    regNumber : /^\d+$/
 };


//校验必须是数字或字母
function isNumberOrLetter(data){
	return regBox.regNumberOrLetter.test(data);
}
//校验邮箱
function isMail(mail){
	return regBox.regEmail.test(mail);
}
//校验电话号
function isPhoneNo(phoneNo){
	if(regBox.regMobile.test(phoneNo) || regBox.regTel.test(phoneNo)){
		return true;
	}else{
		return false;
	}
}
//校验必须数字
function isNumber(data){
	return regBox.regNumber.test(data);
}