/**
 * 
 */
package com.sunline.sunfi.sunfi_cm;

import java.sql.Connection;
import java.util.HashMap;
import java.util.List;

import com.eos.common.connection.ConnectionHelper;
import com.eos.das.entity.DASManager;
import com.eos.das.entity.IDASCriteria;
import com.eos.das.entity.IDASSession;
import com.eos.system.annotation.Bizlet;
import com.sunline.sunfi.util.Convert;

import commonj.sdo.DataObject;

/**
 * @author kaifasishi82
 * @date 2019-01-15 09:28:19
 *
 */
@Bizlet("")
public class ComPara {
	private static String comParaEntity = "com.sunline.sunfi.sunfi_cm.stac.ComPara";
	private static HashMap<String,Object> dataHashMap = null;
	
	/**
	 * 从数据库com_para 表映射到HashMap
	 * @throws Exception
	 */
	@Bizlet("初始化参数表")
	public static void initPara(){
		System.out.println("refresh the paras");
		Connection conn = null;
		IDASSession session = null;
		try{
			conn = ConnectionHelper.getContributionConnection("com.sunline.sunfi.sunfi_cm","default");
			session = DASManager.createDasSession(conn);
			IDASCriteria criteria =  DASManager.createCriteria(comParaEntity);
			criteria.asc("stacid");
			List<DataObject> dataObjs = session.query(criteria);
			session.close();
			conn.close();
			dataHashMap = new HashMap<String,Object>();
			for(int i=0;i<dataObjs.size();i++){
				HashMap<String,Object> tempMap = Convert.convertDataObject2HashMap((DataObject)dataObjs.get(i));
				dataHashMap.put(String.valueOf(tempMap.get("stacid"))+"_"+(String)tempMap.get("parana"), (String)tempMap.get("paravl"));
			}
		}catch(Exception ex){
			ex.printStackTrace();
			if(session!=null){
				session.close();
			}
			try{
				if(conn!=null){
					conn.close();
				}
			}catch(Exception er){}
		}
	}
	/**
	 * 根据参数名获取参数值
	 * @param stacid
	 * @param parana
	 * @return
	 */
	@Bizlet("根据参数名获取参数值")
	public static String getParavl(String stacid,String parana) {
		return getParavl(stacid,parana,false);
	}
	
	public static String getParavl(String stacid,String parana, boolean isreload) {
		try {
			if (isreload||null==dataHashMap) {
				initPara();
			}
			return (String) dataHashMap.get(stacid+"_"+parana);
		} catch (Exception ex) {
			return null;
		}
	}

}
