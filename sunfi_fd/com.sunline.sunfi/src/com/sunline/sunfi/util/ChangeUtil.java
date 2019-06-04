/*******************************************************************************
 * $Header$
 * $Revision$ v1.2
 * $Date$ 2010-08-28
 *
 *==============================================================================
 *
 * Copyright (c) 2001-2010 sunliune Technologies, Ltd.
 * All rights reserved.
 * 
 * Created on 2010-8-28
 *******************************************************************************/

package com.sunline.sunfi.util;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.StringTokenizer;
import java.util.Vector;


/**
 * 
 * ת��������
 *
 */

public class ChangeUtil {
	/**
	 * ʱ���ʽ(�����գ�
	 */
	public static final String DATE_FORMAT_YMD = "yyyyMMdd";
	/**
	 * ʱ���ʽ�����£�
	 */
	public static final String DATE_FORMAT_YM = "yyyyMM";
	/**
	 * ʱ���ʽ���꣩
	 */
	public static final String DATE_FORMAT_Y = "yyyy";
	
	public static final String DATE_FORMAT_YMD_HMS="yyyy-MM-dd HH:mm:ss";
	
	/**
	 * ChangeUtil���ȱʡ��������
	 */
	private ChangeUtil() {
	}
	
	/**
	 * ��һ����','�ָ���ַ�����ת��Ϊһ��Vector��������changeStringToVector(String str, String token)�ļ򻯰汾��
	 * 
	 * @param _str ��Ҫת�����ַ���
	 * @return �������ַ�����Ԫ�ص�Vector����
	 * @see #changeStringToVector
	 */
	public static Vector changeStringToVector(String _str){
		return changeStringToVector(_str, ",");
	}
	/**
	 * ��һ�����ַ���token�ָ���ַ�����ת��Ϊһ��Vector������"����[token]����"��ת��Ϊһ��Vector����Vector��������Ԫ�أ���һ����"����"���ڶ�����"����"��
	 * 
	 * @param _str ��Ҫת�����ַ���
	 * @param _token �ַ����зָ��token����ո�" "����":"�ȡ�
	 * @return �������ַ�����Ԫ�ص�Vector����
	 */
	public static Vector changeStringToVector(String _str, String _token) {
		if( _str== null) {
			return null;
		}
		
		Vector<String> temp = new Vector<String>();
		StringTokenizer st = new StringTokenizer(_str, _token);
		while (st.hasMoreTokens()) {
			temp.add(st.nextToken());
		}
		return temp;
	}
	/**
	 * ��һ��Vector�����б�����ַ���Ԫ��ʹ��","�ָ���ת��Ϊһ���ַ���������public static Vector changeStringToVector(String str)���������
	 * 
	 * @param _v �������ַ�������Ԫ�ص�Vector����
	 * @return һ����","Ϊ�ָ������ַ���
     */
	public static String changeVectorToString(Vector _v) {
		return changeVectorToString(_v, ",");
	}
	/**
	 * ��һ��Vector�����б�����ַ���Ԫ��ʹ��token�ָ���ת��Ϊһ���ַ���������public static Vector changeStringToVector(String str, String token)���������
	 * 
	 * @param _v �������ַ�������Ԫ�ص�Vector����
	 * @param _token �ַ����зָ��token����ո�" "����":"�ȡ�
	 * @return һ����tokenΪ�ָ������ַ���
	 */
	public static String changeVectorToString(Vector _v, String _token) {
		if( _v == null) {
			return null;
		}
		Enumeration enumeration = _v.elements();
		String str = "";
		while (enumeration.hasMoreElements()) {
			str = str + (String) (enumeration.nextElement()) + _token;
		}
		str = str.substring(0, str.length() - 1);
		return str;
	}
	/**
	 * ��һ���ַ��������б�����ַ���Ԫ��ʹ��","�ָ���ת��Ϊһ���ַ�����
	 * 
	 * @param _strArray �������ַ�������Ԫ�ص��ַ�������
	 * @return һ����","Ϊ�ָ������ַ���
	 * @see #changeArrayToString
	 */
	public static String changeArrayToString(String[] _strArray) {
		return changeArrayToString(_strArray, ",");
	}
	/**
	 * ��һ���ַ��������б�����ַ���Ԫ��ʹ��token�ָ���ת��Ϊһ���ַ���������public static Vector changeStringToVector(String str, String token)���������
	 * 
	 * @param _strArray �������ַ�������Ԫ�ص��ַ�������
	 * @param _token �ָ��ַ���ʹ�õķָ�����
	 * @return һ����tokenΪ�ָ������ַ���
	 */
	public static String changeArrayToString(String[] _strArray,String _token) {
		if( _strArray == null) {
			return null;
		}

		int size = _strArray.length;
		if (size == 0) {
			return null;
		} else if (size == 1) {
			return _strArray[0];
		} else {
			String temp = _strArray[0];
			for (int i = 1; i < size; i++) {
				temp = temp + _token + _strArray[i];
			}
			return temp;
		}
	}
	/**
	 * ��һ��ʹ��","�ָ����ָ����ַ�����ת��Ϊһ���ַ������顣
	 * 
	 * @param _str ��token�ָ����ָ����ַ���
	 * @return �ַ�������
	 */
	public static String[] changeStringToArray(String _str) {
		return changeStringToArray(_str, ",");
	}
	/**
	 * ��һ��ʹ��token�ָ����ָ����ַ�����ת��Ϊһ���ַ������顣
	 * 
	 * @param _str ��token�ָ����ָ����ַ���
	 * @param _token �ַ����ķָ���
	 * @return �ַ�������
	 */
	public static String[] changeStringToArray(String _str, String _token) {
		if( _str ==null) {
			return null;
		}

		Vector v = changeStringToVector(_str, _token);
		String[] strArray = new String[v.size()];
		int i = 0;
		for (Enumeration em = v.elements(); em.hasMoreElements(); i++) {
			strArray[i] = (String) em.nextElement();
		}
		return strArray;
	}
	/**
	 * ����Բ���_fromDateΪ����������
	 * 
	 * @param _birthday ����
	 * @param _fromDate ����ʱ��
	 * @return ���䣨�����꣭�����꣩
	 */
	public static int getAgeFromBirthday(java.util.Date _birthday,java.util.Date _fromDate) {
		Calendar calendar =  Calendar.getInstance();
		calendar.setTime(_birthday);
		int birthdayYear = calendar.get(Calendar.YEAR);
		int birthdayMonth = calendar.get(Calendar.MONTH);
		int birthdayDay = calendar.get(Calendar.DAY_OF_MONTH);
		calendar.clear();
		calendar.setTime(_fromDate);
		int currentYear = calendar.get(Calendar.YEAR);
		int currentMonth = calendar.get(Calendar.MONTH);
		int currentDay = calendar.get(Calendar.DAY_OF_MONTH);
		calendar.clear();
		int age = currentYear - birthdayYear;
		if (!((currentMonth >= birthdayMonth)&& (currentDay >= birthdayDay))) {
			age--;
		}
		return age;
	}
	/**
	 * ��õ�ǰ����
	 * 
	 * @param _birthday ����
	 * @return ���䣨�����꣭�����꣩
	 */
	public static int getAgeFromBirthday(java.util.Date _birthday) {
		return getAgeFromBirthday(_birthday,new java.util.Date(System.currentTimeMillis()));
	}
	/**
	 * ��õ�ǰ����
	 * 
	 * @param _birthday ����
	 * @return ���䣨�����꣭�����꣩
	 */
	public static int getAgeFromBirthday(java.sql.Timestamp _birthday) {
		return getAgeFromBirthday(new java.util.Date(_birthday.getTime()),new java.util.Date(System.currentTimeMillis()));
	}
	/**
	 * ʹ�ø�ʽ{@link #DATE_FORMAT_YMD}��ʽ���������
	 * 
	 * @param _date ���ڶ���
	 * @return ��ʽ���������
	 */
	public static String formatDate(java.util.Date _date) {
		return formatDate(_date, DATE_FORMAT_YMD);
	}
	/**
	 * ʹ�ø�ʽ<b>_pattern</b>��ʽ���������
	 * 
	 * @param _date ���ڶ���
	 * @param _pattern ���ڸ�ʽ
	 * @return ��ʽ���������
	 */
	public static String formatDate(java.util.Date _date, String _pattern) {
		if( _date == null) {
			return null;
		}
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(_pattern);
		String stringDate = simpleDateFormat.format(_date);
		return stringDate;
	}
	/**
	 * ʹ�������ַ��Լ򵥵���ʽ��"�� �� ��"����ʽ��ʱ�䴮
	 * 
	 * @param _date ���ڶ���
	 * @return ��ʽ���������
	 */
	public static String simplefFormatChineseDate(java.util.Date _date) {
		if( _date == null) {
			return null;
		}
		Calendar calendar =  Calendar.getInstance();
		calendar.setTime(_date);
		StringBuffer sb = new StringBuffer();
		sb.append(calendar.get(Calendar.YEAR))
			.append("��")
			.append(calendar.get(Calendar.MONTH) + 1)
			.append("��")
			.append(Calendar.DAY_OF_MONTH)
			.append("��");
		calendar.clear();
		return sb.toString();
	}
	/**
	 * ʹ�������ַ��Ը��ӵ���ʽ��"�� �� �� ���� ʱ �� ��"����ʽ��ʱ�䴮
	 * 
	 * @param _date ���ڶ���
	 * @return ��ʽ���������
	 */
	public static String complexFormatChineseDate(java.util.Date _date) {
		if( _date == null) {
			return null;
		}
		Calendar calendar =  Calendar.getInstance();
		calendar.setTime(_date);
		StringBuffer sb = new StringBuffer();
		sb.append(calendar.get(Calendar.YEAR))
			.append("��")
			.append(calendar.get(Calendar.MONTH) + 1)
			.append("��")
			.append(Calendar.DAY_OF_MONTH)
			.append("��")
			.append(Calendar.HOUR_OF_DAY)
			.append("ʱ")
			.append(Calendar.MINUTE)
			.append("��")
			.append(Calendar.SECOND)
			.append("��");
		calendar.clear();
		return sb.toString();
	}
	/**
	 * ��ʱ�䴮ת��Ϊʱ������������<b>_dateStr</b>������ѭ��ʽ{@link #DATE_FORMAT_YMD}
	 * 
	 * @param _dateStr ʱ�䴮
	 * @return ʱ�����
	 */
	public static java.util.Date changeToDate(String _dateStr) throws IllegalArgumentException{
		return changeToDate(_dateStr, DATE_FORMAT_YMD);
	}
	/**
	 * ��ʱ�䴮ת��Ϊʱ�����
	 * 
	 * @param _dateStr ʱ�䴮
	 * @param _pattern ʱ�䴮ʹ�õ�ģʽ
	 * @return ʱ�����
	 * @throws ParamValidateException �������ʱ�䴮����ʹ�õ�ģʽ��ƥ��ʱ����
	 */
	public static java.util.Date changeToDate(String _dateStr,String _pattern) throws IllegalArgumentException  {
		if (_dateStr == null || _dateStr.trim().equals("")) {
			return null;
		}
		java.util.Date date = null;
		SimpleDateFormat format = new SimpleDateFormat(_pattern);
		try {
			date = format.parse(_dateStr);
		} catch (java.text.ParseException pe) {
			throw new IllegalArgumentException("����ʹ��ģʽ:[" + _pattern + "]��ʽ��ʱ�䴮:[" + _dateStr + "]");
		}
		return date;
	}
	/**
	 * ��ʱ�䴮ת��Ϊ���ݿ�ʱ������������<b>_dateStr</b>������ѭ��ʽ{@link #DATE_FORMAT_YMD}
	 * 
	 * @param _dateStr ʱ�䴮
	 * @return ���ݿ�ʱ�����
	 */
	public static java.sql.Date changeToDBDate(String _dateStr) throws IllegalArgumentException{
		return changeForDBDate(changeToDate(_dateStr, DATE_FORMAT_YMD));
	}
	/**
	 * ��ʱ�䴮ת��Ϊ���ݿ�ʱ�����
	 * 
	 * @param _dateStr ʱ�䴮
	 * @param _pattern ʱ�䴮ʹ�õ�ģʽ
	 * @return ʱ�����
	 * @throws ParamValidateException �������ʱ�䴮����ʹ�õ�ģʽ��ƥ��ʱ����
	 */
	public static java.sql.Date changeToDBDate(String _dateStr,String _pattern) throws IllegalArgumentException {
		return changeForDBDate(changeToDate(_dateStr, _pattern));
	}
	/**
	 * ��java.util.Date����ת��Ϊjava.sql.Date����
	 * 
	 * @param _date ��ת����java.util.Date ����
	 * @return java.sql.Date����
	 */
	public static java.sql.Date changeForDBDate(java.util.Date _date) {
		if (_date == null) {
			return null;
		}
		return new java.sql.Date(_date.getTime());
	}
	/**
	 * ��java.sql.Date����ת��Ϊjava.util.Date����
	 * 
	 * @param _date ��ת����java.sql.Date����
	 * @return java.util.Date����
	 */
	public static java.util.Date changFromDBDate(java.sql.Date _date) {
		return (java.util.Date) _date;
	}
	/**
	 * ��java.util.Date����ת��Ϊjava.sql.Timestamp����
	 * 
	 * @param _date ��ת����java.util.Date ����
	 * @return java.sql.Timestamp����
	 */
	public static java.sql.Timestamp changeToTimestamp(java.util.Date _date) {
		if (_date == null) {
			return null;
		}
		return new java.sql.Timestamp(_date.getTime());
	}
	/**
	 * ��java.sql.Timestamp����ת��Ϊjava.util.Date����
	 * 
	 * @param _date ��ת����java.sql.Timestamp ����
	 * @return java.util.Date ����
	 */
	public static java.util.Date changeFromTimestamp(java.sql.Timestamp _date) {
		return (java.util.Date) _date;
	}
	/**
	 * �ı��ַ����ı��뷽ʽ(ISO8859_1)Ϊ(GBK)����֧������
	 * 
	 * @param _str ��ת����ַ���
	 * @return ����GBK������ַ���
	 */
	public static String changeToGB(String _str) throws Exception{
		if( _str == null) {
			return null;
		}
		String gbStr = null;
		try {
			gbStr = new String(_str.getBytes("ISO8859_1"), "GBK");
		} catch (Exception e) {
			throw e;
		}
		return gbStr;
	}
	/**
	 * �ı��ַ����ı��뷽ʽ(GBK)Ϊ(ISO8859_1)
	 * 
	 * @param _str ��ת����ַ���
	 * @return ����ISO8859_1������ַ���
	 */
	public static String changeFromGB(String _str)throws Exception {
		if( _str == null) {
			return null;
		}
		String isoStr = null;
		try {
			isoStr = new String(_str.getBytes("GBK"), "ISO8859_1");
		} catch (Exception e) {
			throw e;
		}
		return isoStr;
	}
	/**
	 * ������ڵ���
	 * 
	 * @param _date ���ڶ���
	 * @return ���ڵ���
	 */
	public static int getYear(java.util.Date _date) {
		
		Calendar calendar =  Calendar.getInstance();
		calendar.setTime(_date);
		int year = calendar.get(Calendar.YEAR);
		calendar.clear();
		return year;
	}
	/**
	 * ������ڵ���
	 * 
	 * @param _date ���ڶ���
	 * @return ���ڵ���
	 */
	public static int getMonth(java.util.Date _date) {
		Calendar calendar =  Calendar.getInstance();
		calendar.setTime(_date);
		// ��0��ʼ
		int month = calendar.get(Calendar.MONTH);
		calendar.clear();
		return (month + 1);
	}
	/**
	 * ������ڵ��죬����Ϊ��
	 * 
	 * @param _date ���ڶ���
	 * @return ���ڵ���
	 */
	public static int getDay(java.util.Date _date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(_date);
		int day = calendar.get(Calendar.DAY_OF_MONTH);
		calendar.clear();
		return day;
	}
	/**
	 * ������ڵ�Сʱ
	 * 
	 * @param _date ���ڶ���
	 * @return ���ڵ�Сʱ
	 */
	public static int getHours(java.util.Date _date) {
		Calendar calendar =  Calendar.getInstance();
		calendar.setTime(_date);
		int value = calendar.get(Calendar.HOUR);
		calendar.clear();
		return value;
	}
	/**
	 * ������ڵķ���
	 * 
	 * @param _date ���ڶ���
	 * @return ���ڵķ���
	 */
	public static int getMinutes(java.util.Date _date) {
		Calendar calendar =  Calendar.getInstance();
		calendar.setTime(_date);
		int value = calendar.get(Calendar.MINUTE);
		calendar.clear();
		return value;
	}
	/**
	 * ������ڵ�С��
	 * 
	 * @param _date ���ڶ���
	 * @return ���ڵ���
	 */
	public static int getSeconds(java.util.Date _date) {
		Calendar calendar =  Calendar.getInstance();
		calendar.setTime(_date);
		int value = calendar.get(Calendar.SECOND);
		calendar.clear();
		return value;
	}
	/**
	 * �����������ڼ����������
	 * 
	 * @param _startDate ��ʼ����
	 * @param _endDate ��ֹ����
	 * @return �������, ������Ϊ����ʾ<b>_endDate</b>��<b>_startDate</b>֮��������Ϊ����ʾ<b>_endDate</b>��<b>_startDate</b>֮ǰ��������Ϊ0��ʾ<b>_endDate</b>��<b>_startDate</b>��ͬһ�졣
	 */
	public static int getDayCount(java.util.Date _startDate,java.util.Date _endDate) {
		Calendar calendar =  Calendar.getInstance();
		calendar.setTime(_startDate);
		int startDay = calendar.get(Calendar.DAY_OF_YEAR);
		int startYear = calendar.get(Calendar.YEAR);
		calendar.clear();
		calendar.setTime(_endDate);
		int endDay = calendar.get(Calendar.DAY_OF_YEAR);
		int endYear = calendar.get(Calendar.YEAR);
		calendar.clear();
		return (endYear - startYear) * 365 + (endDay - startDay);
	}
	/**
	 * �������Date�������, ��������14����1����
	 * 
	 * @param _startDate ��ʼʱ��
	 * @param _endDate ����ʱ��
	 * @return ����Date�������
	 */
	public static int getMonthAmount(java.sql.Date _startDate,java.sql.Date _endDate) {
		int nYear = 0;
		int nMonth = 0;
		int nDay = 0;
		int nMonthAmount = 0;
		Calendar cldStart = Calendar.getInstance();
		Calendar cldEnd = Calendar.getInstance();
		cldStart.setTime(_startDate);
		cldEnd.setTime(_endDate);
		nYear = cldEnd.get(Calendar.YEAR) - cldStart.get(Calendar.YEAR);
		nMonth = cldEnd.get(Calendar.MONTH) - cldStart.get(Calendar.MONTH);
		nDay = cldEnd.get(Calendar.DATE) - cldStart.get(Calendar.DATE);
		if (nDay > 14) {
			nMonthAmount = nYear * 12 + nMonth + 1;
		} else {
			nMonthAmount = nYear * 12 + nMonth;
		}
		return nMonthAmount;
	}
	/**
	 * ��ʽ����������
	 * 
	 * @param _inStrObj �������ִ�����
	 * @return ��������
	 */
	public static long toLong(Object _inStrObj) {
		if (_inStrObj == null || _inStrObj.toString().trim().equals("")) {
			return 0;
		} else {
			return Long.valueOf(_inStrObj.toString()).longValue();
		}
	}
	/**
	 * ��ʽ��������
	 * 
	 * @param _inStrObj �������ִ�����
	 * @return ������
	 */
	public static int toInteger(Object _inStrObj) {
		if (_inStrObj == null || _inStrObj.toString().trim().equals("")) {
			return 0;
		} else {
			return new Integer(_inStrObj.toString()).intValue();
		}
	}
	/**
	 * ��ʽ��˫��������
	 * 
	 * @param _inStrObj ˫���������ִ�����
	 * @return ˫���ȸ�������
	 */
	public static double toDouble(Object _inStrObj) {
		if (_inStrObj == null || _inStrObj.toString().trim().equals("")) {
			return 0;
		} else {
			return Double.valueOf(_inStrObj.toString()).doubleValue();
		}
	}
	/**
	 * ��ʽ��������
	 * 
	 * @param _inStrObj �������ִ�����
	 * @return ��������������ݸ�ʽ���󣬻��ִ�Ϊ�գ��ⷵ��0
	 */
	public static float toFloat(Object _inStrObj) {
		if (_inStrObj == null || _inStrObj.toString().trim().equals("")) {
			return 0;
		} else {
			return Float.valueOf(_inStrObj.toString()).floatValue();
		}
	}
	/**
	 * ���ֽ�������ñ���<b>_encoding</b>ת��Ϊ�ַ���
	 * 
	 * @param _bytes �ֽ�����
	 * @param _encoding ���뷽ʽ
	 * @throws ParamValidateException ������뷽ʽ��֧��ʱ����
	 * @return �ַ���
	 */
	public static String toStr(byte[] _bytes, String _encoding) throws IllegalArgumentException{
		if( _bytes == null) {
			return null;
		}
		
		String s = null;
		try {
			s = new String(_bytes, _encoding);
		} catch (Exception e) {
			throw new IllegalArgumentException("Don't support the encoding:" + _encoding);
		}
		return s;
	}
	/**
	 * ��ʽ����������
	 * 
	 * @param _boolean ��������
	 * @return ���������ֵ�����<b>_boolean</b>Ϊnull, ����false
	 */
	public static boolean toBoolean(Boolean _boolean) {
		if (_boolean == null) {
			return false;
		} else {
			return _boolean.booleanValue();
		}
	}
	/**
	 * ��ö�����ַ�����ʾ�� ��<b>_obj</b>Ϊnullʱ��<b>_replaceStr</b>���
	 * 
	 * @param _obj ����
	 * @param _replaceStr ���nullֵ���ַ���
	 * @return �������ַ���
	 */
	public static String toStr(Object _obj, String _replaceStr) {
		if (_obj == null) {
			return _replaceStr;
		} else {
			return _obj.toString();
		}
	}
	
	/**
	 * �ַ������� ��<b>_str</b>Ϊnullʱ��<b>_replaceStr</b>���
	 * 
	 * @param _str ԭʼ�ַ���
	 * @param _replaceStr ���nullֵ���ַ���
	 * @return �������ַ���
	 */
	public static String toStr(String _str, String _replaceStr) {
		if (_str == null||_str.equals("null")) {
			return _replaceStr;
		} else {
			return _str;
		}
	}
	/**
	 * �ַ������� ��<b>_str</b>Ϊnullʱ��<b>""</b>���
	 * 
	 * @param _str ԭʼ�ַ���
	 * @return �������ַ���
	 */
	public static String toStr(String _str) {
		return toStr(_str, "");
	}
	/**
	 * ��ö�����ַ�����ʾ�� ��<b>_obj</b>Ϊnullʱ��<b>""</b>���
	 * 
	 * @param _obj ����
	 * @return ��ö�����ַ���
	 */
	public static String toStr(Object _obj) {
		if(_obj==null) {
			return "";
		}else{
			return toStr(_obj.toString());
		}
	}
	/**
	 * ���ַ������ñ���<b>_encoding</b>ת��Ϊ�ֽ�����
	 * 
	 * @param _str �ַ���
	 * @param _encoding ���뷽ʽ
	 * @throws ParamValidateException ������뷽ʽ��֧��ʱ����
	 * @return �ֽ�����
	 */
	public static byte[] toBytes(String _str, String _encoding) throws IllegalArgumentException{
		if( _str == null) {
			return null;
		}
		byte[] b = null;
		try {
			b = _str.getBytes(_encoding);
		} catch (Exception e) {
			throw new IllegalArgumentException("Don't support the encoding:" + _encoding);
		}
		return b;
	}
	/**
	 * ��˫������������Ľ��ת�����Ĵ�д��ʽ
	 * 
	 * @param _dMoney ����˫���������Ľ��
	 * @return �������Ĵ�д��ʽ������������<b>dMoney</b>����10^8��С��0.01���ؿմ���
	 */
	public static String toChinese(double _dMoney) {
		String[] strArr = { "��", "Ҽ", "��", "��", "��", "��", "½", "��", "��", "��" };
		String[] strArr1 = { "��", "��", "Բ", "ʰ", "��", "Ǫ", "��", "ʰ", "��", "Ǫ" };
		String[] strArr2 = new String[10];
		String sRtn = "";
		int iTmp;
		double dTmp;
		try {
			_dMoney += 0.001;
			if ((_dMoney >= 100000000) || (_dMoney < 0.01)) {
				sRtn = "";
			} else {
				for (int i = 0; i < 10; i++) {
					dTmp = _dMoney / Math.pow(10, 7 - i);
					iTmp = (new Double(dTmp)).intValue();
					_dMoney -= iTmp * Math.pow(10, 7 - i);
					if (iTmp != 0) {
						strArr2[i] = strArr[iTmp] + strArr1[9 - i];
					} else {
						strArr2[i] = "";
					}
				}
				boolean bFlag = false;
				for (int i = 0; i < 10; i++) {
					if (!"".equals(strArr2[i])) {
						sRtn += strArr2[i];
						bFlag = true;
					} else {
						if (i == 3) {
							sRtn += "��";
							bFlag = true;
						} else if (i == 7) {
							sRtn += "Բ";
							bFlag = true;
						} else if (bFlag) {
							sRtn += "��";
							bFlag = false;
						}
					}
				}
				if (sRtn.startsWith("��")) {
					sRtn = sRtn.substring(1, sRtn.length());
				}
				if (sRtn.startsWith("Բ")) {
					sRtn = sRtn.substring(1, sRtn.length());
				}
				while (sRtn.startsWith("��")) {
					sRtn = sRtn.substring(1, sRtn.length());
				}
				if (sRtn.lastIndexOf("��") == (sRtn.length() - 1)) {
					sRtn = sRtn.substring(0, sRtn.length() - 1);
				}
				if (sRtn.startsWith("Բ")) {
					sRtn = sRtn.substring(1, sRtn.length());
				}
				iTmp = sRtn.indexOf("Բ");
				if (iTmp != -1) {
					if ("��".equals(sRtn.substring(iTmp - 1, iTmp))) {
						sRtn =
							sRtn.substring(0, iTmp - 1)
								+ sRtn.substring(iTmp, sRtn.length());
					}
				}
				iTmp = sRtn.indexOf("��");
				if (iTmp != -1) {
					if ("��".equals(sRtn.substring(iTmp - 1, iTmp))) {
						sRtn =
							sRtn.substring(0, iTmp - 1)
								+ sRtn.substring(iTmp, sRtn.length());
					}
				}
				while (sRtn.startsWith("��")) {
					sRtn = sRtn.substring(1, sRtn.length());
				}
				sRtn += "��";
			}
		} catch (Exception ex) {
		}
		return sRtn;
	}
	/**
	 * ���������String����BigDecimal��������String�����ִ�������null
	 * 
	 * @param _str  ��ת�����ַ���
	 * @return BigDecimal����
	 */
	public static BigDecimal toBigDecimal(String _str) {
		BigDecimal bd = null;
		if (_str != null) {
			try {
				bd = new BigDecimal(_str);
			} catch (Exception e) {
				return null;
			}
		}
		return bd;
	}
	/**
	 * �����꣬�£��գ�ת��ΪTimestamp����,����DB���봦��
	 * 
	 * @param _sDate ��ʽΪ��yyyy-mm-dd
	 * @return Timestamp��ʱ���ʽ
	 */
	public static Timestamp toTimestamp(String _sDate) {
		Timestamp ts = null;
		if (_sDate == null || "".equals(_sDate)) {
			return null;
		}
		ts = Timestamp.valueOf(_sDate + " 00:00:00.000000000");
		return ts;
	}
	/**
	 * �滻Html�ĵ��е�"&nbsp"Ϊ" ", "&lt"Ϊ"<", "&gt"Ϊ">"��"<br>"Ϊ"\r\n"
	 * 
	 * @param _rawStr ԭʼHtml�ĵ�
	 * @return �滻���Html�ĵ�
	 */
	public static String changeHtmlStr(String _rawStr) {
		String str = null;
		if (_rawStr != null) {
			str = replaceString( "&nbsp;", " ", _rawStr);
			str = replaceString( "&lt;","<", str);
			str = replaceString( "&gt;",">", str);
			str = replaceString( "&amp;","&", str);
			str = replaceString( "&quot;","\"", str);
			str = replaceString( "<br>", "\r\n",str);
		}
		return str;
	}
	/**
	 * ʹ���´��滻ԭ���ַ������ϴ�
	 * 
	 * @param _oldStr ���滻���ַ���
	 * @param _newStr ���ַ���
	 * @param _wholeStr �����ַ���
	 * @return �滻���´�
	 */
	public static String replaceString(String _oldStr,String _newStr,String _wholeStr) {
		if( _wholeStr == null){
			return null;
		}
		if( _newStr == null) {
			return _wholeStr;
		}
		
		int start=0, end=0;
		StringBuffer result=new StringBuffer();
	 	result=result.append(_wholeStr);
	 	while ( result.indexOf(_oldStr, start)>-1) {
   			start=result.indexOf(_oldStr, start);
   			end=start+_oldStr.length();
   			result.replace(start,end,_newStr);
   			start += _newStr.length();
	 	}
		return result.toString();
	}
	/**
	 * ����������滻��ʹ���´��滻ԭ���ַ����е�һ���ϴ�������������滻��ʹ���´��滻ԭ���ַ��������һ���ϴ�
	 * 
	 * @param _oldStr ���滻���ַ���
	 * @param _newStr ���ַ���
	 * @param _wholeStr �����ַ���
	 * @param _reverse	�滻�������Ϊfalse�����滻�����������滻
	 * @return �滻���´�
	 */
	public static String replaceFirstString(String _oldStr,String _newStr,String _wholeStr, boolean _reverse) {
		if( _wholeStr == null){
			return null;
		}
		if( _newStr == null) {
			return _wholeStr;
		}
		StringBuffer result=new StringBuffer(_wholeStr);
		int start=0, end=0;
		if(!_reverse) {
			if (result.indexOf(_oldStr)>-1) {
				start=result.indexOf(_oldStr);
				end=start+_oldStr.length();
				result.replace(start,end,_newStr);
			}
		}else{
			if (result.lastIndexOf(_oldStr)>-1) {
				start=result.lastIndexOf(_oldStr);
				end=start+_oldStr.length();
				result.replace(start,end,_newStr);
			}
		}
		return result.toString();
	}	
	
	/**
	 * ���ַ���ת��ΪHTML��ʽ���Ա���JavaScript��ʹ��
	 * 
	 * @param _sourceStr ԭ�ַ���
	 * @return ת������ַ���
	 */
	public static String changeToHTMLStr(String _sourceStr) {
		if (_sourceStr == null) {
			return null;
		}
		StringBuffer buff = new StringBuffer(1024);
		int n = _sourceStr.length();
		char c;
		for (int i = 0; i < n; i++) {
			c = _sourceStr.charAt(i);
			if (c == '"') {
				buff.append('\\');
				buff.append(c);
			} else if (c == '\\') {
				buff.append('\\');
				buff.append(c);
			} else if (c == '\r') {
				buff.append("\\r");
			} else if (c == '\n') {
				buff.append("\\n");
			} else {
				buff.append(c);
			}
		}
		return buff.toString();
	}
	/**
	 * �õ� _value��ȡС�����_lenλ �Ժ��ֵ
	 * 
	 * @param _value ԭֵ
	 * @param _len С������λ��
	 * @return ��ȡ�Ժ��ֵ
	 */
	public static float roundFloat(float _value, int _len) throws IllegalArgumentException{
		int iLen = _len;
		checkParamPositive("_len", _len);
		float d = (float) Math.pow(10, iLen);
		float fValue = _value * d;
		return Math.round(fValue) / d;
	}
	/**
	 * ���float���ַ�����ʾ�����ȶ�_value��_len�������������λ�������λ��С�����λ��С��_len����ʹ��0���롣
	 * 
	 * @param _value ԭֵ
	 * @param _len С������λ��
	 * @return float���ַ���
	 */
	public static String formatFloat(float _value, int _len) throws IllegalArgumentException{
		String fStr = String.valueOf(roundFloat(_value, _len));
		StringBuffer sb = new StringBuffer(fStr);
		int leftBit = fStr.length() - fStr.indexOf(".") - 1;
		if (leftBit < _len) {
			for (int i = 0; i < (_len - leftBit); i++) {
				sb.append("0");
			}
		}
		return sb.toString();
	}
	/**
	 * �õ� _value��ȡС�����_lenλ �Ժ��ֵ
	 * 
	 * @param _value ԭֵ
	 * @param _len С������λ��
	 * @return ��ȡ�Ժ��ֵ
	 */
	public static double roundDouble(double _value, int _len) throws IllegalArgumentException {
		int iLen = _len;
		checkParamPositive("_len", _len);
		double d = Math.pow(10, iLen);
		double dValue = _value * d;
		return Math.round(dValue) / d;
	}
	/**
	 * ���double���ַ�����ʾ�����ȶ�_value��_len�������������λ�������λ��С�����λ��С��_len����ʹ��0���롣
	 * 
	 * @param _value ԭֵ
	 * @param _len С������λ��
	 * @return double���ַ���
	 */
	public static String formatDouble(double _value, int _len) throws IllegalArgumentException{
		String fStr = String.valueOf(roundDouble(_value, _len));
		StringBuffer sb = new StringBuffer(fStr);
		int leftBit = fStr.length() - fStr.indexOf(".") - 1;
		if (leftBit < _len) {
			for (int i = 0; i < (_len - leftBit); i++) {
				sb.append("0");
			}
		}
		return sb.toString();
	}
	

	
	/**
	 * ����ַ��������<p>_len</p>���ַ���
	 * 
	 * @param _str �ַ���
	 * @param _len ����
	 * @return <p>_len</p>���ַ���
	 */
	public static String leftString(String _str, int _len) {
		if (_str == null) {
			return null;
		}
		if (_len < 0) {
			return "";
		}
		if (_str.length() <= _len) {
			return _str;
		} else {
			return _str.substring(0, _len);
		}
	}

	/**
	 * ����ַ������ұ�<p>_len</p>���ַ���
	 * 
	 * @param _str �ַ���
	 * @param _len ����
	 * @return �ַ������ұ�<p>_len</p>���ַ���
	 */	
	public static String rightString(String _str, int _len) {
		if (_str == null) {
			return null;
		}
		if (_len < 0) {
			return "";
		}
		if (_str.length() <= _len) {
			return _str;
		} else {
			return _str.substring(_str.length() - _len);
		}
	}
	
	/**
	 * ������ַ�<p>_padChar</p>��ʹ�����ַ�������Ϊ<p>_size</p>
	 * 
	 * @param _str ԭʼ�ַ���
	 * @param _size �����ַ����ܳ���
	 * @param _padChar ������ַ�
	 * @return ��������ַ�������:rightPad('hell', 3, '0')=hell;rightPad('hell', 10, '0')=hell000000
	 */
	public static String rightPad(String _str, int _size, char _padChar) {
		if (_str == null) {
			return null;
		}
		int pads = _size - _str.length();
		if (pads <= 0) {
			return _str; // returns original String when possible
		}
		return _str.concat(padding(pads, _padChar));
	}
	/**
	 * ������ַ�<p>_padChar</p>��ʹ��������ַ����ܳ�Ϊ<p>_size</p>
	 * 
	 * @param _str ԭʼ�ַ���
	 * @param _size �����ַ����ܳ���
	 * @param _padChar ������ַ�
	 * @return ��������ַ�������:leftPad('hell', 10, '0')=000000hell;leftPad('hell', 3, '0')=hell
	 */
	public static String leftPad(String _str, int _size, char _padChar) {
		if (_str == null) {
			return null;
		}
		int pads = _size - _str.length();
		if (pads <= 0) {
			return _str; // returns original String when possible
		}
		return padding(pads, _padChar).concat(_str);
	}	
	/**
	 * �ַ���<p>padChar</p>�ظ�<p>repeat</p>λ
	 * 
	 * @param _repeat �ظ�����
	 * @param _padChar ���ظ��ַ�
	 * @return �ظ���Ľ���ִ�����:padding(5, 'a')=aaaaa;padding(0, 'a'):""
	 */
	private static String padding(int _repeat, char _padChar) {
		String value = "";
		String padStr = String.valueOf(_padChar);
		if(_repeat>0) {
			for(int i = 0;i<_repeat;i++) {
				value = value.concat(padStr);
			}
		}
		return value;
	}
	
	private static void checkParamPositive(String _str, int _value) throws IllegalArgumentException  {
		if (_value <= 0) {
			throw new IllegalArgumentException("Parameters:" + _str + "Can't is less than or equal to 0");
		}
	}
	
}