package com.avic.common.shortMessage;

import java.rmi.RemoteException;
import java.util.Iterator;
import java.util.List;

import com.avic.common.shortMessage.cn.b2m.eucp.sdkhttp.Mo;
import com.avic.common.shortMessage.cn.b2m.eucp.sdkhttp.StatusReport;

public class TestSDKClient {
    public static String softwareSerialNo = "9SDK-EMY-0999-JDWTP";// ������к�,��ͨ������������Ա��ȡ
    public static String key = "852170";// ���к��״μ���ʱ�Լ��趨
    public static String password = "852170";// ����,��ͨ������������Ա��ȡ

    public static void main(String[] args) {
        /**
         * ��ȡclient�ķ���1 ��ʾ������SDKClient.getClient()��ȡ��Client����,
         * ��Ҳ������Client(softwareSerialNo,password)��ȡһ��Client����
         * ע:ʹ��SDKClient.getClient()��ȡ��Client��������кż�������config.properties������
         */
        // Client client=SDKClient.getClient();

        /**
         * ��ȡclient�ķ���2 �ڹ��캯������ȷ����дsoftwareSerialNo��password
         */
        // Client client2=new Client(softwareSerialNo,password);

        try {
            StartMenu();
            while (true) {
                System.out.println("��������Ž��в���");
                byte[] command = new byte[4];
                System.in.read(command);
                int operate = 0;
                try {
                    String commandString = new String(command);
                    commandString = commandString.replaceAll("\r\n", "").trim();
                    operate = Integer.parseInt(commandString);
                } catch (Exception e) {
                    System.out.println("����������󣡣���");
                }
                switch (operate) {
                    case 1:
                        testRegistEx();
                        break;
                    case 2:
                        testRegistDetailInfo();
                        break;
                    case 3:
                        testGetBalance();
                        break;
                    case 4:
                        testChargeUp();
                        break;
                    case 5:
                        testSerialPwdUpd();
                        break;
                    case 6:
                        testSendSMS();
                        break;
                    case 7:
                        testSendScheduledSMS();
                        break;
                    case 8:
                        testSendSMSAddMessageId();
                        break;
                    case 9:
                        testGetMO();
                        break;
                    case 10:
                        testgetReport();
                        break;
                    case 11:
                        testSendVoice();
                        break;
                    case 12:
                        testLogout();
                    case 13:
                        System.exit(0);
                    default:
                        System.out.println("û�и����� " + operate);
                        break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void StartMenu() {
        int i = 1;
        System.out.println(i + "���������к�,����ʹ�á���ע�����ٴ�ʹ��ʱ���ø÷���.");
        i += 1;
        System.out.println(i + "����ҵ��Ϣע��,Ŀ�����ڶ��ŷ����쳣ʱEmay������ϵ����ҵ.");
        i += 1;
        System.out.println(i + "������ѯ");
        i += 1;
        System.out.println(i + "����ֵ");
        i += 1;
        System.out.println(i + "�������޸�");
        i += 1;
        System.out.println(i + "�����ͼ�ʱ����");
        i += 1;
        System.out.println(i + "�����Ͷ�ʱ����");
        i += 1;
        System.out.println(i + "�����ʹ�����ϢID�Ķ���,�ɹ���ѯ״̬����");
        i += 1;
        System.out.println(i + "����ȡ���ж���");
        i += 1;
        System.out.println(i + "��������ж���״̬����");
        i += 1;
        System.out.println(i + "������������֤��");
        i += 1;
        System.out.println(i + "�����ע��");
        i += 1;
        System.out.println(i + "���رճ���");
    }

    /**
     * ���ע�� 1�����ע�������Ͷ��š��������ж��Žӿڶ��޷�ʹ�� 2�������������ע�ᡢע����ɺ�������кŵĽ���ע��ǰ��״̬
     */
    public static void testLogout() {
        try {
            int a = SingletonClient.getClient().logout();
            System.out.println("testLogout:" + a);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * ������к�ע�ᡢ����˵�Ǽ��������к��״�ʹ�ñ��뼤�� registEx(String serialpass) 1��serialpass
     * ������к����롢���볤��Ϊ6λ�������ַ�����������кź�������ͨ������������Ա��ȡ
     */
    public static void testRegistEx() {
        try {
            int i = SingletonClient.getClient().registEx(password);
            System.out.println("testTegistEx:" + i);
        } catch (RemoteException e) {
            e.printStackTrace();
        }

    }

    /**
     * ���Ͷ��š����Է��Ͷ�ʱ�ͼ�ʱ���� sendSMS(String[] mobiles,String smsContent, String
     * addSerial, int smsPriority) 1��mobiles �ֻ����鳤�Ȳ��ܳ���1000 2��smsContent
     * ���500�����ֻ�1000����Ӣ��
     * ����ͻ���Ҫ���в�ֶ�������������ɻ��ҡ���������ƽ̨�����ʵ��ͨ���Զ���֡��Ʒ���ʵ�ʲ������Ϊ׼�������Ƽ����ų���70������
     * 3��addSerial ������(����С��15���ַ���) �û���ͨ���������Զ���������,������Զ������к���( ��ϵ������ȡ���к����б�)
     * 4�����ȼ���Χ1~5����ֵԽ�����ȼ�Խ��(�����ͬһ���к�) 5���������ŷ�����ο�ʹ���ֲ��Լ�����ʹ��
     */
    public static void testSendSMS() {
        try {
            int i = SingletonClient.getClient(softwareSerialNo,key).sendSMS(new String[] { "15668671907,13478620956,18525308031" }, "���к������ʾ�ó��չ���޹�˾����ǿ,����110000���˻�����,�����!", "",5);// ����չ��
            System.out.println("testSendSMS=====" + i);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * ���Ͷ�ʱ���� sendScheduledSMSEx(String[] mobiles, String smsContent,String
     * sendTime,String srcCharset) 1��mobiles �ֻ����鳤�Ȳ��ܳ���1000 2��smsContent
     * ���500�����ֻ�1000����Ӣ��
     * ����ͻ���Ҫ���в�ֶ�������������ɻ��ҡ���������ƽ̨�����ʵ��ͨ���Զ���֡��Ʒ���ʵ�ʲ������Ϊ׼�������Ƽ����ų���70������
     * 3��sendTime ��ʱ���ŷ���ʱ�� ��ʱʱ���ʽΪ������������������ʱʱ�ַ����룬����20090801123030
     * ��ʾ2009��8��1��12��30��30��������Żᷢ�͵��û��ֻ� 4��srcCharset �ַ����룬Ĭ��Ϊ"GBK"
     * 5��������ʱ���ŷ�����ο�ʹ���ֲ��Լ�����ʹ��
     */
    public static void testSendScheduledSMS() {
        try {
            int i = SingletonClient.getClient().sendScheduledSMSEx(new String[] { "15000000000" },
                    "�첽����", "20110430174830", "GBK");
            System.out.println("testsSendScheduledSMS=====" + i);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * ���ʹ�����ϢID�Ķ��ţ��ɲ�״̬���棩 sendSMSEx(mobiles, smsContent, addSerial, srcCharset,
     * smsPriority, smsID) 1��mobiles �ֻ����鳤�Ȳ��ܳ���1000 2��smsContent
     * ���500�����ֻ�1000����Ӣ��
     * ����ͻ���Ҫ���в�ֶ�������������ɻ��ҡ���������ƽ̨�����ʵ��ͨ���Զ���֡��Ʒ���ʵ�ʲ������Ϊ׼�������Ƽ����ų���70������
     * 3��addSerial ������(����С��15���ַ���) �û���ͨ���������Զ���������,������Զ������к���( ��ϵ������ȡ���к����б�)
     * 4��srcCharset �ַ����룬Ĭ��Ϊ"GBK" 5�����ȼ���Χ1~5����ֵԽ�����ȼ�Խ��(�����ͬһ���к�)
     * 6����ϢID����ID�������ѯ��ѯ״̬����ķ����ж��շ�����Ϣ��״̬���ɹ���ʧ�ܣ� 7��������ʱ���ŷ�����ο�ʹ���ֲ��Լ�����ʹ��
     */
    public static void testSendSMSAddMessageId() {
        try {
            int i = SingletonClient.getClient().sendSMSEx(new String[] { "15000000000" }, "������ϢID�Ķ���", "", "GBK", 5, 123456789);
            System.out.println("testsSendScheduledSMS=====" + i);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    /**
     key	�û��Զ���keyֵ�� ���Ȳ�����15���ַ��֣���������к�ע��ʱ�Ĺؼ��ֱ���һ��
     sendTime	��ʱ������֤��Ķ�ʱʱ�䣬��ʽΪ:����������������ʱʱ�ַ�����,����:20090504111010 ����2009��5��4�� 11ʱ10��10�룬������֤�����ָ����ʱ�䷢�ͳ�ȥ
     sendTimeֵΪ��ʱ��Ϊ��ʱ����������֤��
     sendTimeֵ��Ϊ��ʱ��Ϊ��ʱ����������֤��
     ͨ��ʵ��Ӧ����ʹ�õ����Ǽ�ʱ������֤�룬ʹ��ʱ������Ϊnull
     mobiles	�ֻ�����(�ַ�������,���Ϊ200���ֻ�����)
     ͨ��ʵ��Ӧ����ֻ�õ��˵�����������֤��,�����õ�һ�ֻ����뷢��
     checkCode	������֤��(��಻Ҫ����6���ַ������ٲ�ҪС��4���ַ�;�ַ�����Ϊ0��9��ȫӢ�İ�������ַ�)
     addSerial	����������֤��ʱ������ʵ��������趨Ϊnull
     srcCharset	�ַ����룬Ĭ��Ϊ"GBK"
     smsPriority	������֤��ȼ�����Χ1~5����ֵԽ�����ȼ�Խ��
     smsID	������֤������ID���Զ���Ψһ������ID������λ�����19λ����״̬����IDһһ��Ӧ�����û��Զ���ID����ȷ��ID��Ψһ�ԡ����smsIDΪ0����ȡ������Ӧ��״̬������Ϣ��
     �ò��������smsID������ͬ����������֤��֧��״̬����ʱ��ʵ������,��֮��Ӧ������״̬���������״̬����ӿڹ��á�
     */

    public static void testSendVoice() {
        try {
            String value = SingletonClient.getClient().sendVoice(new String[] { "15000000000" }, "123456", "", "GBK", 5, System.currentTimeMillis());
            System.out.println("testsSendVoice=====" + value);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * ������кų�ֵ�����������кŽ��㡢��ô���Ե��ø÷��������кų�ֵ chargeUp(String cardNo, String
     * cardPass) 1��cardNo ��ֵ������ 2��cardPass ��ֵ������ 3����ֵ�����ź���������ϵ����������Ա���
     */
    public static void testChargeUp() {
        try {
            int a = SingletonClient.getClient().chargeUp("��ֵ������", "����");
            System.out.println("testChargeUp:" + a);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * ��ҵ��ϸ��Ϣע�� registDetailInfo(String eName, String linkMan, String
     * phoneNum,String mobile, String email, String fax, String address,String
     * postcode) 1��eName ��ҵ����(���60�ֽ�) 2��linkMan ��ϵ������(���20�ֽ�) 3��phoneNum
     * ��ϵ�绰(���20�ֽ�) 4��mobile ��ϵ�ֻ�(���15�ֽ�) 5��email �����ʼ�(���60�ֽ�) 6��fax
     * ��ϵ����(���20�ֽ�) 7��address ��˾��ַ(���60�ֽ�) 8��postcode ��������(���6�ֽ�)
     * 9�����ϲ�����Ϣ��������д��ÿ������������Ϊ��
     */
    public static void testRegistDetailInfo() {
        try {

            int a = SingletonClient.getClient().registDetailInfo("��ҵ����", "��ϵ��", "01058750425",
                    "13000000000", "sjfkls@yahoo.cn", "01058750500", "��ҵ��ַ", "056900");
            System.out.println("testRegistDetailInfo:" + a);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * �޸�������к����롢ע���޸�������к������Ժ���Ҫ����ע��(����) serialPwdUpd(String serialPwd, String
     * serialPwdNew) 1��serialPwd ������ 2��serialPwdNew �����롢����Ϊ6λ�������ַ���
     */
    public static void testSerialPwdUpd() {
        try {
            int a = SingletonClient.getClient().serialPwdUpd("123456", password);
            System.out.println("testSerialPwdUpd:" + a);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ��ȡ������кŵ����
    public static void testGetBalance() {
        try {
            double a = SingletonClient.getClient().getBalance();
            System.out.println("testGetBalance:" + a);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ��ȡ����һ����������Ҫ�ķ���
    public static void testGetEachFee() {
        try {
            double a = SingletonClient.getClient().getEachFee();
            System.out.println("testGetEachFee:" + a);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 1����EUCPƽ̨�����ֻ��û����еĶ��� 2������ֵlist�е�ÿ��Ԫ��Ϊһ��Mo���� 4��Mo�������ݽṹ�ο�ʹ���ֲ�
     */
    public static void testGetMO() {
        try {
            List<Mo> a = SingletonClient.getClient().getMO();

            if (a != null) {
                System.out.println("testGetMO1size:" + a.size());
                Iterator<Mo> it = a.iterator();

                while (it.hasNext()) {
                    Mo m = it.next();
                    // ʵ������Ϊֱ�����
                    System.out.println("��������:" + m.getSmsContent());
                    System.out.println("ͨ����:" + m.getChannelnumber());
                    System.out.println("�ֻ���:" + m.getMobileNumber());
                    System.out.println("������:" + m.getAddSerialRev());
                    System.out.println("������:" + m.getAddSerial());
                    // ���ж������Ҫ����,����ҵ���߼�����,�磺�������ݿ⣬д�ļ��ȵ�
                }
            } else {
                System.out.println("NO HAVE MO");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ��ȡ״̬������Ϣ
    public static void testgetReport() {
        try {
            List<StatusReport> list = SingletonClient.getClient().getReport();
            if (list != null) {
                Iterator it = list.iterator();
                while (it.hasNext()) {
                    StatusReport report = (StatusReport) it.next();
                    System.out.println("�ֻ�����:" + report.getMobile() + "\t״̬:"
                            + report.getReportStatus() + "\t��ϢID��" + report.getSeqID());
                }
            } else {
                System.out.println("no have data");
            }
        } catch (Exception e) {
        }
    }


}
