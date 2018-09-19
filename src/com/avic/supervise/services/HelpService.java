package com.avic.supervise.services;

import java.util.List;

import com.avic.supervise.models.Help;

public interface HelpService {
	/**
	 * ��ѯ���������б�
	 * @return 
	 */
	public List<Help> queryHelps(Help help);
	/**
	 * ���ݰ�����Ϣid��ѯ������Ϣ
	 * @return 
	 */
	public Help queryHelpById(Help help);
	/**
	 * ���Ӱ���������Ϣ
	 * @return 
	 */
	public void addHelp(Help help);
	/**
	 * �޸İ���������Ϣ
	 * @return 
	 */
	public void updateHelp(Help help);
	/**
	 * ���û�ͣ�ð�������
	 * @return 
	 */
	public void updateHelpStatus(Help help);
	
	/**
	 * ɾ����������
	 * @return 
	 */
	public void deleteHelp(Help help);
	/**
	 * ��ѯ������������
	 * @return 
	 */
	public int queryHelpCount(Help help);
	
	public int queryFileEx(Help help);
}