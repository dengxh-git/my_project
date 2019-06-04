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
	 * 获取当前日期的前一天
	 * @param dateOfChar 字符串格式
	 * @return
	 * @throws Exception
	 */
	@Bizlet("获取当前日期的前一天")
	public static String getbeforeDay(String dateOfChar) throws Exception {
		Calendar calendar = getDateCalendar(dateOfChar);
		calendar.add(Calendar.DATE, -1);//得到前一天
		return new SimpleDateFormat("yyyyMMdd").format(calendar.getTime());
	}

	/**
	 * 获取当前日期的下一天
	 * @param dateOfChar 字符串格式
	 * @return
	 * @throws Exception
	 */
	@Bizlet("获取当前日期的下一天")
	public static String getnextDay(String dateOfChar) throws Exception {
		Calendar calendar = getDateCalendar(dateOfChar);
		calendar.add(Calendar.DATE, 1);//得到下一天
		return new SimpleDateFormat("yyyyMMdd").format(calendar.getTime());
	}

	/**
	 * 获取当前日期的下一年
	 * @param dateOfChar 字符串格式
	 * @return
	 * @throws Exception
	 */
	@Bizlet("获取当前日期的下一年")
	public static String getnextyear(String dateOfChar) throws Exception {
		Calendar calendar = getDateCalendar(dateOfChar);
		calendar.add(Calendar.YEAR, 1);//得到明年
		return new SimpleDateFormat("yyyyMMdd").format(calendar.getTime());
	}

	/**
	 * 获取当前日期的前一年
	 * @param dateOfChar 字符串格式
	 * @return
	 * @throws Exception
	 */
	@Bizlet("获取当前日期的前一年")
	public static String getlastyear(String dateOfChar) throws Exception {
		Calendar calendar = getDateCalendar(dateOfChar);
		calendar.add(Calendar.YEAR, -1);//得到去年
		return new SimpleDateFormat("yyyyMMdd").format(calendar.getTime());
	}

	/**
	 * 日期字符串，返回一个Calendar的日期对象
	 * @param datetime    日期字符串
	 * @param pattern	  格式（yyyy-MM-dd 、yyyyMMdd）
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
			throw new Exception(datetime + "格式不对，必须是yyyy-MM-dd 、 yyyyMMdd 格式");
		} catch (Exception ex) {

			throw ex;
		}
	}

	/**
	 * 默认时间字符串格式为yyyyMMdd
	 * @param datetime
	 * @return
	 * @throws Exception
	 */
	private static Calendar getDateCalendar(String datetime) throws Exception {
		return getDateCalendar(datetime, "yyyyMMdd");
	}

	/**
	 * 精确到毫秒的时间格式yyyyMMddHHmmss
	 * @return
	 */
	@Bizlet("获取格式到秒当前日期")
	public static String formatDateToMill(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String dateString = sdf.format(date);
		return dateString;
	}

}
