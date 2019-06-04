package com.sunline.sunfi.config;

import java.io.File;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.xpath.XPath;

import com.eos.runtime.core.TraceLoggerFactory;
import com.eos.system.annotation.Bizlet;
import com.eos.system.logging.Logger;
import com.sunline.sunfi.bus.FIException;
import com.sunline.sunfi.util.FileUtil;
import com.sunline.sunfi.util.JDomUtil;

/**
 * 
 * <p>
 * Title:sunfi系统配置文件,路径：\\WEB-INF\\sunline\\config.xml
 * </p>
 * <p>
 * Description:sunfi系统整个配置文件入口，整个配置文件系统都在一个xml文件中
 * </p>
 * <p>
 * Copyright: Copyright (c) 2005 Sunline.
 * </p>
 * <p>
 * Company: Sunline Technologies.
 * </p>
 * 
 * @author goutf@sunline.cn
 * @version 1.0
 */
public class FIConfig {

	private static final Logger logger = TraceLoggerFactory.getLogger(FIConfig.class);

	/**
	 * 站点目录/WEB-INF/sunline 注意：FileUtil.getHomePath()首次加载[服务器首次启动]能够正确解析路径，
	 * 调用类重新编译后取出的路径为：站点目录/class/WEB-INF/sunline
	 */
	private static String sunline_Path = FileUtil.getHomePath();

	/**
	 * fiConf配置文件
	 */
	private static JDomUtil jdomUtil = null;

	/**
	 * 调试状态
	 */
	private static boolean debug = false;

	/**
	 * 站点名称
	 */
	private static String siteName = null;

	/**
	 * 应用名称
	 */
	private static String appName = null;
	
	/**
	 * 缺省语言地区代码
	 */
	private static String locale = null;

	/**
	 * 报表服务器
	 */
	private static String reportUrl = null;

	/**
	 * 分析报表服务器
	 */
	private static String biReportUrl = null;

	private static String jspEncoding = null;

	private static boolean isInit = false;
	
	/**
	 * 文件服务配置
	 */
	private static String repositoryType = null;
	
	private static String repositoryDestination = null;
	
	private static int filemaxsize = -1;
	
	private static int fileSizethreshold = -1;

	/**
	 * 系统初始化
	 */
	private static void init() {
		isInit = false;
		try {
			logger.info("load FI configuration file:" + sunline_Path + "config.xml");

			Document config = JDomUtil.getDocument(new File(sunline_Path + "config.xml"));
			jdomUtil = new JDomUtil(config);

			appName = getString("/config/ficonfig/appname");
			locale = getString("/config/ficonfig/locale");
			siteName = getString("/config/ficonfig/sitename");
			debug = Boolean.valueOf(getString("/config/debug")).booleanValue();
			reportUrl = getString("/config/reportserver/@URL");
			biReportUrl = getString("/config/reportserver/bireport/@URL");
			repositoryType = getString("/config/fileservice/repository/@type");
			repositoryDestination = getString("/config/fileservice/repository/@destination");
			filemaxsize = Integer.valueOf(getString("/config/fileservice/maxsize"));
			fileSizethreshold = Integer.valueOf(getString("/config/fileservice/sizethreshold"));
			isInit = true;
			logger.info("load FI configuration file success!");
		} catch (Exception ex) {
			ex.printStackTrace();
		}

	}

	/**
	 * 根据XPATH取字符串值
	 * 
	 * @param xpath
	 * @return
	 * @throws JDOMException
	 */
	@Bizlet(value = "根据XPATH取字符串值")
	public static String getString(String xpath)  throws JDOMException {
		return getUtil().getSingleNodeString(xpath);
	}

	/**
	 * 取JDomUtil工具
	 * 
	 * @return
	 */
	public static JDomUtil getUtil() {
		if (jdomUtil == null){
			jdomUtil = new JDomUtil(JDomUtil.getDocument(new File(sunline_Path
					+ "config.xml")));
		}
		return jdomUtil;
	}

	/**
	 * 整个xml的Document形式返回
	 * 
	 * @return Document
	 */
	public static Document getFIConf() {
		return getUtil().getXmlDoc();
	}

	/**
	 * 根据xPath 取得Element元素
	 * 
	 * @param xPath
	 *            String
	 * @return Element
	 */
	public static Element getElement(String xPath) throws FIException {
		try {
			if (!isInit) {
				init();
			}
			return ((Element) XPath.selectSingleNode(getFIConf(), xPath));
		} catch (Exception ex) {
			throw new FIException("0000", "Ensure that the configuration file path analysis is correct：xPath=" + xPath);
		}
	}

	/**
	 * 应用系统名称
	 * 
	 * @return String
	 */
	public static String getAppname() {
		if (!isInit) {
			init();
		}
		return appName;
	}
	
	/**
	 * 缺省语言地区代码
	 * 
	 * @return String
	 */
	public static String getLocale() {
		if (!isInit) {
			init();
		}
		return locale;
	}

	/**
	 * 站点名称
	 * 
	 * @return String
	 */
	public static String getSiteName() {
		if (!isInit) {
			init();
		}
		return siteName;
	}

	public static void setDebug(boolean isdebug) {
		debug = isdebug;
	}

	public static boolean isDebug() {
		if (!isInit)
			init();
		return debug;

	}

	public static String getRptUrl() {
		if (!isInit)
			init();
		return reportUrl;
	}

	public static String getBiRptUrl() {
		if (!isInit)
			init();
		return biReportUrl;
	}

	public static void doReload() {
		init();
	}

	/**
	 * @return the jspEncoding
	 */
	public static String getJspEncoding() {
		if (!isInit)
			init();
		return jspEncoding;
	}

	/**
	 * @return Returns the filemaxsize.
	 */
	public static int getFilemaxsize() {
		if (!isInit)
			init();
		return filemaxsize;
	}

	/**
	 * @return Returns the fileSizethreshold.
	 */
	public static int getFileSizethreshold() {
		if (!isInit)
			init();
		return fileSizethreshold;
	}

	/**
	 * @return Returns the repositoryDestination.
	 */
	public static String getRepositoryDestination() {
		if (!isInit)
			init();
		return repositoryDestination;
	}
	
	/**
	 * @return Returns the repositoryType.
	 */
	@Bizlet(value = "获取上传文件类别")
	public static String getRepositoryType() {
		if (!isInit)
			init();
		return repositoryType;
	}

}