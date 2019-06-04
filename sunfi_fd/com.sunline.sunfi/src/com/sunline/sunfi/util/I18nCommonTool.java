/*******************************************************************************
 * $Header$
 * $Revision$
 * $Date$
 *
 *==============================================================================
 * 国际化处理
 * 如果登录时没有设置语言和地区代码则从config.xml获取
 * Copyright (c) 2001-2006 Primeton Technologies, Ltd.
 * All rights reserved.
 * 
 * Created on 2011-8-6
 *******************************************************************************/


package com.sunline.sunfi.util;

import java.util.Locale;

import com.eos.data.datacontext.DataContextManager;
import com.eos.foundation.eoscommon.ResourcesMessageUtil;
import com.sunline.sunfi.config.FIConfig;

public class I18nCommonTool {
	
	private static String locale = null;
	
	/**
	 * 获取语言地区代码
	 * 如果登录时没有设置语言和地区代码则从config.xml获取
	 * @return
	 */
	private static String getLocale(){
		if(null == locale || "".equals(locale)){
			Locale loc = DataContextManager.current().getCurrentLocale();			
			if(null == loc || "".equals(loc.toString())){
				locale = FIConfig.getLocale();
			}else{
				locale = loc.toString();
			}
		}
		return locale;
	}
	
	/**
	 * 获取指定地区的异常国际化资源信息
	 * @param key 异常国际化资源key 
	 * @return 异常国际化资源信息
	 */
	public static String getExceptionResourceMessage(String key)
	{
		return ResourcesMessageUtil.getExceptionResourceMessage(key,getLocale());
	}
	
	/**
	 * 获取指定地区的异常国际化资源信息
	 * @param key 异常国际化资源key 
	 * @param params参数 
	 * @return 异常国际化资源信息
	 */
	public static String getExceptionResourceMessage(String key,Object[] params)
	{
		return ResourcesMessageUtil.getExceptionResourceMessage(key,getLocale(),params);
	}
	
	/**
	 * 获取国际化资源信息
	 * @param key 普通国际化资源key 
	 * @return 普通国际化资源信息
	 */
	public static String getI18nResourceMessage(String key)
	{
		return ResourcesMessageUtil.getI18nResourceMessage(key,getLocale());
	}
	
	/**
	 * 获取国际化资源信息
	 * @param key 普通国际化资源key 
	 * @param params参数 
	 * @return 普通国际化资源信息
	 */
	public static String getI18nResourceMessage(String key,Object[] params)
	{
		return ResourcesMessageUtil.getI18nResourceMessage(key,getLocale(),params);
	}
	
}