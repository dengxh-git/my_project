/*******************************************************************************
 * $Header$
 * $Revision$
 * $Date$
 *
 *==============================================================================
 *
 * Copyright (c) 2001-2006 Primeton Technologies, Ltd.
 * All rights reserved.
 * 
 * Created on 2011-9-11
 *******************************************************************************/

package com.sunline.sunfi.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.eos.system.annotation.Bizlet;

@Bizlet("")
public class DateUtils {

	/**
	 * ��ȡ��ǰ���ڵ�ǰһ��
	 * @param dateOfChar �ַ�����ʽ
	 * @return
	 * @throws Exception
	 */
	@Bizlet("��ȡ��ǰ���ڵ�ǰһ��")
	public static String getbeforeDay(String dateOfChar) throws Exception {
		Calendar calendar = getDateCalendar(dateOfChar);
		calendar.add(Calendar.DATE, -1);//�õ�ǰһ��
		return new SimpleDateFormat("yyyyMMdd").format(calendar.getTime());
	}

	/**
	 * ��ȡ��ǰ���ڵ���һ��
	 * @param dateOfChar �ַ�����ʽ
	 * @return
	 * @throws Exception
	 */
	@Bizlet("��ȡ��ǰ���ڵ���һ��")
	public static String getnextDay(String dateOfChar) throws Exception {
		Calendar calendar = getDateCalendar(dateOfChar);
		calendar.add(Calendar.DATE, 1);//�õ���һ��
		return new SimpleDateFormat("yyyyMMdd").format(calendar.getTime());
	}

	/**
	 * ��ȡ��ǰ���ڵ���һ��
	 * @param dateOfChar �ַ�����ʽ
	 * @return
	 * @throws Exception
	 */
	@Bizlet("��ȡ��ǰ���ڵ���һ��")
	public static String getnextyear(String dateOfChar) throws Exception {
		Calendar calendar = getDateCalendar(dateOfChar);
		calendar.add(Calendar.YEAR, 1);//�õ�����
		return new SimpleDateFormat("yyyyMMdd").format(calendar.getTime());
	}

	/**
	 * ��ȡ��ǰ���ڵ�ǰһ��
	 * @param dateOfChar �ַ�����ʽ
	 * @return
	 * @throws Exception
	 */
	@Bizlet("��ȡ��ǰ���ڵ�ǰһ��")
	public static String getlastyear(String dateOfChar) throws Exception {
		Calendar calendar = getDateCalendar(dateOfChar);
		calendar.add(Calendar.YEAR, -1);//�õ�ȥ��
		return new SimpleDateFormat("yyyyMMdd").format(calendar.getTime());
	}

	/**
	 * �����ַ���������һ��Calendar�����ڶ���
	 * @param datetime    �����ַ���
	 * @param pattern	  ��ʽ��yyyy-MM-dd ��yyyyMMdd��
	 * @return
	 * @throws Exception
	 */
	private static Calendar getDateCalendar(String datetime, String pattern)
			throws Exception {
		try {
			SimpleDateFormat df = new SimpleDateFormat(pattern);
			Date date = df.parse(datetime);
			Calendar cd = Calendar.getInstance();
			cd.setTime(date);
			return cd;
		} catch (ParseException pe) {
			throw new Exception(datetime + "��ʽ���ԣ�������yyyy-MM-dd �� yyyyMMdd ��ʽ");
		} catch (Exception ex) {

			throw ex;
		}
	}

	/**
	 * Ĭ��ʱ���ַ�����ʽΪyyyyMMdd
	 * @param datetime
	 * @return
	 * @throws Exception
	 */
	private static Calendar getDateCalendar(String datetime) throws Exception {
		return getDateCalendar(datetime, "yyyyMMdd");
	}

	/**
	 * ��ȷ�������ʱ���ʽyyyyMMddHHmmss
	 * @return
	 */
	@Bizlet("��ȡ��ʽ���뵱ǰ����")
	public static String formatDateToMill(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String dateString = sdf.format(date);
		return dateString;
	}

}
