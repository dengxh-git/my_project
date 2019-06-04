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
 * 取数据库连接工具类
 * TODO 此处填写 class 信息
 *
 * @author dailihui (mailto:dailh@sunline.cn)
 */
/*
 * 修改历史
 * $Log$
 */
public class DBConnection 
{


	/**
	 * 获取指定contribution和别名的数据库连接。
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
	 * 获得当前contribution的默认数据库连接
	 * @return
	 * @throws Exception
	 */
	public static Connection getConnection() throws Exception {
		return getConnection(null,null);
	}

	/**
	 * 获取指定数据连接的数据访问会话对象
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public static INamedSqlSession getINamedSqlSession(Connection conn) throws Exception {
		return com.eos.das.sql.NamedSqlSessionFactory.createSQLMapSession(conn);
	}

	
//	/**
//	 * 获得指定contribution和别名的数据访问会话对象
//	 * @param contributionName
//	 * @param dsName
//	 * @return
//	 * @throws Exception
//	 */
//	public static INamedSqlSession getINamedSqlSession(String contributionName,String dsName) throws Exception { 
//		return  getINamedSqlSession(getConnection(contributionName,dsName));
//	}
	
	/**
	 * 获取当前contribution的默认数据连接
	 * @return
	 * @throws Exception
	 */
	public static INamedSqlSession getINamedSqlSession() throws Exception {
		return  getINamedSqlSession(getConnection());
	}
	/**
	 * 获取指定数据连接的数据访问会话对象
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
	 *  关闭IDASSession 数据库连接
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
	 * 关闭命名sql的DAS session和数据库连接。
	 * 
	 * @param session  数据访问会话对象。
	 * @param conn  数据库连接。
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
     * 释放所有的数据库操作资源，请用在finally块里
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
     * 释放所有的数据库操作资源，请用在finally块里
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
     * 释放所有的数据库操作资源，请用在finally块里
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
