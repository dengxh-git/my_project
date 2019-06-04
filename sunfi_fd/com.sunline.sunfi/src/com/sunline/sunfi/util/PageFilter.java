package com.sunline.sunfi.util;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eos.access.http.IWebInterceptor;
import com.eos.access.http.IWebInterceptorChain;
import com.eos.data.datacontext.DataContextManager;
import com.eos.data.datacontext.IMUODataContext;
import com.eos.data.datacontext.IUserObject;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;

public class PageFilter implements IWebInterceptor {

	public void doIntercept(HttpServletRequest request,
			HttpServletResponse response, IWebInterceptorChain interceptorChain)
			throws IOException, ServletException {
		
		//拦截非法请求
		DataObject tempdb=DataObjectUtil.createDataObject("com.sunline.sunfi.db.infc.public.EmsFilterpage");
		tempdb.set("pagename", request.getServletPath());
		DataObject a[]=DatabaseUtil.queryEntitiesByTemplate("default", tempdb);
		if(a.length==0){
			interceptorChain.doIntercept(request, response);
		}else{
			String mainID="";		//sig
			String tempID="";		//敏感参数
			String cacheRandom="";	//缓存数据
			String skipPage="";		//跳转页面
			
			String bz="";
			bz=a[0].get("idname").toString();
			if(bz.contains(",")){
				String dcs[]=bz.split(",");
				for (int i = 0; i < dcs.length; i++) {
					bz=request.getParameter(dcs[i]);
					tempID=tempID+bz;
				}
			}else{
				tempID=request.getParameter(a[0].get("idname").toString());;
			}
			
			//支持在不同场景下一个页面存在多个重要参数的情况，但每个请求只能使用一个参数作为敏感数据
//			for(int i =0;i<a.length;i++){
//				
//				tempID=request.getParameter(a[i].get("idname").toString());;
//				
//				skipPage=(String) a[i].get("erskippage");
//				
				if(tempID!=null){}
//					break;
//				}else{
//				}
//			}
			
			if(skipPage==""||null==skipPage)
				skipPage="/sunfi/filterHint.jsp";//如果数据库未配置，默认使用该提示页面

			mainID=request.getParameter("sig");
			if(mainID!=null){
				mainID=mainID.replace(' ', '+');
			}
			
			if(tempID==null||mainID==null){
				request.getRequestDispatcher(skipPage).forward(request, response);
			}else{
				
				try {
					//cacheRandom=to.callLogicBusiness("random")[0].toString();
					
					IMUODataContext muo = DataContextManager.current().getMUODataContext();
					IUserObject userobject = muo.getUserObject();
					cacheRandom=(String) userobject.get("sigCache");
					if(("").equals(cacheRandom)||cacheRandom==null){
						Object[] result = null;
						String componentName = "com.sunline.sunfi.util.enDecrypt";
						String operationName = "updateEmpRandom_ems";
						ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
						// 逻辑流的输入参数
						Object[] params = new Object[2];
						params[0]=null;
						params[1]="EMS";
						result = logicComponent.invoke(operationName, params);
						cacheRandom=result[1].toString();
					}
					//userobject.put("sigCache", "");
				} catch (Throwable e) {
					// TODO 自动生成的 catch 块
					e.printStackTrace();
				}
				
				EnAndDeCrypt3DES des=new EnAndDeCrypt3DES("abcdefghabcdefghabcdefghabcdefgh");
				if(des.encrypt(tempID+cacheRandom).equals(mainID)){
					interceptorChain.doIntercept(request, response);
				}else{
					request.getRequestDispatcher(skipPage).forward(request, response);
				}
			}
		}
		
	}
}

