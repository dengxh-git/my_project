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
 * Created on 2011-5-15
 *******************************************************************************/


package com.sunline.sunfi.util;

import com.eos.system.annotation.Bizlet;
import commonj.sdo.DataObject;

public class DataObjectUtil {
	
	/**
     * ����DataObject����ֵ
     * @param dataObject ���ݶ���
     * @param property ��������
     * @param value ����ֵ
     */
	@Bizlet("����DataObject����ֵ")
	public static void setPropertyValue(DataObject dataObject,String property,Object value){
		dataObject.set(property, value);

	}

}
