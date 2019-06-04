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
 * Created on 2011-10-1
 *******************************************************************************/


package com.sunline.sunfi.util;

import java.io.InputStream;
import java.io.PrintStream;

import org.apache.commons.net.telnet.TelnetClient;
import org.apache.log4j.Logger;

import com.eos.system.annotation.Bizlet;

public class TelnetCommandRunner {
	
	private static final Logger logger = Logger.getLogger(TelnetCommandRunner.class);
			
	private TelnetClient telnet = new TelnetClient();    
	private InputStream in;    
	private PrintStream out;    
	private char prompt = '$';// 普通用户结束    

	public TelnetCommandRunner( String host, int port, String user, String password, String prompt) {    
		try {    
			telnet.connect( host, port );    
			in = telnet.getInputStream();    
			out = new PrintStream( telnet.getOutputStream() );    
			// 根据root用户设置结束符
			if(null != prompt && !"".equals(prompt)){
				this.prompt = prompt.charAt(0);
			}else{
				this.prompt = user.equals( "root" ) ? '#' : '$';
			}
			login( user, password );    
		} catch ( Exception e ) {    
			e.printStackTrace();    
		}    
	}    

	/**   
	 * 登录   
	 *    
	 * @param user   
	 * @param password   
	 */   
	public void login( String user, String password ) {    
		readUntil( "login:" );    
		write( user );    
		readUntil( "Password:" );    
		write( password );    
		readUntil( prompt + "" );    
	}    

	/**   
	 * 读取分析结果   
	 *    
	 * @param pattern   
	 * @return   
	 */   
	public String readUntil( String pattern ) {    
		try {    
			char lastChar = pattern.charAt( pattern.length() - 1 ); 
			//System.out.println("lastChar:"+lastChar);
			StringBuffer sb = new StringBuffer();    
			char ch = ( char ) in.read();    
			while ( true ) {    
				sb.append( ch );    
				if (ch == lastChar) {    
					if (sb.toString().endsWith( pattern )) {    
						return sb.toString();    
					}    
				}    
				ch = ( char ) in.read();    
			}    
		} catch ( Exception e ) {    
			e.printStackTrace();    
		}    
		return null;    
	}    

	/**   
	 * 写操作   
	 *    
	 * @param value   
	 */   
	public void write( String value ) {    
		try {    
			out.println( value );    
			out.flush();    
		} catch ( Exception e ) {    
			e.printStackTrace();    
		}    
	}    

	/**   
	 * 向目标发送命令字符串   
	 *    
	 * @param command   
	 * @return   
	 */   
	public String sendCommand( String command ) {    
		try {    
			write( command );    
			return readUntil( prompt + "" );    
		} catch ( Exception e ) {    
			e.printStackTrace();    
		}    
		return null;    
	}    

	/**   
	 * 关闭连接   
	 */   
	public void disconnect() {    
		try {    
			telnet.disconnect();    
		} catch ( Exception e ) {    
			e.printStackTrace();    
		}    
	}    
    
	/**
	 * 通过Telnet连接执行脚本
	 * @param host
	 * @param port
	 * @param username
	 * @param password
	 * @param cmd
	 * @return
	 */
	@Bizlet(value = "通过Telnet连接执行脚本")
	public static int runCmd(String host, String port, String username, String password,
			String cmd, String prompt){
		int ret = -1;
		try {
			TelnetCommandRunner telnet = new TelnetCommandRunner( host, Integer.valueOf(port), username, password, prompt );
			//拆分路径与脚本内容
			int idx =  cmd.lastIndexOf("/");
			telnet.sendCommand("cd " + cmd.substring(0,idx));
			String r =telnet.sendCommand(cmd.substring(idx+1));
			//System.out.println(r);
			if (logger.isDebugEnabled()) {
				logger.debug(r);
			}
			if(-1 != r.indexOf("result=0")){//输出result=0表示执行成功
				ret = 0;
			}
			telnet.disconnect();
		}
		catch ( Exception e ) {    
			e.printStackTrace();    
		}

		return ret;
		
	}

	/**
	 * 测试
	 * @param args
	 */
	public static void main( String[] args ) {    
		try {    
			System.out.println( "Start Telnet..." );    
			String host = "11.0.34.2";    
			int port = 23;    
			String user = "oracle";    
			String password = "oracle";   
			/*TelnetCommandRunner telnet = new TelnetCommandRunner( host, port, user, password ); 
			//telnet.sendCommand( "export LANG=en" );
			String r1 = telnet.sendCommand( "cd /oracle/sunline/" );    
			String r2 = telnet.sendCommand( "pwd" );    
			String r3 = telnet.sendCommand( "sh glisetl.sh 20110903" );    

			System.out.println( "View Result" );    
			System.out.println( r1 );    
			System.out.println( r2 );    
			System.out.println( r3 );  

			telnet.disconnect();    */

			String cmd = "/oracle/sunline/backupdb.sh";
			int idx =  cmd.lastIndexOf("/");
			System.out.println(idx);
			System.out.println(cmd.substring(0,idx));
			System.out.println(cmd.substring(idx+1));
			int ret = TelnetCommandRunner.runCmd(host,String.valueOf(port),user,password,cmd,"");			
			System.out.println( "ret:" +ret );  
		} catch ( Exception e ) {    
			e.printStackTrace();    
		}    
	}    
}   