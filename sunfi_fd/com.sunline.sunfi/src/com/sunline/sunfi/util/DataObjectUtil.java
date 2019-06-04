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
     * 设置DataObject属性值
     * @param dataObject 数据对象
     * @param property 属性名称
     * @param value 属性值
     */
	@Bizlet("设置DataObject属性值")
	public static void setPropertyValue(DataObject dataObject,String property,Object value){
		dataObject.set(property, value);

	}

}
