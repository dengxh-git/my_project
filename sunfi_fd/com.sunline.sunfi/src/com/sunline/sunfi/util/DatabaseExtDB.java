/**
 * 版权所有：版权所有(C) 2010，长亮科技
 * 文件编号：无
 * 文件名称：DatabaseExtDB.java
 * 系统编号：CRM V1.0
 * 系统名称：CRM
 * 设计作者：杨小云
 * 完成日期：2012.3.19
 * 设计文档：无
 * 内容摘要：此类在DatabaseExt外面再套了一层，方法与DatabaseExt一模一样，开发人员可以调用此类，也可以修改此类，更为灵活
 * 		   该类增加了一个重要方法getNameSqlIdByDB，该方法可以转换命名sql，会根据你的命名sql名称，自动调用对应的数据库的命名sql
 */
package com.sunline.sunfi.util;
import java.sql.Connection;
import java.util.List;

import com.eos.das.entity.IDASSession;
import com.eos.das.entity.SequenceGenerator;
import com.eos.das.sql.INamedSqlSession;
import com.eos.das.sql.NamedSqlSessionFactory;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.system.exception.EOSRuntimeException;

import commonj.sdo.DataObject;

@Bizlet("Extended database operating tools")
public class DatabaseExtDB extends DatabaseUtil {
	// 数据库类型
	private final static String DB_TYPE = "ORACLE";

	// 是否跨数据库标识，true为跨数据库，false为单一数据库
	private final static boolean IS_OVER_DATABASE_FLAG = true;

	/**
	 * 根据数据库类型转换命名sql
	 * 
	 * @param nameSqlId
	 * @return
	 */
	private static String getNameSqlIdByDB(String nameSqlId) {
		// 如果跨数据库标识为false，则直接返回命名sql
		if (!IS_OVER_DATABASE_FLAG) {
			return nameSqlId;
		}

		// 先判断不用处理的情况
		if (nameSqlId == null || "".equals(nameSqlId.trim())
				|| !nameSqlId.contains(".")) {
			return nameSqlId;
		}

		StringBuffer resultSql = new StringBuffer("");
		String[] sqlArr = nameSqlId.split("\\.");

		/*
		 * 在倒数第二个字符串，将数据库标识替换掉，或者加上
		 */
		for (int i = 0; i < sqlArr.length; i++) {
			if (i > 0)
				resultSql.append(".");

			if (i == sqlArr.length - 2) {
				if (sqlArr[i].startsWith("ORACLE")
						|| sqlArr[i].startsWith("DB2")
						|| sqlArr[i].startsWith("SYSBASE")) {
					resultSql.append(sqlArr[i].replace("ORACLE", DB_TYPE)
							.replace("DB2", DB_TYPE)
							.replace("SYSBASE", DB_TYPE));
				} else {
					resultSql.append(DB_TYPE).append(sqlArr[i]);
				}
			} else {
				resultSql.append(sqlArr[i]);
			}
		}
		return resultSql.toString();
	}

	@Bizlet(value = "Get sequence according to the name", params = { @com.eos.system.annotation.BizletParam(index = 0, type = com.eos.system.annotation.ParamType.CONSTANT) })
	public static long getNextSequence(String name) throws Exception {
		return SequenceGenerator.getNextSequence(name);
	}

	@Bizlet(value = "Set sequence", params = {
			@com.eos.system.annotation.BizletParam(index = 0, type = com.eos.system.annotation.ParamType.CONSTANT),
			@com.eos.system.annotation.BizletParam(index = 1, type = com.eos.system.annotation.ParamType.CONSTANT) })
	public static void setSequenceValue(String name, long value)
			throws Exception {
		SequenceGenerator.setValue(name, value);
	}

	@Bizlet(value = "Use criteria or template to query with page.", params = { @com.eos.system.annotation.BizletParam(index = 0, defaultValue = "default", type = com.eos.system.annotation.ParamType.CONSTANT) })
	public static DataObject[] commonQueryWithPage(String dsName,
			DataObject criteria, Object pagecond) throws EOSRuntimeException {
		return DatabaseExt.commonQueryWithPage(dsName, criteria, pagecond);

	}

	@Bizlet(value = "Query with page according to SDO query template.", params = { @com.eos.system.annotation.BizletParam(index = 0, defaultValue = "default", type = com.eos.system.annotation.ParamType.CONSTANT) })
	public static DataObject[] queryEntitiesByTemplateWithPage(String dsName,
			DataObject template, DataObject pagecond)
			throws EOSRuntimeException {
		return DatabaseExt.queryEntitiesByTemplateWithPage(dsName, template,
				pagecond);
	}

	@Bizlet(value = "Query with page according to criteria entity", params = { @com.eos.system.annotation.BizletParam(index = 0, defaultValue = "default", type = com.eos.system.annotation.ParamType.CONSTANT) })
	public static DataObject[] queryEntitiesByCriteriaEntityWithPage(
			String dsName, DataObject criteriaEntity, DataObject pagecond)
			throws EOSRuntimeException {
		return DatabaseExt.queryEntitiesByCriteriaEntityWithPage(dsName,
				criteriaEntity, pagecond);
	}

	@Bizlet(value = "Query according to namedsql", params = {
			@com.eos.system.annotation.BizletParam(index = 0, defaultValue = "default", type = com.eos.system.annotation.ParamType.CONSTANT),
			@com.eos.system.annotation.BizletParam(index = 1, type = com.eos.system.annotation.ParamType.CONSTANT) })
	public static Object[] queryByNamedSql(String dsName, String nameSqlId,
			Object parameterObject) throws EOSRuntimeException {
		return DatabaseExt.queryByNamedSql(dsName, getNameSqlIdByDB(nameSqlId),
				parameterObject);
	}

	@Bizlet("返回list，不返回数组，功能跟queryByNamedSql一样")
	public static List queryListByNamedSql(String dsName, String nameSqlId,
			Object parameterObject) {
		Connection conn = null;
		INamedSqlSession session = null;
		List list = null;
		try {
			conn = DatabaseUtil.getConnection(dsName);
			session = NamedSqlSessionFactory.createSQLMapSession(conn);
			list = session.queryForList(getNameSqlIdByDB(nameSqlId),
					parameterObject);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DatabaseUtil.closeConnection(session, conn);
		}
		return list;
	}

	@Bizlet(value = "Count the number of query result of namedsql.", params = {
			@com.eos.system.annotation.BizletParam(index = 0, defaultValue = "default", type = com.eos.system.annotation.ParamType.CONSTANT),
			@com.eos.system.annotation.BizletParam(index = 1, type = com.eos.system.annotation.ParamType.CONSTANT) })
	public static int countByNamedSql(String dsName, String nameSqlId,
			Object parameterObject) throws EOSRuntimeException {
		return DatabaseExt.countByNamedSql(dsName, getNameSqlIdByDB(nameSqlId),
				parameterObject);
	}

	@Bizlet(value = "Query with page according to namedsql.", params = {
			@com.eos.system.annotation.BizletParam(index = 0, defaultValue = "default", type = com.eos.system.annotation.ParamType.CONSTANT),
			@com.eos.system.annotation.BizletParam(index = 1, type = com.eos.system.annotation.ParamType.CONSTANT),
			@com.eos.system.annotation.BizletParam(index = 2, type = com.eos.system.annotation.ParamType.CONSTANT),
			@com.eos.system.annotation.BizletParam(index = 3, type = com.eos.system.annotation.ParamType.CONSTANT) })
	public static Object[] queryByNamedSql(String dsName, String nameSqlId,
			int begin, int length, Object parameterObject)
			throws EOSRuntimeException {
		return DatabaseExt.queryByNamedSql(dsName, getNameSqlIdByDB(nameSqlId),
				begin, length, parameterObject);

	}

	@Bizlet(value = "Query with page according to namedsql.", params = {
			@com.eos.system.annotation.BizletParam(index = 0, defaultValue = "default", type = com.eos.system.annotation.ParamType.CONSTANT),
			@com.eos.system.annotation.BizletParam(index = 1, type = com.eos.system.annotation.ParamType.CONSTANT) })
	public static Object[] queryByNamedSqlWithPage(String dsName,
			String nameSqlId, DataObject pageCond, Object parameterObject)
			throws EOSRuntimeException {
		return DatabaseExt.queryByNamedSqlWithPage(dsName,
				getNameSqlIdByDB(nameSqlId), pageCond, parameterObject);
	}

	@Bizlet(value = "Execute specified namedsql", params = {
			@com.eos.system.annotation.BizletParam(index = 0, defaultValue = "default", type = com.eos.system.annotation.ParamType.CONSTANT),
			@com.eos.system.annotation.BizletParam(index = 1, type = com.eos.system.annotation.ParamType.CONSTANT) })
	public static void executeNamedSql(String dsName, String nameSqlId,
			Object parameterObject) throws EOSRuntimeException {
		DatabaseExt.executeNamedSql(dsName, getNameSqlIdByDB(nameSqlId),
				parameterObject);
	}

	@Bizlet(value = "Batch executing specified namedsql", params = {
			@com.eos.system.annotation.BizletParam(index = 0, defaultValue = "default", type = com.eos.system.annotation.ParamType.CONSTANT),
			@com.eos.system.annotation.BizletParam(index = 1, type = com.eos.system.annotation.ParamType.CONSTANT) })
	public static int executeNamedSqlBatch(String dsName, String nameSqlId,
			Object[] parameterObjects) {
		return DatabaseExt.executeNamedSqlBatch(dsName,
				getNameSqlIdByDB(nameSqlId), parameterObjects);
	}

	@Bizlet(value = "Lock the record according to the primary key", params = { @com.eos.system.annotation.BizletParam(index = 0, defaultValue = "default", type = com.eos.system.annotation.ParamType.CONSTANT) })
	public static void lockEntity(String dsName, DataObject dataObject)
			throws EOSRuntimeException {
		DatabaseExt.lockEntity(dsName, dataObject);
	}

	public static void lockEntity(IDASSession dasSession, DataObject entity) {
		DatabaseExt.lockEntity(dasSession, entity);
	}

	@Bizlet("Generate sequence for primary key  of persistent entity")
	public static void getPrimaryKey(DataObject entity) {
		DatabaseExt.getPrimaryKey(entity);
	}

	@Bizlet(value = "Cascade update a record", params = { @com.eos.system.annotation.BizletParam(index = 0, defaultValue = "default", type = com.eos.system.annotation.ParamType.CONSTANT) })
	public static void insertEntityCascade(String dsName, DataObject entity) {
		DatabaseExt.insertEntityCascade(dsName, entity);
	}

	@Bizlet(value = " Cascade delete a record", params = { @com.eos.system.annotation.BizletParam(index = 0, defaultValue = "default", type = com.eos.system.annotation.ParamType.CONSTANT) })
	public static void deleteEntityCascade(String dsName, DataObject entity) {
		DatabaseExt.deleteEntityCascade(dsName, entity);
	}

	@Bizlet(value = "Cascade update a record", params = {
			@com.eos.system.annotation.BizletParam(index = 0, defaultValue = "default", type = com.eos.system.annotation.ParamType.CONSTANT),
			@com.eos.system.annotation.BizletParam(index = 2, type = com.eos.system.annotation.ParamType.CONSTANT) })
	public static void updateEntityCascade(String dsName, DataObject entity,
			String[] property) {
		DatabaseExt.updateEntityCascade(dsName, entity, property);
	}

	@Bizlet(value = "Execute namedSql", params = {
			@com.eos.system.annotation.BizletParam(index = 0, defaultValue = "default", type = com.eos.system.annotation.ParamType.CONSTANT),
			@com.eos.system.annotation.BizletParam(index = 1, type = com.eos.system.annotation.ParamType.CONSTANT) })
	public static int executeNamedSqlWithResult(String dsName,
			String nameSqlId, Object parameterObject)
			throws EOSRuntimeException {
		return DatabaseExt.executeNamedSqlWithResult(dsName,
				getNameSqlIdByDB(nameSqlId), parameterObject);
	}

	public static String[] getIdPropertyNames(IDASSession dasSession,
			String entityName) {
		return DatabaseExt.getIdPropertyNames(dasSession, entityName);
	}

	public static String[] getCollectionPropertyNames(IDASSession dasSession,
			String entityName) {
		return DatabaseExt.getCollectionPropertyNames(dasSession, entityName);
	}

	public static String[] getCollectionPropertyColumnNames(
			IDASSession dasSession, String entityName, String propertyName) {
		return DatabaseExt.getCollectionPropertyColumnNames(dasSession,
				entityName, propertyName);
	}

	public static String getPropertyNameByColumnNames(IDASSession dasSession,
			String entityName, String[] targetColumnNames,
			List<String> collectFields) {
		return DatabaseExt.getPropertyNameByColumnNames(dasSession, entityName,
				targetColumnNames, collectFields);
	}

	@Bizlet(value = "Get description from CodeEntity and set it to the specified property of entities", params = {
			@com.eos.system.annotation.BizletParam(index = 0, defaultValue = "default", type = com.eos.system.annotation.ParamType.CONSTANT),
			@com.eos.system.annotation.BizletParam(index = 2, type = com.eos.system.annotation.ParamType.CONSTANT),
			@com.eos.system.annotation.BizletParam(index = 3, type = com.eos.system.annotation.ParamType.CONSTANT),
			@com.eos.system.annotation.BizletParam(index = 4, type = com.eos.system.annotation.ParamType.CONSTANT),
			@com.eos.system.annotation.BizletParam(index = 5, type = com.eos.system.annotation.ParamType.CONSTANT),
			@com.eos.system.annotation.BizletParam(index = 6, type = com.eos.system.annotation.ParamType.CONSTANT) })
	public static void fillCodeDesc(String dsName, DataObject[] entities,
			String propertyName, String codeEntityName,
			String associationPropertyName, String codeEntityPropertyName,
			String entityPropertyName) {
		DatabaseExt.fillCodeDesc(dsName, entities, propertyName,
				codeEntityName, associationPropertyName,
				codeEntityPropertyName, entityPropertyName);
	}

	/** @deprecated */
	public static void getCodeDescInEntity(String dsName,
			DataObject[] entities, String propertyName, String codeEntityName,
			String associationPropertyName, String codeEntityPropertyName,
			String entityPropertyName) {
		DatabaseExt.getCodeDescInEntity(dsName, entities, propertyName,
				codeEntityName, associationPropertyName,
				codeEntityPropertyName, entityPropertyName);
	}

	@Bizlet(value = "Generate the where sql statement according to criteriaDataObject", params = { @com.eos.system.annotation.BizletParam(index = 0, defaultValue = "default", type = com.eos.system.annotation.ParamType.CONSTANT) })
	public static String generateWhereSql(String dsName,
			DataObject criteriaDataObject) {
		return DatabaseExt.generateWhereSql(dsName, criteriaDataObject);
	}

	@Bizlet(value = "Get table name", params = { @com.eos.system.annotation.BizletParam(index = 0, defaultValue = "default", type = com.eos.system.annotation.ParamType.CONSTANT) })
	public static String getTableName(String dsName, String entityName) {
		return DatabaseExt.getTableName(dsName, entityName);
	}
}