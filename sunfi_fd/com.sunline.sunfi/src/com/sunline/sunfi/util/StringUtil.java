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
 * Created on 2010-10-14
 *******************************************************************************/


package com.sunline.sunfi.util;

import java.text.DateFormat;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class StringUtil {

	/**
	 * ÅÐ¶Ï×Ö·ûÊÇ·ñÎª¿Õ
	 * 
	 * @param _str;´ýÅÐ¶Ï×Ö·û
	 * @return boolean flag; true ¿Õ×Ö·û;false ·Ç¿Õ×Ö·û
	 */
	public static boolean isEmptyStr(String _str){
		boolean flag = true;
		if (_str != null && !"".equals(_str) && !"null".equals(_str)){
			flag = false;
		}
		return flag;
	}
	
	/**
	 * È¥¿Õº¯Êý
	 * @param src
	 * @param offset
	 * @param length
	 * @return
	 */
	public static String isNotNullStr(String str){
		if(str==null||str.equals("null")){
			str = "";
		}
		return str;
	}
	
	public static String datediff(String date,String day){
	     DateFormat format = new SimpleDateFormat("yyyy-MM-dd");  
	     String returndate = "";
	     try {  
	         Date d = format.parse(date);  
	         Calendar c = Calendar.getInstance();  
	         c.setTime(d);  
	         c.add(c.DATE, Integer.parseInt(day));  
	         Date temp_date = c.getTime();   
	         returndate = format.format(temp_date);
	     } catch (Exception e) {  
	         e.printStackTrace();  
	     }  
	     return returndate;
	}
	
	public static String getTwoDay(String begin_date, String end_date) {
		  long day = 0;
		  try {
			  Format f = new SimpleDateFormat("yyyy-MM-dd");
	          Date begin_date1 = (Date) f.parseObject(begin_date);
	          Date end_date1 = (Date) f.parseObject(end_date);
		   SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		   String sdate = format.format(Calendar.getInstance().getTime());
		   
		   if (begin_date1 == null) {
			   begin_date1 = format.parse(sdate);
		   }
		   if (end_date1 == null) {
			   end_date1 = format.parse(sdate);
		   }
		   day = (end_date1.getTime() - begin_date1.getTime())
		     / (24 * 60 * 60 * 1000);
		  } catch (Exception e) {
		   return "-1";
		  }
		  return String.valueOf(day);
		 }
	 
	/**
	 * ÌîÁãº¯Êý
	 * @param src
	 * @param offset
	 * @param length
	 * @return
	 */
	public static String isNullBz(String str){
		if(str==null||str.equals("null")||str.equals("")){
			str = "Áã";
		}
		return str;
	}
	
	public static String subString(String src, int offset, int length){
        try{
            return new String(src.getBytes(), offset, length);
        }catch(Exception e){
            return null;
        }
    }

    public static String subString(String src, int offset){
        try{
            byte[] bytes = src.getBytes();
            return new String(bytes, offset,bytes.length-offset);
        }catch(Exception e){
            return null;
        }
    }

    public static String getNullDefault(String src, String defaultval){
        if(null != src){
            return src;
        }
        return defaultval;
    }
	
	public static String getEmptyDefault(String src, String defVal){
        if(null != src && 0 < src.trim().length()){
            return src;
        }
        return defVal;
    }
}
