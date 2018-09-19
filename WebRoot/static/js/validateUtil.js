var regBox = {
	regNumberOrLetter : /^[A-Za-z0-9]+$/, //���ֻ���ĸ
    regEmail : /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/,//����
    regMobile : /^0?1[3|4|5|8][0-9]\d{8}$/,//�ֻ�
    regTel : /^0\d{2,3}-?\d{7,8}$/,//�绰
    regNumber : /^\d+$/
 };


//У����������ֻ���ĸ
function isNumberOrLetter(data){
	return regBox.regNumberOrLetter.test(data);
}
//У������
function isMail(mail){
	return regBox.regEmail.test(mail);
}
//У��绰��
function isPhoneNo(phoneNo){
	if(regBox.regMobile.test(phoneNo) || regBox.regTel.test(phoneNo)){
		return true;
	}else{
		return false;
	}
}
//У���������
function isNumber(data){
	return regBox.regNumber.test(data);
}