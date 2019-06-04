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
 * Created on 2011-10-1
 *******************************************************************************/


package com.sunline.sunfi.util;

import com.eos.system.annotation.Bizlet;

public class CryptoUtil {

	/**
	 * ���ַ���ʹ��DES���ܲ�����base64���룬���������Կ
	 * @param plainText ����
	 * @return ����
	 */
	@Bizlet("���ַ���ʹ��DES���ܲ�����base64���룬���������Կ")
	public static String encryptByDES(String plainText){
		String keyString  = "";
		keyString = com.eos.foundation.eoscommon.RandomUtil.getRandomString(5, 3);
		String cryptograph = com.eos.foundation.common.utils.CryptoUtil.encryptByDES(plainText,keyString);
		StringBuffer temp = new StringBuffer(cryptograph);
		temp.insert(0,keyString.substring(0, 1));
		temp.insert(2,keyString.substring(1, 2));
		temp.insert(4,keyString.substring(2, 3));
		temp.insert(6,keyString.substring(3, 4));
		temp.insert(8,keyString.substring(4, 5));
		cryptograph = temp.toString();
		return cryptograph;
	}
	
	/**
	 * ���ַ���ʹ��DES���ܲ�����base64���룬���������Կ
	 * @param cryptograph ����
	 * @return ����
	 */
	@Bizlet("���ַ���ʹ��DES���ܲ�����base64���룬���������Կ")
	public static String decryptByDES(String cryptograph ){
		String keyString  = "";
		keyString = cryptograph.substring(0,1)+cryptograph.substring(2,3)+cryptograph.substring(4,5)+cryptograph.substring(6,7)+cryptograph.substring(8,9);
		StringBuffer temp = new StringBuffer(cryptograph);
		temp.delete(8, 9);
		temp.delete(6, 7);
		temp.delete(4, 5);
		temp.delete(2, 3);
		temp.delete(0, 1);
		cryptograph = temp.toString();
		String plainText  = com.eos.foundation.common.utils.CryptoUtil.decryptByDES(cryptograph,keyString);
		return plainText;
	}
}
