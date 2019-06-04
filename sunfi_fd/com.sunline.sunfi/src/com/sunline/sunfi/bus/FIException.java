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


package com.sunline.sunfi.bus;

public class FIException extends Exception{

	/**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -6833179639513315865L;

	private String errorCode;

	private String errorMessage;

	public FIException(String errorCode,String errorMessage){
        super(errorMessage);
		this.errorCode=errorCode;
		this.errorMessage=errorMessage;
	}

	public String getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}

}