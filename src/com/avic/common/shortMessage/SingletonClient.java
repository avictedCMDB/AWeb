package com.avic.common.shortMessage;


import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;

import com.avic.common.utils.ConfigHolder;




public class SingletonClient {
	private static Client client=null;
	private SingletonClient(){
	}
	public synchronized static Client getClient(String softwareSerialNo,String key){
		if(client==null){
			try {
				client=new Client(softwareSerialNo,key);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return client;
	}
	public synchronized static Client getClient(){
		if(client==null){
			try {
				System.out.println(ConfigHolder.getInstance().getConfig("SmsSerialNo"));
				client=new Client(ConfigHolder.getInstance().getConfig("SmsSerialNo"),ConfigHolder.getInstance().getConfig("SmsKey"));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return client;
	}
	
	
}
