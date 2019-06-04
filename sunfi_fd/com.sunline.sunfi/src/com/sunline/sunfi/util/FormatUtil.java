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
 * Created on 2010-10-21
 *******************************************************************************/

package com.sunline.sunfi.util;

import java.text.DecimalFormat;

import com.eos.system.annotation.Bizlet;

@Bizlet("")
public class FormatUtil {

	/**
	 * Ĭ��2λ����
	 * @param value String
	 * @param defaultstr String
	 * @return String
	 */
	public static String decimalFormat(String value, String defaultstr) {

		return decimalFormat(value, defaultstr, 2);
	}

	/**
	 *
	 * @param value String
	 * @param defaultstr String
	 * @param scale int С����ľ���
	 * @return String
	 */
	public static String decimalFormat(String value, String defaultstr,
			int scale) {

		if (value == null) {
			return defaultstr;
		}
		try {
			DecimalFormat d = new DecimalFormat("#,##0.00");
			return d.format(Double.parseDouble(value));
		} catch (Exception e) {
			return defaultstr;
		}
	}

	/**
	 * ���ָ�ʽ�� Ĭ�ϸ�ʽ��###0.00
	 * @param value ��Ҫ��ʽ����ֵ
	 * @return
	 */
	@Bizlet("")
	public static String formatToNum(double value) {
		return formatToNum(value, "###0.00");
	}

	/**
	 * ���ָ�ʽ��
	 * @param value ��Ҫ��ʽ����ֵ
	 * @param formatStr ��ʽ��
	 * @return
	 */
	@Bizlet("")
	public static String formatToNum(double value, String formatStr) {
		if (formatStr == null || "".equals(formatStr.trim())) {
			formatStr = "#,##0.00";
		}
		try {
			DecimalFormat d = new DecimalFormat(formatStr);
			return d.format(value);
		} catch (Exception e) {
			return "0.00";
		}
	}

	/**
	 * �ַ�����ʽ���ָ�ʽת��
	 * @param value
	 * @param defaultstr
	 * @return
	 */
	public static String formatToNum(String value, String defaultstr) {

		if (value == null) {
			return defaultstr;
		}
		try {
			DecimalFormat d = new DecimalFormat("###0.00");
			return d.format(Double.parseDouble(value));
		} catch (Exception e) {
			return defaultstr;
		}
	}

	/**
	 * �ַ�����ʽ���ָ�ʽת��
	 * @param value String
	 * @param defaultstr String
	 * @param formatStr  String ��ʽ
	 * @return String
	 */
	@Bizlet("�ַ�����ʽ���ָ�ʽת��")
	public static String formatToNum(String value, String defaultstr,
			String formatStr) {

		if (value == null) {
			return defaultstr;
		}
		if (formatStr == null || "".equals(formatStr.trim())) {
			formatStr = "#,##0.00";
		}
		try {
			DecimalFormat d = new DecimalFormat(formatStr);
			return d.format(Double.parseDouble(value));
		} catch (Exception e) {
			return defaultstr;
		}
	}

	/**
	 * ��Ӿ�������
	 * @param value String
	 * @param scale int
	 * @return String
	 */
	public static String decimalFormat(String value, int scale) {
		return decimalFormat(value, "0", scale);
	}

	public static String decimalFormat(String value) {
		return decimalFormat(value, "0");
	}

	/**
	 * ת��������������������򷵻�Ĭ��ֵ
	 * @param value String
	 * @param defaultstr String
	 * @return String
	 */
	public static String toInteger(String value, String defaultstr) {

		if (value == null) {
			return defaultstr;
		}
		try {
			return Integer.parseInt(value) + "";
		} catch (Exception e) {
			return defaultstr;
		}
	}

	/**
	 * ת��������������������򷵻�0
	 * @param value
	 * @return
	 */
	public static String toInteger(String value) {
		return toInteger(value, "0");
	}

}
