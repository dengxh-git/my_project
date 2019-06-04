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
 * TODO �˴���д class ��Ϣ ��������
 * 
 * @author luxl (mailto:luxl@sunline.cn)
 */

@Bizlet("ͨ��ID��ȡ���ƻ�ͨ�����ƻ�ȡID��")
public class GetNameOrID {
	
	/**
	 * ͨ��ID��ȡ����
	 * @param dsName;����Դ����
	 * @param entity;����ʵ��
	 * @param idColumns;ID�ֶ���������ֶ���"��"�ָ�
	 * @param idValues;IDֵ�����ֵ��"��"�ָ�
	 * @param retNameColumn;���ص�Name�ֶ�
	 * @return name;��������
	 */
	@Bizlet("ͨ��ID��ȡ����")
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
	 * ͨ��ID��ȡID������
	 * @param dsName;����Դ����
	 * @param entity;����ʵ��
	 * @param idColumns;ID�ֶ���������ֶ���"��"�ָ�
	 * @param idValues;IDֵ�����ֵ��"��"�ָ�
	 * @param retIDColumn;���ص�ID�ֶ�
	 * @param retNameColumn;���ص�Name�ֶ�
	 * @return name;��������
	 */
	@Bizlet("ͨ��ID��ȡID������")
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
	 * ͨ�����ƻ�ȡID��
	 * @param dsName;����Դ����
	 * @param entity;����ʵ��
	 * @param nameColumn;�����ֶΣ�����ֶ���"��"�ָ�
	 * @param nameValue;����ֵ�����ֵ��"��"�ָ�
	 * @param retIDColumn;���ص�ID�ֶ�
	 * @return ids;����ID��
	 */
	@Bizlet("ͨ�����ƻ�ȡID��")
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
