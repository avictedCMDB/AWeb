package com.avic.market.models;
/**
 * �ͻ���Ϣʵ��
 *
 */
public class AsCustomerDto {
    private String customerContactName;		//��ϵ��
    private String customerTel;				//��ϵ�绰
    private String customerMobilePhone; 	//�ֻ���
    private String customerEmail;			//Email
    private String customerPostcode;		//�ʱ�
	public String getCustomerContactName() {
		return customerContactName;
	}
	public void setCustomerContactName(String customerContactName) {
		this.customerContactName = customerContactName;
	}
	public String getCustomerTel() {
		return customerTel;
	}
	public void setCustomerTel(String customerTel) {
		this.customerTel = customerTel;
	}
	public String getCustomerMobilePhone() {
		return customerMobilePhone;
	}
	public void setCustomerMobilePhone(String customerMobilePhone) {
		this.customerMobilePhone = customerMobilePhone;
	}
	public String getCustomerEmail() {
		return customerEmail;
	}
	public void setCustomerEmail(String customerEmail) {
		this.customerEmail = customerEmail;
	}
	public String getCustomerPostcode() {
		return customerPostcode;
	}
	public void setCustomerPostcode(String customerPostcode) {
		this.customerPostcode = customerPostcode;
	}
    
    
}
