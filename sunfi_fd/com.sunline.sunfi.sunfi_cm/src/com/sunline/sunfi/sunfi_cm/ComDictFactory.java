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
 * Created on 2010-8-11
 *******************************************************************************/


package com.sunline.sunfi.sunfi_cm;

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
 * Created on 2010-8-10
 *******************************************************************************/

import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.eos.common.connection.ConnectionHelper;
import com.eos.das.entity.DASManager;
import com.eos.das.entity.ExpressionHelper;
import com.eos.das.entity.IDASCriteria;
import com.eos.das.entity.IDASSession;
import com.eos.server.dict.DictFactory;
import com.eos.server.dict.DictType;
import com.eos.server.dict.impl.DictEntryImpl;
import com.eos.server.dict.impl.DictTypeImpl;
import commonj.sdo.DataObject;

public class ComDictFactory implements DictFactory {

	//加载实体
	private static final String typeEntity = "com.sunline.sunfi.sunfi_cm.comdict.ComDict";
	private static final String typeDetlEntity = "com.sunline.sunfi.sunfi_cm.comdict.ComDictDetl";
	private static final String crcyEntity = "com.sunline.sunfi.sunfi_cm.stac.ComCrcy";
	
	public Map<String, DictType> loadAllDictTypes() throws Exception {
		Map<String, DictType> retData  = new HashMap<String, DictType>();
		Connection conn = ConnectionHelper.getContributionConnection("com.sunline.sunfi.sunfi_cm","default");
		try{
			List <DataObject> resultData = this.queryLoadDatas(conn);
			String key;
			DictType type;
			for(int i=0;i<resultData.size();i++){
				DataObject oneRecord = resultData.get(i);
				String dictcd = oneRecord.getString("dictcd");
				String dictna = oneRecord.getString("dictna");
				
				key = dictcd;		
				type = new DictTypeImpl(key,dictna);
				
				List <DataObject> detailData = this.queryLoadDataDetls(conn,dictcd);
				for(int j=0;j<detailData.size();j++){
					DataObject detailRecord = (DataObject)detailData.get(j);
					String dcdlcd = detailRecord.getString("dcdlcd");
					String dcdlna = detailRecord.getString("dcdlna");
					String isvald = detailRecord.getString("isvald");
					if("1".equals(isvald)){
						type.addDictEntry(new DictEntryImpl(dcdlcd,dcdlna));
					}
				}
				retData.put(key, type);			
				
			}
			
			//加载币种
			key ="FI_CRCYCD";
			List <DataObject> crcyData = this.queryLoadCrcys(conn);
			type = new DictTypeImpl(key,"");
			for(int j=0;j<crcyData.size();j++){
				String dcdlcd = crcyData.get(j).getString("crcycd");
				String dcdlna = crcyData.get(j).getString("crcyna");
				type.addDictEntry(new DictEntryImpl(dcdlcd,dcdlna));
			}
			retData.put(key, type);		
			return retData;
		}catch(Exception e){
			throw e;
		}finally{
			conn.close();
		}
	}
	
	/**
	 * 
	 * @param fullEntityName   被加载的实体名称
	 * @return 需要加载的数据
	 */
	private List<DataObject> queryLoadDatas(Connection conn) throws Exception
	{
		
		List <DataObject> returnDatas = null;
		IDASSession session = DASManager.createDasSession(conn);
		IDASCriteria criteria =  DASManager.createCriteria(typeEntity);
		criteria.asc("dictcd");
		returnDatas = session.query(criteria);
		session.close();
		return returnDatas;
	} 
	
	/**
	 * 
	 * @param fullEntityName   被加载的实体名称
	 * @return 需要加载的数据
	 */
	private List<DataObject> queryLoadDataDetls(Connection conn,String dictcd) throws Exception
	{
		
		List <DataObject> returnDatas = null;
		IDASSession session = DASManager.createDasSession(conn);
		IDASCriteria criteria =  DASManager.createCriteria(typeDetlEntity);
		criteria.add(ExpressionHelper.eq("dictcd",dictcd));
		criteria.asc("sortno");
		returnDatas = session.query(criteria);
		session.close();
		return returnDatas;
	}
	
	/**
	 * 
	 * @param fullEntityName   被加载的实体名称
	 * @return 需要加载的数据
	 */
	private List<DataObject> queryLoadCrcys(Connection conn) throws Exception
	{
		
		List <DataObject> returnDatas = null;
		IDASSession session = DASManager.createDasSession(conn);
		IDASCriteria criteria =  DASManager.createCriteria(crcyEntity);
		criteria.add(ExpressionHelper.eq("usabtg","1"));
		criteria.asc("crcycd");
		returnDatas = session.query(criteria);
		session.close();
		return returnDatas;
	} 


}

