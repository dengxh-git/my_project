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
 * Created on 2010-11-7
 *******************************************************************************/


package com.sunline.sunfi.sunfi_cm;

import java.util.HashMap;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRField;

public class SunfiJRDataSource implements JRDataSource {
	
	HashMap [] dataSource;
	int index = -1;
	
	public SunfiJRDataSource(HashMap [] dataSource){
		this.dataSource = dataSource;
	}
	
	public Object getFieldValue(JRField arg0) throws JRException {
		// TODO Auto-generated method stub
		if(dataSource!=null){
			return dataSource[index].get(arg0.getName());
		}
		return null;
	}

	public boolean next() throws JRException {
		// TODO Auto-generated method stub
		index++;
		if(dataSource!=null&&index<dataSource.length){
			return true;
		}
		return false;
	}
}
