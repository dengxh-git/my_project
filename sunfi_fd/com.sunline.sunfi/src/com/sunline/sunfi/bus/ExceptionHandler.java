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
 * �쳣������<BR>
 * �����Զ����쳣ʱ���׳��쳣����ʾ�쳣ҳ�棬ͬʱ���쳣��ʾҳ�水"����"��ť�󣬿��Է���ǰһ�ε�url�����Ա�����<BR>
 * ע:�ô�����ֻ����ҳ����.
 * @author 
 */
/*
 * �޸���ʷ
 * $Log$
 */
public class ExceptionHandler implements IHandler {
	
	private static final String KEY_PREVIOUS_PAGE_FLOW="_previous_pageflow";
	
	private static final String KEY_PREVIOUS_CONTEXT_PARAM="_previous_context_param";
	
	//���һ����ȷ��ҳ����
	private String previousPageFlow;
	//���һ�������������
	private Object previousRootObject;
	//��ǰ�������������
	private Object currentRootObject;
	
	/**
	 * ����ִ�гɹ�֮��Ż�ȡ��Ӧ����action
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
	 * ���ɵ�ǰ�������������<BR>
	 * �����������ĵ���������ת��ΪHidden��������쳣ҳ�棬��Ϊ���صĲ���<BR>
	 * ע��:ֻ�е�ǰ�����flow������action��������������ܻ�ȡ��Ӧ�Ĳ���ֵ.�統ǰ����Ϊ_eosFlowAction=action2,
	 * ��ôpreviousRootObject��ֻ����action2�������������,���������ݣ�
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
						//����Ϊ�����֣������ظ�����
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
	 *	ִ��ǰ����ҳ�����̵���Ӧ�����Ĳ����������쳣�����ݵĻ���
	 */
	public int doBefore(IRuntimeContext runtimeContext) {
		if(runtimeContext instanceof PageflowRuntimeContext){
			PageflowRuntimeContext context=(PageflowRuntimeContext)runtimeContext;
			this.currentRootObject=context.getRootObject();
		}
		return RET_OK;
	}

	/**
	 * �쳣ʱ������������ǰһ������ɹ����URL�͵�ǰ����Ĳ���,���ڱ����ݵĻ���
	 */
	public int doException(IRuntimeContext runtimeContext, Throwable t) {
		if(runtimeContext instanceof PageflowRuntimeContext){
			PageflowRuntimeContext context=(PageflowRuntimeContext)runtimeContext;
			context.set(KEY_PREVIOUS_PAGE_FLOW,previousPageFlow);
			//��ǰ����url==ǰһ�������url�������׳����쳣��˵������������
			//��ʱ�ָ�֮ǰ���������
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

