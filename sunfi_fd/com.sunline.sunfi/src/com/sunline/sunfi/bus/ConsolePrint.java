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
 * Created on 2011-9-20
 *******************************************************************************/


package com.sunline.sunfi.bus;

import com.eos.system.annotation.Bizlet;

public class ConsolePrint {
	
	/**
	 * ����̨��ӡ
	 * @param msg
	 * @return
	 */
	@Bizlet("����̨��ӡ")
	public static void println(String msg){
		System.out.println(msg);
	}
}
