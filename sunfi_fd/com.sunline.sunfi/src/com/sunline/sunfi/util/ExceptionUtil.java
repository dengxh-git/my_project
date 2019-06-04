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
 * Created on 2010-10-10
 *******************************************************************************/


package com.sunline.sunfi.util;

import java.util.HashMap;
import java.util.Map;

import com.eos.system.annotation.Bizlet;
import com.sunline.sunfi.bus.FIException;

public class ExceptionUtil {
	
	private static Map<String,String> fies = new HashMap<String,String>();
	
	/**
	 * 抛出自定义异常FIException
	 * @param errorCode
	 * @param errorMessage
	 * @throws Exception
	 */
	@Bizlet("抛出自定义异常FIException")
	public static void throwFIException(String errorCode,String errorMessage)throws Exception{
 		 throw new FIException(errorCode,errorMessage);
	}
	
	/**
	 * 抛出自定义异常FIException并进行国际化处理
	 * @param errorCode
	 * @param errorMessage
	 * @param msgIsI18nKey errorMessage是否为国际化Key
	 * @throws Exception
	 */
	@Bizlet("抛出自定义异常FIException并进行国际化处理")
	public static void throwFIException(String errorCode,String errorMessage,boolean msgIsI18nKey)throws Exception{
		 if(msgIsI18nKey){
			 errorMessage = I18nCommonTool.getI18nResourceMessage(errorMessage);
		 }
 		 throw new FIException(errorCode,errorMessage);
	}
	
	/**
	 * 设置自定义异常FIException信息
	 * @param key
	 * @param errorMessage
	 */
	@Bizlet("设置自定义异常FIException信息")
	public static void setFIExceptionMsg(String key,String errorMessage){
		fies.put(key, errorMessage);
		//System.out.println("key:"+key+",111msg:"+errorMessage);
	}
	
	/**
	 * 获取自定义异常FIException信息
	 * @param key
	 * @return
	 */
	@Bizlet("获取自定义异常FIException信息")
	public static String getFIExceptionMsg(String key){
		String msg = null;
		if (fies.containsKey(key)){
			msg =(String)fies.get(key);
			fies.remove(key); //获取后清空
		}
		//System.out.println("key:"+key+",222msg:"+msg);
		return msg;
	}
}