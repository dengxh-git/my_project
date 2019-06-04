package com.sunline.sunfi.db.infc;

import java.io.Serializable;
import java.util.HashMap;

import com.eos.data.datacontext.IUserObject;
import com.eos.foundation.database.DatabaseExt;
import com.eos.runtime.core.TraceLoggerFactory;
import com.eos.system.annotation.Bizlet;
import com.eos.system.logging.Logger;
import com.sunline.sunfi.util.SunfiPackage;


public class DBInfc implements Serializable{
	
	/**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = 3927690447379772262L;
	private static final Logger logger = TraceLoggerFactory.getLogger(DBInfc.class);
	
	/**
	 * 获取键值报文
	 * @param prcscd 处理码
	 * @param master 非循环节点
	 * @param detail 循环节点
	 * @param userinfo 用户信息
	 * @return
	 */
	@Bizlet("获取键值报文")
	public static String getPackage(String prcscd,HashMap<String, String> master,HashMap<String, Object>[] detail,IUserObject userinfo){		
		SunfiPackage sunfiPack = null;//组报文程序
		String pckgdt = null;//报文数据
		try {
			sunfiPack =new SunfiPackage(userinfo,master,detail,prcscd);
			pckgdt = sunfiPack.getPackage();
		} catch (Exception e) {
			//e.printStackTrace();
			logger.error(e);
		}
		return pckgdt;
		
	}
	
	/**
	 * 获取指定键值报文
	 * @param prcscd 处理码
	 * @param master 报文数据
	 * @param detail 循环节点
	 * @param userinfo 用户信息
	 * @param singleKey 非循环报文key值
	 * @param muKey 循环报文key值
	 * @return
	 */
	@Bizlet("获取键值报文")
	public static String getPackage(String prcscd,HashMap<String, String> master,HashMap<String, Object>[] detail,IUserObject userinfo,String[] singleKey,String[] muKey)throws Exception{		
		SunfiPackage sunfiPack = null;//组报文程序
		String pckgdt = null;//报文数据
		try {
			sunfiPack =new SunfiPackage(userinfo,master,detail,prcscd);
			sunfiPack.setPackageKey(singleKey, muKey);
			pckgdt = sunfiPack.getPackage();
		} catch (Exception e) {
			//e.printStackTrace();
			logger.error(e);
			
			throw  e;
		}
		return pckgdt;
		
	}
		
	/**
	 * 获取键值报文（剔除指定键值）
	 * @param prcscd 处理码
	 * @param master 报文数据
	 * @param detail 循环节点
	 * @param userinfo 用户信息
	 * @param singleKey 非循环报文不需要打包key值
	 * @param muKey 循环报文key值
	 * @return
	 */
	@Bizlet("获取键值报文")
	public static String getPackageEx(String prcscd,HashMap<String, String> master,HashMap<String, Object>[] detail,IUserObject userinfo,String[] singleExcludeKey,String[] muExcludeKey){		
		SunfiPackage sunfiPack = null;//组报文程序
		String pckgdt = null;//报文数据
		try {
			sunfiPack =new SunfiPackage(userinfo,master,detail,prcscd);
			sunfiPack.setPackageExcludeKey(singleExcludeKey, muExcludeKey);
			pckgdt = sunfiPack.getPackage();
		} catch (Exception e) {
			//e.printStackTrace();
			logger.error(e);
		}
		return pckgdt;
		
	}

	/**
	 * 调用后台接口存储过程
	 * @param dsName 数据源名称
	 * @param prcscd 处理码
	 * @param pckgdt 报文数据
	 * @return
	 */
	@Bizlet("调用后台存储过程")
	public static HashMap<String, Object> invokeInfcMain(String dsName,String prcscd,String pckgdt){		
		//System.out.println("报文：\n"+ pckgdt);
		logger.info("报文：\n"+ pckgdt);
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("Pi_Prcscd", prcscd);
		params.put("Pi_Pckgdt", pckgdt);
		DatabaseExt.queryByNamedSql(dsName, "com.sunline.sunfi.db.infc.infc.Infc", params);
		Integer Po_Retuin = (Integer)params.get("Po_Retuin");

		String Po_Erortx = (String)params.get("Po_Erortx");
		
		//屏蔽提示信息中的“erortx=”
		//对于后台类似处理码flow_agree存储过程没有返回信息
		if(!"".equals(Po_Erortx) && Po_Erortx != null){
			params.put("Po_Erortx",Po_Erortx.replaceAll("erortx=", ""));
		}
		
		//System.out.println("调用存储过程执行成功:Po_Retuin="+ Po_Retuin + "Po_Erortx="+Po_Erortx);
		logger.info("Call sprocs on success :Po_Retuin="+ Po_Retuin + "Po_Erortx="+Po_Erortx);
		
		if (Po_Retuin == 0) {//成功处理
			
		} else {//失败处理
			

		}
		return params;
		
	}
	
	/**
	 * 调用后台接口存储过程
	 * @param dsName 数据源名称
	 * @param pckgdt 报文数据
	 * @return
	 */
	@Bizlet("调用后台存储过程")
	public static HashMap<String, Object> invokeInfcMainOther(String dsName,String pckgdt){		
		//System.out.println("报文：\n"+ pckgdt);
		logger.info("报文：\n"+ pckgdt);
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("Pi_Pckgdt", pckgdt);
		DatabaseExt.queryByNamedSql(dsName, "com.sunline.sunfi.db.infc.infc.InfcOther", params);
		Integer Po_Retuin = (Integer)params.get("Po_Retuin");

		String Po_Erortx = (String)params.get("Po_Erortx");
		
		//System.out.println("调用存储过程执行成功:Po_Retuin="+ Po_Retuin + "Po_Erortx="+Po_Erortx);
		logger.info("Call sprocs on success :Po_Retuin="+ Po_Retuin + "Po_Erortx="+Po_Erortx);
		
		if (Po_Retuin == 0) {//成功处理
			
		} else {//失败处理
			

		}
		return params;
		
	}
	
	/**
	 * 处理调用存储过程后的返回信息
	 * @param params 返回信息
	 * @return
	 */
	@Bizlet("处理调用存储过程后的返回信息")
	public static HashMap<String, Object> processReturnMsg(HashMap<String, Object> params){	
		HashMap<String, Object> retmsg = new HashMap<String, Object>();
		Integer retuin = (Integer)params.get("Po_Retuin");
		String erortx = (String)params.get("Po_Erortx");
		if(erortx == null){
			erortx = "";
		}
		retmsg.put("retuin", retuin);
		retmsg.put("erortx", erortx);
		return retmsg;
		
	}
}