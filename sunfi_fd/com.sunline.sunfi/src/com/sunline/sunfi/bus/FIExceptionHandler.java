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
 * Created on 2010-10-22
 *******************************************************************************/


package com.sunline.sunfi.bus;

import java.lang.reflect.UndeclaredThrowableException;
import java.util.HashMap;

import com.eos.data.datacontext.DataContextManager;
import com.eos.engine.core.IHandler;
import com.primeton.ext.engine.core.IRuntimeContext;

public class FIExceptionHandler implements IHandler {

	public int doAfter(IRuntimeContext arg0) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int doBefore(IRuntimeContext arg0) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int doException(IRuntimeContext arg0, Throwable t) {
		// TODO Auto-generated method stub
		DataContextManager.current().getDefaultContext().set("_fiexception", null);
		Throwable ct;
		if(t instanceof UndeclaredThrowableException){
        	UndeclaredThrowableException ute = (UndeclaredThrowableException)t;
        	Throwable ut = ute.getUndeclaredThrowable();
        	ct = ut.getCause();
        }else{
        	ct = t.getCause();
        }
		//µ›πÈ≤È—Ø“Ï≥£‘¥
		while(ct != null){
			if(ct instanceof FIException){
				FIException fie = (FIException)ct; 
				HashMap<String,Object> map = new HashMap<String,Object>();
				map.put("errorCode", fie.getErrorCode());
				map.put("errorMessage", fie.getErrorMessage());
				DataContextManager.current().getDefaultContext().set("_fiexception", map);
				break;
			}
			ct = ct.getCause();
		}
		return 0;
	}

	public int doFinalize(IRuntimeContext arg0) {
		// TODO Auto-generated method stub
		return 0;
	}

}
