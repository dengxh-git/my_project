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
 * Created on 2010-8-12
 *******************************************************************************/

package com.sunline.sunfi.bus;

import java.util.Map;
import java.util.Set;

import com.eos.engine.core.IHandler;
import com.eos.web.taglib.util.XpathHelper;
import com.primeton.engine.core.impl.context.PageflowRuntimeContext;
import com.primeton.ext.engine.core.IRuntimeContext;

/**
 * 
 * 异常处理器<BR>
 * 用于自定义异常时，抛出异常并显示异常页面，同时在异常显示页面按"返回"按钮后，可以返回前一次的url并回显表单数据<BR>
 * 注:该处理器只拦截页面流.
 * @author 
 */
/*
 * 修改历史
 * $Log$
 */
public class ExceptionHandler implements IHandler {
	
	private static final String KEY_PREVIOUS_PAGE_FLOW="_previous_pageflow";
	
	private static final String KEY_PREVIOUS_CONTEXT_PARAM="_previous_context_param";
	
	//最近一次正确的页面流
	private String previousPageFlow;
	//最近一次请求参数对象
	private Object previousRootObject;
	//当前的请求参数对象
	private Object currentRootObject;
	
	/**
	 * 引擎执行成功之后才获取相应请求action
	 */
	public int doAfter(IRuntimeContext runtimeContext) {
		
		if(runtimeContext instanceof PageflowRuntimeContext){
			PageflowRuntimeContext context=(PageflowRuntimeContext)runtimeContext;
			previousPageFlow=context.getFlowInstance().getPageflowQName()+"?_eosFlowAction="+context.getCurrentAction();
			previousRootObject=context.getRootObject();
		}
	
		return RET_OK;
	}

	
	/**
	 * 生成当前请求的隐含数据<BR>
	 * 将请求上下文的所有内容转化为Hidden域输出在异常页面，作为返回的参数<BR>
	 * 注意:只有当前请求的flow定义了action的输出参数，才能获取相应的参数值.如当前请求为_eosFlowAction=action2,
	 * 那么previousRootObject中只包含action2的输出参数内容,即回显数据．
	 * @return
	 */
	private String generateHiddenSubmitDatas(Object rootObject){
		StringBuffer buff=new StringBuffer();
	
		if(rootObject instanceof Map){
			
			Map<String,Object> parameterContext = (Map)rootObject;
			
			try {
				Set<Map.Entry<String, Object>> dataSet = parameterContext.entrySet();
				
				for(Map.Entry<String, Object> entry:dataSet){
	
					Map objectMap=XpathHelper.Object2Map(entry.getValue(), entry.getKey());
					
					Set<Map.Entry<String, Object>> paramSet = objectMap.entrySet();
					for(Map.Entry<String, Object> nestEntry:paramSet){
						String key=nestEntry.getKey();
						//以下为保留字，避免重复生成
						if(key.endsWith("__type")||key.startsWith("__exception")||
								key.endsWith("_eosFlowKey")||
								key.endsWith("_previous_pageflow")||
								key.endsWith("_eosFlowAction"))
							continue;
						
						buff.append(nestEntry.getKey()).append("<input type=\"text\" name=\"").append(nestEntry.getKey()).append("\" value=\"").append(nestEntry.getValue()).append("\"/>");
						
					}
				}
			} catch (Exception e) {
	
			}
		}
		
		return buff.toString();
	}

	/**
	 *	执行前保留页面流程的相应上下文参数，便于异常后内容的回显
	 */
	public int doBefore(IRuntimeContext runtimeContext) {
		if(runtimeContext instanceof PageflowRuntimeContext){
			PageflowRuntimeContext context=(PageflowRuntimeContext)runtimeContext;
			this.currentRootObject=context.getRootObject();
		}
		return RET_OK;
	}

	/**
	 * 异常时，上下文设置前一次请求成功后的URL和当前请求的参数,便于表单数据的回显
	 */
	public int doException(IRuntimeContext runtimeContext, Throwable t) {
		if(runtimeContext instanceof PageflowRuntimeContext){
			PageflowRuntimeContext context=(PageflowRuntimeContext)runtimeContext;
			context.set(KEY_PREVIOUS_PAGE_FLOW,previousPageFlow);
			//当前请求url==前一次请求的url，并且抛出了异常，说明参数有问题
			//此时恢复之前的请求参数
			String currentPageFlow=context.getFlowInstance().getPageflowQName()+"?_eosFlowAction="+context.getCurrentAction();
			if(previousPageFlow!=null&&previousPageFlow.equals(currentPageFlow))
				context.set(KEY_PREVIOUS_CONTEXT_PARAM,generateHiddenSubmitDatas(previousRootObject));
			else
				context.set(KEY_PREVIOUS_CONTEXT_PARAM,generateHiddenSubmitDatas(currentRootObject));
			//context.set("__exception/params", "sunline");
			context.set("err_para_0", "sunline");
		}
		
		return RET_OK;
	}

	public int doFinalize(IRuntimeContext runtimeContext) {
		return RET_OK;
	}
}

