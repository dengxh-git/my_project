/*******************************************************************************
 * $Header$
 * $Revision$
 * $Date$
 *
 *==============================================================================
 *
 * Copyright (c) 2001-2006 sunline Technologies, Ltd.
 * All rights reserved.
 * 
 * Created on 2010-11-2
 *******************************************************************************/

package com.sunline.sunfi.sunfi_cm;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Random;

import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrintManager;
import net.sf.jasperreports.engine.JasperPrint;

import com.eos.common.connection.DataSourceHelper;
import com.eos.runtime.core.ApplicationContext;
import com.eos.system.annotation.Bizlet;
import com.eos.system.utility.DatetimeUtil;

/**
 * 
 * 提供IReport打印
 *
 * @author 安宣部 (mailto:anxb@sunline.cn)
 */
public class IReportUtil {
	
	public static final String PDF_TYPE = "pdf";//pdf打印文件
	public static final String HTML_TYPE = "html";//html打印文件
	/**
	 * 生成html打印文件
	 * @param jasperName
	 * @param dataSource
	 * @param parameters
	 * @return
	 */
	private String print(String jasperName, SunfiJRDataSource dataSource, HashMap parameters, String dsName ,String type){
		
		ApplicationContext context = ApplicationContext.getInstance(); 
		String WarRealPath = context.getWarRealPath();
		if(WarRealPath.endsWith(File.separator) == false) {
			WarRealPath = WarRealPath + File.separator;
		}
		//String  webPath = context.getWarRealPath() + "WEB-INF" + File.separator + "classes";
		//String  webPath = WarRealPath + "WEB-INF" + File.separator + "classes";
		//打印原文件目录
		String filepath = WarRealPath + "report" + File.separator + jasperName + ".jasper"; 
		//临时文件名
		String fileName = jasperName + DatetimeUtil.getCurrentTimeAsString() + new Random().nextInt(1000) ;
		//生成打印文件目录
		//String printPath = context.getWarRealPath() + "reporthtml" + File.separator;
		String printPath = WarRealPath + "reporthtml" + File.separator;
		File printFile = new File(printPath);
		if(!printFile.exists()){
			printFile.mkdir();
		}
		
		Connection conn = null;
		try{
			File reptfile = new File(filepath);
			JasperPrint jasperPrint;
			if(dataSource==null){
				conn = DataSourceHelper.getDataSource(dsName).getConnection();
				jasperPrint = JasperFillManager.fillReport(reptfile.getPath(),parameters,conn);
			}else{
				jasperPrint = JasperFillManager.fillReport(reptfile.getPath(),parameters,dataSource);
			}
			if (PDF_TYPE.equals(type)){//生成pdf文件
				fileName = fileName + ".pdf";
				JasperExportManager.exportReportToPdfFile(jasperPrint, printPath + fileName);
			}else if (HTML_TYPE.equals(type)){//生成html文件
				fileName = fileName + ".html";
				JasperExportManager.exportReportToHtmlFile(jasperPrint, printPath + fileName);
			}
			
		}catch(Exception ex){
			filepath = "";
			System.out.print("Jasper Output Error:" + ex.getMessage());
			ex.printStackTrace();
		}finally{
			if(conn != null){
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		filepath = "/reporthtml" + File.separator + fileName;
		return filepath;
	}
	
	/**
	 * 测试
	 */
	public static JasperPrint printForJsp(String jasperName, SunfiJRDataSource dataSource, HashMap parameters, String dsName ,String type){
		
		//临时文件目录
		ClassLoader classLoader = JasperPrint.class.getClassLoader();
		String webPath = classLoader.getResource("/").getPath();
		
		JasperPrint jasperPrint = null;
		
		//打印原文件目录
		String filepath = webPath + File.separator + "report" + File.separator + jasperName + ".jasper"; 
		 
		//临时文件名
		String fileName = jasperName + DatetimeUtil.getCurrentTimeAsString() + new Random().nextInt(1000) ;
		
		//生成打印文件目录
		String printPath = webPath.replaceAll("WEB-INF/classes/", "") + "reporthtml" + File.separator;
		File printFile = new File(printPath);
		if(!printFile.exists()){
			printFile.mkdir();
		}
		try{
			File reptfile = new File(filepath);
			
			if(dataSource==null){
				Connection conn = DataSourceHelper.getDataSource(dsName).getConnection();
				jasperPrint = JasperFillManager.fillReport(reptfile.getPath(),parameters,conn);
			}else{
				jasperPrint = JasperFillManager.fillReport(reptfile.getPath(),parameters,dataSource);
			}
			if (PDF_TYPE.equals(type)){//生成pdf文件
				fileName = fileName + ".pdf";
				JasperExportManager.exportReportToPdfFile(jasperPrint, printPath + fileName);
			}else if (HTML_TYPE.equals(type)){//生成html文件
				fileName = fileName + ".html";
				JasperExportManager.exportReportToHtmlFile(jasperPrint, printPath + fileName);
			}
			
		}catch(Exception ex){
			filepath = "";
			System.out.print("Jasper Output Error:" + ex.getMessage());
			ex.printStackTrace();
		}
		filepath = "/reporthtml" + File.separator + fileName;
		return jasperPrint;
	}
	
	/**
	 * 通过定时器调用本方法,定时删除打印文件
	 */
	public void emptyReport(){
		ApplicationContext context = ApplicationContext.getInstance();
		
		//打印文件目录
		String printPath = context.getWarRealPath() + "reporthtml" + File.separator;
		File printFileDic = new File(printPath);
		try{
			if(printFileDic.exists() && printFileDic.isDirectory()){
				File[] files = printFileDic.listFiles();
				for(int i=0;i<files.length;i++){
					files[i].delete();
				}			
			}			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	
	/**
	 * 生成html打印文件
	 * @param jasperName
	 * @param dataObjects
	 * @return
	 */
	@Bizlet("根据用户定义数据源生成html打印文件")
	public String print(String jasperName, HashMap [] paramHashMaps){
		return this.print(jasperName, new SunfiJRDataSource(paramHashMaps), null, null, "html");
	}
	
	/**
	 * 生成指定打印文件
	 * @param jasperName
	 * @param dataObjects
	 * @param type
	 * @return
	 */
	@Bizlet("根据用户定义数据源生成指定打印文件")
	public String print(String jasperName, HashMap [] paramHashMaps, String type){
		return this.print(jasperName, new SunfiJRDataSource(paramHashMaps), null, null, type);
	}
	
	/**
	 * 生成html打印文件
	 * @param jasperName
	 * @param parameters
	 * @param dsName
	 * @return
	 */
	@Bizlet("根据用户自定义数据库连接生成html打印文件")
	public String print(String jasperName, HashMap parameters, String dsName){
		return this.print(jasperName, null, parameters, dsName, "html");
	}
	
	/**
	 * 生成指定打印文件
	 * @param jasperName
	 * @param parameters
	 * @param dsName
	 * @param type
	 * @return
	 */
	@Bizlet("根据用户自定义数据库连接生成指定打印文件")
	public String print(String jasperName, HashMap parameters, String dsName, String type){
		return this.print(jasperName, null, parameters, dsName, type);
	}
	
}
