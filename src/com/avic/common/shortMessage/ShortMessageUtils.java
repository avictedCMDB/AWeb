package com.avic.common.shortMessage;

import java.rmi.RemoteException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.avic.common.utils.ConfigHolder;

public class ShortMessageUtils {
	
	
	protected static final Log logger = LogFactory.getLog(ShortMessageUtils.class);
	
	/**
	 * 发送短信、可以发送定时和即时短信 sendSMS(String[] mobiles,String smsContent, String
	 * addSerial, int smsPriority) 1、mobiles 手机数组长度不能超过1000 2、smsContent
	 * 最多500个汉字或1000个纯英文
	 * 、请客户不要自行拆分短信内容以免造成混乱、亿美短信平台会根据实际通道自动拆分、计费以实际拆分条数为准、亿美推荐短信长度70字以内
	 * 3、addSerial 附加码(长度小于15的字符串) 用户可通过附加码自定义短信类别,或添加自定义主叫号码( 联系亿美索取主叫号码列表)
	 * 4、优先级范围1~5，数值越高优先级越高(相对于同一序列号) 5、其它短信发送请参考使用手册自己尝试使用
	 */
	public static void sendSMS(String[] mobiles,String smsContent) throws RemoteException {
		String softwareSerialNo = ConfigHolder.getInstance().getConfig("SmsSerialNo");
		String key = ConfigHolder.getInstance().getConfig("SmsKey");
		String SmsSign = ConfigHolder.getInstance().getConfig("SmsSign");
		String logMes ="";
		for (int i = 0; i < mobiles.length; i++) {
			logMes = logMes + mobiles[i]+",";
		}
		logger.debug("发送短信：号码："+logMes +"内容"+ smsContent);
		smsContent = SmsSign + smsContent; 
		int i =SingletonClient.getClient(softwareSerialNo,key).sendSMS(mobiles, smsContent, "",5);
		logger.debug("发送短信结束："+i);
	}

}
