/**
 * 
 */
package com.sunline.sunfi.sunfi_wf.util;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.eos.common.connection.ConnectionHelper;
import com.eos.das.sql.INamedSqlSession;
import com.eos.das.sql.NamedSqlSessionFactory;
import com.eos.system.annotation.Bizlet;
import com.eos.system.exception.EOSRuntimeException;
import com.eos.workflow.omservice.WFParticipant;

/**
 * @author kaifasishi82
 * @date 2018-12-28 09:00:22
 *
 */
@Bizlet("")
public class SunfiParticipant {
	
	//接口实现的命名sql名称
		private static String namedsqlset = "com.sunline.sunfi.sunfi_wf.util.sunfiparticipant.";
		
		private static String dsPackage = "com.sunline.sunfi.sunfi_wf";
		//数据源名称
		private static String dsName = "default";
	
		/**
		 * 根据流程实例id获取参与者
		 * @param wkflid
		 * @return
		 */
		@SuppressWarnings("rawtypes")
		public static List getPatticipantBywkflid(String wkflid){ 
			List<WFParticipant> wfParticipants = new ArrayList<WFParticipant>();
			Map<String, String> parameterMap = new HashMap<String, String>();
			parameterMap.put("wkflid", wkflid);
			wfParticipants = queryNamedSql("query_wkflid", parameterMap);
		    return wfParticipants;
		}
		
		/**
		 * 根据角色和用户获取参与者
		 * @param roleid
		 * @param usercd
		 * @return
		 */
		@SuppressWarnings("rawtypes")
		public static List getPatticipantByuserRole(String roleid,String usercd){ 
			List<WFParticipant> wfParticipants = new ArrayList<WFParticipant>();
			Map<String, String> parameterMap = new HashMap<String, String>();
			parameterMap.put("roleid", roleid);
			parameterMap.put("usercd", usercd);
			wfParticipants = queryNamedSql("query_roleUser", parameterMap);
		    return wfParticipants;
		}
		
		@SuppressWarnings("unchecked")
		protected static List<WFParticipant> queryNamedSql(String namedSql, Object param) {
			return queryNamedSql(null,namedsqlset + namedSql, param);
		}
		@SuppressWarnings("rawtypes")
		public static List queryNamedSql(String dsName,String namedSql, Object param) {
			Connection conn = null;
			INamedSqlSession session = null;
			try {
				conn =getConnection(dsName);
				session = NamedSqlSessionFactory.createSQLMapSession(conn);
				List result = session.queryForList(namedSql, param);
				return result;
			} finally {
				closeSession(session, conn);
			}
		}
		public static Connection getConnection(String name) {
			if (name == null || name.trim().equals(""))
				name = dsName;
			return getConnection(dsPackage, name);
		}
		
		public static Connection getConnection(String packname, String name) {
			Connection conn = null;
			if (name == null || name.trim().equals("")) {
				name = dsName;
			}
			if (packname == null || packname.trim().equals("")) {
				packname = dsPackage;
			}
	        try{
	        	conn =ConnectionHelper.getContributionConnection(packname, name);
	        }catch(Exception e){
	        }
			return conn;
		}
		
		public static void closeSession(INamedSqlSession session, Connection conn) {
			if (session != null) {
				try {
					session.close();
				} catch (Exception e) {
					throw new EOSRuntimeException("Close session failed!", e);
				}
			}
			if (conn != null) {
				try {
					if (!conn.isClosed())
						conn.close();
				} catch (Exception e) {
					throw new EOSRuntimeException("Close connection failed!", e);
				}
			}
		}

}
