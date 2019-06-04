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
	 * 默认2位精度
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
	 * @param scale int 小数后的精度
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
	 * 数字格式化 默认格式符###0.00
	 * @param value 需要格式化的值
	 * @return
	 */
	@Bizlet("")
	public static String formatToNum(double value) {
		return formatToNum(value, "###0.00");
	}

	/**
	 * 数字格式化
	 * @param value 需要格式化的值
	 * @param formatStr 格式符
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
	 * 字符串格式数字格式转换
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
	 * 字符串格式数字格式转换
	 * @param value String
	 * @param defaultstr String
	 * @param formatStr  String 格式
	 * @return String
	 */
	@Bizlet("字符串格式数字格式转换")
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
	 * 添加精度设置
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
	 * 转换成整数，如果非整数则返回默认值
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
	 * 转换成整数，如果非整数则返回0
	 * @param value
	 * @return
	 */
	public static String toInteger(String value) {
		return toInteger(value, "0");
	}

}
