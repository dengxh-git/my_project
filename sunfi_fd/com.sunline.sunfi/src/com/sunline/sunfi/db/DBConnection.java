/*******************************************************************************
 * $Header$
 * $Revision$
 * $Date$
 *
 *==============================================================================
 *
 * Copyright (c) 2002-2009 Shenzhen Sunline Tech Co.,Ltd.
 * All rights reserved.
 * 
 * Created on 2009-4-28
 *******************************************************************************/


package com.sunline.sunfi.db;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.eos.common.connection.ConnectionHelper;
import com.eos.das.entity.DASManager;
import com.eos.das.entity.IDASSession;
import com.eos.das.sql.INamedSqlSession;
import com.eos.system.exception.EOSRuntimeException;
/**
 * ȡ���ݿ����ӹ�����
 * TODO �˴���д class ��Ϣ
 *
 * @author dailihui (mailto:dailh@sunline.cn)
 */
/*
 * �޸���ʷ
 * $Log$
 */
public class DBConnection 
{


	/**
	 * ��ȡָ��contribution�ͱ��������ݿ����ӡ�
	 * @param contributionName
	 * @param dsName
	 * @return
	 * @throws Exception
	 */
	public static Connection getConnection(String contributionName,String dsName) throws Exception {
		if (dsName == null || dsName.trim().equals(""))
			dsName = "sunfi";
			if( contributionName == null || "".equals(contributionName.trim()) )
				return ConnectionHelper.getConnection(dsName);
			else
				return ConnectionHelper.getContributionConnection(contributionName, dsName);
	}

	/**
	 * ��õ�ǰcontribution��Ĭ�����ݿ�����
	 * @return
	 * @throws Exception
	 */
	public static Connection getConnection() throws Exception {
		return getConnection(null,null);
	}

	/**
	 * ��ȡָ���������ӵ����ݷ��ʻỰ����
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public static INamedSqlSession getINamedSqlSession(Connection conn) throws Exception {
		return com.eos.das.sql.NamedSqlSessionFactory.createSQLMapSession(conn);
	}

	
//	/**
//	 * ���ָ��contribution�ͱ��������ݷ��ʻỰ����
//	 * @param contributionName
//	 * @param dsName
//	 * @return
//	 * @throws Exception
//	 */
//	public static INamedSqlSession getINamedSqlSession(String contributionName,String dsName) throws Exception { 
//		return  getINamedSqlSession(getConnection(contributionName,dsName));
//	}
	
	/**
	 * ��ȡ��ǰcontribution��Ĭ����������
	 * @return
	 * @throws Exception
	 */
	public static INamedSqlSession getINamedSqlSession() throws Exception {
		return  getINamedSqlSession(getConnection());
	}
	/**
	 * ��ȡָ���������ӵ����ݷ��ʻỰ����
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public static IDASSession getIDASSession(Connection conn) throws Exception {
		return DASManager.createDasSession(conn);
	}
	public static IDASSession getIDASSession() throws Exception {
		return DASManager.createDasSession(getConnection());
	}
	/**
	 *  �ر�IDASSession ���ݿ�����
	 * @param session
	 * @param conn
	 */
	public static void closeSession(IDASSession session, Connection conn) {
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

	/**
	 * �ر�����sql��DAS session�����ݿ����ӡ�
	 * 
	 * @param session  ���ݷ��ʻỰ����
	 * @param conn  ���ݿ����ӡ�
	 */
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

	   /**
     * �ͷ����е����ݿ������Դ��������finally����
     * @param conn
     * @param stmt
     * @param rs
     * @author 
     * @since 
     */
    public static void closeConnection(Connection conn,Statement stmt,ResultSet rs)
    {
        if(rs!=null)
        {
            try
            {
                rs.close();
            }
            catch(Exception e)
            {
            }
        }
        if(stmt!=null)
        {
            try
            {
                stmt.close();
            }
            catch(Exception e)
            {
            }
        }
        if(conn!=null)
        {
            try
            {
                conn.close();
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
        }
    }

    /**
     * �ͷ����е����ݿ������Դ��������finally����
     * @param conn
     * @param pstmt
     * @param rs
     * @author 
     * @since 
     */
    public static void closeConnection(Connection conn,PreparedStatement pstmt,ResultSet rs)
    {
        if(rs!=null)
        {
            try
            {
                rs.close();
            }
            catch(Exception e)
            {
            }
        }
        if(pstmt!=null)
        {
            try
            {
                pstmt.close();
            }
            catch(Exception e)
            {
            }
        }
        if(conn!=null)
        {
            try
            {
                conn.close();
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
        }
    }


    /**
     * �ͷ����е����ݿ������Դ��������finally����
     * @param conn
     * @param stmt
     * @param cs
     * @author 
     * @since 
     */
    public static void closeConnection(Connection conn,CallableStatement cs,ResultSet rs)
    {
        if(rs!=null)
        {
            try
            {
                rs.close();
            }
            catch(Exception e)
            {
            }
        }
        if(cs!=null)
        {
            try
            {
                cs.close();
            }
            catch(Exception e)
            {
            }
        }
        if(conn!=null)
        {
            try
            {
                conn.close();
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
        }
    }
	
    
}
