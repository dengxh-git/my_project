package com.sunline.sunfi.db;

import java.sql.Connection;
import java.util.List;

import com.eos.das.entity.DASManager;
import com.eos.das.entity.ExpressionHelper;
import com.eos.das.entity.IDASCriteria;
import com.eos.das.entity.IDASSession;
import com.eos.das.entity.ProjectionHelper;
import com.eos.system.annotation.Bizlet;
import com.sunline.sunfi.util.StringUtil;

import commonj.sdo.DataObject;

/**
 * 
 * TODO 此处填写 class 信息 公共方法
 * 
 * @author luxl (mailto:luxl@sunline.cn)
 */

@Bizlet("通过ID获取名称或通过名称获取ID串")
public class GetNameOrID {
	
	/**
	 * 通过ID获取名称
	 * @param dsName;数据源别名
	 * @param entity;数据实体
	 * @param idColumns;ID字段名，多个字段用"，"分隔
	 * @param idValues;ID值，多个值用"，"分隔
	 * @param retNameColumn;返回的Name字段
	 * @return name;返回名称
	 */
	@Bizlet("通过ID获取名称")
	public static String getNameByID(String dsName,String entity,String idColumns,String idValues,String retNameColumn)
			throws Exception {
		String name = "";
		if (!StringUtil.isEmptyStr(dsName)&&!StringUtil.isEmptyStr(entity)&&!StringUtil.isEmptyStr(idColumns)&&!StringUtil.isEmptyStr(idValues)&&!StringUtil.isEmptyStr(retNameColumn)) {
			Connection conn = DBConnection.getConnection(null, dsName);
			IDASSession session = DBConnection.getIDASSession(conn);
			IDASCriteria criteria = DASManager.createCriteria(entity);
			String [] column = idColumns.split(",");
			String [] value  = idValues.split(",");
			for(int i=0;i<column.length;i++){
			 criteria.add(ExpressionHelper.eq(column[i], value[i]));
			}
			
			List<DataObject> dataObjects = session.query(criteria);
			if(dataObjects.size()>0){
				name = dataObjects.get(0).getString(retNameColumn);
			}
			DBConnection.closeSession(session, conn);
		}
		return name;
	}
	
	/**
	 * 通过ID获取ID及名称
	 * @param dsName;数据源别名
	 * @param entity;数据实体
	 * @param idColumns;ID字段名，多个字段用"，"分隔
	 * @param idValues;ID值，多个值用"，"分隔
	 * @param retIDColumn;返回的ID字段
	 * @param retNameColumn;返回的Name字段
	 * @return name;返回名称
	 */
	@Bizlet("通过ID获取ID及名称")
	public static String getIDAndNameByID(String dsName,String entity,String idColumns,String idValues,String retIDColumn,String retNameColumn)
			throws Exception {
		String name = "";
		if (!StringUtil.isEmptyStr(dsName)&&!StringUtil.isEmptyStr(entity)&&!StringUtil.isEmptyStr(idColumns)&&!StringUtil.isEmptyStr(idValues)&&!StringUtil.isEmptyStr(retNameColumn)) {
			Connection conn = DBConnection.getConnection(null, dsName);
			IDASSession session = DBConnection.getIDASSession(conn);
			IDASCriteria criteria = DASManager.createCriteria(entity);
			String [] column = idColumns.split(",");
			String [] value  = idValues.split(",");
			for(int i=0;i<column.length;i++){
			 criteria.add(ExpressionHelper.eq(column[i], value[i]));
			}
			
			List<DataObject> dataObjects = session.query(criteria);
			if(dataObjects.size()>0){
				name = dataObjects.get(0).getString(retIDColumn)+"(" + dataObjects.get(0).getString(retNameColumn)+")";
			}
			DBConnection.closeSession(session, conn);
		}
		return name;
	}
	
	/**
	 * 通过名称获取ID串
	 * @param dsName;数据源别名
	 * @param entity;数据实体
	 * @param nameColumn;名称字段，多个字段用"，"分隔
	 * @param nameValue;名称值，多个值用"，"分隔
	 * @param retIDColumn;返回的ID字段
	 * @return ids;返回ID串
	 */
	@Bizlet("通过名称获取ID串")
	public static String getIDSByName(String dsName,String entity,String nameColumn,String nameValue,String retIDColumn)
			throws Exception {
		String ids = "";
		if (!StringUtil.isEmptyStr(dsName)&&!StringUtil.isEmptyStr(entity)&&!StringUtil.isEmptyStr(retIDColumn)&&!StringUtil.isEmptyStr(nameValue)&&!StringUtil.isEmptyStr(nameColumn)) {
			Connection conn = DBConnection.getConnection(null, dsName);
			IDASSession session = DBConnection.getIDASSession(conn);
			IDASCriteria criteria = DASManager.createCriteria(entity);
			String [] column = nameColumn.split(",");
			String [] value  = nameValue.split(",");
			criteria.setProjection(ProjectionHelper.projectionList().add(ProjectionHelper.property(retIDColumn)));
			for(int i=0;i<column.length;i++){
			 criteria.add(ExpressionHelper.like(column[i], "%"+value[i]+"%"));
			}
			List<DataObject> dataObjects = session.query(criteria);
			for(int i=0;i<dataObjects.size();i++){
				DataObject dataObject = dataObjects.get(i);
				ids = ids+','+dataObject.getString(retIDColumn);
			}
			
			DBConnection.closeSession(session, conn);
		}
		return ids;
	}

}
