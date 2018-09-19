package com.avic.common.shortMessage;

import java.rmi.RemoteException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.avic.common.utils.ConfigHolder;

public class ShortMessageUtils {
	
	
	protected static final Log logger = LogFactory.getLog(ShortMessageUtils.class);
	
	/**
	 * ���Ͷ��š����Է��Ͷ�ʱ�ͼ�ʱ���� sendSMS(String[] mobiles,String smsContent, String
	 * addSerial, int smsPriority) 1��mobiles �ֻ����鳤�Ȳ��ܳ���1000 2��smsContent
	 * ���500�����ֻ�1000����Ӣ��
	 * ����ͻ���Ҫ���в�ֶ�������������ɻ��ҡ���������ƽ̨�����ʵ��ͨ���Զ���֡��Ʒ���ʵ�ʲ������Ϊ׼�������Ƽ����ų���70������
	 * 3��addSerial ������(����С��15���ַ���) �û���ͨ���������Զ���������,������Զ������к���( ��ϵ������ȡ���к����б�)
	 * 4�����ȼ���Χ1~5����ֵԽ�����ȼ�Խ��(�����ͬһ���к�) 5���������ŷ�����ο�ʹ���ֲ��Լ�����ʹ��
	 */
	public static void sendSMS(String[] mobiles,String smsContent) throws RemoteException {
		String softwareSerialNo = ConfigHolder.getInstance().getConfig("SmsSerialNo");
		String key = ConfigHolder.getInstance().getConfig("SmsKey");
		String SmsSign = ConfigHolder.getInstance().getConfig("SmsSign");
		String logMes ="";
		for (int i = 0; i < mobiles.length; i++) {
			logMes = logMes + mobiles[i]+",";
		}
		logger.debug("���Ͷ��ţ����룺"+logMes +"����"+ smsContent);
		smsContent = SmsSign + smsContent; 
		int i =SingletonClient.getClient(softwareSerialNo,key).sendSMS(mobiles, smsContent, "",5);
		logger.debug("���Ͷ��Ž�����"+i);
	}

}
